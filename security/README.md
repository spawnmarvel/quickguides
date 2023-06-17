# General security

## RFC 6125 Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using :lock: :key: X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

https://datatracker.ietf.org/doc/html/rfc6125

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

## Zero trust

But on a smaller scale, mTLS is highly useful and quite practical for individual organizations, especially when those organizations employ a Zero Trust approach to network security.


https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/


## AZ-220 Implement Security (5-10%)

### Quick Reference: Key Concepts and Terminology

Three widely used authentication types are X.509 certificates, Trusted Platform Modules (TPM), and symmetric keys.

X.509 certificate - A type of digital identity you can use for authentication. The X.509 certificate standard is documented in IETF RFC 5280. 

In Azure IoT, there are two ways to authenticate certificates:

* Thumbprint. A thumbprint algorithm is run on a certificate to generate a hexadecimal string. The generated string is a unique identifer for the certificate.
* :lock: :key: CA authentication based on a full chain. A certificate chain is a hierarchical list of all certificates needed to authenticate an end-entity (EE) certificate. To authenticate an EE certificate, it’s necessary to authenticate each certificate in the chain including a trusted root CA.

Pros for X.509

* X.509 is the most secure authentication type supported in Azure IoT.
* X.509 allows a high level of control for purposes of certificate management.
* Many vendors are available to provide X.509 based authentication solutions.

Cons for X.509

* Many customers may need to rely on external vendors for their certificates.
* Certificate management can be costly and adds to total solution cost.
* Certificate life-cycle management can be difficult if logistics are not well thought out.

Trusted Platform Module (TPM) - A standard for securely generating and storing cryptographic keys, also known as ISO/IEC 11889. TPM also refers to a virtual or physical I/O device that interacts with modules that implement the standard.

There are two key differences between TPMs and symmetric keys:

* TPM chips can also store X.509 certificates.
* TPM attestation in DPS uses the TPM endorsement key (EK), a form of asymmetric authentication. With asymmetric authentication, a public key is used for encryption, and a separate private key is used for decryption. In contrast, symmetric keys use symmetric authentication, where the private key is used for both encryption and decryption.

Pros for TPM

* TPMs are included as standard hardware on many Windows devices, with built-in support for the operating system.
* TPM attestation is easier to secure than shared access signature (SAS) token-based symmetric key attestation.
* You can easily expire and renew, or roll, device credentials. DPS automatically rolls the IoT Hub credentials whenever a TPM device is due for reprovisioning.

Cons for TPM

* TPMs are complex and can be difficult to use.
* Application development with TPMs is difficult unless you have a physical TPM or a quality emulator.
* You may have to redesign the board of your device to include a TPM in the hardware.
* If you roll the EK on a TPM, it destroys the identity of the TPM and creates a new one. Although the physical chip stays the same, it has a new identity in your IoT solution.

Symmetric key - The same key is used to encrypt and decrypt messages. As a result, the same key is known to both the device and the service that authenticates it. 

Azure IoT supports SAS token-based symmetric key connections. 

Symmetric key authentication requires significant owner responsibility to secure the keys and achieve an equal level of security with X.509 authentication. 

If you use symmetric keys, the recommended practice is to protect the keys by using a hardware security module (HSM).

Symmetric key - The same key is used to encrypt and decrypt messages. As a result, the same key is known to both the device and the service that authenticates it. Azure IoT supports SAS token-based symmetric key connections. :lock: :key: **Symmetric key authentication requires significant owner responsibility to secure the keys and achieve an equal level of security with X.509 authentication.** If you use symmetric keys, the recommended practice is to protect the keys by using a hardware security module (HSM).

Pros for symmetric key

* Using symmetric keys is the simplest, lowest cost way to get started with authentication.
* Using symmetric keys streamlines your process because there’s nothing extra to generate.

Cons for symmetric key

