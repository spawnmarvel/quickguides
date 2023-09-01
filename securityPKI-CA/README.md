
# Certificate Authority

The below tutorial is translated to windows and cmd is used.

https://www.rabbitmq.com/ssl.html#manual-certificate-generation

## Certificate Authority

Tested with
```bash
c:\Program Files\OpenSSL-Win64\bin>openssl version
OpenSSL 1.1.1m  14 Dec 2021
```
Test with: Win64OpenSSL-3_1_2.msi
Make a new path since v 1 is using default path

* C:\Program Files\OpenSSL-Win64-3\OpenSSL-Win64
* The OpenSSL binaries (/bin) directory

```bash
c:\Program Files\OpenSSL-Win64-3\OpenSSL-Win64\bin>openssl version
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)

# 1 First let's create a directory for our test Certificate Authority:

mkdir testca
cd testca
mkdir certs private
echo 01 > serial # should have content 01
echo > index.txt # remove the content from the file "Echo is on"

```
Parameters for Root CA Configuration File https://pki-tutorial.readthedocs.io/en/latest/simple/root-ca.conf.html

openssl.cnf https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/openssl.cnf

![Folders ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/folders.jpg)

Next we need to generate the key and certificates that our test Certificate Authority will use. Still within the testca directory

```bash
# 2 Key and certificate
# Generate the key
openssl req -x509 -config c:\testca\openssl.cnf -newkey rsa:2048 -days 720 -out c:\testca\ca_certificate.pem -outform PEM -subj /CN=SocratesIncCa/ -nodes

# Generate certificate
openssl x509 -in c:\testca\ca_certificate.pem -out c:\testca\ca_certificate.cer -outform DER

# This is all that is needed to generate a test Certificate Authority. 
# The root certificate is in ca_certificate.pem and is also in ca_certificate.cer. 
# These two files contain the same information, but in different formats, PEM and DER. 
# Most software uses the former but some tools require the latter.
```
![Folders 2 ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/folders2.jpg)


