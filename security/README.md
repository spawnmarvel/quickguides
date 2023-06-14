# General security

## RFC 6125 ... Identity within Internet Public Key Infrastructure Using X.509 (PKIX) [...]

Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

https://datatracker.ietf.org/doc/html/rfc6125

## ISO and IEC Approve OASIS AMQP Advanced Message Queuing Protocol

Example with AMQPS and client/server (shovel) configured with X.509 running mTls(Tls), and information about the AMQP approved as an open standard.

https://github.com/spawnmarvel/quickguides/tree/main/amqp

## What is mutual TLS (mTLS)?

Mutual TLS (mTLS) is a type of authentication in which the two parties in a connection authenticate each other using the TLS protocol.

mTLS is often used in a Zero Trust security framework* to verify users, devices, and servers within an organization. It can also help keep APIs secure.


* TLS works using a technique called public key cryptography, which relies on a pair of keys — a public key and a private key. 
* Anything encrypted with the public key can be decrypted only with the private key.

Therefore, a server that decrypts a message that was encrypted with the public key proves that it possesses the private key. Anyone can view the public key by looking at the domain's or server's TLS certificate.

TLS
1. Client connects to server
2. Server presents its TLS certificate
3. Client verifies the server's certificate
4. Client and server exchange information over encrypted TLS connection


![TLS](https://github.com/spawnmarvel/quickguides/blob/main/security/tls.jpg)

In mTLS, however, both the client and server have a certificate, and both sides authenticate using their public/private key pair.

1. Client connects to server
2. Server presents its TLS certificate
3. Client verifies the server's certificate
4. Client presents its TLS certificate
5. Server verifies the client's certificate
6. Server grants access
7. Client and server exchange information over encrypted TLS connection

![mTLS](https://github.com/spawnmarvel/quickguides/blob/main/security/mtls.jpg)

## Why use mTLS?

mTLS helps ensure that traffic is secure and trusted in both directions between a client and server. 

This provides an additional layer of security for users who log in to an organization's network or applications. 

It also verifies connections with client devices that do not follow a login process, such as Internet of Things (IoT) devices.

mTLS prevents various kinds of attacks, including:

* On-path attacks: On-path attackers place themselves between a client and a server and intercept or modify communications between the two. When mTLS is used, on-path attackers cannot authenticate to either the client or the server, making this attack almost impossible to carry out.
* Spoofing attacks: Attackers can attempt to "spoof" (imitate) a web server to a user, or vice versa. Spoofing attacks are far more difficult when both sides have to authenticate with TLS certificates.
* Credential stuffing: Attackers use leaked sets of credentials from a data breach to try to log in as a legitimate user. Without a legitimately issued TLS certificate, credential stuffing attacks cannot be successful against organizations that use mTLS.
* Brute force attacks: [...] mTLS ensures that a password is not enough to gain access to an organization's network.
* Phishing attacks: [...] Even if a user falls for such an attack, the attacker still needs a TLS certificate and a corresponding private key in order to use those credentials.
* Even if a user falls for such an attack, the attacker still needs a TLS certificate and a corresponding private key in order to use those credentials.

## Websites already use TLS, so why is mTLS not used on the entire Internet?
For everyday purposes, one-way authentication provides sufficient protection. The goals of TLS on the public Internet are:
1. to ensure that people do not visit spoofed websites
2. to keep private data secure and encrypted as it crosses the various networks that comprise the Internet
3. to make sure that data is not altered in transit.

TLS, accomplishes these goals.



https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/


