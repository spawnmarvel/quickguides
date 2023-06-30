# ChatGPT

When it comes to secure data transfer over the internet, there are several best practices you can follow to protect your data. Here are some key recommendations:

1. Encryption: Utilize encryption techniques to protect the confidentiality of your data. Use strong encryption algorithms such as AES (Advanced Encryption Standard) for symmetric encryption and RSA (Rivest-Shamir-Adleman) or ECC (Elliptic Curve Cryptography) for asymmetric encryption.

2. Secure Protocols: Use secure protocols such as HTTPS (Hypertext Transfer Protocol Secure) for web communications and SFTP (Secure File Transfer Protocol) or FTPS (FTP over SSL/TLS) for file transfers. These protocols provide encryption and authentication to safeguard data during transmission.

3. SSL/TLS Certificates: Implement SSL/TLS certificates to establish secure connections between clients and servers. This ensures data integrity and authenticity. Keep the certificates up to date and obtain them from trusted Certificate Authorities.

4. Strong Authentication: Implement strong authentication mechanisms to prevent unauthorized access. Require complex passwords or consider using multifactor authentication (MFA) methods such as SMS codes, tokens, or biometrics to enhance security.

5. Firewall and Intrusion Detection Systems: Set up firewalls and intrusion detection systems to monitor and control incoming and outgoing network traffic. Configure them properly to filter out potential threats and block unauthorized access attempts.

6. Regular Updates and Patching: Keep all software, including operating systems, web servers, and applications, up to date with the latest security patches. Vulnerabilities in software can be exploited by attackers, and updates often include critical security fixes.

7. Secure File Transfer: If you need to transfer files, consider using secure file transfer mechanisms such as Secure FTP (SFTP), which encrypts both commands and data, or use secure file-sharing services with strong access controls.

8. Data Loss Prevention (DLP): Implement DLP solutions to prevent accidental or intentional data leaks. DLP tools can identify sensitive data and enforce policies to control its transfer and storage, minimizing the risk of data breaches.

9. Employee Awareness and Training: Educate your employees about data security best practices. Train them to recognize phishing attempts, use strong passwords, and follow secure data handling procedures. Regularly remind them about the importance of security and keep them informed about emerging threats.

10. Regular Auditing and Monitoring: Implement robust monitoring and auditing mechanisms to detect any suspicious activities or unauthorized access attempts. Regularly review logs and monitor network traffic to identify potential security breaches.


Remember, security is an ongoing process, and it is essential to stay updated with the latest security practices and emerging threats. Consider consulting with cybersecurity professionals to ensure you are following the most up-to-date and appropriate security measures for your specific use case

# Vicuna extra

Use a VPN: Consider using a virtual private network (VPN) to encrypt and secure the data as it travels over the internet.
Use access controls: Use access controls such as user authentication and authorization to ensure that only authorized individuals can access the data.
Use a reputable service provider: Choose a reputable service provider with a track record of security and data protection.


# General security PKI

## RFC 6125 Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using :lock: :key: X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

https://datatracker.ietf.org/doc/html/rfc6125


## Public Key Infrastructure (PKI) In a Nutshell

* Public key infrastructure is technology used to prove one’s identity by 3rd party
* To declare trust to a Certificate authority (CA), you must install the CA certificate in folder called trusted root certification authority in windows for example.
* Now after you declare that you trust these CAs, anyone who has a valid certificate obtained by one of your CAs will be trusted on your machine

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


## Azure best practices for network security

