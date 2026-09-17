# AMQP Shovel MTLS with RFC-6125

Shovel plugin

* https://www.rabbitmq.com/shovel.html

Installing on Windows

* https://www.rabbitmq.com/docs/install-windows

rabbitmq / rabbitmq-server Releases list

* https://github.com/rabbitmq/rabbitmq-server/releases

Download Erlang/OTP

* https://www.erlang.org/downloads

RabbitMQ and Erlang/OTP Compatibility Matrix

* https://www.rabbitmq.com/docs/which-erlang

Win32/Win64 OpenSSL

* https://slproweb.com/products/Win32OpenSSL.html

## Table of Contents

- [AMQP Shovel MTLS with RFC-6125](#amqp-shovel-mtls-with-rfc-6125)
  - [Table of Contents](#table-of-contents)
  - [Assumptions](#assumptions)
  - [Useful information](#useful-information)
  - [Install for tls](#install-for-tls)
  - [(View example in misc section if needed.)](#view-example-in-misc-section-if-needed)
  - [Configure for mtls](#configure-for-mtls)
      - [Notes 17.09.2026 new erlang and rabbitmq version](#notes-17092026-new-erlang-and-rabbitmq-version)
      - [advanced.config example ip :frog:](#advancedconfig-example-ip-frog)
      - [MITM and DNS](#mitm-and-dns)
      - [advanced.config example DNS :frog:](#advancedconfig-example-dns-frog)
      - [rabbitmq.conf example :frog:](#rabbitmqconf-example-frog)
    - [Architecture Security Verdict](#architecture-security-verdict)
    - [Strengths of This Production Setup](#strengths-of-this-production-setup)
    - [Remaining Production Hardening Checklist](#remaining-production-hardening-checklist)
    - [Comparison: Root CA vs. Intermediate CA Architecture](#comparison-root-ca-vs-intermediate-ca-architecture)
  - [Misc](#misc)
    - [Queues, topic and exchanges](#queues-topic-and-exchanges)
    - [RabbitMQ commands](#rabbitmq-commands)


## Assumptions

This guides assumes you know a bit about all the following:

* Networking and security
* Powershell
* Openssl
* X.509
* RabbitMQ and Erlang

## Useful information

ISO and IEC Approve OASIS AMQP Advanced Message Queuing Protocol.

AMQP provides a platform-agnostic method for ensuring information is safely transported between applications, among organizations, within mobile infrastructures, and across the Cloud. [...]

AMQP v1.0 is an international open standard that is ISO and IEC approved as ISO/IEC 19464:2014.

* https://www.oasis-open.org/news/pr/iso-and-iec-approve-oasis-amqp-advanced-message-queuing-protocol/


--- 

Server Identity Check RFC-6125.

Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

* https://datatracker.ietf.org/doc/html/rfc6125

--- 

Mtls

* https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/

---

Basic concepts of RabbitMQ and the shovel application.

* https://www.rabbitmq.com/shovel.html

* https://www.rabbitmq.com/uri-spec.html

* https://www.rabbitmq.com/ssl.html#peer-verification

* https://www.rabbitmq.com/access-control.html#basics

* https://github.com/rabbitmq/rabbitmq-server/blob/v3.7.x/deps/rabbit/docs/rabbitmq.config.example

---

| Configuration File  | Format Used                            | Purpose                             |
| ------------------- | -------------------------------------- | ----------------------------------- |
| rabbitmq.conf       | New style format (sysctl or ini-like)  | Should be used for most settings.   |
| advanced.config     | Classic (Erlang terms)                 | A limited number of settings that cannot be expressed in the new style configuration format, like static shovels. |


## Install for tls

Software (version example):

* otp_win64_24.2 
* rabbitmq-server-3.9.12
* Win64 OpenSSL v1.1.1m (msi, Installs the most commonly used essentials of Win64 OpenSSL)
* Get OpenSSL https://slproweb.com/products/Win32OpenSSL.html

---

Certificates

What can you do before you have the certificates:

* Install Erlang, RabbitMQ, configure rabbitmq.conf, make a empty advanced.config
* Create users, set limits for disk and memory
* Verify installation
* Order or generate certificates and files

When do you use the certificates:

* When configure tls, you need the server certificates for VM2 where the shovel connects to
* When configure mtls, you need the server certificates for VM2 where the shovel connects to, and the client\server certificate for VM1, where the shovel is configured

How to generate certificates:

Many ways he says, the easy way and right way is to use a internal PKI and OpenSSL

* A full PKI, https://github.com/spawnmarvel/todo-and-current/blob/main/pki_store/openssl.cnf

or 

* A minimal PKI, https://github.com/spawnmarvel/todo-and-current/blob/main/pki_store/pki_store_minmal_root_and_server_cert_client_server_auth/README.md

or

A request.inf file, certreq and a cert store to by it from, but, there is one issue, the shovel applications requires the

```ini
extendedKeyUsage        = serverAuth, clientAuth
```

to work, the shovel is a client and server (VM1), the server (VM2) is just a server.

So in 2026, Removal of the Client Authentication EKU from TLS Server Certificates – What You Need to Know:

* https://www.ssl.com/blogs/removal-of-the-client-authentication-eku-from-tls-server-certificates-what-you-need-to-know/

"Mutual TLS (mTLS) and Client Cert Scenarios: If you were using a TLS server certificate for client authentication, you will need to obtain a separate certificate with the clientAuth EKU from another source. " aka go internal PKI.


---

1. Install Erlang (admin)

Set ERLANG_HOME after it is installed, use "Edit the systems environment variables gui"

```cmd
# Path to bin, set this after, example
ERLANG_HOME=C:\Program Files\erl-24.2 (i.e version)

echo %ERLANG_HOME%
```

---

2. Set RabbitMQ environments

https://www.rabbitmq.com/configure.html

In the context of deployment automation this means that environment variables such as:

* RABBITMQ_BASE
* RABBITMQ_CONFIG_FILE 
* (RABBITMQ_ADVANCED_CONFIG_FILE) 

should ideally be set before RabbitMQ is installed. 

This would help avoid unnecessary confusion and Windows service re-installations.

Add:
```json
[]. 
```
inside the advanced.config, that is the empty erlang format and place advanced.config and rabbitmq.conf in the location of RABBITMQ_BASE ( example, F:\RabbitMqStore)

Note: Cookie and rabbitmqctl bat issue

* C:\Windows\System32\config\systemprofile\.erlang.cookie 
* C:\Windows\.erlang.cookie

```ps1
# Place the file in the following location, if you get an error running rabbitmqctl:
C:\Users\<your user profile>
```

Set this before install RabbitMQ, use "Edit the systems environment variables gui"

```cmd
# Set this before install, preferable to to data disk, i.e F:
RABBITMQ_BASE=F:\RabbitMqStore
RABBITMQ_CONFIG_FILE=F:\RabbitMqStore\rabbitmq.conf
RABBITMQ_ADVANCED_CONFIG_FILE=F:\RabbitMqStore\advanced.config
```

---

3. Install RabbitMQ (admin)

---

4. VM1 (Shovel client)

Remember the cookie, if there is an issue.

```cmd
# cd to sbin

rabbitmq-plugins.bat list
# or
rabbitmq-plugins list
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_shovel
rabbitmq-plugins enable rabbitmq_shovel_management

# To list the enabled plugins
rabbitmq-plugins list -e 

```

(View example in misc section if needed.)
---

5. VM2 (Server)

```cmd
# cd to sbin
rabbitmq-plugins list
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_auth_mechanism_ssl

# To list the enabled plugins
rabbitmq-plugins list -e 

```

rabbitmq_auth_mechanism_ssl is for x.509 authentication with certificates.

* https://www.rabbitmq.com/docs/plugins

---

6. Add a new user on both VM' with name equal to the CN that will be used on the client X.509 certificate.

Give access to that user to a vhost example \ or create a new vhost and grant it administrator.

And a new administrator user for support, i.e: mycompany (user).

Make sure the guest user can only access via localhost or delete that user.

---

7. Make sure firewall is open on both servers.

* VM1 -> Oubound 5671 to VM2
* VM2 -> Inbound 5671 from V1

```ps1
# Do a test on VM1
Test-NetConnection -ComputerName VM2 -Port 5671
```

---

8. Configure a tls shovel

A tls shovel is configured like this for easy troubleshooting.

* VM1 configure shovel with the username, password and a ca bundle with VM2 root/intermediate certificates.
* VM2 configure tls 5671 for external and 562 for internal connections
* VM2 configure

```ini
ssl_options.verify     = verify_peer
ssl_options.fail_if_no_peer_cert = true

#change to:
ssl_options.verify     = verify_none
ssl_options.fail_if_no_peer_cert = false
# the is unsecure, but we can check if everything works before we set up mtls
```

While making the shovel you can:

Validate and format the advanced.config so it goes a bit faster.

```ps1
# You can validate the advanced.config file for syntax errors

& "C:\Program Files\Erlang OTP\bin\erl.exe" -noshell -eval "case file:consult('C:/RabbitmqBaseFolder/advanced.config') of {ok, _} -> io:format('~n--- CONFIG VALID ---~n'); {error, enoent} -> io:format('~n--- ERROR: FILE NOT FOUND ---~n'); {error, {L, M, E}} -> io:format('~n--- SYNTAX ERROR Line ~p: ~s ---~n', [L, M:format_error(E)]); {error, R} -> io:format('~n--- ERROR: ~p ---~n', [R]) end, halt()."

--- CONFIG VALID ---


# You can format (remove space, empty lines etc) for the advanced.config

& "C:\Program Files\Erlang OTP\bin\erl.exe" -noshell -eval "case file:consult('C:/RabbitmqBaseFolder/advanced.config') of {ok, Terms} -> Formatted = lists:map(fun(Term) -> io_lib:format('~p.~n~n', [Term]) end, Terms), file:write_file('advanced.config', Formatted), io:format('~n--- CONFIG FORMATTED ---~n'); {error, {L, M, E}} -> io:format('~n--- CANNOT FORMAT: SYNTAX ERROR Line ~p: ~s ---~n', [L, M:format_error(E)]) end, halt()."

# --- CONFIG FORMATTED ---

```
---

8. On VM1 make the queues as auto-create in the shovel configuration, if the shovel is running then GOTO 9

---
9. On VM2 queues should now be autogenerated

---

10. Check shovel management on VM1-> the status should be running

We now have a server VM1 and a client running a shovel to the server VM2, TCP 5671 Success AMQP.

We now have a client that trust the server and uses the server CA certificates, verifies server, checks that the server present a certificate with our configured SNI in CN of the sertificate. Shovel is configured with AMQPS, SSL/TLS towards the server. Forcing the client to only accept a server with a certificate from the trust and a matching SNI. This can be enough in many situations.



## Configure for mtls

Now that you have both certificates and the tls shovel is success, we can configure for mtls and X.509 authentication.


VM1 advanced.config (client)

1. Overview Answer

Yes, it auto-creates the queues on both hosts.

Because you have included explicit declarations blocks in both the source and destination sections, the Shovel plugin will send those declaration commands over the AMQP connection as soon as it initializes.

2. Local Host (Source) Declarations
In your source block ("amqp://" connecting to local host):

Auto-creates Queue: Declares durable queue <<"AZQueueDataX509">>.

Auto-creates Exchange: Ensures topic exchange <<"amq.topic">> exists.

Auto-creates Binding: Binds <<"AZQueueDataX509">> to <<"amq.topic">> using routing key <<"AZQueueDataRouteX509">>

3. Remote Host (Destination) Declarations
In your destination block ("amqps://pdp-shovel-1@xx.xx.xx.xx:5671..." connecting to remote host):

Auto-creates Queue: Declares durable queue <<"AZQueueDataX509">> on the remote broker.

Auto-creates Binding: Binds <<"AZQueueDataX509">> to <<"amq.topic">> with routing key <<"AZQueueDataRouteX509">> on the remote broker.

4. How the Message Routing Works
Local Host: Messages published to amq.topic with routing key AZQueueDataRouteX509 land in AZQueueDataX509.

Shovel Worker: Reads messages from local queue AZQueueDataX509 with a prefetch count of 1.

Remote Host: Transfers messages over TLS (amqps) using X.509 client certificates and publishes them directly onto the remote host.




#### Notes 17.09.2026 new erlang and rabbitmq version

* RabbitMQ 4.3.5
* Erlang 27.3.4.16

Set this at rabbitmq.conf besides other configuration parameters before you start the shovel with ssl parameters.


Server remote rabbitmq.conf

```ini
ssl_options.verify = verify_peer
ssl_options.fail_if_no_peer_cert = true
```

Else you could get:

Client shovel

```log

2026-09-17 11:06:33.119000+02:00 [warning] <0.1065.0> Shovel 'put_x509' failed to connect (URI: amqps://10.10.10.10:5671): ACCESS_REFUSED - Login was refused using authentication mechanism EXTERNAL. For details see the broker logfile.

```

Server

```log
2026-09-17 11:31:27.936000+02:00 [info] <0.222761.0> accepting AMQP connection 44.44.44.444:64427 -> 10.10.10.10:5671
2026-09-17 11:31:27.936000+02:00 [info] <0.222767.0> connection 44.44.44.444:64428 -> 10.10.10.10:5671 has a client-provided name: Shovel put_x509
2026-09-17 11:31:27.936000+02:00 [error] <0.222767.0> Error on AMQP connection <0.222767.0> (44.44.44.444:64428 -> 10.10.10.10:5671, state: starting):
2026-09-17 11:31:27.936000+02:00 [error] <0.222767.0> EXTERNAL login refused: connection peer presented no TLS (x.509) certificate

```


#### advanced.config example ip :frog:

vm1

<details>
  <summary>Click to expand configuration</summary>

```erlang
[
 %% RabbitMQ Shovel Plugin
 %%
 %% See https://www.rabbitmq.com/docs/shovel for details
 %% ----------------------------------------------------------------------------
  {rabbitmq_shovel,
  [ {shovels, [ {shovel_put_X509,
                  [ {source,
                      [ {protocol, amqp091},
                        {uris, [ "amqp://" ]},
                        {declarations, [ {'queue.declare',
                                            [{queue, <<"AZQueueDataX509">> },  durable]},
				            {'exchange.declare',
                                            [ {exchange, <<"amq.topic">>},
                                              {type, <<"topic">>},
                                              durable
                                            ]},
                                          {'queue.bind',
                                            [ {exchange, <<"amq.topic">>},
                                              {queue,    <<"AZQueueDataX509">>},
					 {routing_key, <<"AZQueueDataRouteX509">>}
                                            ]}
                                          ]},
                        {queue, <<"AZQueueDataX509">>},
                        {prefetch_count, 1}
                      ]},
                    {destination,
                      [ {protocol, amqp091},
                        {uris, ["amqps://pdp-shovel-1@44.44.44.44:5671?cacertfile=E:\\RabbitMqStore\\certs\\pdp-shovel-1.ca-bundle&certfile=E:\\RabbitMqStore\\certs\\client_certificate.pem&keyfile=E:\\RabbitMqStore\\certs\\private_key.pem&verify=verify_peer&server_name_indication=pdp-shovel-2&auth_mechanism=external&heartbeat=15"]},
                        {declarations, [
					{'queue.declare',
                                            [{queue, <<"AZQueueDataX509">> },  durable]},
					 {'queue.bind',
                                            [ {exchange, <<"amq.topic">>},
                                              {queue,    <<"AZQueueDataX509">>},
					      {routing_key, <<"AZQueueDataRouteX509">>}
                                            ]}
					 ]},
                        {publish_properties, [ {delivery_mode, 2} ]},
                        {add_forward_headers, true}
                          ]},
                    {ack_mode, on_confirm},
                    {reconnect_delay, 15}
                  ]}
				   %% next shovel add comma
				   %% ,
				   %% {shovel_put_X509_2, [
				   %% ]}
		
		
              ]}
  ]}].
```

</details>


#### MITM and DNS

Previously, the Shovel connected to: 44.44.44.444

On server
```bash
# run this on the server
openssl x509 -in E:\RabbitMqStore\certs\public.crt.pem -noout -text
```

while the server certificate identified:

```text
X509v3 Subject Alternative Name:
    DNS:pdp-shovel-2
```

Edit this on client where the shovels is

```cmd
C:\Windows\System32\drivers\etc\hosts
```

Open hosts and add a line such as:

```txt

44.44.44.444  pdp-shovel-2

```

the Shovel could connect using:

```bash
amqps://pdp-shovel-2:5671
```

Windows resolved that hostname to 10.127.12.37 before the TCP connection was made.
- During the TLS handshake:
  - The client connected to 10.127.12.37 (after DNS/hosts resolution).  - It identified the intended server as it20-no1-ta-284.  - The server presented a certificate containing:

```text
X509v3 Subject Alternative Name:
    DNS:pdp-shovel-2
```

 - That identity now matches the name the client used.

The Shovel was changed to connect using the server's DNS name instead of its IP address. A corresponding DNS/hosts entry resolves that hostname to the server's IP address. The server's X.509 certificate contains the same DNS name in its Subject Alternative Name (SAN), allowing the client to verify that it is communicating with the intended RabbitMQ server. This aligns the connection endpoint with the certificate identity and follows TLS best practices.

Under those assumptions, your configuration follows the standard mTLS model and provides strong protection against MITM attacks.

#### advanced.config example DNS :frog:

vm1

<details>
  <summary>Click to expand configuration</summary>

```erlang
[
 %% RabbitMQ Shovel Plugin
 %%
 %% See https://www.rabbitmq.com/docs/shovel for details
 %% ----------------------------------------------------------------------------
  {rabbitmq_shovel,
  [ {shovels, [ {shovel_put_X509,
                  [ {source,
                      [ {protocol, amqp091},
                        {uris, [ "amqp://" ]},
                        {declarations, [ {'queue.declare',
                                            [{queue, <<"AZQueueDataX509">> },  durable]},
				            {'exchange.declare',
                                            [ {exchange, <<"amq.topic">>},
                                              {type, <<"topic">>},
                                              durable
                                            ]},
                                          {'queue.bind',
                                            [ {exchange, <<"amq.topic">>},
                                              {queue,    <<"AZQueueDataX509">>},
					 {routing_key, <<"AZQueueDataRouteX509">>}
                                            ]}
                                          ]},
                        {queue, <<"AZQueueDataX509">>},
                        {prefetch_count, 1}
                      ]},
                    {destination,
                      [ {protocol, amqp091},
                        {uris, ["amqps://pdp-shovel-2@xx.xx.xx.xx:5671?cacertfile=E:\\RabbitMqStore\\certs\\pdp-shovel-1.ca-bundle&certfile=E:\\RabbitMqStore\\certs\\client_certificate.pem&keyfile=E:\\RabbitMqStore\\certs\\private_key.pem&verify=verify_peer&server_name_indication=pdp-shovel-2&auth_mechanism=external&heartbeat=15"]},
                        {declarations, [
					{'queue.declare',
                                            [{queue, <<"AZQueueDataX509">> },  durable]},
					 {'queue.bind',
                                            [ {exchange, <<"amq.topic">>},
                                              {queue,    <<"AZQueueDataX509">>},
					      {routing_key, <<"AZQueueDataRouteX509">>}
                                            ]}
					 ]},
                        {publish_properties, [ {delivery_mode, 2} ]},
                        {add_forward_headers, true}
                          ]},
                    {ack_mode, on_confirm},
                    {reconnect_delay, 15}
                  ]}
				   %% next shovel add comma
				   %% ,
				   %% {shovel_put_X509_2, [
				   %% ]}
		
		
              ]}
  ]}].
```

</details>


#### rabbitmq.conf example :frog:

VM2 rabbitmq.conf (server)

<details>
  <summary>Click to expand configuration</summary>

```ini

## RabbitMQ configuration example:
## https://github.com/rabbitmq/rabbitmq-server/blob/v3.8.x/deps/rabbit/docs/rabbitmq.conf.example

###########################################################################
## ACCESS CONTROL
###########################################################################

## The default "guest" user is only permitted to connect from localhost.
loopback_users.guest = true

###########################################################################
## RESOURCE LIMITS
###########################################################################

## Memory high watermark.
## RabbitMQ will apply flow control when memory usage exceeds 50%.
## https://www.rabbitmq.com/memory.html
vm_memory_high_watermark.relative = 0.5

## Minimum free disk space before flow control is activated.
disk_free_limit.absolute = 5GB

###########################################################################
## LOGGING
###########################################################################

## Keep 5 log files, each up to 10 MB.
log.file.rotation.count = 5
log.file.rotation.size  = 10485760

###########################################################################
## AMQP LISTENERS
###########################################################################

## Standard AMQP listener (no TLS).
## Used by clients authenticating with username/password.
##
## To disable:
## listeners.tcp = none
listeners.tcp.default = 5672

## AMQP over TLS (SSL)
listeners.ssl.default = 5671

###########################################################################
## TLS CERTIFICATES
###########################################################################

## Server certificate presented to TLS clients.

ssl_options.cacertfile = D:\RabbitMqStore\certs\ca_public.bundle
ssl_options.certfile   = D:\RabbitMqStore\certs\public.crt.pem
ssl_options.keyfile    = D:\RabbitMqStore\certs\private.key.pem

###########################################################################
## MUTUAL TLS (mTLS)
###########################################################################

## Request and verify client certificates.
## Every client connecting on port 5671 must present a valid
## X.509 certificate signed by the configured CA.
##
## This enables mutual TLS (mTLS):
## - Client verifies the RabbitMQ server certificate.
## - RabbitMQ verifies the client certificate.
##
## This is required when using EXTERNAL authentication
## (for example RabbitMQ Shovel with auth_mechanism=external).

ssl_options.verify = verify_peer
ssl_options.fail_if_no_peer_cert = true

## If client certificates are signed by an intermediate CA,
## verification depth may need to be increased.
## Default = 1
##
## https://www.rabbitmq.com/ssl.html#peer-verification-depth
ssl_options.depth = 2

## Allow only TLS 1.2
ssl_options.versions.1 = tlsv1.2

###########################################################################
## RABBITMQ SHOVEL TLS
###########################################################################

## Static Shovel destination URIs support TLS query parameters.
##
## Available parameters include:
##
##   cacertfile
##   certfile
##   keyfile
##   verify
##   fail_if_no_peer_cert
##   server_name_indication
##   auth_mechanism
##   heartbeat
##   connection_timeout
##   channel_max
##   versions
##
## Example:
##
## {uris,
##   ["amqps://client@server:5671?
##     cacertfile=D:\\RabbitMqStore\\certs\\ca_public.bundle
##     &certfile=D:\\RabbitMqStore\\certs\\public.crt.pem
##     &keyfile=D:\\RabbitMqStore\\certs\\private.key.pem
##     &verify=verify_peer
##     &server_name_indication=rabbitmq01.example.com
##     &auth_mechanism=external
##     &heartbeat=15"]}
##
## Documentation:
## https://www.rabbitmq.com/uri-query-parameters.html
##
## RabbitMQ plugins such as Shovel and Federation use Erlang TLS libraries
## internally. If additional TLS verification settings are required,
## see:
##
## https://www.rabbitmq.com/ssl.html#erlang-client

###########################################################################
## MANAGEMENT UI (HTTPS)
###########################################################################

## Disable unsecured HTTP management if HTTPS is used.
## management.tcp.port = 15672

## HTTPS Management UI
management.ssl.port       = 15671
management.ssl.cacertfile = D:\RabbitMqStore\certs\ca_public.bundle
management.ssl.certfile   = D:\RabbitMqStore\certs\public.crt.pem
management.ssl.keyfile    = D:\RabbitMqStore\certs\private.key.pem

## HTTP Strict Transport Security (HSTS)
management.hsts.policy = max-age=31536000; includeSubDomains

## Allow only TLS 1.2 for the management UI.
management.ssl.versions.1 = tlsv1.2

###########################################################################
## TLS
###########################################################################

## TLS handshake timeout in milliseconds.
## Optional. Remove to use RabbitMQ defaults.
ssl_handshake_timeout = 15000

###########################################################################
## AUTHENTICATION
###########################################################################

## Enabled authentication mechanisms:
##
## PLAIN
## -------
## RabbitMQ username/password authentication.
##
## AMQPLAIN
## --------
## Legacy AMQP 0-9-1 username/password authentication.
##
## EXTERNAL
## --------
## X.509 client certificate authentication.
##
## This configuration allows:
##
## • Username/password clients on port 5672.
##
## • X.509 certificate clients on port 5671
##   (for example RabbitMQ Shovel using
##   auth_mechanism=external).
##
## Since mTLS is enforced on port 5671
## (verify_peer + fail_if_no_peer_cert=true),
## every client connecting to 5671 must present
## a valid client certificate.

auth_mechanisms.1 = PLAIN
auth_mechanisms.2 = AMQPLAIN
auth_mechanisms.3 = EXTERNAL

## To require certificate authentication only,
## enable EXTERNAL as the only authentication mechanism.
##
## This disables username/password authentication.
##
## auth_mechanisms.1 = EXTERNAL

###########################################################################
## CERTIFICATE USER MAPPING
###########################################################################

## Use the client certificate Common Name (CN)
## as the RabbitMQ username when using EXTERNAL
## authentication.
##
## Example:
##
## Client certificate:
##   Subject: CN=epn-no1-wmq-001
##
## RabbitMQ user:
##   epn-no1-wmq-001

ssl_cert_login_from = common_name

###########################################################################
## AUTHENTICATION BACKEND
###########################################################################

## Use the internal RabbitMQ user database.
##
## "internal" is an alias for:
## rabbit_auth_backend_internal
##
## https://www.rabbitmq.com/access-control.html

auth_backends.1 = rabbit_auth_backend_internal
```

1. Alignment Analysis
Yes, the remote host's rabbitmq.conf aligns with your Shovel configuration.

The Shovel connection string you configured on the source host matches every TLS security requirement and authentication setting configured on this remote host.

2. Key Configuration Matches
Port & Protocol (amqps://...:5671): The remote host exposes TLS on listeners.ssl.default = 5671, matching your Shovel URI.

X.509 Peer Verification: The remote host enforces ssl_options.verify = verify_peer and ssl_options.fail_if_no_peer_cert = true. Your Shovel URI explicitly passes matching query parameters (verify=verify_peer).

External Authentication (auth_mechanism=external): The remote host enables auth_mechanisms.3 = EXTERNAL, allowing the Shovel client to authenticate via its X.509 client certificate rather than a username/password.

Username Mapping (ssl_cert_login_from = common_name): The remote host extracts the Common Name (CN) from your client certificate (client_certificate.pem) and uses it as the RabbitMQ username. In your Shovel URI (amqps://pdp-shovel-1@...), the CN inside client_certificate.pem must be pdp-shovel-1.

TLS Versioning: The remote host restricts connections to ssl_options.versions.1 = tlsv1.2, which modern Erlang OTP releases support out of the box.

1. Critical Gotchas to Check

User Permissions on Remote Host:

Because ssl_cert_login_from = common_name translates the login name to pdp-shovel-1, you must ensure a user named pdp-shovel-1 exists in the remote RabbitMQ internal database with full write/declare permissions on the target vhost (/):

Intermediate CA Chains:
The remote config explicitly sets ssl_options.depth = 2. Ensure that the CA bundle configured in your Shovel URI (pdp-shovel-1.ca-bundle) includes the complete certificate authority chain leading up to the root CA.

SNI Matching:

Your Shovel URI specifies server_name_indication=pdp-shovel-2. The SAN (Subject Alternative Name) or CN in the remote server's certificate (public.crt.pem) must match pdp-shovel-2 or the TLS handshake will fail verification.

We now have a client that trust the server and uses the server CA certificates, verifies server, checks that the server present a certificate with our configured SNI in CN of the sertificate. Shovel is configured with AMQPS, SSL/TLS towards the server. Forcing the client to only accept a server with a certificate from the trust and a matching SNI.

Upgraded to a trust between the client and server CA's. Forcing the server to only accept a client with a certificate from the trust. SSL/mTLS


</details>


### Architecture Security Verdict

Yes, this is an enterprise-grade, highly secure Shovel setup.

By combining mutual TLS (mTLS), hardware-level certificate authentication, strict cipher parameters, and automatic queue topology declarations, this pattern follows defense-in-depth principles for cross-datacenter message routing.


### Strengths of This Production Setup

Mutual TLS (mTLS) is one of the standard ways to protect against man-in-the-middle (MITM) attacks, but it's the combination of client-side and server-side verification that matters.

In your setup:

On the Shovel (TLS client):

```txt
verify=verify_peer
cacertfile=...
server_name_indication=pdp-shovel-2
```

This causes the Shovel to:

- Verify that the server's certificate chains to your trusted CA.
- Verify the server's identity (subject to the client library's hostname verification behavior).
- Reject an attacker pretending to be your RabbitMQ broker unless they have a certificate trusted by your CA and matching the expected server identity.

On the destination RabbitMQ (TLS server):

```ini
ssl_options.verify = verify_peer
ssl_options.fail_if_no_peer_cert = true
```

This causes the broker to:

- Require every client to present a certificate.
- Verify that the certificate chains to a trusted CA.
- Reject clients without a valid certificate.

So each party authenticates the other:

```txt
Shovel  <========== TLS ==========>  RabbitMQ

verifies server certificate      verifies client certificate
```

That is mutual TLS.

Regarding MITM specifically:

If an attacker intercepts the connection, they would need to present a server certificate that the Shovel trusts. If they don't have a certificate issued by a trusted CA (or another certificate under your trust model that is accepted), the Shovel will reject the connection.

Likewise, if the attacker tries to connect to the destination broker as the client, they would need a valid client certificate trusted by the broker, or the broker will reject the connection.

So you do not need fail_if_no_peer_cert in the Shovel to protect against MITM. The critical client-side setting is:

```txt
verify=verify_peer
```

along with:

- a trusted CA (cacertfile),- the correct server identity (server_name_indication and, if hostname verification is enabled by the client, a matching certificate).
The server-side setting fail_if_no_peer_cert=true is about authenticating clients, not about the client protecting itself against MITM. That protection comes from the client's certificate validation.

***Looking only at the RabbitMQ configuration and the static Shovel configuration, it follows the recommended pattern for X.509-authenticated Shovels.***

By switching to the hostname and making it resolvable, you addressed the server identity part of the TLS configuration.

Specifically:

- On the destination broker:
  - `listeners.ssl.default = 5671` ✔
  - `ssl_options.cacertfile` ✔
  - `ssl_options.certfile` ✔
  - `ssl_options.keyfile` ✔
  - `ssl_options.verify = verify_peer` ✔
  - `ssl_options.fail_if_no_peer_cert = true` ✔
  - `auth_mechanisms` includes `EXTERNAL` ✔
  - `ssl_cert_login_from = common_name` ✔

- On the Shovel:
  - `amqps://it20-no1-ta-284:5671` ✔
  - `cacertfile` ✔
  - `certfile` ✔
  - `keyfile` ✔
  - `verify=verify_peer` ✔
  - `server_name_indication=pdp-shovel-2` ✔
  - `auth_mechanism=external` ✔
  - The hostname used in the URI resolves to the destination broker's IP address (via DNS or `hosts`) ✔
  - The server certificate contains a Subject Alternative Name (SAN) matching the hostname (`DNS:pdp-shovel-2`) ✔

This combination provides:

- Mutual TLS (mTLS).
- Server certificate validation using a trusted CA.
- Client certificate validation by the RabbitMQ broker.
- Certificate-based authentication using the `EXTERNAL` mechanism.
- Validation that the client is connecting to the intended RabbitMQ server through a hostname that matches the certificate's Subject Alternative Name (SAN), which is the recommended TLS deployment pattern.


* Your configuration now provides strong protection against man-in-the-middle (MITM) attacks, assuming it is operating as configured.

* Cryptographic Identity Verification (mTLS): Enforcing verify_peer and fail_if_no_peer_cert = true on both ends prevents Unauthorized Access and Man-In-The-Middle (MITM) inspection.

* Passwordless Authentication (auth_mechanism = external): Using X.509 client certificates mapped directly via ssl_cert_login_from = common_name removes static plain-text passwords from configuration files and memory.

* Traffic Isolation & TLS 1.2+ Enforced: Restricting connections to modern TLS versions blocks legacy protocol fallback attacks (such as POODLE or BEAST).

* Delivery Guarantees (ack_mode = on_confirm): Shovel will only remove messages from the source queue after receiving an explicit publisher confirm from the remote broker, guaranteeing zero message loss during network drops or restarts.

* Network Interruption Recovery: Parameters like reconnect_delay = 15 and heartbeat = 15 ensure quick detection of dead TCP sockets and silent recovery across WAN connections.

### Remaining Production Hardening Checklist

Before marking the deployment final, verify these operational controls on the host operating systems:

1. Private Key ACLs on Disk:
Ensure private_key.pem on the source host and private.key.pem on the destination host have restricted Windows ACLs (readable strictly by the system user running the RabbitMQ service, e.g., LOCAL SYSTEM or a dedicated service account).

2. User Permissions on Destination Broker:
Confirm the user account corresponding to the certificate CN (pdp-shovel-1) is provisioned on the remote host with appropriate write scope:

3. CRL / Certificate Revocation Strategy:
If a client key is ever compromised, ensure you have a process to revoke the certificate or update the CA bundle on the server without causing downtime.

### Comparison: Root CA vs. Intermediate CA Architecture

Yes, cryptographically, it is equally secure.

The underlying encryption (AES/GCM), handshake security, and mutual authentication (mTLS) remain 100% identical whether you sign server and client certificates directly with a Root Certificate Authority (CA) or through an Intermediate CA


When your organization owns and controls the PKI infrastructure (such as an internal Microsoft Active Directory Certificate Services (AD CS) instance, HashiCorp Vault, or a dedicated internal CA server), using a direct Root CA for internal mTLS is standard practice and completely fine.

Yes, building a self-managed OpenSSL PKI using .cnf files is completely valid, fully secure, and extremely common for internal industrial/OT infrastructure.

When you manage your own CA using custom OpenSSL configuration files, you maintain total control over key usage, extension flags (SANs, Extended Key Usage), and certificate lifetimes without relying on third-party tools or heavy enterprise PKI software.


```txt
/my-custom-pki/
├── openssl.cnf           # OpenSSL CA configuration file
├── ca.key                # Private key of your Root CA (KEEP ON PKI MACHINE ONLY!)
├── ca.crt                # Public certificate of your Root CA (Distributed to servers)
├── server.key / server.crt   # Issued to destination server (pdp-shovel-2)
└── client.key / client.crt   # Issued to source client (pdp-shovel-1)
```

## Misc


### Queues, topic and exchanges

![topolgy](https://github.com/spawnmarvel/quickguides/blob/main/amqp/images/queue.png)


These are the four exchange types in RabbitMQ

* Direct: The message is routed to the queues whose binding key exactly matches the routing key of the message. For example, if the queue is bound to the exchange with the binding key pdfprocess, a message published to the exchange with a routing key pdfprocess is routed to that queue.

* Fanout: A fanout exchange routes messages to all of the queues bound to it.

* Topic: The topic exchange does a wildcard match between the routing key and the routing pattern specified in the binding.

* Headers: Headers exchanges use the message header attributes for routing.

### RabbitMQ commands

1. Application & Node Management

```cmd
rabbitmqctl.bat status
```
Shoves, name, plugins, config, disk interface etc

2. User & Access Management

```cmd

cd c:\Program Files\RabbitMQ Server\rabbitmq_server-3.12.1\sbin>

rabbitmqctl.bat add_user lima pass123
Adding user "lima" ...
Done. Don't forget to grant the user permissions to some virtual hosts! See 'rabbitmqctl help set_permissions' to learn more.

rabbitmqctl.bat change_password lima newpass123
Changing password for user "lima" ...


rabbitmqctl.bat set_user_tags lima administrator
Setting tags for user "lima" to [administrator] ...

rabbitmqctl.bat set_permissions -p / lima ".*" ".*" ".*"
Setting permissions for user "lima" in vhost "/" ...
```

https://www.rabbitmq.com/docs/cli

In order to create a passwordless user, create one with any password that passes validation and clear the password using rabbitmqctl's clear_password command:

```cmd
>rabbitmqctl.bat add_user x509name "2be-removed"
Adding user "x509name" ...
Done. Don't forget to grant the user permissions to some virtual hosts! See 'rabbitmqctl help set_permissions' to learn more.

rabbitmqctl.bat set_user_tags x509name administrator

rabbitmqctl.bat set_permissions -p / x509name ".*" ".*" ".*"

rabbitmqctl clear_password x509name
Clearing password for user "x509name" ...
```

https://www.rabbitmq.com/docs/passwords

3. Listing & Monitoring Resources

```cmd


rabbitmqctl.bat list_queues
 
rabbitmqctl.bat list_exchanges

rabbitmqctl.bat list_bindings

rabbitmqctl.bat list_connections

rabbitmqctl.bat list_consumers

```

4. Plugins

Example list:

```cmd
c:\Program Files\RabbitMQ Server\rabbitmq_server-3.12.1\sbin>rabbitmq-plugins list -e
Listing plugins with pattern ".*" ...
 Configured: E = explicitly enabled; e = implicitly enabled
 | Status: * = running on rabbit@BER-0803
 |/
[E ] rabbitmq_management        3.12.1
[e ] rabbitmq_management_agent  3.12.1
[E ] rabbitmq_mqtt              3.12.1
[e ] rabbitmq_shovel            3.12.1
[E ] rabbitmq_shovel_management 3.12.1
[E ] rabbitmq_stream            3.12.1
```

Enable a new plugin if needed:

```cmd
c:\Program Files\RabbitMQ Server\rabbitmq_server-3.12.1\sbin>rabbitmq-plugins enable rabbitmq_trust_store
Enabling plugins on node rabbit@BER-0803:
rabbitmq_trust_store
The following plugins have been configured:
  rabbitmq_management
  rabbitmq_management_agent
  rabbitmq_mqtt
  rabbitmq_shovel
  rabbitmq_shovel_management
  rabbitmq_stream
  rabbitmq_trust_store
Applying plugin configuration to rabbit@BER-0803...
The following plugins have been enabled:
  rabbitmq_trust_store

set 7 plugins.
Offline change; changes will take effect at broker restart.
```
