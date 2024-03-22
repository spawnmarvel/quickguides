# Mqtt with RabbitMQ

RabbitMQ supports MQTT versions 3.1, 3.1.1, and 5.0 via a plugin that ships in the core distribution.

https://www.rabbitmq.com/docs/mqtt

## Enabling the Plugin

```bash 
rabbitmq-plugins enable rabbitmq_mqtt
```

## Serving Millions of Clients with Native MQTT (RabbitMQ 3.12. >)

Covered after mini project below

Native MQTT turns RabbitMQ into an MQTT broker opening the door for a broader set of IoT use cases.

Native MQTT ships in RabbitMQ 3.12.

https://www.rabbitmq.com/blog/2023/03/21/native-mqtt

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


### Topic level separator and wildcards

The MQTT protocol specification defines slash ("/") as topic level separator whereas AMQP 0-9-1 defines a dot (".") as topic level separator. This plugin translates patterns under the hood to bridge the two.

For example, MQTT topic cities/london becomes AMQP 0.9.1 topic cities.london and vice versa. Therefore, when an MQTT client publishes a message with topic cities/london, if an AMQP 0.9.1 client wants to receive that message, it should create a binding from its queue to the topic exchange with binding key cities.london.

Vice versa, when an AMQP 0.9.1 client publishes a message with topic cities.london, if an MQTT client wants to receive that message, it should create an MQTT subscription with topic filter cities/london.

| MQTT          | AMQP 0.9.1    | Description |
| ------------- | ------------- | ------------- |
| / (slash)     | . (dot)       | topic level separator
| + (plus)      | * (asterisk)  | single-level wildcard (match a single word)
| # (hash)      | # (hash)      | multi-level wildcard (match zero or more words)

* MQTT topics that have dots in them won't work as expected and are to be avoided
* the same goes for AMQP 0-9-1 routing and binding keys that contains slashes.


https://www.rabbitmq.com/docs/mqtt

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

## paho-mqtt 2.0.0

This document describes the source code for the Eclipse Paho MQTT Python client library, which implements versions 5.0, 3.1.1, and 3.1 of the MQTT protocol.

* This code provides a client class which enables applications to connect to an MQTT broker to publish messages
* and to subscribe to topics and receive published messages. 
* It also provides some helper functions to make publishing one off messages to an MQTT server very straightforward.
* TLDR Known limitations

https://pypi.org/project/paho-mqtt/



https://www.rabbitmq.com/docs/mqtt

## Mini mqtt project publish

Lets assume the one sensors from below and test some concepts with Python and RabbitMQ.

* myhome/livingroom/temperature

Json example:
```json
{
    
    "keyvault": [
        {
            "mqtthost": "localhost",
            "mqttuser": "username-rmq",
            "mqttpass": "pass-rmq"
        }
    ]
}
```


We publish to

* myhome/livingroom/temperature/sensor1

We define 3 queues with amq.topic and routing key.

* myhome.livingroom.#
* myhome.livingroom.temperature.#
* myhome.livingroom.temperature.sensor1.#

and start the run_pub_sensor1.py

![3 queues](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/3_queues.jpg)

We get data on all 3 queues.


If the publisher is not subscribing to a topic,but only pushing:

```py

 def on_connect(self, client, userdata, flags, rc, duck_properties):
        logging.info("On connect " + str(client) + ". " + str(flags) + ". " + str(rc))
        if rc == 0 and client.is_connected():
            logging.info("Connected to Mqtt broker!")
            # https://pypi.org/project/paho-mqtt/#client
            # this is for subscriber
            # we should always subscribe from on_connect callback to be sure
            # our subscribed is persisted across reconnections.
            # client.subscribe("$SYS/#")
            # client.subscribe(self.mqtt_topic)
        else:
            logging.info("Failed to connect, return code " + str(rc))


```

If we now send data, we are just pushing to a topic, we do not get the auto queue with application id.

![No subscribe](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/no_subscribe.jpg)

If we inspect the message, it is not persistent, then it must be 2.

![No persistent](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/not_persistent.jpg)

We will dig into that later, but lest try to subscribe to a topic, with a subscriber.

## Mini mqtt project subscribe

Lets start the subscriber.

![Start subsriber](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/start_sub.jpg)

Lets start the publisher.

![Start publisher](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/start_publ.jpg)

(I removed the, self.simulate_wait())

And check that messages is incoming to queues and subscriber.

![Pub sub](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/pub_sub.jpg)

At this point RabbitMQ was just a broker between pub and sub.

We also stored all messages in the 3 queues.

# Get to know what rabbitmq can do

## Serving Millions of Clients with Native MQTT blog

* MQTT plugin parses MQTT messages and sends them directly to queues.
* Native MQTT turns RabbitMQ into an MQTT broker opening the door for a broader set of IoT use cases.
* Native MQTT ships in RabbitMQ 3.12.

