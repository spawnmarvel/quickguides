# AMQP Shovel MTLS  with SNI = hostname - RFC-6125

https://www.rabbitmq.com/shovel.html
* Shovel plugin

https://datatracker.ietf.org/doc/html/rfc6125
* Representation and Verification of Domain-Based Application Service
Identity within Internet Public Key Infrastructure Using X.509 (PKIX)
Certificates in the Context of Transport Layer Security (TLS)
* RFC-6125

## Server Identity Check RFC-6125

<details><summary>2.4. Server Identity Check -></summary>
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


## Shovel
* A shovel behaves like a well-written client application, which connects to its source and destination, 
  consumes and republishes messages, and uses acknowledgements on both ends to cope with failures.
* A Shovel uses Erlang AMQP 0-9-1 and Erlang AMQP 1.0 clients under the hood.

## Scenario and roles for this test:

<details><summary>Two way direction and One way direction -></summary>
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

<details><summary>The New and Old Config File Formats -></summary>
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


https://docs.vmware.com/en/VMware-Tanzu-RabbitMQ-for-Kubernetes/1.2/tanzu-rmq/GUID-configure.html


 | Configuration File  | Format Used                            | Purpose                             |
 | ------------------- | -------------------------------------- | ----------------------------------- |
 | rabbitmq.conf       | New style format (sysctl or ini-like)  | Should be used for most settings.   |
 | advanced.config     | Classic (Erlang terms)                 | A limited number of settings that cannot be expressed in the new style configuration format |

</p>
</details>

## Installing
<details><summary>Software version -></summary>
<p>

For this test:
https://www.rabbitmq.com/install-windows.html
* rabbitmq-server-3.9.12
* otp_win64_24.2
* Win64 OpenSSL v1.1.1m

https://slproweb.com/products/Win32OpenSSL.html

* The Win32/Win64 OpenSSL Installation Project is dedicated to providing a simple installation of OpenSSL for Microsoft Windows. 
* Win64 OpenSSL v1.1.1m MSI (63MB Installer)

Latest News, https://www.openssl.org/

* 14-Dec-2021OpenSSL 1.1.1m is now available, including bug fixes
* For this you need OpenSSL 1.1.1 or lower (v 3 has an issue with -legacy and more, maybe fixed in the future)

</p>
</details>

## Environment

<details><summary>Azure -></summary>
<p>

[![Screenshot](https://github.com/spawnmarvel/quickguides/blob/main/amqp/2_images_readme/azure_vm.jpg)

</p>
</details>

### TCP 5671 configuration (test shovel communication) AMQP:

* 1 Install Erlang (admin)
* Set home after
```cmd
# Path to bin, set this after
ERLANG_HOME=C:\Program Files\erl-24.2
```

* 2 Set RabbitMQ environments

https://www.rabbitmq.com/configure.html

* In the context of deployment automation this means that environment variables such as 
* RABBITMQ_BASE and RABBITMQ_CONFIG_FILE should ideally be set before RabbitMQ is installed. 
* This would help avoid unnecessary confusion and Windows service re-installations.

```cmd
# Set this before install, preferable to to data disk, i.e F:
RABBITMQ_BASE=c:\software
RABBITMQ_CONFIG_FILE=c:\software\rabbitmq.conf
RABBITMQ_ADVANCED_CONFIG_FILE=c:\software\advanced.config
```


* 3 Install RabbitMQ (admin)
* 3.1 Rememeber the cookie, if there is an issue.
* 4 VM1 Enable management, shovel and shovel management
* 4.1 VM2 Enable management
* 5 Add a new user on both VM's with access to vhost as administrator.
* 6 VM1 -> Oubound 5671
* 6.1 VM2 -> Inbound 5671
* 6.1 Test-NetConnection -ComputerName VM2 -Port 5671
* 7 Make a test shovel with tcp listner 5671 (5672 must also avaliable on hosts VM1, VM2 but just in trusted network for writing data to RabbtiMQ, not internet)
* 8 Make the queues on VM1, if the shovel is running then 8
* 9 On VM2 queues should now be autogenerated
* 10 Check shovel VM1-> VM2 status running

## We now have a server and a client running a shovel to the server, TCP 5671 Success AMQP

### SSL VM2 Server:
* 1 Make CSR key must be exportable and CN + SAN must be hostname(.domain.something)
* 1.1 The certreq command can be used [...] create a new request from an .inf file
* https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1

```cmd
# [...]
CN = hostname(.domain.something)
# [...]
Exportable = TRUE
[RequestAttributes] 
SAN="dns=hostname(.domain.something)"
```
* 2 When CSR approved is back, import certificate in personal
* 3 Export personal as pfx (yes, export private key, include all certs if possible), save the password for later use
* 4 Get the private key

* 4.1 Run cms as admin navigate to openssl bin and check version
```cmd
cd "c:\Program Files\OpenSSL-Win64\bin"
openssl version
```
* It should be OpenSSL 1.1.1m 14 Dec 2021

* 4.2 Run the following command to extract the private key:
```cmd
openssl pkcs12 -in myfile.pfx -nocerts -out private.key.pem -nodes
```
* 4.3 Run the following command to extract the certificate
```cmd
(openssl pkcs12 -in myfile.pfx -clcerts -nokeys -out public.crt.pem -nodes)
openssl pkcs12 -in myfile.pfx -nokeys -out public.crt.pem -nodes
```
* 4.4 Run the following command to verify CN (must be hostname(.domain.something))
```cmd
openssl x509 -nout -subject -in public.crt.pem
```

### 5 Update config VM2 Server:
ssl listner 5671, ssl options cacertfile (use root.csr), certfile, keyfile, verify,verify_peer, password, set this {fail_if_no_peer_cert, false}]},

```cmd
# (two slashes) for win path
"C:\\folder\\certs\\ca_cert.crt, .pem"
```

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

## We now have a server with certificate and a client with no certificate running a shovel to the server AMQPS

### 6 Before we can configure mTLS (Client and Server): We need to have both CRS's approved for verify_peer:
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

### Extra Note:
For this test, I followed: Manually Generating a CA, Certificates and Private Keys:

* https://www.rabbitmq.com/ssl.html#manual-certificate-generation
* OpenSSL.cnf on VM1, own CA root and certificate
* OpenSSL.cnf on VM2, own CA root and certificate
* Made bundle of:
* VM1 root, VM2 root on VM1, Save newly created file as 'vm1yourDomain.ca-bundle'.
* VM2 root, VM1 root on VM2, Save newly created file as 'vm2yourDomain.ca-bundle'.

* http://marianoguerra.org/tmp/site/ssl/usersguide/

### SSL VM1 Client:
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

## We now have a server with certificate and a client with certificate and SNI enabled, running a shovel to the server. SSL/mTLS
## Erlang SNI

<details><summary>Specify the hostname to be used in TLS Server Name Indication extension -></summary>
<p>

https://www.erlang.org/doc/man/ssl.html

* Specify the hostname to be used in TLS Server Name Indication extension. If not specified it will default to the Host argument of connect/[3,4] unless it is of type inet:ipaddress().

* The HostName will also be used in the hostname verification of the peer certificate using public_key:pkix_verify_hostname/2.


[![Screenshot](https://github.com/spawnmarvel/quickguides/blob/main/amqp/2_images_readme/azure_vm_rfc-6125.jpg)

</p>
</details>

## Notes

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

* The plugin is enough to use the Common Name as a user name.
* https://groups.google.com/g/rabbitmq-users/c/8L1O9YuKP-E

</p>
</details>