* Symmetric keys take a significant degree of effort to secure the keys. The same key is shared between device and cloud, which means the key must be protected in two places. In contrast, the challenge with TPM and X.509 * certificates is proving possession of the public key without revealing the private key.
* Symmetric keys make it easy to follow poor security practices. A common tendency with symmetric keys is to hard code the unencrypted keys on devices. While this practice is convenient, it leaves the keys vulnerable. You can mitigate some risk by securely storing the symmetric key on the device. However, :lock: :key: **if your priority is ultimately security rather than convenience, use X.509 certificates or TPM for authentication.**


https://microsoft.github.io/PartnerResources/azure/iot/assets/07ImplementSecurity


## Choosing a key algorithm

RSA

RSA-based signature schemes enjoy wide compatibility across multiple platforms by virtue of their age. If you need to support clients using legacy operating systems, protocols, firmware or other technology stacks, RSA is a common choice.

ECDSA

While asymmetric keys based on elliptic curves are relatively newer than their RSA counterparts, they are still supported in many of the most common technology stacks released over the last decade. They are especially popular because they can achieve similar levels of security strength to RSA keys using smaller key sizes. Applications that use ECDSA keys store and transmit less data over the wire.

Mixed chains

### Decision-making guide

You can use this simple guide to help you choose an appropriate signing algorithm for your CA key:

1 Choose an algorithm family
* If you are creating a subordinate CA chaining up to an existing root CA, use the same family as the root.
* If you are creating a new root CA but need to work with legacy systems that don't support ECDSA, use one of the RSA signing algorithms.
* Otherwise, use one of the Elliptic curve signing algorithms.

2 (RSA only) Choose a signature algorithm
* If you expect to work with older libraries or frameworks that don't support PSS, use one of the RSA_SIGN_PKCS1 algorithms.
* Otherwise, use one of the RSA_SIGN_PSS algorithms.

3 Choose a key size

For a new root CA or a subordinate CA that is expected to have a lifetime in the order of years, we recommend that you use the largest key size available for that algorithm family.
* For RSA, the largest supported key size is 4096 bits.
* For ECDSA, the largest supported key size is 384 bits.
For subordinate CAs with a shorter lifetime, it is sufficient to use smaller key sizes, such as 2048 bits for RSA or 256 bits for ECDSA.


https://cloud.google.com/certificate-authority-service/docs/choosing-key-algorithm

## certreq

The certreq command can be used to request certificates from a certification authority (CA), to retrieve a response to a previous request from a CA, to create a new request from an .inf file, to accept and install a response to a request, to construct a cross-certification or qualified subordination request from an existing CA certificate or request, and to sign a cross-certification or qualified subordination request.



| Key | Description | Example
| --- | ----------- | ----
| Subject | Several apps rely on the subject information in a certificate. | Subject = CN=computer1.contoso.com
| KeySpec | Determines if the key can be used for signatures, for Exchange (encryption), or for both. | KeySpec = 1
| KeyLength | Defines the length of the public and private key. | KeyLength = 2048
| Exportable | If set to TRUE, the private key can be exported with the certificate. | Exportable = TRUE
| MachineKeySet | This key is important when you need to create certificates that are owned by the machine and not a user. Private keys are stored in the local computer store rather than the current user store. | MachineKeySet = TRUE
| SMIME | If this parameter is set to TRUE, an extension with the object identifier value 1.2.840.113549.1.9.15 is added to the request. (Secure Multipurpose Internet Mail) | SMIME = FALSE
| PrivateKeyArchive | The PrivateKeyArchive setting works only if the corresponding RequestType is set to CMC because only the Certificate Management Messages over CMS (CMC) request format allows for securely transferring the requester's private key to the CA for key archival. | PrivateKeyArchive = FALSE
| UserProtected | Notify the user through a dialog box or other method that the key is accessed. The Cryptographic Service Provider (CSP) in use defines the precise behavior. | UserProtected = FALSE
| UseExistingKeySet | This parameter is used to specify that an existing key pair should be used in building a certificate request | UseExistingKeySet = FALSE
| ProviderName | The provider name is the display name of the CSP. If you don't know the provider name of the CSP you are using, run certutil –csplist from a command line. | ProviderName = Microsoft RSA SChannel Cryptographic Provider
| ProviderType | The provider type is used to select specific providers based on specific algorithm capability such as RSA Full. | ProviderType = 12
| RequestType | Determines the standard that is used to generate and send the certificate request. PKCS10 -- 1, PKCS7 -- 2  | RequestType = PKCS10
| KeyUsage | Defines what the certificate key should be used for. Older syntax can also be used: a single hexadecimal value with multiple bits set, instead of the symbolic representation. | For example, KeyUsage = 0xa0



