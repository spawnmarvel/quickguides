# example automate with powershell

1. The "Template & Reload" Strategy (Recommended)
This is the most robust way to handle static shovels. Instead of manually editing files, you use a configuration management tool (like Ansible or Puppet or a script) to manage the .pem files and the config.

* The Automation: Use a tool to fetch the cert from your CA and write it to /etc/rabbitmq/certs/.

* The Trick: In rabbitmq.conf and advanced.config, point your shovel to these file paths.


Since you are on Windows and using a static path like F:\certs, the goal is to turn that manual "Export-PFX-to-OpenSSL" dance into a repeatable script. On Windows, you can use PowerShell to bridge the gap between certreq, the Certificate Store, and the OpenSSL commands you've been running.

Here is the automated workflow to replace the "previous person's" manual errors with a clean, scripted process.

The Automation Script (PowerShell)
You can save this as Update-RabbitCerts.ps1. It handles the request, the import, and the extraction without you needing to touch the MMC snap-in.

To keep your server "clean" and avoid cluttering the Windows Certificate Store, we will skip the certreq -accept and Export-PfxCertificate steps. Instead, we will use OpenSSL to process the Certificate Response (.cer) directly.

This approach treats the certificates as "flat files" in F:\certs, which is ideal for RabbitMQ's advanced.config and rabbitmq.conf.


This is the definitive, full-automation script that:

1. Backs up your current environment.

2. Requests a new cert using your .inf.

3. Aborts if the CA doesn't issue the cert (The Gatekeeper).

4. Accepts it into the Personal store.

5. Extracts everything to F:\certs using your specific OpenSSL path.

6. Merges the Local and Remote CAs into a clean ca.bundle (no leaf certs!).

7. Reloads RabbitMQ TLS.

```ps1

# --- CONFIGURATION ---
$OpenSSL      = "C:\Program Files\OpenSSL\bin\openssl.exe"
$WorkDir      = "F:\certs"
$INFFile      = "$WorkDir\request.inf"
$RemoteCAPath = "$WorkDir\remote_server_ca.pem"
$BackupRoot   = "F:\backups"
$TempPFX      = "$WorkDir\temp_transfer.pfx"
$TempPass     = "Transfer123"
$Timestamp    = Get-Date -Format "yyyyMMdd_HHmm"

# 0. Parse CN from INF to find the cert in the store later
$CN = Select-String -Path $INFFile -Pattern 'Subject\s*=\s*"CN=(.*?)"' | ForEach-Object { $_.Matches.Groups[1].Value }
if (!$CN) { Write-Error "Could not find CN in $INFFile. Check formatting."; exit }

# --- STEP 1: BACKUP ---
Write-Host "Step 1: Backing up F:\certs..." -ForegroundColor Cyan
$BackupPath = Join-Path $BackupRoot "certs_$Timestamp"
if (!(Test-Path $BackupRoot)) { New-Item $BackupRoot -ItemType Directory -Force }
Copy-Item -Path "$WorkDir\*" -Destination $BackupPath -Recurse -Force

# --- STEP 2: GENERATE AND SUBMIT ---
Write-Host "Step 2: Generating request and submitting to CA..." -ForegroundColor Cyan
& certreq.exe -new "$INFFile" "$WorkDir\new_request.req"
& certreq.exe -submit -q "$WorkDir\new_request.req" "$WorkDir\new_cert.cer"

# --- THE GATEKEEPER ---
# If the CA didn't return a file, stop here so we don't break the existing setup.
if (!(Test-Path "$WorkDir\new_cert.cer")) {
    Write-Host "ABORTING: No certificate file returned from CA. Request may be pending." -ForegroundColor Red
    exit
}

# --- STEP 3: ACCEPT AND EXPORT ---
Write-Host "Step 3: Accepting cert into Personal Store and exporting to PFX..." -ForegroundColor Cyan
# This links the .cer to the private key and keeps it in Cert:\LocalMachine\My
& certreq.exe -accept "$WorkDir\new_cert.cer"

# Find the cert in the LocalMachine\My store to export it
$Cert = Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Subject -like "*CN=$CN*" } | Sort-Object NotBefore -Descending | Select-Object -First 1
$SecurePass = ConvertTo-SecureString $TempPass -AsPlainText -Force
Export-PfxCertificate -Cert $Cert -FilePath $TempPFX -Password $SecurePass

# --- STEP 4: OPENSSL CONVERSIONS ---
Write-Host "Step 4: Converting to PEM files for RabbitMQ..." -ForegroundColor Cyan

# Extract Private Key (Unencrypted for RabbitMQ nodes)
& "$OpenSSL" pkcs12 -in $TempPFX -nocerts -out "$WorkDir\private.key.pem" -nodes -passin "pass:$TempPass"

# Extract Client Cert (The public leaf)
& "$OpenSSL" pkcs12 -in $TempPFX -clcerts -nokeys -out "$WorkDir\public.crt.pem" -nodes -passin "pass:$TempPass"

# Extract Local CA Chain (Intermediate/Root)
# Using -cacerts ensures the Leaf is NOT in the chain (prevents your previous error!)
& "$OpenSSL" pkcs12 -in $TempPFX -cacerts -nokeys -out "$WorkDir\local_chain.pem" -nodes -passin "pass:$TempPass"

# --- STEP 5: MERGE CA BUNDLE ---
Write-Host "Step 5: Building Unified ca.bundle..." -ForegroundColor Cyan
if (Test-Path $RemoteCAPath) {
    # Combined: [Your CA Chain] + [The Remote Server's CA]
    Get-Content "$WorkDir\local_chain.pem", $RemoteCAPath | Set-Content "$WorkDir\ca.bundle"
} else {
    Write-Warning "Remote CA not found at $RemoteCAPath. ca.bundle only contains local chain."
    Move-Item "$WorkDir\local_chain.pem" "$WorkDir\ca.bundle" -Force
}

# --- STEP 6: CLEANUP & RELOAD ---
Write-Host "Step 6: Cleaning up and reloading RabbitMQ TLS..." -ForegroundColor Cyan

# We leave the cert in Cert:\LocalMachine\My as requested, but clean up temp files.
Remove-Item $TempPFX, "$WorkDir\local_chain.pem", "$WorkDir\new_cert.cer", "$WorkDir\new_request.req"

# Trigger TLS reload for HTTPS Management and Shovels
rabbitmqctl eval "ssl:rehash()."

Write-Host "SUCCESS: F:\certs updated. Cert remains in Personal Store. Shovel/HTTPS reloaded." -ForegroundColor Green


```
