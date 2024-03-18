# Mqtt with RabbitMQ

RabbitMQ supports MQTT versions 3.1, 3.1.1, and 5.0 via a plugin that ships in the core distribution.

https://www.rabbitmq.com/docs/mqtt

## Enabling the Plugin

```bash 
rabbitmq-plugins enable rabbitmq_mqtt
```

## Supported MQTT features

RabbitMQ supports most MQTT 5.0 features including the following:

* QoS 0 (at most once) and QoS 1 (at least once) publish & subscribe
* TLS, OAuth 2.0
* Clean and non-clean sessions
* Message Expiry Interval
* Subscription Identifier and Subscription Options
* Will messages including Will Delay Interval
* Request / Response including interoperability with other protocols such as AMQP 0.9.1 and AMQP 1.0
* Topic Alias
* Retained messages with the limitations described in section Retained Messages and Stores
* MQTT over a WebSocket via the RabbitMQ Web MQTT Plugin

## Minimal rabbitmq.conf

```bash

# [...]

ssl_options.cacertfile = C:\testca\ca_certificate.pem
ssl_options.certfile   = C:\testca\server3\server3_certificate.pem
ssl_options.keyfile    = C:\testca\server3\private_key.pem
ssl_options.verify     = verify_none
ssl_options.fail_if_no_peer_cert = false

mqtt.listeners.tcp.default = 1883
mqtt.listeners.ssl.default = 8883
mqtt.ssl_cert_login = true
mqtt.allow_anonymous = true

# [...]

```