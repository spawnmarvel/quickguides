# Requests and renew 

## Continue from manual steps in the main readme.md

certreq -new

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1

```cmd
certreq –new request.inf certificate.req
```

<details><summary>Convert pem to other formats or follow below</summary>
<p>
https://www.misterpki.com/convert-pem-to-other-formats/

.pem – Privacy Enhanced Mail Certificate. A PEM file is Base64 encoded and may be an X.509 certificate file, a private key file, or any other key material. PEM encoded files are commonly used in Apache and Tomcat servers.

.crt – Shorthand way to say “cert”, the .crt file extension is a security extension that may be either Base64 encoded or binary. Most commonly, .crt is a Base64 encoded certificate.

.cer – Shorthand way to almost say “cert”, the .cer file extension is an Internet Security Certificate that may be either Base64 encoded or binary. Most commonly, .cer is a binary certificate.

.der – The .der file extension is for a certificate file in binary format.

.pfx – The .pfx file extension is a PKCS12 certificate bundle which may contain an end entity certificate, a certificate chain, and matching private key. .pfx can be interchanged with .p12 and may be protected by a password.

.p12 – Personal Information Exchange File that is encrypted with a password and is interchangeable with the .pfx file extension.

* To convert a pem encoded certificate to a .crt extension, simply rename the file. This assumes you want .crt to be Base64 encoded. 

* To convert a pem encoded certificate to a .cer extension, simply rename the file. This assumes you want .cer to remain Base64 encoded. 

A pem encoded certificate is already a “cert”, and the .cert file extension isn’t a “real” extension, so it is better to used an already defined file extension such as .cer, .pem, or .crt.

</p>
</details>
* 2 When CSR approved is back, import certificate in MMC at the personal certificate store, if the cert is not valid, import all CA's in the store also. (They are missing)

* * If the content is on binary format, .cer*, meaning the cert content does not start with ----BEGIN CERTIFICATE-----
* * Import the .cer* to a local MMC (add signers also for verification). Then export it in MMC to format Base64 encoded. (.cer can be Base64 encoded or binary )
* * Then you can cp the txt content to wherever
* 2.1 When all CA's are imported in MMC, the personal should be valid. (If you cannot find the cert in mmc personal, import it direct on personal tab
)
* 3 Export personal from MMC as pfx (yes, export private key, include all certs if possible), save the password for later use just for openssl.

* * View IBM.info 

* 4 Now get the private key and extract the certificate fro the pfx file

* It could be that you need to type c:\Program Files\OpenSSL-Win64\bin\openssl "enter"
* OpenSSL>

* 4.1 Run cms as admin navigate to openssl bin and check version
```cmd
cd "c:\Program Files\OpenSSL-Win64\bin"
openssl version
```
* It should be OpenSSL 1.1.1m 14 Dec 2021

* * Update 05.11.2024 not tested, https://www.sslshopper.com/ssl-converter.html
* * Public key is embedded in the SSL certificate and Private key is stored on the server and kept secret.
* * Only possible on linux? Seems so

* 4.2 Run the following command to extract the private key:
```bash
openssl pkcs12 -in myfile.pfx -nocerts -out private.key.pem -nodes
# enter the password used from the mmc export or create a new one.
```
* 4.3 Run the following command to extract the certificate
```bash
openssl pkcs12 -in myfile.pfx -clcerts -nokeys -out public.crt.pem -nodes
# enter the same password (from 4.2)
```
* 4.4 Run the following command to verify CN (must be hostname(.domain.something))
```bash
openssl x509 -noout -subject -in public.crt.pem
```

* 4.5 Run the following command to verify end date (notAfter=Jan 27 10:36:48 2026 GMT)
```bash
openssl x509 -noout -enddate -in public.crt.pem
```

* 4.6 Run the following command to verify serial (59000017Axxxxxxxxxxxxxxxxxxxxxxxxx)
```bash
openssl x509 -noout -serial -in public.crt.pem
```

## Automate the above

```cmd
# make request
certreq –new request.inf certificate.req

# The –accept parameter links the previously generated private key with the issued certificate and removes the pending certificate request from the system where the certificate is requested (if there's a matching request).

# imported the personal, not showing and certificate enrollment request is still there?
# use this if the request was generated by another user, or old OS etc.
certreq -accept certnew.cer

```

openssl view bundle ca.bundle, the openssl storeutl app was added in OpenSSL 1.1.1.
```bash

c:\Program Files\OpenSSL-Win64-3\OpenSSL-Win64\bin>openssl version
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)

# C:\RabbitmqBaseFolder\cert
openssl storeutl -noout -text -certs c:\RabbitmqBaseFolder\cert\ca.bundle

```

```log
0: Certificate
Issuer: C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert Global Root G2
Validity
            Not Before: Aug  1 12:00:00 2013 GMT
            Not After : Jan 15 12:00:00 2038 GMT
1: Certificate
Issuer: C=US, O=Microsoft Corporation, CN=Microsoft RSA Root Certificate Authority 2017
        Validity
            Not Before: Jan 17 20:22:49 2020 GMT
            Not After : Jun 27 20:22:49 2024 GMT
[...]
Total found: 2
```

export from mmx as pfx
