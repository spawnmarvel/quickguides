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


Server Identity Check RFC-6125.

Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)

* https://datatracker.ietf.org/doc/html/rfc6125

Mtls

* https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/

Basic concepts of RabbitMQ and the shovel application.

* https://www.rabbitmq.com/shovel.html

* https://www.rabbitmq.com/uri-spec.html

* https://www.rabbitmq.com/ssl.html#peer-verification

* https://www.rabbitmq.com/access-control.html#basics

* https://github.com/rabbitmq/rabbitmq-server/blob/v3.7.x/deps/rabbit/docs/rabbitmq.config.example


| Configuration File  | Format Used                            | Purpose                             |
| ------------------- | -------------------------------------- | ----------------------------------- |
| rabbitmq.conf       | New style format (sysctl or ini-like)  | Should be used for most settings.   |
| advanced.config     | Classic (Erlang terms)                 | A limited number of settings that cannot be expressed in the new style configuration format |


## Install for tls

## Configure for mtls

## Misc
