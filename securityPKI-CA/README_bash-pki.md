# OpenSSL (default bash) PKI

Creating a self-signed certificate using OpenSSL is a straightforward process. Below are the steps to generate a self-signed SSL/TLS certificate:

To include DNS aliases (a.k.a. Subject Alternative Names) in your self-signed cert, you need to tell OpenSSL about them—either via the CLI’s -addext flag (OpenSSL 1.1.1+) or by using an extra config section. Here are both methods:

### Step 1: Generate a Private Key
First, you need to generate a private key. You can do this using the following command:

```bash
openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:2048
```

- `-algorithm RSA`: Specifies the algorithm to use (RSA in this case).
- `-out private.key`: Specifies the output file for the private key.
- `-pkeyopt rsa_keygen_bits:2048`: Specifies the key length (2048 bits is common).

### Step 2: Create a Certificate Signing Request (CSR)
Next, create a Certificate Signing Request (CSR). This is typically used to request a certificate from a Certificate Authority (CA), but for a self-signed certificate, you'll use it to generate the certificate directly.

```bash
openssl req -new -key private.key -out csr.csr
```

- `-new`: Indicates that you're creating a new CSR.
- `-key private.key`: Specifies the private key to use.
- `-out csr.csr`: Specifies the output file for the CSR.

You'll be prompted to enter details such as country, organization, common name (domain name), etc. Fill these out as appropriate.

### Step 3: Generate the Self-Signed Certificate
Now, use the CSR to generate the self-signed certificate:

```bash
openssl x509 -req -days 365 -in csr.csr -signkey private.key -out certificate.crt
```

- `-req`: Indicates that the input is a CSR.
- `-days 365`: Specifies the number of days the certificate will be valid (1 year in this case).
- `-in csr.csr`: Specifies the input CSR file.
- `-signkey private.key`: Specifies the private key to use for signing.
- `-out certificate.crt`: Specifies the output file for the certificate.

### Step 4: Verify the Certificate
You can verify the details of the generated certificate using the following command:

```bash
openssl x509 -text -noout -in certificate.crt
```

- `-text`: Displays the certificate details in a human-readable format.
- `-noout`: Prevents the output of the encoded version of the certificate.
- `-in certificate.crt`: Specifies the certificate file to verify.


![openssl bash](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/openssl_bash.jpg)

### Optional: Combine Private Key and Certificate
If you want to combine the private key and certificate into a single file (often used in server configurations), you can do so with:

```bash
cat private.key certificate.crt > certificate.pem
```

This creates a `certificate.pem` file containing both the private key and the certificate.

### Summary
After following these steps, you'll have a self-signed certificate (`certificate.crt`) and a corresponding private key (`private.key`). This certificate can be used for testing or internal purposes where a trusted CA-signed certificate is not required.

**Note:** Self-signed certificates will trigger security warnings in web browsers because they are not issued by a trusted CA. For production environments, it's recommended to obtain a certificate from a trusted CA.

## DNS aliases (a.k.a. Subject Alternative Names)

To include DNS aliases (a.k.a. Subject Alternative Names) in your self-signed cert, you need to tell OpenSSL about them—either via the CLI’s -addext flag (OpenSSL 1.1.1+) or by using an extra config section. Here are both methods:

To include DNS aliases (a.k.a. Subject Alternative Names) in your self-signed cert, you need to tell OpenSSL about them—either via the CLI’s `-addext` flag (OpenSSL 1.1.1+) or by using an extra config section. Here are both methods:

---

## 1  Quick CLI way (OpenSSL 1.1.1+)

```bash
# 1. Generate private key
openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:2048

# 2. Create & self-sign in one step, with SANs
openssl req -new \
  -key private.key \
  -subj "/C=US/ST=NY/L=NYC/O=Example Corp/CN=example.com" \
  -addext "subjectAltName = DNS:example.com,DNS:www.example.com,DNS:api.example.com" \
  -x509 -days 365 \
  -out certificate.crt
```

What’s happening?  
• `-addext "subjectAltName = …"` injects the SAN list directly into the cert.  
• `-x509` tells `req` to output a self-signed certificate.  

---

## 2  Using an OpenSSL config file

1) Create a custom config (e.g. `openssl.cnf`):

   ```ini
   [ req ]
   default_bits       = 2048
   prompt             = no
   default_md         = sha256
   distinguished_name = dn
   req_extensions     = v3_req

   [ dn ]
   C  = US
   ST = NY
   L  = NYC
   O  = Example Corp
   CN = example.com

   [ v3_req ]
   # Basic constraints + SAN
   basicConstraints = CA:FALSE
   subjectAltName   = @alt_names

   [ alt_names ]
   DNS.1 = example.com
   DNS.2 = www.example.com
   DNS.3 = api.example.com
   ```

2) Run the commands:

   ```bash
   # Generate key
   openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:2048

   # Create CSR with SANs from config
   openssl req -new \
     -key private.key \
     -out csr.csr \
     -config openssl.cnf

   # Self-sign CSR, carrying over the v3_req extensions
   openssl x509 -req -days 365 \
     -in csr.csr \
     -signkey private.key \
     -out certificate.crt \
     -extensions v3_req \
     -extfile openssl.cnf
   ```

---

## Verify your SANs

```bash
openssl x509 -in certificate.crt -noout -text | grep -A1 "Subject Alternative Name"
```

You should see your DNS aliases listed under “Subject Alternative Name”.

---

🎉 That’s it! You now have a self-signed cert with multiple DNS aliases for `example.com`, `www.example.com`, `api.example.com`, etc.