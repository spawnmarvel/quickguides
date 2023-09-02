
# Certificate Authority

The below tutorial is translated to windows and cmd is used.

https://www.rabbitmq.com/ssl.html#manual-certificate-generation

## How to Generate a CSR (Certificate Signing Request) in Linux

https://www.tecmint.com/generate-csr-certificate-signing-request-in-linux/

## Make Certificate Authority

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
openssl req -x509 -config c:\testca\openssl.cnf -newkey rsa:2048 -days 3652 -out c:\testca\ca_certificate.pem -outform PEM -subj /CN=SocratesIncCa/ -nodes

# Generate certificate
openssl x509 -in c:\testca\ca_certificate.pem -out c:\testca\ca_certificate.cer -outform DER

# This is all that is needed to generate a test Certificate Authority. 
# The root certificate is in ca_certificate.pem and is also in ca_certificate.cer. 
# These two files contain the same information, but in different formats, PEM and DER. 
# Most software uses the former but some tools require the latter.
```
![Folders 2 ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/folders2.jpg)

Having set up our Certificate Authority, we can now generate private keys and certificates for the clients and the servers. 

Root certificate after inmporting to MMC-> certificates

![Root ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/root.jpg)

Server

```bash
cd c:\testca
mkdir server
cd server

# Generating RSA private key
openssl genrsa -out c:\testca\server\private_key.pem 2048

# Generating request
openssl req -new -key c:\testca\server\private_key.pem -out c:\testca\server\req.pem -outform PEM -subj /CN=BER-0803 -nodes

# Generating certificate for a server, it can only have the server role

# Only server extension
openssl ca -config c:\testca\openssl.cnf -in c:\testca\server\req.pem -out c:\testca\server\server_certificate.pem -notext -batch -extensions server_ca_extensions

# Using configuration from c:\testca\openssl.cnf
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'BER-0803'
# Certificate is to be certified until Sep  1 09:46:33 2033 GMT (3652 days)

# Write out database with 1 new entries
# Database updated

# Make cer file also
openssl x509 -in c:\testca\server\server_certificate.pem -out c:\testca\server\server_certificate.cer -outform DER

```
Server certificate

![Server ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/server1.jpg)

Example with using the certificate in RabbitMQ

```log
listeners.ssl.default = 5671
ssl_options.cacertfile = C:\testca\ca_certificate.pem
ssl_options.certfile   = C:\testca\server\server_certificate.pem
ssl_options.keyfile    = C:\testca\server\private_key.pem
```

![RabbitMQ ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/rabbitmq.jpg)

RabbitMQ broker uses certificates and private keys in the PEM format. 

Some client libraries use the PEM format, others will require conversion to a different format (e.g. PKCS#12).

![Folders ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/folder3.jpg)

Client

```bash
cd c:\testca
mkdir client

# Generating RSA private key
openssl genrsa -out c:\testca\client\private_key.pem 2048

# Generating request
openssl req -new -key c:\testca\client\private_key.pem -out c:\testca\client\req.pem -outform PEM -subj /CN=NOR-0705 -nodes

# Only client extension
openssl ca -config c:\testca\openssl.cnf -in c:\testca\client\req.pem -out c:\testca\client\client_certificate.pem -notext -batch -extensions client_ca_extensions

# Using configuration from c:\testca\openssl.cnf
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'NOR-0705'
# Certificate is to be certified until Sep  1 09:57:10 2033 GMT (3652 days)

# Write out database with 1 new entries
# Database updated

# Make cer file also
openssl x509 -in c:\testca\client\client_certificate.pem -out c:\testca\client\client_certificate.cer -outform DER
```
Client certificate

![Client ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/client.jpg)
