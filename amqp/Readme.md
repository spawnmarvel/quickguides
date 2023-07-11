# AMQP Shovel MTLS RFC-6125

https://www.rabbitmq.com/shovel.html
* Shovel plugin

## ISO and IEC Approve OASIS AMQP Advanced Message Queuing Protocol
AMQP provides a platform-agnostic method for ensuring information is safely transported between applications, among organizations, within mobile infrastructures, and across the Cloud. [...]

https://www.oasis-open.org/news/pr/iso-and-iec-approve-oasis-amqp-advanced-message-queuing-protocol/


## Open standard
AMQP v1.0 is an international standard that is ISO and IEC approved as ISO/IEC 19464:2014.
There are many reasons to develop an open standard. One of these reasons is easily implied by the term “open standard.” 

With AMQP being an open standard messaging protocol it’s much easier for completely different software systems to communicate without requiring a lot of extra overhead; 
such as custom integration code between any 2 systems, or even whole applications whose sole role is to facilitate those communications.

* 1 messaging protocol to rule them all

In addition to being a common messaging protocol between systems, AMQP is designed with a few key features in mind:

* Security
* Reliability
* Interoperability
* Standard
* Open

## Server Identity Check RFC-6125

https://datatracker.ietf.org/doc/html/rfc6125
* Representation and Verification of Domain-Based Application Service
Identity within Internet Public Key Infrastructure Using X.509 (PKIX)
Certificates in the Context of Transport Layer Security (TLS)
* RFC-6125

<details><summary>2.4. Server Identity Check</summary>
<p>

#### We can hide anything, even code!

   During the TLS negotiation, the client MUST check its understanding
   of the server hostname against the server's identity as presented in
   the server Certificate message, in order to prevent man-in-the-middle
   attacks.  Matching is performed according to these rules:

   * The client MUST use the server hostname it used to open the
      connection as the value to compare against the server name as
      expressed in the server certificate.  The client MUST NOT use any
      form of the server hostname derived from an insecure remote source
      (e.g., insecure DNS lookup).  CNAME canonicalization is not done.

   *  If a subjectAltName extension of type dNSName is present in the
      certificate, it SHOULD be used as the source of the server's
      identity.

   *  Matching is case-insensitive.

   *  A "*" wildcard character MAY be used as the left-most name
      component in the certificate.  For example, *.example.com would
      match a.example.com, foo.example.com, etc. but would not match
      example.com.

   *  If the certificate contains multiple names (e.g. more than one
      dNSName field), then a match with any one of the fields is
      considered acceptable.
</p>
</details>


## Mutal TLS

https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/



## AMQP Shovel MTLS URI with SNI and RFC-6125



## Shovel (amqp_client.ssl_options)
* https://www.rabbitmq.com/shovel.html
* * A shovel behaves like a well-written client application, which connects to its source and destination, 
  consumes and republishes messages, and uses acknowledgements on both ends to cope with failures.
* * A Shovel uses Erlang AMQP 0-9-1 and Erlang AMQP 1.0 clients under the hood.
* https://www.rabbitmq.com/uri-spec.html
* * The client must act as a TLS client, and begin the TLS handshake as soon as the underlying TCP/IP connection has been established. All AMQP 0-9-1 protocol data is sent as TLS "application data". Other than this, normal AMQP 0-9-1 behaviour is followed.
* https://www.rabbitmq.com/uri-query-parameters.html
* * amqps: TLS options can also be specified globally using the amqp_client.ssl_options configuration key in the rabbitmq.config or advanced.config
* https://www.rabbitmq.com/ssl.html
* * Peer verification is highly recommended in production environments. With careful consideration, disabling it can make sense in certain environments (e.g. development).
* * Thus it is possible to create an encrypted TLS connection without having to verify certificates. Client libraries usually support both modes of operation.
* * When peer verification is enabled, it is common for clients to also check whether the hostname of the server they are connecting to matches one of two fields in the server certificate: the SAN (Subject Alternative Name) or CN (Common Name).

## SSL
* https://www.rabbitmq.com/ssl.html#peer-verification
* * How Peer Verification Works
* * When a TLS connection is established client and server perform connection negotiation that takes several steps. The first step is when the peers optionally exchange their certificates. Having exchanged certificates, the peers can optionally attempt to establish a chain of trust between their CA certificates and the certificates presented. This acts to verify that the peer is who it claims to be
* * The process is known as peer verification or peer validation and follows an algorithm known as the Certification path validation algorithm.

https://github.com/spawnmarvel/quickguides/blob/main/amqp/1_Images_SSL_TLS_MTLS/test_9.2_mTLS_with%20SNI_Hostname1_Build_Global_SSL.jpg

##### 2709 Encrypt in init (Encode, Decode)

<details><summary>#2709</summary>
<p>

https://github.com/rabbitmq/rabbitmq-server/issues/2709

As of #2056:

* The client used by Shovel and Federation encrypts credentials on init and decrypts them when they have to be used.
* If for any reason an exception is logged before the process had a chance to encrypt them, there is nothing that can be done to prevent the runtime from logging what's in the process state as part of an exception.
* #2056 has shipped with RabbitMQ 3.8

Example:

https://github.com/spawnmarvel/quickguides/blob/main/amqp/info/Shovel_Encrypted_1.jpg


</p>
</details>

## Authentication

<details><summary>Authentication, Authorisation, Access Control</summary>
<p>

https://www.rabbitmq.com/access-control.html#basics

* a virtual host named / (a slash)
* a user named johndoe with a password, granted full access to the /somehost virtual host
* Two primary ways of authenticating a client are username/password pairs and X.509 certificates. 
* Username/password pairs can be used with a variety of authentication backends that verify the credentials.
* * Connections that fail to authenticate will be closed with an error message in the server log.
* [...]

</p>
</details>

## Scenario and roles for this test:

<details><summary>Two way direction and One way direction</summary>
<p>

#### We can hide anything, even code!

* Two way direction
* VM1 Client
* Initiator of shovel amqp client for:
* 1 PUT (shovel_put_local_data, queue22)
* 2 GET (shovel_get_remote_data, queue11)
* Uses amqp_client
* VM2 Server:
* Receives shovel data from PUT (on queue22) and can send back on GET (on queue11)


```mermaid
graph TD;
    Client-VM1-->Server-VM2;
    Server-VM2-->Client-VM1;
```

* One way direction
* VM1 Client
* Initiator of shovel amqp client for:
* 1 PUT (shovel_put_local_data, queue22)
* Uses amqp_client
* VM2 Server:
* Receives shovel data from PUT (on queue22)

```mermaid
graph TD;
    Client-VM1-->Server-VM2;
```
</p>
</details>

## Dependencies

<details><summary>The New and Old Config File Formats</summary>
<p>

#### We can hide anything, even code!


It depends in which way you install RabbitMQ. 
The file usually is not present. If you need it, you have to create it.
* Prior to 3.7.0:
* %APPDATA%\RabbitMQ\rabbitmq.config
The configuration file is named rabbitmq.config and uses the Erlang term format (aka the "classic format" for RabbitMQ config files).
* RabbitMQ 3.7.0+
* %APPDATA%\RabbitMQ\rabbitmq.conf
In RabbitMQ 3.7.0+, the main configuration file is rabbitmq.conf. An additional config file named advanced.config is also used for some advanced configuration settings; it uses the classic format.

* https://www.rabbitmq.com/configure.html
* That file is commonly named advanced.config. It will be merged with the configuration provided in rabbitmq.conf

* https://github.com/rabbitmq/rabbitmq-server/blob/v3.7.x/deps/rabbit/docs/rabbitmq.config.example
* Users of RabbitMQ 3.7.x, or later should prefer the new style format (rabbitmq.conf) in combination with an advanced.config file (as needed).



https://docs.vmware.com/en/VMware-Tanzu-RabbitMQ-for-Kubernetes/1.2/tanzu-rmq/GUID-configure.html


 | Configuration File  | Format Used                            | Purpose                             |
 | ------------------- | -------------------------------------- | ----------------------------------- |
 | rabbitmq.conf       | New style format (sysctl or ini-like)  | Should be used for most settings.   |
 | advanced.config     | Classic (Erlang terms)                 | A limited number of settings that cannot be expressed in the new style configuration format |

</p>
</details>

## Installing
<details><summary>Software version</summary>
<p>

For this test:
https://www.rabbitmq.com/install-windows.html
* rabbitmq-server-3.9.12
* otp_win64_24.2
* Win64 OpenSSL v1.1.1m (for most servers and a must if old win 2008)
* * https://slproweb.com/products/Win32OpenSSL.html or download the msi in this repository ~ OpenSSLMsi
* * Win 2019 (OpenSSL 3.0 and 1.1.1 Binary Distributions for Microsoft Windows) should (!?) work that was used for the smoke test.
* * https://kb.firedaemon.com/support/solutions/articles/4000121705


* The Win32/Win64 OpenSSL Installation Project is dedicated to providing a simple installation of OpenSSL for Microsoft Windows. 
* Win64 OpenSSL v1.1.1m MSI (63MB Installer)

Latest News, https://www.openssl.org/

* 14-Dec-2021OpenSSL 1.1.1m is now available, including bug fixes
* For this you need OpenSSL 1.1.1 or lower (v 3 has an issue with -legacy and more, maybe fixed in the future)

</p>
</details>

## Environment

<details><summary>Azure</summary>
<p>

