# General security

## RFC 6125 .. Identity within Internet Public Key Infrastructure Using X.509 (PKIX) [...]

Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

https://datatracker.ietf.org/doc/html/rfc6125

## ISO and IEC Approve OASIS AMQP Advanced Message Queuing Protocol

Example with AMQPS and client/server (shovel) configured with X.509 running mTls(Tls), and information about the AMQP approved as an open standard.

https://github.com/spawnmarvel/quickguides/tree/main/amqp

## What is mutual TLS (mTLS)?

Mutual TLS (mTLS) is a type of authentication in which the two parties in a connection authenticate each other using the TLS protocol.

mTLS is often used in a Zero Trust security framework* to verify users, devices, and servers within an organization. It can also help keep APIs secure.


TLS works using a technique called public key cryptography, which relies on a pair of keys — a public key and a private key. Anything encrypted with the public key can be decrypted only with the private key.

Therefore, a server that decrypts a message that was encrypted with the public key proves that it possesses the private key. Anyone can view the public key by looking at the domain's or server's TLS certificate.

TLS
1. Client connects to server
2. Server presents its TLS certificate
3. Client verifies the server's certificate
4. Client and server exchange information over encrypted TLS connection



https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/


