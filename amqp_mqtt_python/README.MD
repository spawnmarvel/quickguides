# Mqtt with RabbitMQ

RabbitMQ supports MQTT versions 3.1, 3.1.1, and 5.0 via a plugin that ships in the core distribution.

https://www.rabbitmq.com/docs/mqtt

## Enabling the Plugin

```bash 
rabbitmq-plugins enable rabbitmq_mqtt
```

## Serving Millions of Clients with Native MQTT

Covered after mini project below

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

Covered after mini project below

### Mapping MQTT to the AMQP 0.9.1 model

Covered after mini project below

### Queue Types

Covered after mini project below

### Queue Properties and Arguments

Covered after mini project below

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

### Using Quorum Queues

Covered after mini project below

### MQTT QoS 0 queue type

The MQTT plugin creates an MQTT QoS 0 queue if the following three conditions are met:

* Feature flag rabbit_mqtt_qos0_queue is enabled.
* The MQTT client subscribes with QoS 0.
* The MQTT 5.0 client connects with a Session Expiry Interval of 0, or the MQTT 3.1.1 client connects with CleanSession set to 1.


### Overload protection

Covered after mini project below


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

* .#
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

It is good practice to avoid topic levels that do not add additional information, like using the same topic level across all  subscriptions. 

The most common example of such abuse is using the company name as the first level for every subscription.

While some topic levels typically have less variety than others, you should omit topic levels that are the same for every topic. 

Similarly, leading with forward slashes must be matched, so should be avoided if you don’t want them present on all topics.

Bad practice:

* home/livingarea/kitchen
* home/livingarea/bathroom
* home/garage

Bad practice:

* /livingarea/kitchen
* /livingarea/bathroom
* /garage

Good practice:

* livingarea/kitchen
* livingarea/bathroom
* Garage



https://www.hivemq.com/blog/mqtt-topic-tree-matching-challenges-best-practices-explained/#:~:text=MQTT%20is%20a%20publish%2Fsubscribe,avoid%20analyzing%20the%20packet's%20payload

## HiveMQ-What Are MQTT Topics and Their Role in MQTT Message Filtering?

In MQTT, Topic refers to a UTF-8 string that filters messages for a connected client. A topic consists of one or more levels separated by a forward slash (topic level separator).

**Examples of MQTT Topics**

1. myhome/groundfloor/livingroom/temperature: This topic represents the temperature in the living room of a home located on the ground floor.
2. USA/California/San Francisco/Silicon Valley: This topic hierarchy can track or exchange information about events or data related to the Silicon Valley area in San Francisco, California, within the United States.
3. 5ff4a2ce-e485-40f4-826c-b1a5d81be9b6/status: This topic could be used to monitor the status of a specific device or system identified by its unique identifier.
4. Germany/Bavaria/car/2382340923453/latitude: This topic structure could be utilized to share the latitude coordinates of a particular car in the region of Bavaria, Germany.

**Best Practices for Using MQTT Topics**

* Each topic must contain at least one character.
* Topic strings can include empty spaces to allow for more readable or descriptive topics.
* Topics are case-sensitive, meaning "myhome/temperature" and "MyHome/Temperature" are considered as two different topics.
* The forward slash alone is a valid topic and can be used to represent a broad topic or serve as a wildcard for subscribing to multiple topics simultaneously.

**What Are MQTT Wildcards and How to Use Them With Topic Subscriptions?**

* In MQTT, wildcards provide a powerful mechanism for subscribing to multiple topics simultaneously.
* It’s important to note that wildcards can only be used for subscription
* When a client subscribes to a topic, it can either subscribe to the exact topic of a published message or utilize wildcards to broaden its subscription. 
* There are two types of wildcards: single-level and multi-level.

**MQTT Wildcard – Single Level: +**

The single-level wildcard is represented by the plus symbol (+) and allows the replacement of a single topic level.

For example, a subscription to 

myhome/groundfloor/+/temperature

can produce the following results:

* myhome/groundfloor/livingroom/temperature
* myhome/groundfloor/kitchen/temperature

**MQTT Wildcard – Multi Level:**

The multi-level wildcard covers multiple topic levels. It is represented by the hash symbol (#) and must be placed as the last character in the topic, preceded by a forward slash.

When a client subscribes to a topic with a multi-level wildcard, it receives all messages of a topic that begins with the pattern before the wildcard character, regardless of the length or depth of the topic. 

If the topic is specified as “#” alone, the client receives all messages sent to the MQTT broker.

For example, a subscription to 

myhome/groundfloor/#

can produce the following results:

* myhome/groundfloor/livingroom/temperature
* myhome/groundfloor/kitchen/temperature
* myhome/groundfloor/kitchen/brightness

However, it’s important to consider that subscribing with a multi-level wildcard alone can be an anti-pattern if high throughput is expected. 

Subscribing to a broad topic can result in a large volume of messages being delivered to the client, potentially impacting system performance and bandwidth usage. 

Follow best practices to optimize topic subscriptions and avoid unnecessary message overload.

**Why and When to Use MQTT Topics Beginning with $**

In MQTT, topic naming flexibility is vast, allowing you to choose names that suit your needs. However, there is one important exception to be aware of: topics that start with a $ symbol have a distinct purpose.

These topics are not included in the subscription when using the multi-level wildcard (#) as a topic. 

Instead, topics beginning with $ are reserved for internal statistics of the MQTT broker, providing valuable insights into its operation.

Publishing messages to topics starting with $ is not permitted, as these topics serve as a means for the MQTT broker to expose internal information and statistics to clients. 

While there is currently no official standardization for these topics, it is common to use the prefix $SYS/ to denote such information, although specific implementations of brokers may vary.

Here are a few examples of $SYS topics and the information they can provide:

* $SYS/broker/clients/connected: Indicates the number of clients currently connected to the MQTT broker.
* $SYS/broker/clients/disconnected: Shows the number of clients that have disconnected from the MQTT broker.
* $SYS/broker/clients/total: Represents the total count of clients, both connected and disconnected, that have interacted with the MQTT broker.
* $SYS/broker/messages/sent: Provides the count of messages sent by the MQTT broker.
* $SYS/broker/uptime: Reflects the duration the MQTT broker has been running.

**MQTT Best Practices**

* /myhome/groundfloor/livingroom -> myhome/groundfloor/livingroom, Hence, it’s recommended to exclude the leading forward slash.
* Never use spaces in an MQTT Topic, A space is the natural enemy of every programmer, UTF-8 has many different white space types.
* Keep MQTT topics short and concise
* Use only ASCII characters, and avoid non-printable characters
* Embed a unique identifier or the Client Id in topics, For example, a client with the client1 ID can publish to client1/status but not to client2/status.
* Avoid Subscribing to Wildcards (#), Sometimes, it is necessary to subscribe to all messages that are transferred over the broker. For example, to persist all messages into a database. Do not subscribe to all messages on a broker by using an MQTT client and subscribing to a multi-level wildcard. Frequently, the subscribing client is not able to process the load of messages that results from this method (especially if you have a massive throughput).
* Embrace Extensibility, Topics in MQTT provide inherent flexibility, allowing for future expansion and new features. Consider how your topic structure can accommodate future enhancements or the addition of new sensors or functionalities.
* Use specific topics, not general ones

For instance, if you have three sensors in your living room, create topics like 
* myhome/livingroom/temperature
* myhome/livingroom/brightness
* myhome/livingroom/humidity 
instead of using a generic topic like myhome/livingroom.

https://www.hivemq.com/blog/mqtt-essentials-part-5-mqtt-topics-best-practices/

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