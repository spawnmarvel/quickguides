# Powershell PKI


## Create Your Own SSL Certificate using PowerShell

This is simple as it looks. Using the ‘New-SelfSignedCertificate’ cmdlet, you can create self-signed certificate in a jiffy.

```ps1
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My 
```

## Export Self-signed Certificate using PowerShell

```ps1
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My 

Export-Certificate -Cert $Certificate -FilePath "C:\$certname.cer" 

```

## Export Certificate with Private Key

```ps1
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My 

$Pwd = ConvertTo-SecureString -String "Testing" -Force -AsPlainText 
Export-PfxCertificate -Cert $Certificate -FilePath "D:\$certname.pfx" -Password $Pwd 


```

## Create Self-signed SSL Certificate with Longer Expiry


```ps1
# month
$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My -NotAfter (Get-Date).AddMonths(36) 

# years

$Certificate=New-SelfSignedCertificate –Subject testing.com -CertStoreLocation Cert:\CurrentUser\My -NotAfter (Get-Date).AddYears(5) 

```


## Delete Self-Signed Certificate using PowerShell

```ps1
Remove-Item -Path Cert:\CurrentUser\My\{PasteTheCertificateThumbprintHere} -DeleteKey  

```

## Make a powershell x.509 tutorial with the most common functions for a self signed certificate

Certainly! Below is a PowerShell tutorial that covers the most common functions to create a self-signed X.509 certificate. This tutorial will guide you through generating a self-signed certificate, exporting it, and installing it into the local machine's certificate store.

### Tutorial: Creating a Self-Signed X.509 Certificate in PowerShell

#### Step 1: Open PowerShell as Administrator
To perform certificate operations, you need administrative privileges. Open PowerShell with "Run as Administrator".

#### Step 2: Create a Self-Signed Certificate

1. **Define Certificate Parameters**
   Set the parameters for the certificate you want to create. Here are some common parameters:
   - `Subject`: The name of the certificate.
   - `DnsName`: The domain name associated with the certificate.
   - `KeyUsage`: Specifies the purpose of the key contained in the certificate.
   - `KeyAlgorithm`: The algorithm used for the private key.
   - `KeyLength`: The length of the key.
   - `CertStoreLocation`: The certificate store location.

```powershell
$certParams = @{
    Subject            = "CN=localhost"
    DnsName            = "localhost"
    KeyUsage           = "KeyEncipherment, DigitalSignature"
    KeyAlgorithm       = "RSA"
    KeyLength          = 2048
    CertStoreLocation  = "Cert:\LocalMachine\My"
}
```

2. **Create the Certificate**
   Use the `New-SelfSignedCertificate` cmdlet to create the certificate.

```powershell
$cert = New-SelfSignedCertificate @certParams
```

#### Step 3: Export the Certificate

1. **Export the Certificate to a File**
   Export the created certificate to a file. Here, we'll export it in PFX format.

```powershell
$certFilePath = "C:\Certs\localhost.pfx"
$password = ConvertTo-SecureString -String "YourStrongPassword!" -AsPlainText -Force
Export-PfxCertificate -Cert $cert -FilePath $certFilePath -Password $password
```

#### Step 4: Import the Certificate into the Local Machine Store

1. **Import the Certificate**
   To use the certificate, you need to import it into the local machine's certificate store.

```powershell
$pfxFilePath = "C:\Certs\localhost.pfx"
$password = ConvertTo-SecureString -String "YourStrongPassword!" -AsPlainText -Force

Import-PfxCertificate -FilePath $pfxFilePath -CertStoreLocation "Cert:\LocalMachine\My" -Password $password
```

#### Step 5: Verify the Certificate

1. **List Certificates in the Store**
   To verify that the certificate has been imported correctly, list the certificates in the local machine's personal store.

```powershell
Get-ChildItem -Path "Cert:\LocalMachine\My"
```

### Summary

Here’s the complete script for creating, exporting, and importing a self-signed certificate:

```powershell
# Define Certificate Parameters
$certParams = @{
    Subject            = "CN=localhost"
    DnsName            = "localhost"
    KeyUsage           = "KeyEncipherment, DigitalSignature"
    KeyAlgorithm       = "RSA"
    KeyLength          = 2048
    CertStoreLocation  = "Cert:\LocalMachine\My"
}

# Create the Self-Signed Certificate
$cert = New-SelfSignedCertificate @certParams

# Export the Certificate to a PFX File
$certFilePath = "C:\Certs\localhost.pfx"
$password = ConvertTo-SecureString -String "YourStrongPassword!" -AsPlainText -Force
Export-PfxCertificate -Cert $cert -FilePath $certFilePath -Password $password

# Import the Certificate into the Local Machine Certificate Store
$pfxFilePath = "C:\Certs\localhost.pfx"
Import-PfxCertificate -FilePath $pfxFilePath -CertStoreLocation "Cert:\LocalMachine\My" -Password $password

# Verify the Certificate
Get-ChildItem -Path "Cert:\LocalMachine\My"
```

This tutorial covers the essentials for creating, exporting, and importing a self-signed X.509 certificate using PowerShell. Adjust the parameters as needed for your specific use case.

