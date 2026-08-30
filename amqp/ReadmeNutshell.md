# AMQP Shovel MTLS with RFC-6125

https://www.rabbitmq.com/shovel.html
* Shovel plugin

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

* 

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
inside the advanced.config, that is the empty erlang format and place advanced.config and rabbitmq.conf in the location of RABBITMQ_BASE ( example, c:software)

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
RABBITMQ_BASE=c:\software
RABBITMQ_CONFIG_FILE=c:\software\rabbitmq.conf
RABBITMQ_ADVANCED_CONFIG_FILE=c:\software\advanced.config
```

---

3. Install RabbitMQ (admin)

---

4. VM1 (Shovel client)

Remember the cookie, if there is an issue.

```cmd
# cd to sbin
rabbitmq-plugins list
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_shovel
rabbitmq-plugins enable rabbitmq_shovel_management

# To list the enabled plugins
rabbitmq-plugins list -e 

```

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

```json
ssl_options.verify     = verify_peer
ssl_options.fail_if_no_peer_cert = true

// change to:
ssl_options.verify     = verify_none
ssl_options.fail_if_no_peer_cert = false
// the is unsecure, but we can check if everything works before we set up mtls
```

While makeing the shovel you can:

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

## Configure for mtls

## Misc