https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1

https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509keystorageflags?view=net-7.0

## Entrust

```bash
Save the following file as request.inf on your server editing the subject according to the comment:

;----------------- request.inf -----------------

[Version]
Signature="$Windows NT$"

[NewRequest]
;Change to your,country code, company name and common name
Subject = "C=US, O=Example Co, CN=something.example.com"

KeySpec = 1
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
SMIME = False
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
ProviderType = 12
RequestType = PKCS10
KeyUsage = 0xa0

[EnhancedKeyUsageExtension]
OID=1.3.6.1.5.5.7.3.1 ; this is for Server Authentication / Token Signing


[Version]
Signature= "$Windows NT$"
[NewRequest]
Subject= "CN=server.domain.com"
KeySpec = 1
KeyLength = 2048
Exportable = FALSE
MachineKeySet = TRUE
SMIME = FALSE
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
ProviderType = 12
RequestType = PKCS10
KeyUsage = 0xa0

```

https://www.entrust.com/knowledgebase/ssl/csr-generation-and-installation-using-certreq-command-windows

## Request a Client Server Authentication

```bash
;----------------- request.inf -----------------
  [Version]
  
  Signature="$Windows NT$"

  [NewRequest]
   
  Subject = "CN=XX-UNIT-EXAMPLE.ads.iu.edu" 
  ;
  ;replace XX-UNIT-EXAMPLE in this line with workstation name, follow UITS naming conventions
  ;
  KeySpec = 1
  KeyLength = 2048
  Exportable = TRUE
  FriendlyName = "IU Client Server Authentication (Offline request)" 
  ;
  ;friendly name for request
  ;
  MachineKeySet = TRUE
  SMIME = False
  PrivateKeyArchive = FALSE
  UserProtected = FALSE
  UseExistingKeySet = FALSE
  ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
  ProviderType = 12
  RequestType = PKCS10
  KeyUsage = 0xa0
 
  [EnhancedKeyUsageExtension]
  
  OID=1.3.6.1.5.5.7.3.2; Client authentication
  OID=1.3.6.1.5.5.7.3.1; Server authentication

  [Extensions]
  
  2.5.29.17 = "{text}dns=XX-UNIT-EXAMPLE.ads.iu.edu" 
  ;
  ;replace XX-UNIT-EXAMPLE in this line with workstation name, follow UITS naming conventions
  ;
  ;-----------------------------------------------
```

https://kb.iu.edu/d/beyk




## ISO and IEC Approve OASIS AMQP Advanced Message Queuing Protocol

Example with AMQPS and client/server (shovel) configured with X.509 running mTls(Tls), and information about the AMQP approved as an open standard.

https://github.com/spawnmarvel/quickguides/tree/main/amqp


