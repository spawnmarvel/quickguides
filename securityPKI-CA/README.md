
# Certificate Authority

The below tutorial is translate to windows

https://www.rabbitmq.com/ssl.html#manual-certificate-generation

## Certificate Authority

Tested with
```cmd
c:\Program Files\OpenSSL-Win64\bin>openssl version
OpenSSL 1.1.1m  14 Dec 2021
```
Test with: Win64OpenSSL-3_1_2.msi
Make a new path since v 1 is using default path

* C:\Program Files\OpenSSL-Win64-3\OpenSSL-Win64
* The OpenSSL binaries (/bin) directory

```cmd
c:\Program Files\OpenSSL-Win64-3\OpenSSL-Win64\bin>openssl version
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)

# 1 First let's create a directory for our test Certificate Authority:

mkdir testca
cd testca
mkdir certs private
echo 01 > serial # should have content 01
echo > index.txt # remove the content from the file "Echo is on"

```