[![Screenshot](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/2_images_readme/azure_vm.jpg)

</p>
</details>

### TCP 5671 configuration (test shovel communication) AMQP:

* 1 Install Erlang (admin)
* Set home after
```cmd
# Path to bin, set this after
ERLANG_HOME=C:\Program Files\erl-24.2 (i.e version)
```

* 2 Set RabbitMQ environments

https://www.rabbitmq.com/configure.html

* In the context of deployment automation this means that environment variables such as 
* RABBITMQ_BASE and RABBITMQ_CONFIG_FILE should ideally be set before RabbitMQ is installed. 
* This would help avoid unnecessary confusion and Windows service re-installations.
* Make advanced.config (with content [].) and rabbitmq.conf in the location of value for RABBITMQ_BASE (c:software)


<details><summary>Cookie and rabbitmqctl bat issue</summary>
<p>

If Erlang is version 20.2 or above, copy the following file:

C:\Windows\System32\config\systemprofile\.erlang.cookie 

If Erlang is of version bellow 20.2, copy the following file:

C:\Windows\.erlang.cookie

Place the file in the following location:
C:\Users\<your user profile>

</p>
</details>

```cmd
# Set this before install, preferable to to data disk, i.e F:
RABBITMQ_BASE=c:\software
RABBITMQ_CONFIG_FILE=c:\software\rabbitmq.conf
RABBITMQ_ADVANCED_CONFIG_FILE=c:\software\advanced.config
``

* 3 Install RabbitMQ (admin)
* 3.1 Remember the cookie, if there is an issue.
* 4 VM1 Enable rabbitmq_management, rabbitmq_shovel and rabbitmq_shovel_management
* * rabbitmq-plugins list
* * rabbitmq-plugins enable <plugin-name>
* 4.1 VM2 Enable management
* 5 Add a new user on both VM' with name equal to the CN that will be used on the client
* 5.1 Give access to that user to a vhost as administrator.
* 6 VM1 -> Oubound 5671
* 6.1 VM2 -> Inbound 5671
* 6.1 Test-NetConnection -ComputerName VM2 -Port 5671
* 7 Make a test shovel with tcp listner 5671 (5672 must also avaliable on hosts VM1 and VM2, but just in trusted network for writing data to RabbtiMQ, not internet)
* 8 Make the queues on VM1, if the shovel is running then 9
* 9 On VM2 queues should now be autogenerated
* 10 Check shovel VM1-> VM2 status running

## We now have a server and a client running a shovel to the server, TCP 5671 Success AMQP

### SSL VM2 Server:
* 1 Make CSR key must be exportable and CN + SAN must be hostname(.domain.something)
* (Look in RequestAttributes_or_extensions.info, Note 2.5.29.17 is the OID for a SAN extension. )
* https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff625722(v=ws.10)
* 1.1 The certreq command can be used [...] create a new request from an .inf file
* https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1
* Update:13.06.2023
* * Certificate Authority must be a public certificate, not internal certificate.

```cmd
certreq –new request.inf certificate.req
```
Example content, view RequestExample for example on windows.

```cmd
# [...]
CN = hostname(.domain.something)
# [...]
Exportable = TRUE
[RequestAttributes] 
SAN="dns=hostname(.domain.something)"

or

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "dns=.domain.something&"
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

* 4.2 Run the following command to extract the private key:
```cmd
openssl pkcs12 -in myfile.pfx -nocerts -out private.key.pem -nodes
# enter the password used from the mmc export or create a new one.
```
* 4.3 Run the following command to extract the certificate
```cmd
openssl pkcs12 -in myfile.pfx -clcerts -nokeys -out public.crt.pem -nodes
# enter the same password (from 4.2)
```
* 4.4 Run the following command to verify CN (must be hostname(.domain.something))
```cmd
openssl x509 -noout -subject -in public.crt.pem
```

### 5 Update config VM2 Server:
ssl listner 5671, ssl options cacertfile (use root.csr or bundle (intermediate, root) it depends on amount of certificates), certfile, keyfile, verify,verify_peer, (password=optional), set this {fail_if_no_peer_cert, false}]},

```cmd
# (two slashes) for win path
"C:\\folder\\certs\\ca_cert.crt, .pem"
```

#### rabbitmq.conf (easier format)
You could use the rabbitmq.conf (easier format) for the server that is not using the shovel.
The has its own format, Erlang syntax.

https://github.com/spawnmarvel/quickguides/blob/main/amqp/management.txt

Log should be:
* * [info] <0.506.0> Ready to start client connection listeners
* * [info] <0.617.0> started TCP listener on [::]:5672
* * [info] <0.635.0> started TCP listener on 0.0.0.0:5672
* * [info] <0.655.0> started TLS (SSL) listener on [::]:5671
* * [info] <0.675.0> started TLS (SSL) listener on 0.0.0.0:5671
* * [info] <0.506.0> Server startup complete; 3 plugins started.
* * [info] <0.506.0>  * rabbitmq_management

### 5.1 Update config VM1 Client:
* Check shovel VM1-> VM2, it should be starting......
* Update VM1 (Client) test shovel with AMQPS tcp listner 5671
* {uris, ["amqp://test:test@xx.xx.xx.xx:5671"]},
* {uris, ["amqps://test:test@xx.xx.xx.xx:5671"]},
* Check shovel VM1-> VM2 status running, and check VM2 connection parameters in Management * SSL/TLS
* SSL/TLS success