| Practise           | Description
| ------------------ | --------------------------------------------
| Use strong network controls | You can connect Azure virtual machines (VMs) and appliances to other networked devices by placing them on Azure virtual networks
| Logically segment subnets   | Azure virtual networks are similar to LANs on your on-premises network. The idea behind an Azure virtual network is that you create a network, based on a single private IP address space, on which you can place all your Azure virtual machines.
| Adopt a Zero Trust approach |
| Control routing behavior | You can configure the next-hop address to reach specific destinations.
| Use virtual network appliances | Network security groups and user-defined routing can provide a certain measure of network security at the network and transport layers of the OSI model. But in some situations, you want or need to enable security at high levels of the stack.
| Deploy perimeter networks for security zones | A perimeter network (also known as a :bridge_at_night:dmz) is a physical or logical network segment that provides an extra layer of security between your assets and the internet. Specialized network access control devices on the edge of a perimeter network allow only desired traffic into your virtual network.
| Avoid exposure to the internet with dedicated WAN links | Site-to-site VPN. It's a trusted, reliable, and established technology, but the connection takes place over the internet. Bandwidth is constrained to a maximum of about 1.25 Gbps. Site-to-site VPN is a desirable option in some scenarios. <br/>Azure ExpressRoute. We recommend that you use ExpressRoute for your cross-premises connectivity. ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection facilitated by a connectivity provider. 
| Disable RDP/SSH Access to virtual machines | Bastion, Jump server, Point-to-site VPN,  site-to-site VPN, ExpressRoute.
| Secure your critical Azure service resources to only your virtual networks | Improved security for your Azure service resources: With Azure Private Link<br>Privately access Azure service resources on the Azure platform<br/>Access from On-premises and peered networks<br/>Protection against data leakage<br/>


https://learn.microsoft.com/en-us/azure/security/fundamentals/network-best-practices

## DMZ network

In computer security, a :bridge_at_night:DMZ network (sometimes referred to as a “demilitarized zone”) functions as a subnetwork containing an organization's exposed, outward-facing services. It acts as the exposed point to an untrusted network, commonly the internet.

The goal of a :bridge_at_night:DMZ is to add an extra layer of security to an organization's local area network. A protected and monitored network node that faces outside the internal network can access what is exposed in the :bridge_at_night:DMZ, while the rest of the organization's network is safe behind a firewall.

When implemented properly, a :bridge_at_night:DMZ network gives organizations extra protection in detecting and mitigating security breaches before they reach the internal network, where valuable assets are stored.

