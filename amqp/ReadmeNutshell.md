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

* In the context of deployment automation this means that environment variables such as 
* RABBITMQ_BASE and RABBITMQ_CONFIG_FILE should ideally be set before RabbitMQ is installed. 
* This would help avoid unnecessary confusion and Windows service re-installations.
* Make advanced.config (with content [].) and rabbitmq.conf in the location of value example for RABBITMQ_BASE (c:software)

Note: Cookie and rabbitmqctl bat issue

* C:\Windows\System32\config\systemprofile\.erlang.cookie 
* C:\Windows\.erlang.cookie

```ps1
# Place the file in the following location:
C:\Users\<your user profile>
```

Set this before install RabbitMQ, use "Edit the systems environment variables gui"

```cmd
# Set this before install, preferable to to data disk, i.e F:
RABBITMQ_BASE=c:\software
RABBITMQ_CONFIG_FILE=c:\software\rabbitmq.conf
RABBITMQ_ADVANCED_CONFIG_FILE=c:\software\advanced.config
```

3. Install RabbitMQ (admin)

Remember the cookie, if there is an issue.

4. VM1 (Shovel client)

```cmd
# cd to sbin
rabbitmq-plugins list
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_shovel
rabbitmq-plugins enable rabbitmq_shovel_management

# To list the enabled plugins
rabbitmq-plugins list -e 

```

* 4.1 VM2 (Server) Enable rabbitmq_management, rabbitmq_auth_mechanism_ssl [For x.509 auth](https://www.rabbitmq.com/docs/plugins)

## Configure for mtls

## Misc
