# Certificate Requests and Renewals for AMQP/mTLS

This guide continues from the manual steps in the main [README.md](../README.md).

---

## Table of Contents

1. [Generate a New Certificate Request](#1-generate-a-new-certificate-request)
2. [Convert Binary Certificate to Human Readable](#2-convert-binary-certificate-to-human-readable)
3. [Certificate Format Conversion](#3-certificate-format-conversion)
4. [Import and Export Certificates](#4-import-and-export-certificates)
5. [Extract Private Key and Certificate from PFX](#5-extract-private-key-and-certificate-from-pfx)
6. [Automate the Process](#6-automate-the-process)
7. [Generate CSR on Different Host](#7-generate-csr-on-different-host)
8. [Test mTLS Authentication](#8-test-mtls-authentication)

---

## 1. Generate a New Certificate Request

Use `certreq` to create a new certificate request:

```cmd
certreq -new request.inf certificate.req
```

> 📖 Reference: [certreq command documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1)

---

## 2. Convert Binary Certificate to Human Readable

Convert a `.crt` binary certificate to `.cer` Base64 format:

```powershell
certutil -encode C:\tmp\server01.corp.logo.com.crt C:\tmp\server01.corp.logo.com.cer
```

**Expected output:**
```
Input Length = 2205
Output Length = 3088
CertUtil: -encode command completed successfully
```

---

## 3. Certificate Format Conversion

| Format | Description |
|--------|-------------|
| `.pem` | Base64 encoded X.509 certificate (commonly used in Apache/Tomcat) |
| `.crt` | Certificate file - can be Base64 or binary |
| `.cer` | Certificate file - can be Base64 or binary |
| `.der` | Binary format certificate |
| `.pfx` / `.p12` | PKCS12 bundle containing certificate, chain, and private key |

### Converting PEM to Other Formats

> 📖 Reference: [SSL Shopper Converter](https://www.sslshopper.com/ssl-converter.html)

**To convert PEM to .crt or .cer:** Simply rename the file (if Base64 encoded is desired).

> ⚠️ A PEM encoded certificate is already valid - using `.cert` extension is not standard. Use `.cer`, `.pem`, or `.crt` instead.

---

## 4. Import and Export Certificates

### Step 1: Import Certificate
When the CSR is approved, import the certificate in MMC:
- Add to **Personal** certificate store
- If the cert shows as invalid, import all CA certificates to the store

> 💡 The shovel server needs both **server auth** and **client auth** (at minimum server auth is required).

### Step 2: Handle Binary Format Certificates
If the certificate is binary (content does not start with `-----BEGIN CERTIFICATE-----`):
1. Import the `.cer` to local MMC (add signers for verification)
2. Export from MMC as **Base64 encoded** `.cer`

### Step 3: Verify Validity
- After importing all CAs, the personal certificate should be valid
- If not found in MMC Personal, import directly to Personal tab

### Step 4: Export as PFX
Export the personal certificate from MMC:
- Format: PFX (include private key)
- Include all certificates in the chain if possible
- Save the password for OpenSSL operations

---

## 5. Extract Private Key and Certificate from PFX

### Prerequisites
Check OpenSSL version:
```cmd
cd "c:\Program Files\OpenSSL-Win64\bin"
openssl version
```

> ✅ Recommended: OpenSSL 1.1.1m 14 Dec 2021 or later

### Extract Private Key
```bash
openssl pkcs12 -in myfile.pfx -nocerts -out private.key.pem -nodes
```
*Enter the password used during MMC export when prompted.*

### Extract Certificate
```bash
openssl pkcs12 -in myfile.pfx -clcerts -nokeys -out public.crt.pem -nodes
```
*Enter the same password.*

### Verify the Certificate

**Check CN (must be hostname.domain.something):**
```bash
openssl x509 -noout -subject -in public.crt.pem
```

**Check expiration date:**
```bash
openssl x509 -noout -enddate -in public.crt.pem
```
Example output: `notAfter=Jan 27 10:36:48 2026 GMT`

**Check serial number:**
```bash
openssl x509 -noout -serial -in public.crt.pem
```

### View CA Bundle
```bash
openssl storeutl -noout -text -certs C:\RabbitmqBaseFolder\cert\ca.bundle
```

---

## 6. Automate the Process

For automated certificate requests, see [README_auto_ps1.md](README_auto_ps1.md).

### Basic Commands

```cmd
# Make request
certreq -new request.inf certificate.req

# Accept the issued certificate (links private key with certificate)
certreq -accept certnew.cer
```

> ℹ️ The `-accept` parameter links the previously generated private key with the issued certificate and removes the pending request from the system.

---

## 7. Generate CSR on Different Host

Yes! You can generate the CSR and private key on a different host, then transfer both to your app host for mTLS.

### Process Overview

1. **Generate on Host A (Secure Machine)**
   - Create private key and CSR
   - Send CSR to Certificate Authority (CA)

2. **Get Signed Certificate**
   - CA signs and returns the certificate

3. **Transfer to App Host (Host B)**
   - Securely copy private key and certificate
   - Use secure methods: `scp`, `rsync` over SSH

### Important Notes

- Windows Certificate Manager on Host B will not have the original enrollment request
- The pending request will appear as "orphaned" - this is harmless
- **Best Practice:** Delete unused "Certificate Enrollment Request" entries to keep the store clean

---

## 8. Test mTLS Authentication

### Port Reference

| Protocol | Port | Description |
|----------|------|-------------|
| AMQP | 5672 | Unencrypted |
| AMQPS | 5671 | TLS-encrypted (often with mTLS) |

### Test with OpenSSL

#### Server Side (Simulated)
```bash
openssl s_server -accept 5671 -CAfile C:\path\to\cacert.pem -cert C:\path\to\server.cert.pem -key C:\path\to\server.key.pem -state
```

#### Client Side (Simulated)
```bash
openssl s_client -connect 127.0.0.1:5671 -key C:\path\to\client.key.pem -cert C:\path\to\client.cert.pem -CAfile C:\path\to\cacert.pem -state
```

#### Test Against Real Broker (e.g., RabbitMQ)
```bash
openssl s_client -connect your-broker-host:5671 -key C:\path\to\client.key.pem -cert C:\path\to\client.cert.pem -CAfile C:\path\to\cacert.pem -state
```

### Interpreting Results

#### ✅ Successful mTLS Handshake
- **OpenSSL output:** `Verify return code: 0 (ok)`
- **RabbitMQ logs:** Successful TLS handshake (may show AMQP protocol header error after - this is expected as s_client does not send AMQP frames)

#### ❌ Failed Handshake
- **OpenSSL output:** SSL alert error
  ```
  error:14094410:SSL routines:ssl3_read_bytes:sslv3 alert handshake failure
  ```
- **RabbitMQ logs:** `TLS handshake error: tls_alert_certificate_unknown`

> ⚠️ Running `openssl s_client` to test does NOT disturb or interrupt current traffic on your RabbitMQ server.

![test ssl](https://github.com/spawnmarvel/quickguides/blob/main/amqp/RequestRenewExample/openssl_client_test.jpg)
---

## Notes

- Public key is embedded in the SSL certificate
- Private key is stored on the server and kept secret
- The Shovel server requires both server auth and client auth for full mTLS support