## New MQTT QoS 0 Queue Type


![Before mqtt to amqp](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/before.jpg)



* Native MQTT ships with a new RabbitMQ queue type called rabbit_mqtt_qos0_queue. 
* To have the MQTT plugin create queues of that new queue type, the 3.12 feature flag with the same name rabbit_mqtt_qos0_queue must be enabled.

In all RabbitMQ versions, the MQTT plugin creates a dedicated queue per MQTT subscriber, 0, 1 or 2 queues.

* There are 0 queues for an MQTT connection if the MQTT client never sends a SUBSCRIBE packet. The MQTT client is only publishing messages.
* There is 1 queue for an MQTT connection if the MQTT client creates one or multiple subscriptions with the same Quality of Service (QoS) level.
* There are 2 queues for an MQTT connection if the MQTT client creates one or multiple subscriptions with both QoS 0 (at most once) and QoS 1 (at least once).

Queue naming pattern mqtt-subscription-<MQTT client ID>qos[0|1] where <MQTT client ID> is the MQTT client identifier and [0|1] is either 0 for a QoS 0 subscription or 1 for a QoS 1 subscription.


Figure 3 shows an MQTT subscriber that connects with CleanSession=1 and subscribes with QoS 0. Clean session means that the MQTT session lasts only as long as the network connection between client and server. 

When the session ends, all session state in the server is deleted, which implies the queue gets auto deleted.

As seen in Figure 3, each classic queue results in two additional Erlang processes: one supervisor process, and one worker process.



![QoS 0 Queue Type](https://github.com/spawnmarvel/quickguides/blob/main/amqp_mqtt_python/images/qos0_queue.jpg)


https://www.rabbitmq.com/blog/2023/03/21/native-mqtt

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


## Limitations

The following MQTT features are unsupported:

* QoS 2 (exactly once)
* Shared subscriptions
* A Will Message that is both delayed and retained is not retained.

### How the MQTT plugin works

RabbitMQ MQTT plugin targets MQTT 3.1, 3.1.1, and 5.0 supporting a broad range of MQTT clients. 

It also makes it possible for MQTT clients to interoperate with AMQP 0-9-1, AMQP 1.0


### Mapping MQTT to the AMQP 0.9.1 model

### Queue Types

### Queue Properties and Arguments

### Topic level separator and wildcards


For example, MQTT topic cities/london becomes AMQP 0.9.1 topic cities.london and vice versa. Therefore, when an MQTT client publishes a message with topic cities/london, if an AMQP 0.9.1 client wants to receive that message, it should create a binding from its queue to the topic exchange with binding key cities.london.

Vice versa, when an AMQP 0.9.1 client publishes a message with topic cities.london, if an MQTT client wants to receive that message, it should create an MQTT subscription with topic filter cities/london.

| MQTT          | AMQP 0.9.1    | Description |
| ------------- | ------------- | ------------- |
| / (slash)     | . (dot)       | topic level separator
| + (plus)      | * (asterisk)  | single-level wildcard (match a single word)
| # (hash)      | # (hash)      | multi-level wildcard (match zero or more words)

* MQTT topics that have dots in them won't work as expected and are to be avoided
* the same goes for AMQP 0-9-1 routing and binding keys that contains slashes.

### Using Quorum Queues

### MQTT QoS 0 queue type

The MQTT plugin creates an MQTT QoS 0 queue if the following three conditions are met:

* Feature flag rabbit_mqtt_qos0_queue is enabled.
* The MQTT client subscribes with QoS 0.
* The MQTT 5.0 client connects with a Session Expiry Interval of 0, or the MQTT 3.1.1 client connects with CleanSession set to 1.


### Overload protection


https://www.rabbitmq.com/docs/mqtt

## Sparkplug Support

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

mqtt.sparkplug = true

# [...]

```

https://www.rabbitmq.com/docs/mqtt#sparkplug-support


## Rabbitmq MQTT / Persistent queue

Example:
1. Create a queue Q1 (e.g. via your AMQP 0.9.1 client or via the Management UI).
2. Bind Q1 to the topic exchange called "amq.topic" (that exchange is already created by RabbitMQ) with routing key for example "mytopic".
3. Create an MQTT connection which publishes with QoS 1 to topic "mytopic".
4. Optionally, disconnect your MQTT publishing connection.
5. Depending on whether your AMQP 0.9.1 client is already connected or not, make sure it connects and consumes from queue Q1. The message should then arrive in your AMQP consuming app.

The important part here is that Q1 (not created by the MQTT plugin) must exist at the point in time your MQTT connection is publishing such that the message will be routed to Q1.
(Whether Q1 is a classic queue or quorum queue does not really matter for the purpose of this test. Of course, if you want high availability and message safety, use a quorum queue.)



https://groups.google.com/g/rabbitmq-users/c/Gq4Gxh2rgVg?pli=1