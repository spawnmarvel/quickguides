# Hivemq

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