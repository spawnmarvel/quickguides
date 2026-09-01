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

- [Assumptions](#assumptions)
- [Useful information](#Useful-information)
- [Install for tls](#install-for-tls)
- [Configure for mtls](#configure-for-mtls)
- [Misc](#misc)


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
                        {uris, ["amqps://pdp-shovel-1@xx.xx.xx.xx:5671?cacertfile=E:\\RabbitMqStore\\certs\\pdp-shovel-1.ca-bundle&certfile=E:\\RabbitMqStore\\certs\\client_certificate.pem&keyfile=E:\\RabbitMqStore\\certs\\private_key.pem&verify=verify_peer&fail_if_no_peer_cert=true&server_name_indication=pdp-shovel-2&auth_mechanism=external&heartbeat=15"]},
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

VM2 rabbitmq.conf (server)

```ini

# ...

# ssl
listeners.ssl.default = 5671
ssl_options.cacertfile = F:\RabbitMqStore\certs\pdp-shovel-2.ca-bundle
ssl_options.certfile   = F:\RabbitMqStore\certs\public.crt.pem
ssl_options.keyfile    = F:\RabbitMqStore\certs\private.key.pem
ssl_options.verify     = verify_peer
ssl_options.fail_if_no_peer_cert = true
## When using a client certificate signed by an intermediate CA, 
## it may be necessary to configure RabbitMQ server to use a higher verification depth.
## The default depth is 1.
## https://www.rabbitmq.com/ssl.html#peer-verification-depth
ssl_options.depth  = 2

# ....
## TLS handshake timeout, in milliseconds.
ssl_handshake_timeout = 15000
## To use auth-mechanism-ssl, the EXTERNAL mechanism should be enabled:
auth_mechanisms.1 = PLAIN
auth_mechanisms.2 = AMQPLAIN
auth_mechanisms.3 = EXTERNAL

## To force x509 certificate-based authentication on all clients,
## exclude all other mechanisms (note: this will disable password-based
## authentication even for the management UI!):
# auth_mechanisms.1 = EXTERNAL

## To use the TLS cert's CN instead of its DN as the username
ssl_cert_login_from   = common_name

## internal for rabbit_auth_backend_internal,"internal" is an alias for rabbit_auth_backend_internal
## https://www.rabbitmq.com/access-control.html
auth_backends.1   = rabbit_auth_backend_internal

# tls version, disables versions older than TLSv1.2
ssl_options.versions.1 = tlsv1.2
```

We now have a client that trust the server and uses the server CA certificates, verifies server, checks that the server present a certificate with our configured SNI in CN of the sertificate. Shovel is configured with AMQPS, SSL/TLS towards the server. Forcing the client to only accept a server with a certificate from the trust and a matching SNI.

Upgraded to a trust between the client and server CA's. Forcing the server to only accept a client with a certificate from the trust. SSL/mTLS


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