### Note: if you do NOT get the behaviour mentioned above: use TCP Viewer and check connection with AMQP, then switch to AMQPS:
* TLS server: In state hello at tls_record.erl:564 generated SERVER ALERT: Fatal
* Shovel 'my_shovel' failed to connect (URI: amqps://xx.xx.xx.xx:5671): closed

<details><summary>Notes of confusion -></summary>
<p>

* VM1 shovel log:
* * Shovel 'shovel_get_remote_data' failed to connect (URI: amqp://xx.xx.xx.xx:5671): {server_sent_malformed_header,<<21,3,1,0,2,2,10>>}
* VM2 will report:
* * Unexpected Message
* * {unsupported_record_type,65}
* * TLS server: In state hello at tls_record.erl:564 generated SERVER ALERT: Fatal 
* You need to alter amqp to amqps

* VM1 shovel log:
* * Shovel 'shovel_put_local_data' failed to connect (URI: amqps://xx.xx.xx.xx:5671): closed
* * Shovel 'shovel_put_local_data' has no more URIs to try for connection
* * Shovel 'shovel_put_local_data' could not connect to destination
* Even if Test-NetConnection -ComputerName VM2 -Port 5671 works:
* * IS THE FW APPLICATION USED:(i.e Paloalto or other) configured with amqp, rabbitmq and not amqps? (use any)

https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClibCAC

- incomplete
One example is, if a client sends a server a SYN and the Palo Alto Networks device creates a session for that SYN , 
but the server never sends a SYN ACK back to the client, then that session is incomplete.

https://docs.paloaltonetworks.com/prisma/prisma-cloud/prisma-cloud-admin/get-started-with-prisma-cloud/prisma-cloud-faqs.html

What is the list of web applications that Prisma Cloud automatically classifies?

* 5672, RabbitMQ
* 5671, RabbitMQ

https://www.reddit.com/r/paloaltonetworks/comments/og2okd/commit_warnings_xxx_requires_certain/

So we came across "Commit Warnings" that say for exmaple application "rabbitmq" requires "ssl" to be allowed.


</p>
</details>

### TLS: We now have a client that trust the server and uses the server CA certificates, verifies server, checks that the server present a certificate with our configured SNI in CN of the sertificate. Shovel is configured with AMQPS, SSL/TLS towards the server. Forcing the client to only accept a server with a certificate from the trust and a matching SNI. This can be enough in many situations.

### 6 Before we can configure mTLS (Client and Server): We need to have both CRS's approved for verify_peer:
#### 6.1 But we can verify_peer from client if we have all server certificates and server CA's, go to section:11.03.2022 Update: Before SSL VM1 Client
* https://www.rabbitmq.com/ssl.html
* TLS has two primary purposes: encrypting connection traffic and providing a way to authenticate (verify) the peer to mitigate against Man-in-the-Middle attacks. 
* Both are  accomplished using a set of roles, policies and procedures known as Public Key Infrastructure (PKI).

### 7 Make Bundle of Root CA in this order:
* https://www.rabbitmq.com/ssl.html
* All trusted CA certificates must be added to a single file called the CA certificate bundle (MMC Gui of certmgr from our CSR)
* On Windows trusted certificates are managed using tools such as certmgr.
* For example, if certificate B is signed by A and C is signed by B, the chain is A (Root), B (Intermediat), C (Server certificate) (commas here are used for clarity). 
* The "topmost" (first or only) CA is often referred to as the root CA for the chain.
* Mutual Peer Verification (Mutual TLS Authentication or mTLS)
* When both sides perform this peer verification process, this is known as mutual TLS authentication or mTLS.
* When Peer Verification Fails: 
* * If no trusted and otherwise valid certificate is found, 
* * peer verification fails and client's TLS (TCP) connection is closed with a fatal error ("alert" in OpenSSL parlance) that says "Unknown CA" or similar
* RabbitMQ relies on Erlang's TLS implementation. It assumes that all trusted CA certificates are added to the server certificate bundle.
* For Rabbitmq to read the files:

* https://support.comodo.com/index.php?/Knowledgebase/Article/View/1145/1/how-do-i-make-my-own-bundle-file-from-crt-files

Open the .crt in Notepad and copy contents of all files in reverse order and paste them into the new file.

Example: (Intermediate 3, Intermediate 2,) Intermediate 1, Root Certificate. This is reverse order.

* When using RabbitMQ plugins such as Federation or Shovel with TLS, 
it may be necessary to configure verification depth for the Erlang client that those plugins use under the hood.


<details><summary>Extra Note about this test</summary>
<p>

For this test, I followed: Manually Generating a CA, Certificates and Private Keys:

* https://www.rabbitmq.com/ssl.html#manual-certificate-generation
* OpenSSL.cnf on VM1, own CA root and certificate
* OpenSSL.cnf on VM2, own CA root and certificate
* Made bundle of:
* VM1 root, VM2 root, on VM1, Save newly created file as 'vm1yourDomain.ca-bundle'.
* VM2 root, VM1 root, on VM2, Save newly created file as 'vm2yourDomain.ca-bundle'.
* If intermediate:
* VM1 intermediate, root, VM2 intermediate, root, on VM1, Save newly created file as 'vm1_vm2_yourDomain.ca-bundle'.
* VM2 intermediate, root, VM1 intermediate, root, on VM2, Save newly created file as 'vm2_vm1_yourDomain.ca-bundle'.

* http://marianoguerra.org/tmp/site/ssl/usersguide/

</p>
</details>

<details><summary>Before SSL VM1 Client: Take the time to verify all recieved CA's and generated server certificate</summary>
<p>

11.03.2022 Update: Before SSL VM1 Client: Take the time to verify all recieved CA's and generated server certificate:
11.03.2022 Update start: Test CA's (bundle with only server CA), server certificate, SNI before proceeding to client SSL.

Update 11.03.2022:

In this test the setup was: VM1 Azure WE, VM2 on-prem NO with external signed server certificate, 1 intermediate and 1 root certificate.

Before you set up client certificate it can be good to verify server TLS 100% so you know that the certificates are correct.
On VM1 client you now only have the shovel config section, but on VM2 you have the server ssl section and more.
On VM2 copy the bundle (intermediate and root is the order in the bundle) as-is over to the VM1, after you have verifed that all works on VM2 with the new cert and CA's from server.
At this point it can be a need to make higher depth for SSL, depth = 2.

If we expect this code in the advanced config:
```cmd
[{rabbitmq_shovel,
  [ {shovels, 
  [ {shovel_get_remote_data,
# [...]
```
Then on VM1 test in this order after adding amqp_client section:
* 1 add the bundle from server, keep server_name_indication,disabled, verify,verify_none, fail_if_no_peer_cert,false
* 1.1 Check the shovel status at VM1 on every stop/start of RabbitMQ, to see if one step fails
* 2 alter verify,verify_peer
* 3 fail_if_no_peer_cert,true
* 4 server_name_indication,"CN from server sertificate aka hostname.domain.xx"
* 5 Check the shovel status at VM1 on every stop/start of RabbitMQ, to see if one step fails

The result will be
```cmd
[{amqp_client, [
    {ssl_options, [{cacertfile,"C:\\testca_store\\bundle\\only-server-ca-intermediate-then-root.ca-bundle"},
	{server_name_indication,"CN from server sertificate aka hostname.domain.xx"},
   {depth, 2},
    {verify,verify_peer},
    {fail_if_no_peer_cert,true}]}
	]},
 {rabbitmq_shovel,
```
Now we have verifed all certificates from the server VM2 and saved alot of time.....

11.03.2022 Update end
</p>
</details>

### SSL VM1 Client:
* If you do not need or don't yet have the client CA's and certificate, go to: 6.1 section: But we can verify_peer from client
* 1 = Same steps as VM2 but with VM1 hostname
* 2, 3, 4 = same steps
* GOTO 6, 7

### 8 Update config VM1 Client:
* 8.0 Add section {amqp_client, above the {rabbitmq_shovel, section
* 8.1 Now use the vm1yourDomain.ca-bundle as ssl_options, [{cacertfile, "c:\\op\ssl\\vm1yourDomain.ca-bundle"},
* 8.2 The rest of the ssl_options is what we have for VM1, ssl options certfile, keyfile, verify  verify_peer, password, set this {fail_if_no_peer_cert, true}]}, 
```cmd
# (two slashes) for win path
"C:\\folder\\certs\\ca_cert.crt, .pem"
```
* 8.2 Here we will also add, {server_name_indication,"hostname-VM2"} so we only connect to that host (mTLS) and reject all other hosts.

### 8 Update config VM2 server: 
* Edit config to use the bundle: Now use the vm2yourDomain.ca-bundle as ssl_options, [{cacertfile, "c:\\op\ssl\\vm2yourDomain.ca-bundle"},
* 8.4 Check shovel VM1-> VM2 status running
* SSL/mTLS success

### 9 Update config VM2 server
* this {fail_if_no_peer_cert, false}]} to true
* SSL/mTLS success

Now the client knows that the server is THE SERVER and the server knows that the client is A CLIENT with it's own certificate and public / private keys for encryption.

Hence we can connect many clients to that server and all will be on mTls with encryption.

### TLS: We now have a client that trust the server and uses the server CA certificates, verifies server, checks that the server present a certificate with our configured SNI in CN of the sertificate. Shovel is configured with AMQPS, SSL/TLS towards the server. Forcing the client to only accept a server with a certificate from the trust and a matching SNI. 
### mTLS: Upgraded to a trust between the client and server CA's. Forcing the server to only accept a client with a certificate from the trust. SSL/mTLS


## 10 Example automatic setup of queues, topic.
When 1-9 is done, mTLS (or TLS), shovel, queues, put and send etc.
It can be further automated for RabbitMQ to auto create the queues at both ends, bind the remote queue to a routing key.

Let's make 1 new shovel:

* Name: shovel_put
* source, [ {protocol, amqp091}, {uris, [ "amqp://"....
* destination,[ {protocol, amqp091}, {uris, ["amqps://...

With new queue names and routing:

* Queue name: AZQueueData [Will be create at amqp and amqps (remote)]
* Routing key: AZQueueDataRoute, amq.topic [Will be create at amqp and amqps (remote)]
* Prefetch_count, 1 (how many messages are being sent at the same time)
* delivery_mode, 2 (persistent, write it to disk on the queue)
* ack_mode, on_confirm, reconnect_delay, 15

Config used:
* * vm1_advanced_10_amqps_ssl_auto_gen_queues_.config
* * vm2_advanced_4_tcp_ssl_mtls_bundle_handshake_timeout.config was unchanged.

### You can now the patch server, restart RabbitMQ and all queues with configuration will stay.

<details><summary>Example automatic setup</summary>
<p>

https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/3_images_Auto_Gen_Queue_Routing_SSL_TLS_MTLS_/10_auto_gen_queue_routing_mtls_bundle.jpg

</p>
</details>

## 11 x509 (TLS/SSL) certificate Authentication Mechanism

#### Now we can further secure the connectivety with x509 (TLS/SSL) certificate Authentication Mechanism


https://github.com/rabbitmq/rabbitmq-auth-mechanism-ssl

* When a client connects and performs TLS upgrade, the username is obtained from the client's TLS (x509) certificate. The user's password is not checked.
* In order to use this mechanism the client must connect with TLS enabled, and present a client certificate.
* For safety the server must be configured with the SSL option 'verify' set to 'verify_peer', to ensure that if an SSL client presents a certificate, it gets verified.

#### Username Extraction from Certificate

#### Distinguished Name
* By default this will set the username to an RFC 4514-ish string form of the certificate's subject's Distinguished Name, similar to that produced by OpenSSL's "-nameopt RFC 2253" option.
* You can obtain this string form from a certificate with a command like:
* * openssl x509 -in path/to/cert.pem -nameopt RFC2253 -subject -noout
* or from an existing amqps connection with commands like:
* * rabbitmqctl list_connections peer_cert_subject

#### Subject Alternative Name
* Can be used, https://github.com/rabbitmq/rabbitmq-server/tree/master/deps/rabbitmq_auth_mechanism_ssl
* Or of type email

#### Common Name
* To use the Common Name instead, set rabbit.ssl_cert_login_from to common_name
* auth_mechanisms.1 = EXTERNAL
* ssl_cert_login_from = common_name

####  11.1 Implement X.509

https://github.com/rabbitmq/rabbitmq-server/tree/master/deps/rabbitmq_auth_mechanism_ssl

Steps:
* Verify the CN of the client certificate:
* * openssl x509 -noout -subject -in c:\path\to-client\client_certificate.pem
* * subject=CN = CN-name
* Verify that you have a user on VM1 and VM2 equal to the CN-name from the certificate on VM1
* Verify on VM2 (Broker) the client (VM1) certificate subject from the above mTls connection (global mTLS):
* * rabbitmqctl list_connections peer_cert_subject
* * Listing connections ...
* * peer_cert_subject
* * CN=CN-name

* Enable rabbitmq_auth_mechanism_ssl on VM2
* Add to existing advanced.config
* * {auth_mechanisms, ['PLAIN', 'AMQPLAIN', 'EXTERNAL']}, {auth_backends, [rabbit_auth_backend_internal]}, {ssl_cert_login_from, common_name}
* On the amqp_client (VM2):
* Copy the global SSL properties and make it URI friendly and also add:

### After you have installed RabbitMQ, navigate to Shovel Management. URI examples is available on the webpage.

https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/4_images_management_ssl/uri.jpg


* * auth_mechanism=external and heartbeat=15 (sec)
* *  {uris, ["amqps://pdp-shovel-1@xx.xx.xx.xx:5671?cacertfile=C:\\testca_store\\bundle\\pdp-shovel-1.ca-bundle&certfile=C:\\testca_store\\client\\client_certificate.pem&keyfile=C:\\testca_store\\client\\private_key.pem&verify=verify_peer&fail_if_no_peer_cert=true&server_name_indication=pdp-shovel-2&auth_mechanism=external&heartbeat=15"]}, 
* The URI even works without the user name, since it it extracted from the certificate and also from the {auth_backends, [rabbit_auth_backend_internal]},

* *  {uris, ["amqps://xx.xx.xx.xx:5671?cacertfile=C:\\testca_store\\bundle\\pdp-shovel-1.ca-bundle&certfile=C:\\testca_store\\client\\client_certificate.pem&keyfile=C:\\testca_store\\client\\private_key.pem&verify=verify_peer&fail_if_no_peer_cert=true&server_name_indication=pdp-shovel-2&auth_mechanism=external&heartbeat=15"]}, 

As mentioned in above section for shovel and docs:
TLS options can also be specified globally using the amqp_client.ssl_options configuration key in the rabbitmq.config or advanced.config
* {amqp_client, [{ssl_options, [
They will be merged with the TLS parameters from the URI (the latter will take precedence) and affect all outgoing RabbitMQ Erlang client connections on the node, including plugins that use the client internally (Federation, Shovel, etc).

https://github.com/spawnmarvel/quickguides/blob/main/amqp/x509/mtls_x509.jpg



### mTLS: Upgraded to use x509 (TLS/SSL) certificate Authentication Mechanism and no credentials, login is from certificate CN and rabbit_auth_backend_internal does authorization.


<details><summary>Renew certificate tips</summary>
<p>

This depends on what certificate is expired, server VM2 or client VM1?
Is is also dependendt on if you used x.509 or not.
The main task is to check what is expired:
* CA's or personal
* Generate CSR personal or download new CA's from repository (owner etc)
* Import new personal, make private key and cert or import CA's
* Update folder with personal cert or update bundle with new CA's
* Update first global ssl, set back URI from x.509 to -u -p 
* When global is success, set back URI from -u -p to x.509 

TLS:
* VM2 server has a certificate
* VM1 client on amqps shovel and we use the bundle from VM2 with SNI

mTLS:
* VM2 server has a certificate and bundle contains VM1 certs, VM2 cert.
* VM1 client has a certificate and bundle contains VM2 certs, VM1 certs and SNI configured.


* Plan ahead, make an alert for the dates
* Set back both configs to:
* * VM1 just {rabbitmq_shovel, amqp, edit from amqps, and keep other configuration, but remove ssl section.
* * VM2 {tcp_listeners, [{"0.0.0.0",5672}, {"0.0.0.0",5671}]} and keep other configuration, but remove ssl section.
* * section: We now have a server and a client running a shovel to the server, TCP 5671 Success AMQP
* * * And then renew your certificates.

</p>
</details>

<details><summary>How to Optimize the RabbitMQ Prefetch Count</summary>
<p>

https://www.cloudamqp.com/blog/how-to-optimize-the-rabbitmq-prefetch-count.html

#### A larger prefetch count generally improves the rate of message delivery. 

The broker does not need to wait for acknowledgments as often and the communication between the broker and consumers decreases. 

Still, smaller prefetch values can be ideal for distributing messages across larger systems. 

Smaller values maintain the evenness of message consumption. A value of one helps ensure equal message distribution.

* A prefetch count that is set too small may hurt performance since RabbitMQ might end up in a state, where the broker is waiting to get permission to send more messages.

* A large prefetch count, on the other hand, could take lots of messages off the queue and deliver all of them to one single consumer, keeping the other consumers in an idling state.

#### How to set the correct prefetch value?

If you have one single or only a few consumers processing messages quickly, we recommend prefetching many messages at once to keep your client as busy as possible. 

If you have about the same processing time all the time and network behavior remains the same, simply take the total round trip time and divide by the processing time on the client for each message to get an estimated prefetch value.


</p>
</details>

<details><summary>Erlang SNI: Specify the hostname to be used in TLS Server Name Indication extension</summary>
<p>

https://www.erlang.org/doc/man/ssl.html

* Specify the hostname to be used in TLS Server Name Indication extension. If not specified it will default to the Host argument of connect/[3,4] unless it is of type inet:ipaddress().

* The HostName will also be used in the hostname verification of the peer certificate using public_key:pkix_verify_hostname/2.


[![Screenshot](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/2_images_readme/azure_vm_rfc-6125.jpg)

</p>
</details>

<details><summary>Notes -></summary>
<p>

## Tips
* 1 If the distance is long between server and client:
* server {ssl_handshake_timeout, 5000}, default is 5 seconds, increase it.
* client shovel {reconnect_delay, 15}

### Understanding TLS Connection Log Errors
* https://www.rabbitmq.com/troubleshooting-ssl.html
* {ssl_upgrade_error, ...} This is a generic error that could have many causes. Make sure you are using the recommended version of Erlang.
* {ssl_upgrade_error,"record overflow"} = server response is record oveflow, client is amqp, set amqps

### Getting Help and Providing Feedback
* If you have questions about the contents of this guide or any other topic related to RabbitMQ, don't hesitate to ask them on the RabbitMQ mailing list.
* https://groups.google.com/g/rabbitmq-users

* Advanced config https://www.ibm.com/support/pages/example-rabbitmq-configuration-file-encryption
* Advanced.config.example https://github.com/rabbitmq/rabbitmq-server/blob/v3.8.x/deps/rabbit/docs/advanced.config.example

</p>
</details>

## Extra

<details><summary>Python Pika SSL</summary>
<p>
https://github.com/spawnmarvel/python-snippets/tree/master/rabbitmq_pika
</p>
</details>


<details><summary>Management SSL</summary>
<p>
When you visit the URL from a browser you get an error in the log or many

2022-09-20 12:41:18.195000+02:00 [notice] <0.670.0> TLS server: In state wait_finished received CLIENT ALERT: Fatal - Certificate Unknown

https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/4_images_management_ssl/management_ssl.jpg
</p>
</details>


## 13 Common RabbitMQ Mistakes and How to Avoid Them
https://www.cloudamqp.com/blog/part4-rabbitmq-13-common-errors.html


## 14 rabbitmqctl(8)


https://www.rabbitmq.com/rabbitmqctl.8.html

```cmd

rabbitmqctl list_queues
rabbitmqctl status
rabbitmqctl add_user newuser pass123
rabbitmqctl list_users
rabbitmqctl set_user_tags newuser administrator
rabbitmqctl set_permissions -p / newuser ".*" ".*" ".*"
rabbitmqctl list_permissions

rabbitmqctl delete_queue AZQueueData

```

## 15 Dynamic shovel using CLI tools

Using CLI Tools Declaring a Dynamic Shovel

https://www.rabbitmq.com/shovel-dynamic.html#declaring

```cmd
# localhost queue01 and queue02
rabbitmqctl.bat set_parameter shovel my-shovel  "{""src-protocol"": ""amqp091"", ""src-uri"":""amqp://localhost"", ""src-queue"": ""queue01"", ""dest-protocol"": ""amqp091"", ""dest-uri"": ""amqp://localhost"", ""dest-queue"": ""queue02""}"
   
```
Management

![Dynamic shovel ](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/5_shovel/dynamicshovel.jpg)

Status

![Shovel status ](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/5_shovel/shovelstatus.jpg)

Add msg to queue01, it is moved to queue02

![Shovel move ](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/5_shovel/shovelmove.jpg)

URI Query Parameters

https://www.rabbitmq.com/uri-query-parameters.html

```cmd
# localhost queue01 and queue02, src heartbeat=10&connection_timeout=10000
rabbitmqctl.bat set_parameter shovel my-shovel  "{""src-protocol"": ""amqp091"", ""src-uri"":""amqp://localhost"", ""src-queue"": ""queue01"", ""dest-protocol"": ""amqp091"", ""dest-uri"": ""amqp://localhost?heartbeat=10&connection_timeout=10000"", ""dest-queue"": ""queue02""}"
   
```

AMQP 1.0 Shovel Definition Reference

AMQP 1.0 source and destination properties have some differences from their AMQP 0-9-1 counterparts.

https://www.rabbitmq.com/shovel-dynamic.html#amqp10-reference



AMQP 1.0 enable (already enabled if not run:)
```cmd
rabbitmq-plugins list
[E*] rabbitmq_amqp1_0                  3.12.1

```

![Shovel amqp 10 ](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/5_shovel/shovelamqp10.jpg)

Get definition after make it in UI

http://localhost:15672/api/shovels

[{"node":"rabbit@BER-0803","timestamp":"2023-07-11 20:49:06","name":"shovel","vhost":"/","type":"dynamic","state":"running","src_uri":"amqp://","src_protocol":"amqp091","dest_protocol":"amqp10","dest_uri":"amqp://localhost:5672","src_queue":"queue01","dest_address":"queue02","blocked_status":"running"}]

| Key | Description
| --- | -----------
|dest-address | not dest-queue The AMQP 1.0 link address. Mandatory.

```cmd
# localhost queue01 and queue02, src address and AMQP 1.0
rabbitmqctl.bat set_parameter shovel my-shovel  "{""src-protocol"": ""amqp091"", ""src-uri"":""amqp://localhost"", ""src-queue"": ""queue01"", ""dest-protocol"": ""amqp10"", ""dest-uri"": ""amqp://localhost"", ""dest-address"": ""queue02""}"
```

AMQP 1.0 support for RabbitMQ

https://github.com/rabbitmq/rabbitmq-server/tree/main/deps/rabbitmq_amqp1_0

Shovelling a message from RabbitMQ to Azure ServiceBus

https://gist.github.com/kjnilsson/159c643fb34604f8ea20be336109261b

First get the SB connection string from the Microsoft Azure portal. Typically it will look something like:
* Endpoint=sb://shoveltest.servicebus.windows.net/;SharedAccessKeyName=TheUser;SharedAccessKey=Some/String=;EntityPath=aqueue1

Given this we can translate the connection string into an amqp URI as follows:
* amqps://TheUser:Some%2FString=@shoveltest.servicebus.windows.net:5671=versions=tlsv1.0,tlsv1.1,tlsv1.2

Note we restricted the tls versions it should attempt to use as well as URI encoded the UserName and Password as Azure kindly include a lot of forward slashes into these.

This URI can now be used to configure the shovel URI together with the queue name as either the source or destination assuming the SB queue is not configured to use sessions or partitions.

Sessions and Partitions

To use SB sessions and partitions with the shovel some additional configuration is required. The current best way to do so is by using the static shovel configuration to add the required properties and/or message annotations.

https://www.rabbitmq.com/shovel-static.html



Sevice bus

   
