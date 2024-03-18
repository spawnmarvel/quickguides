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

## Visuals


https://follow-e-lo.com/2023/11/22/amqp-mqtt-rabbitmq-configuration-with-python/

## HiveMQ-MQTT Topic Tree & Topic Matching: Challenges and Best Practices Explained

* MQTT is a publish/subscribe protocol where devices act as MQTT Clients and exchange messages over an MQTT Broker. 
* MQTT Clients send their data in the PUBLISH control packets to the specific topic. 
* The topic is separate from the packet’s payload, which allows the broker to avoid analyzing the packet’s payload. 
* The broker delivers the published message to every client subscribed with a matching topic filter.

The main difference is that topic is used for publishing and cannot contain wildcard characters whereas the topic filter can.

* The wildcard characters are used to aggregate multiple streams of data into one and are thus used on the subscriber’s side
* It is possible to create a topic filter without wildcard characters, then it would only match at most one topic. That case is often referred to as an exact subscription. 

In a nutshell, topic filter can be thought of as a selector for topics that the PUBLISH packets are sent to. The broker must be able to find the matching subscriptions for each published message.

## HiveMQ-MQTT Wildcard Topic Matching Challenge Explained

* Since there are many use cases for wildcards, let’s examine the technical challenge of capitalizing on wildcard subscriptions.

For instance, if a message is published to the topic “town/house/kitchen”, all the subscriptions with the following topic filters would match:

* #
* town/#
* town/house/#
* +/house/kitchen
* town/+/kitchen
* town/house/+
* +/+/kitchen
* town/+/+
* +/+/+
* town/house/kitchen
* …

The broker must also check the map for all these topic filters. In production workloads, the broker has to find the matching subscriptions for published messages thousands of times per second, so it needs a specialized data structure for a fast lookup.

## HiveMQ-The Topic Tree

The Topic Tree is a data structure used to solve the challenges posed by the above wildcard topic matching problem.

We start at the root of the topic tree and proceed through its levels using the topic segments to select the next node. 

* If the current node has wildcard subscriptions (with # or +),  they are added to the matching subscriptions. 
* Once there are no more segments to match in the topic and there are non-wildcard subscriptions in the current node, there are exact subscriptions for this topic.
* The broker can continue delivering the published message to the subscribed clients once it has found all matching subscriptions.
* This way of storing the subscriptions also reduces memory usage because topic levels shared across multiple subscriptions are only stored once.

## HiveMQ-Best Practices





https://www.hivemq.com/blog/mqtt-topic-tree-matching-challenges-best-practices-explained/#:~:text=MQTT%20is%20a%20publish%2Fsubscribe,avoid%20analyzing%20the%20packet's%20payload