![DMZ ](https://github.com/spawnmarvel/quickguides/blob/main/security/dmz.jpg)

https://www.barracuda.com/support/glossary/dmz-network

## Implement a secure hybrid network

This reference architecture shows a secure hybrid network that extends an on-premises network to Azure. The architecture implements a perimeter network, also called a :bridge_at_night:DMZ, between the on-premises network and an Azure virtual network. All inbound and outbound traffic passes through Azure Firewall.

![Azure DMZ ](https://github.com/spawnmarvel/quickguides/blob/main/security/azure-dmz.jpg)

https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/dmz/secure-vnet-dmz?tabs=portal

## AZ-220 Implement Security (5-10%)

### Quick Reference: Key Concepts and Terminology

Three widely used authentication types are X.509 certificates, Trusted Platform Modules (TPM), and symmetric keys.

:lock: :key: X.509 certificate - A type of digital identity you can use for authentication. The :lock: :key: X.509 certificate standard is documented in IETF RFC 5280. 

In Azure IoT, there are two ways to authenticate certificates:

* Thumbprint. A thumbprint algorithm is run on a certificate to generate a hexadecimal string. The generated string is a unique identifer for the certificate.
* :lock: :key: CA authentication based on a full chain. A certificate chain is a hierarchical list of all certificates needed to authenticate an end-entity (EE) certificate. To authenticate an EE certificate, it’s necessary to authenticate each certificate in the chain including a trusted root CA.

Pros for :lock: :key: X.509

* :lock: :key: X.509 is the most secure authentication type supported in Azure IoT.
* :lock: :key: X.509 allows a high level of control for purposes of certificate management.
* Many vendors are available to provide X.509 based authentication solutions.

Cons for :lock: :key: X.509

* Many customers may need to rely on external vendors for their certificates.
* Certificate management can be costly and adds to total solution cost.
* Certificate life-cycle management can be difficult if logistics are not well thought out.

Trusted Platform Module (TPM) - A standard for securely generating and storing cryptographic keys, also known as ISO/IEC 11889. TPM also refers to a virtual or physical I/O device that interacts with modules that implement the standard.

There are two key differences between TPMs and symmetric keys:

* TPM chips can also store :lock: :key: X.509 certificates.
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


## MMC Create CSR and Key with Microsoft Management Console (MMC)


“Certificate Enrollment Requests” is where the private portion of your key is stored after generating a CSR while waiting for a CA’s response.

1. The contents of this file will be sent to your CA when you order an SSL Certificate. 
2. If you look under the “Certificate Enrollment Requests” node, you will see an object corresponding to the CSR awaiting the CA’s response.
3. When the CA returns a response, it can be imported by right clicking on the “Personal” node and selecting All Tasks -> Import. 
5. The enrollment request will disappear from “Certificate Enrollment Requests” and be replaced by an entry in the “Personal” node corresponding to your newly signed certificate. 
6. It is now available for use by software on your system, or available to be exported by right clicking the certificate and choosing



https://www.ssltrust.com.au/help/setup-guides/microsoft-certificates-mmc

## certreq

The certreq command can be used to request certificates from a certification authority (CA), to retrieve a response to a previous request from a CA, to create a new request from an .inf file, to accept and install a response to a request, to construct a cross-certification or qualified subordination request from an existing CA certificate or request, and to sign a cross-certification or qualified subordination request.


```cmd
# Open command prompt and make sure you have the full admin rights on the server to do this step
# certreq -new

certreq –new request.inf certificate.req


# When your certificate is issued you'll typically receive a file called certificate.crt
# Save it on the server and from the same directory run:
# The –accept parameter links the previously generated private key with the issued certificate and removes 
# the pending certificate request from the system where the certificate is requested (if there is a matching request).
# To manually accept a certificate

certreq -accept certificate.crt

# This will install the cert in the Windows certificate store and it will be available in IIS , MMC , Exchange , 
# LDAP/Active Directory , Terminal Services and those products that make use of the Windows certificate store.
```


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

## Entrust X.509

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



## Request my SSL certificate example

Choose

![Chain](https://github.com/spawnmarvel/quickguides/blob/main/security/request_ssl.jpg)

Paste

![Chain](https://github.com/spawnmarvel/quickguides/blob/main/security/request_ssl_paste.jpg)



https://uk.godaddy.com/help/request-my-ssl-certificate-562



# AMQP Advanced Message Queuing Protocol mTLS

Example with AMQPS and client/server (shovel) configured with :lock: :key:X.509 running mTls(Tls), and information about the AMQP approved as an open standard.

https://github.com/spawnmarvel/quickguides/tree/main/amqp


![Chain](https://github.com/spawnmarvel/quickguides/blob/main/security/chain.jpg)

https://www.rabbitmq.com/ssl.html#peer-verification


## AMQP Shovels

Connecting brokers with the Shovel plugin is conceptually similar to connecting them with Federation. However, the plugin works at a lower level.

Whereas federation aims to provide opinionated distribution of exchanges and queues, the shovel simply consumes messages from a queue on one broker, and forwards them to an exchange on another.

Typically you would use the shovel to link brokers across the internet when you need more control than federation provides.

https://www.rabbitmq.com/distributed.html

## AMQP, RabbitMQ From A Different Machine Or Network (bitnami)

Connect To RabbitMQ From A Different Machine Or Network (bitnami)

The recommended way for connecting two instances deployed in different networks is by using VPC network peering. 

* Virtual Private Clouds (VPCs), even if those instances belong to different projects or are hosted in different regions. 
* This feature, known as VPC Network Peering, can result in better security (as services do not need to be exposed on public IP addresses) and performance (due to use of private, rather than public, networks and IP addresses).

If you must make it accessible over a public IP address, we recommend restricting access to a trusted list of source IP addresses and ports using firewall rules. 

To do so, follow the instructions below.

* Option 1: Peer both virtual networks to secure the connections between the two instances.
* Option 2: Create an SSH tunnel to connect the application using the public IP address. 
* Option 3: Make the server publicly accessible and restrict access to a trusted list of source IP addresses using firewall rules.


https://docs.bitnami.com/google-templates/infrastructure/rabbitmq/administration/connect-remotely/

## How to connect to remote RabbitMQ Server behind a corporation proxy

RabbitMQ client libraries need to be able to resolve hostnames and TCP connectivity to the target host(s), so if a SOCKS proxy configuration provides those things, there really isn't much else to configure.


https://groups.google.com/g/rabbitmq-users/c/b2zrs3FKiLo?pli=1

## Authentication, Authorisation, Access Control AMQP

Authentication, Authorisation, Access Control AMQP

https://www.rabbitmq.com/access-control.html

## How To Set Up SSL/TLS Client (Mutual) Authentication Between An IBM WebSphere Application Server And The IBM Web Server Plug-in

SSL/TLS Client authentication (AKA Mutual authentication) is similar to regular, server authentication except that the server requests a certificate from the client to verify the client is who they claim to be. The certificate must be an :lock: :key: X.509 certificate and signed by a certificate authority (CA) trusted by the server.

Ultimately, SSL/TLS Client/Mutual authentication provides a more secure method for the server to verify the client's identity. This can be useful with IBM WebSphere Application Server (WAS) when a Web Server is configured on a remote machine in front of WAS. When the Web Server is located on a remote machine, communications between WAS and the Web Server Plug-in might occur over the Internet, which exposes the data. Enabling SSL/TLS Client/Mutual authentication will not only encrypt the data like the standard, Server authentication; but it will also provide a higher level of verification of the client entity to ensure the client can be trusted.

https://www.ibm.com/support/pages/how-set-ssltls-client-mutual-authentication-between-ibm-websphere-application-server-and-ibm-web-server-plug


# Security best practices for IoT solutions

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

# CI/CD Github Actions 

## Implement CI/CD with GitHub – Deploy Azure Functions

https://follow-e-lo.com/2023/06/13/implement-ci-cd-with-github-deploy-azure-functions/


## Configure the Microsoft Security DevOps GitHub action

https://learn.microsoft.com/en-us/azure/defender-for-cloud/github-action

Managing security and analysis settings for your organization

In the "Security" section of the sidebar, click  Code security and analysis.

![Github enable](https://github.com/spawnmarvel/quickguides/blob/main/security/github_enable.jpg)

You can enable or disable features for all repositories. The impact of your changes on repositories in your organization is determined by their visibility:

* Private vulnerability reporting - Your changes affect public repositories only.
* Dependency graph - Your changes affect only private repositories because the feature is always enabled for public repositories.
* Dependabot alerts - Your changes affect all repositories.
* Dependabot security updates - Your changes affect all repositories.
* Secret scanning - Your changes affect public repositories and public npm packages these repositories may depend on. This option controls whether or not secret scanning alerts for users are enabled. Secret scanning alerts for partners always runs on all public repositories.
* Code scanning - Your changes affect public repositories

![Code security and analysis](https://github.com/spawnmarvel/quickguides/blob/main/security/git_hub_code_security_and_analysis.jpg)

When you enable one or more security and analysis features for existing repositories, you will see any results displayed on GitHub within minutes

![Github detect](https://github.com/spawnmarvel/quickguides/blob/main/security/github_detect.jpg)

When you open the mail you can drill down to where the issue is located at.


![Security overview](https://github.com/spawnmarvel/quickguides/blob/main/security/github_security_overview.jpg)

https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/managing-security-and-analysis-settings-for-your-organization

## How to Protect Secrets When Using GitHub Actions?

GitHub Actions are a new breed of FaaS. This new service allows anyone to write and execute code in the form of a script run by the GitHub platform. 

But one thing most developers and SREs miss when working with GitHub actions is to protecting the secrets leading to data leaks.

GitHub Actions are a powerful tool that allows you to automate your workflow.

* Say NO to Plain Text Secrets
* * Direct hard-coding secrets such as database username and password in the .yml file lead to sensitive data exposure, which is a security concern.

The problem with using plain text secrets directly in the GitHub actions is that these secrets are checked into your code. If someone gets a hold of your code, that person has access to your secrets.

With this in mind, using environment variables (GitHub Secrets) to store your secrets seems wiser. This way, you can use the same secrets in your CI server, local machine, and deployment scripts. But what exactly is a GitHub secret?

* "Secret" is a data type in GitHub actions used to store sensitive data that you do not want to include in your GitHub action's source code. 
* Secrets are encrypted using a libsodium sealed box to keep them secure.

```bash

${{ secrets.SECRET_NAME }}

```

How to Create & Use GitHub Secrets?

Before diving into how to create secrets, you must know that there are three types of secrets in GitHub: Repository, Environment & Organization.

Repository Secrets
* Repository Secrets are visible to everyone with access to the repository and are used to store sensitive information like deployment keys.
* To create a repository secret, navigate to the settings tab of your repository and click on Secrets < Actions < New repository secret. Enter the name & value of the secret and click on Add button.

![Github secret](https://github.com/spawnmarvel/quickguides/blob/main/security/github_secret.jpg)

Environment Secrets
* Environment secrets are tied to repository-level secrets, but these are linked to specific examples such as dev, staging, or prod. These types of secrets are useful when you have multiple testing environments, each of which has different resources.
* To create an environment secret, navigate to the settings tab of the repository and click on Environments < Choose Environment < Environment Secrets < Add Secret. Enter the name & value of the secret and click Add secret.

Organization Secrets
* Organization Secrets are visible to members of the organization and are used to store sensitive information like API keys. You can also limit the repositories that can access those secrets.
* To create an organization secret, navigate to the main page of the organization (for example, https://github.com/Mergifyio) and click on Settings < Secrets < Actions < New organization secret. Enter the secret details and click on Add secret button.

Note: You must have Admin level privileges to create an organization secret.

https://blog.mergify.com/how-to-protect-secrets-when-using-github-actions/

## How to use GitHub Actions securely

A combined source control solution with CI/CD pipelines is a powerful capability, as organizations can manage their application lifecycle processes from within a single solution. But at the same time, organizations should watch out for potential security risks and threats if the solution’s implementation doesn’t have security as the core focus.

Securing your software development and application release chain entails several different mechanisms and scenarios to keep under control. This article focuses on five ways to use GitHub Actions securely:

| # | Description | Comment
| - | ----------- | ------- 
| 1 | Use trusted code | One of the most vital features of GitHub source control is the built-in secure code scanning tool, based on CodeQL and Dependabot. Code scanning is available for public and private repositories in a GitHub Enterprise Advanced Security licensed scenario.
| 2 | Self-hosted runners versus public-hosted runners | ***GitHub-hosted runners*** are the virtual machines executing the Actions workflows and events. Once a workflow is complete, the GitHub-hosted runner completely resets, guaranteeing the machine is completely clean. It’s impossible to gain access to any information that was running or stored on that machine.<br/><br/> ***Self-hosted runners*** are virtual machines that you set up yourself, often to have more control of what’s running inside that virtual machine. You can deploy these runners in your on-premises network or public cloud scenarios. While you might consider them more secure since your security teams run in an environment you control, they’re also vulnerable to security threats. Often, self-hosted runners are not as fleeting as the GitHub-hosted ones. Without continuous updates, information stored on the server—and the tools and packages running on it—become a security risk. Next, ensure you don’t use self-hosted runners for public repositories. Actions are available to anyone in a public repository, which might expose a security breach in your self-hosted runners, compromising the rest of your network. You should use the latest versions of the supported operating systems where possible (e.g., Ubuntu Linux 20.04, Windows Server 2022, or macOS Big Sur 11, identified as <OS>-latest):
| 3 | Understand the pull_request trigger and the vulnerabilities it creates| Typically, you’d require manual approval because of the peer review concept of DevOps, where someone is watching over the code in the branch before accepting a merge into the main branch.<br/><br/>However, there might be situations where organizations might decide to allow GitHub Actions to create and approve such pull requests. While there may be benefits from enabling this setting, it could be risky to allow GitHub Actions to trigger this Action. 
| 4 | Understand the risks coming with script injections and how to prevent them | Script injections are a vital part of how GitHub runs Actions. Think of these as additional tasks that run as part of your Actions’ workflow to perform “something.”  When creating workflows, custom Actions, and composite Actions, you should always consider whether your code might execute untrusted input from attackers. <br/><br/> In general, when using braces ({{ }}) in a GitHub Action, they pick up variable values, which can be system properties or custom ones you define. Typically, workflow execution replaces these values.<br/><br/> Using the if statement as part of the run event allows you to perform a specific task when the outcome of the value is true or false. <br/>if [[ “${{ github.event.issue.title}}” == *” issue”$* ]] <br/>then<br/><action step here, for example curl>
| 5 | Efficiently managing secrets and authentication (OpenID Connect)| It should be no surprise that storing secrets as plain text within your source code or as part of your GitHub Actions workflows is a mistake. Luckily, GitHub provides built-in secret detection for many common solutions and cloud platforms, as outlined in the GitHub docs. The security engine is looking for “security patterns,” identifying secrets and connection strings for Adobe, Amazon AWS, Microsoft Azure, and many other platforms. <br/><br/>This protects your secrets and secret strings as GitHub won’t allow you to store these strings inside a GitHub repository. However, applications need secrets to interact with one another or allow your GitHub Actions to communicate with the target environment when running a deployment. While it’s still possible to create secret variables for this authentication, think of service principles when using Azure or a service ID when targeting Amazon AWS. However, you should rely on OpenID Connect to authenticate your Actions with a target cloud environment

https://mattermost.com/blog/how-to-use-github-actions-securely/


## GitHub Actions Security Best Practices

* Set minimum scope for credentials, the GITHUB_TOKEN should always be granted the minimum required permissions to execute a workflow/job.
* * You should make use of the ‘permission’ key in your workflows to configure the minimum required permissions for a workflow or job. This will allow fine-grained control over the privileges of your GitHub Actions.
* Use specific action version tags
* * Typically, when people make their own workflows on GitHub, they use Actions made by someone else. Almost all workflows begin with a step like the one below:

```yaml
 - name: Checkout repository
   uses: actions/checkout@v3
```

* * The important part to consider is how it checks out your code. That line that starts with “uses” means that there’s some work going on behind the scenes to get the code from your GitHub repo to the server that is running your workflow. For the “actions/checkout” action, that behind-the-scenes stuff lives in its own repo. 
* * No one has the time to watch for updates on every third-party action they use, but luckily GitHub gives us a way to prevent updates from altering the actions we use. Rather than running an action with a tag from the repo, you can use a commit hash.
* Don’t use plain-text secrets
* Don’t reference values that you don’t control, GitHub allows you to use ${{}} brackets to reference secrets and other values from your GitHub environment.

https://blog.gitguardian.com/github-actions-security-cheat-sheet/


# Exam SC-900: Microsoft Security, Compliance, and Identity Fundamentals

https://learn.microsoft.com/en-us/certifications/exams/sc-900/


# Extra:

##  Cogent Aveva Secure plant to cloud

With the DataHub IoT Gateway you never need Internet access on the plant network. 

Using the DataHub within a :bridge_at_night:dmz means no inbound firewall ports on either the plant network or the cloud.

The DataHub on the plant network provides an outbound connection to the :bridge_at_night:dmz, and the DataHub on the :bridge_at_night:dmz uses an outbound MQTT connection to send data to the cloud.

https://www.aveva.com/en/products/datahub-iot-gateway/

## DATAHUB IOT GATEWAY

The DataHub® IoT Gateway™ streams real-time OPC UA and OPC DA industrial data directly into Manufacturing Execution Systems (MES), device clouds, and Big Data analytics platforms.


https://cogentdatahub.com/products/datahub-iot-gateway/

## Cogent Documentation 3.12.3.1. Azure IoT Hub


Because MQTT is a messaging protocol, not a data communications protocol, it does not specify a particular format for making a connection or the data payload. Thus, each MQTT implementation can be different with its own, unique connection characteristics.

Our Standard MQTT option provides a generic way to configure a connection to any MQTT broker. In addition, we offer the following pre-configured options to facilitate connecting to Azure [...]

* IoT Hub Name
* Device Name
* Tell IoT Hub to treat messages as JSON text instead of binary.
* Subscribe to cloud-to-device events

Azure IoT Hub does not allow a client application to subscribe to a topic. That is the way Azure is designed. It was never intended to be a general-purpose MQTT broker. The only way to get data from Azure via MQTT is through a mechanism called “Cloud-to-device events”. There is a setting in the DataHub configuration for that. You need to generate the events from the Azure portal. The Azure documentation can provide more information:
https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-devguide-messaging

* CA Certificates
* * DataHub software supports CA certificates for SSL, in either PEM or PFX format. To use a CA certificate you need to do the following in your Azure IoT Hub configuration : [...]
* Azure IoT Password Creation
* * The Azure IoT password is an SAS token. To generate the SAS token:


https://cogentdatahub.com/library/documentation/


## Manually install IBM WebSphere Application Server Network Deployment traditional on Azure Virtual Machines

* Create a custom virtual network and create the VMs within the network.
* Install WebSphere Application Server Network Deployment traditional on the VMs by using the graphical interface manually.
* Configure a WAS cluster by using the Profile Management Tool.
* Configure a PostgreSQL datasource connection in the cluster.
* Deploy and run a Java EE application in the cluster.
* Expose the application to the public internet via Azure Application Gateway.
* Validate the successful configuration.

https://learn.microsoft.com/en-us/azure/developer/java/migration/migrate-websphere-to-azure-vm-manually

# How to build a :bridge_at_night:dmz server in Azure

In general a web-server running in Azure could be protect with an Azure Application Gateway with WAF:

https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview



Azure routes traffic between Azure, on-premises, and Internet resources. Azure automatically creates a route table for each subnet within an Azure virtual network and adds system default routes to the table.

You can build :bridge_at_night:dmz in Azure Cloud within your subscription or tenant. The concept of a :bridge_at_night:dmz or perimeter network is not new; :bridge_at_night:dmz is a layered network security approach to minimize the attack footprint of an application.

Best Practices

* Segment- Multiple Azure Networks within a single vNET with large IP Address space.
* Control- Create multiple NSGs, associate FrontEnd NSG and Backend NSG with untrusted and trusted network respectively to control to and from Azure.
* Enforce – Enforce user-defined rules to allow only desired TCP & UDP traffic to the vNET, Use Virtual Network Appliance and Perimeter Networks at all times for Enterprise Azure deployment. 
* * Disable RDP at the VM level and allow RDP at the FrontEnd NSG. Use a jump box in the :bridge_at_night:dmz to access workloads.

## Create an Azure service principal with Azure PowerShell (SPN) key vault RBAC

https://follow-e-lo.com/2023/04/25/create-an-azure-service-principal-with-azure-powershell/

## Use a Windows VM system-assigned managed identity to access Azure Storage via a SAS credential

https://follow-e-lo.com/2022/08/13/5min-tutorial-use-a-windows-vm-system-assigned-managed-identity-to-access-azure-storage/