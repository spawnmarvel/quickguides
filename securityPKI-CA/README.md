
# Certificate Authority

The below tutorial is translated to windows and cmd is used.

https://www.rabbitmq.com/ssl.html#manual-certificate-generation

## How to Generate a CSR (Certificate Signing Request) in Linux

https://www.tecmint.com/generate-csr-certificate-signing-request-in-linux/

## Make Certificate Authority SocatesIncCA

Ref https://pki-tutorial.readthedocs.io/en/latest/simple/index.html#overview

"We assume an organisation named SocratesIncCaInc, controlling the domain socrates.org. The organisation runs a small PKI to secure its email and intranet traffic."
"To construct the PKI, we first create the Simple Root CA and its CA certificate. We then use the root CA to create the Simple Signing CA. 
"Once the CAs are in place, we issue TLS-server certificate's to servers and clients or server/client purpose"

![Simple PKI ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/simplepki.jpg)

### commonName format
The common name is not a URL. It doesn’t include any protocol (e.g. http:// or https://), port number, or pathname. 

For instance, https://example.com or example.com/path are incorrect. In both cases, the common name should be example.com.

It must precisely match the server name where the certificate is installed. 

If the certificate is issued for a subdomain, it should be the full subdomain. 

For instance, for the www and api subdomains of example.com, the common name will be www.example.com or api.example.com, and not example.com.

### Common Name vs Subject Alternative Name

The common name can only contain up to one entry: either a wildcard or non-wildcard name. 

It’s not possible to specify a list of names covered by an SSL certificate in the common name field.

The common name can only contain up to one entry: either a wildcard or non-wildcard name. 

It’s not possible to specify a list of names covered by an SSL certificate in the common name field.

### OpenSSL V

Tested with
```bash
c:\Program Files\OpenSSL-Win64\bin>openssl version
OpenSSL 1.1.1m  14 Dec 2021
```
Test with: Win64OpenSSL-3_1_2.msi
Make a new path since v 1 is using default path

* C:\Program Files\OpenSSL-Win64-3\OpenSSL-Win64
* The OpenSSL binaries (/bin) directory


## Start

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

Root certificate after importing to MMC-> certificates

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

The we can use in a client application only (App request, code, shovel etc.)

All steps were done with openssl ca -config c:\testca\openssl.cnf

![Folder Client ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/folderclient.jpg)

## Server and client auth in one certificate

With reference to RabbitMQ.
If we are to have RabbitMQ as a server and also use the shovel function, then we are a server to incoming and a client to outgoing.

Now lets create a new config file to use
* c:\testca\openssl2.cnf
* Copy all the content from c:\testca\openssl.cnf, we use that as a base

Test it first
```bash
# Make a new client folder client 2
cd c:\testca
mkdir client2

# Generating RSA private key
openssl genrsa -out c:\testca\client2\private_key.pem 2048

# Generating request
openssl req -new -key c:\testca\client2\private_key.pem -out c:\testca\client2\req.pem -outform PEM -subj /CN=NOR-0706 -nodes

# Only client extension using new config openssl2.cnf
openssl ca -config c:\testca\openssl2.cnf -in c:\testca\client2\req.pem -out c:\testca\client2\client_certificate.pem -notext -batch -extensions client_ca_extensions

# Using configuration from c:\testca\openssl2.cnf
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'NOR-0706'
# Certificate is to be certified until Sep  1 10:10:56 2033 GMT (3652 days)

# Write out database with 1 new entries
# Database updated
```
The same databases (index.txt) is updated, good.
```log
V	330901094633Z		04	unknown	/CN=BER-0803
V	330901095710Z		05	unknown	/CN=NOR-0705
V	330901101056Z		06	unknown	/CN=NOR-0706

```
Changes in the openssl2.cnf
From https://access.redhat.com/solutions/28965

Below extended key attributes have to be used in the certificate, As per RFC 3280, section "extended key usage"
* TLS WWW server authentication
* TLS WWW client authentication
* Signing of downloadable executable code
* E-mail protection

```log

[ req ]
default_bits = 2048
default_keyfile = "C:\\testca\\private\\ca_private_key.pem"
default_md = sha256
prompt = yes
distinguished_name = root_ca_distinguished_name
# x509_extensions = root_ca_extensions
# https://access.redhat.com/solutions/28965
x509_extensions = v3_ca # The extentions to add to the self signed cert
req_extensions  = v3_req
x509_extensions = usr_cert

[ usr_cert ]
basicConstraints = CA:false
nsCertType = client, server, email
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
nsComment = "OpenSSL Generated Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer

[ v3_req ]
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
```


```bash
# Make a new server folder server 2
cd c:\testca
mkdir server2

# Generating RSA private key
openssl genrsa -out c:\testca\server2\private_key.pem 2048

# Generating request
openssl req -new -key c:\testca\server2\private_key.pem -out c:\testca\server2\req.pem -outform PEM -subj /CN=SWE-0810 -nodes

# Server and client extension using new config openssl2.cnf
openssl ca -config c:\testca\openssl2.cnf -in c:\testca\server2\req.pem -out c:\testca\server2\server2_certificate.pem -notext -batch

# Using configuration from c:\testca\openssl2.cnf
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'SWE-0810'
# Certificate is to be certified until Sep  1 10:21:26 2033 GMT (3652 days)

# Write out database with 1 new entries
# Database updated

# Make cer file also
openssl x509 -in c:\testca\server2\server2_certificate.pem -out c:\testca\server2\server2_certificate.cer -outform DER

```
All purposes

![All ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/allpurpose2.jpg)

Example with using the certificate in RabbitMQ

```log
listeners.ssl.default = 5671
ssl_options.cacertfile = C:\testca\ca_certificate.pem
ssl_options.certfile   = C:\testca\server2\server2_certificate.pem
ssl_options.keyfile    = C:\testca\server2\private_key.pem
```

All files

![All files ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/allfiles.jpg)

## Converting Using OpenSSL

https://stackoverflow.com/questions/13732826/convert-pem-to-crt-and-key

```bash

cd c:\testca
mkdir server2

# We have the pem from above
c:\testca\server2\server2_certificate.pem 

# Make cer file also
openssl x509 -in c:\testca\server2\server2_certificate.pem -out c:\testca\server2\server2_certificate.cer -outform DER

# Convert PEM to CRT (.CRT file)
openssl x509 -outform der -in c:\testca\server2\server2_certificate.pem -out c:\testca\server2\server2_certificate.crt

```

Cannot read the file due to base encoding?
* CP the conntent of the .pem file to a crt file

![Pem to crt ](https://github.com/spawnmarvel/quickguides/blob/main/securityPKI-CA/images/crt.jpg)