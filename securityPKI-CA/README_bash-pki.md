# OpenSSL PKI

Creating a self-signed certificate using OpenSSL is a straightforward process. Below are the steps to generate a self-signed SSL/TLS certificate:

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

### Optional: Combine Private Key and Certificate
If you want to combine the private key and certificate into a single file (often used in server configurations), you can do so with:

```bash
cat private.key certificate.crt > certificate.pem
```

This creates a `certificate.pem` file containing both the private key and the certificate.

### Summary
After following these steps, you'll have a self-signed certificate (`certificate.crt`) and a corresponding private key (`private.key`). This certificate can be used for testing or internal purposes where a trusted CA-signed certificate is not required.

**Note:** Self-signed certificates will trigger security warnings in web browsers because they are not issued by a trusted CA. For production environments, it's recommended to obtain a certificate from a trusted CA.