![Chain](https://github.com/spawnmarvel/quickguides/blob/main/security/chain.jpg)

https://www.rabbitmq.com/ssl.html#peer-verification


## Security best practices for IoT solutions

You can divide security in an IoT solution into the following three areas:

* Device security: Securing the IoT device while it's deployed in the wild.
* Connection security: Ensuring all data transmitted between the IoT device and IoT Hub is confidential and tamper-proof.
* Cloud security: Providing a means to secure data while it moves through, and is stored in the cloud.

Connection security

* Use X.509 certificates to authenticate your devices to IoT Hub: IoT Hub supports both X509 certificate-based authentication and security tokens as methods for a device to authenticate with your IoT hub. If possible, use :lock: :key: X509-based authentication in production environments as it provides greater security.
* Use Transport Layer Security (TLS) 1.2 to secure connections from devices: IoT Hub uses TLS to secure connections from IoT devices and services. 
* Ensure you have a way to update the TLS root certificate on your devices: TLS root certificates are long-lived, but they still may expire or be revoked.
* Consider using Azure Private Link: Azure Private Link lets you connect your devices to a private endpoint on your VNet, enabling you to block access to your IoT hub's public device-facing endpoints.

https://learn.microsoft.com/en-us/azure/iot/iot-security-best-practices

## Device authentication concepts in IoT Central

Devices authenticate with the IoT Central application by using either a shared access signature (SAS) token or an X.509 certificate. X.509 certificates are recommended in production environments.

### X.509 enrollment group

In a production environment, using X.509 certificates is the recommended device authentication mechanism for IoT Central. To learn more, see Device Authentication using X.509 CA Certificates.

An X.509 enrollment group contains a root or intermediate X.509 certificate. Devices can authenticate if they have a valid leaf certificate that's derived from the root or intermediate certificate.

## SAS enrollment group

A SAS enrollment group contains group-level SAS keys. Devices can authenticate if they have a valid SAS token that's derived from a group-level SAS key.

https://learn.microsoft.com/en-us/azure/iot-central/core/concepts-device-authentication


## Authenticating a device to IoT Hub

Supported X.509 certificates

* You can use any :lock: :key: X.509 certificate to authenticate a device with IoT Hub by uploading either a certificate thumbprint or a certificate authority (CA) to Azure IoT Hub.

Enforcing X.509 authentication

* For additional security, an IoT hub can be configured to not allow SAS authentication for devices and modules, leaving X.509 as the only accepted authentication option.

```
az resource update -n <iothubName> -g <resourceGroupName> --resource-type Microsoft.Devices/IotHubs --set properties.disableDeviceSAS=true properties.disableModuleSAS=true
```

Use SAS tokens as a device

There are two ways to obtain DeviceConnect permissions with IoT Hub with SAS tokens: 

* use a symmetric device key from the identity registry
* or use a shared access key.


https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-dev-guide-sas?tabs=node#authenticating-a-device-to-iot-hub

# Extra:

## Create an Azure service principal with Azure PowerShell (SPN) key vault RBAC

https://follow-e-lo.com/2023/04/25/create-an-azure-service-principal-with-azure-powershell/

## Use a Windows VM system-assigned managed identity to access Azure Storage via a SAS credential

https://follow-e-lo.com/2022/08/13/5min-tutorial-use-a-windows-vm-system-assigned-managed-identity-to-access-azure-storage/


## More links to read and OSI


Connect To RabbitMQ From A Different Machine Or Network (bitnami)
https://docs.bitnami.com/google-templates/infrastructure/rabbitmq/administration/connect-remotely/

How to Protect Secrets When Using GitHub Actions?
https://blog.mergify.com/how-to-protect-secrets-when-using-github-actions/

How to use GitHub Actions securely
https://mattermost.com/blog/how-to-use-github-actions-securely/

Configure the Microsoft Security DevOps GitHub action
https://learn.microsoft.com/en-us/azure/defender-for-cloud/github-action

GitHub Actions Security Best Practices
https://blog.gitguardian.com/github-actions-security-cheat-sheet/

Authentication, Authorisation, Access Control AMQP
https://www.rabbitmq.com/access-control.html

Exam SC-900: Microsoft Security, Compliance, and Identity Fundamentals
https://learn.microsoft.com/en-us/certifications/exams/sc-900/