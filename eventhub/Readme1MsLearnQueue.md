# AZ-305 Microsoft Azure Architect Design Prerequisites

## Discover Azure message queues

https://learn.microsoft.com/en-us/training/modules/discover-azure-message-queue/

## Introduction

Azure supports two types of queue mechanisms: Service Bus queues and Storage queues.

* Service Bus queues are part of a broader Azure messaging infrastructure that supports queuing, publish/subscribe, and more advanced integration patterns. 
* Storage queues are part of the Azure Storage infrastructure. They allow you to store large numbers of messages. You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. 


## Choose a message queue solution

### Consider using Service Bus queues

* Receive messages without having to poll the queue.
* Guaranteed first-in-first-out (FIFO) ordered delivery.
* Support automatic duplicate detection.
* Application to process messages as parallel long-running streams
* Requires transactional behavior and atomicity
* Messages that can exceed 64 KB but won't likely approach the 256-KB limit.


### Consider using Storage queues

* Must store over 80 gigabytes of messages in a queue.
* Track progress for processing a message in the queue. 
* Require server side logs of all of the transactions

## Explorer Azure Service Bus

Service Bus tiers

| Premium                               | Standard
| ------------------------------------- | -----------------------
| High throughput                       | Variable throughput
| Predictable performance               | Variable latency
| Fixed pricing                         | Pay as you go variable pricing
| Ability to scale workload up and down | N/A
| Message size up to 100 MB             | Message size up to 256 KB

Advanced features

![Advanced ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/advanced1.jpg)

| Feature           | Description
| ----------------- | ---------------------------------------------------
| Message sessions  | Create FIFO guarantee, enable sessions
| Autoforwarding    | Chains queue/topic to another queue/topic in same ns
| DLQ               | Service Bus supports a dead-letter queue (DLQ). A DLQ holds messages that can't be delivered to any receiver. Service Bus lets you remove messages from the DLQ and inspect them.
| Scheduled delivery| You can submit messages to a queue or topic for delayed processing. You can schedule a job to become available for processing by a system at a certain time.
| Message deferral  | A queue or subscription client can defer retrieval of a message until a later time. The message remains in the queue or subscription, but it's set aside.
| Batching          | Client-side batching enables a queue or topic client to delay sending a message for a certain period of time.
| Transactions      | A transaction groups two or more operations together into an execution scope. Service Bus supports grouping operations against a single messaging entity within the scope of a single transaction. A message entity can be a queue, topic, or subscription.
| Filtering and actions | Subscribers can define which messages they want to receive from a topic. These messages are specified in the form of one or more named subscription rules.
| Autodelete on idle | Autodelete on idle enables you to specify an idle interval after which a queue is automatically deleted. The minimum duration is 5 minutes.
| Duplicate detection | An error could cause the client to have a doubt about the outcome of a send operation. Duplicate detection enables the sender to resend the same message, or for the queue or topic to discard any duplicate copies.
| Security protocols | Service Bus supports security protocols such as Shared Access Signatures (SAS), Role Based Access Control (RBAC) and Managed identities for Azure resources.
| Geo-disaster recovery | Regions or datacenters experience downtime, Geo-disaster recovery enables data processing to continue operating in a different region or datacenter.
| Security           | Service Bus supports standard AMQP 1.0 and HTTP/REST protocols.


### Compliance with standards and protocols

The primary wire protocol for Service Bus is Advanced Messaging Queueing Protocol (AMQP) 1.0, an open ISO/IEC standard. It allows customers to write applications that work against Service Bus and on-premises brokers such as ActiveMQ or RabbitMQ. The AMQP protocol guide provides detailed information in case you want to build such an abstraction.

AMQP 1.0 in Azure Service Bus and Event Hubs protocol guide https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-protocol-guide


## Discover Service Bus queues, topics, and subscriptions

Queues
* Queues offer First In, First Out (FIFO) message delivery to one or more competing consumers.

Receive modes:

Receive and delete
* Service Bus receives the request from the consumer, it marks the message as consumed and returns it to the consumer application. This mode is the simplest model. It works best for scenarios in which the application can tolerate not processing a message if a failure occurs.

Peek lock
1. Finds the next message to be consumed, locks it to prevent other consumers from receiving it, and then, return the message to the application.
2. After the application finishes processing the message, it requests the Service Bus service to complete the second stage of the receive process. Then, the service marks the message as consumed.

Topics and subscriptions
* A queue allows processing of a message by a single consumer
* Topics and subscriptions provide a one-to-many form of communication in a publish and subscribe pattern.

Rules and actions
*  In many scenarios, messages that have specific characteristics must be processed in different ways. To enable this processing, you can configure subscriptions to find messages that have desired properties and then perform certain modifications to those properties.
* While Service Bus subscriptions see all messages sent to the topic, you can only copy a subset of those messages to the virtual subscription queue. This filtering is accomplished using subscription filters. 
* Such modifications are called filter actions. When a subscription is created, you can supply a filter expression that operates on the properties of the message. The properties can be both the system properties (for example, Label) and custom application properties (for example, StoreName.) The SQL filter expression is optional in this case. 
* Without a SQL filter expression, any filter action defined on a subscription is performed on all the messages for that subscription.

## Explore Service Bus message payloads and serialization

Message routing and correlation

The broker properties are system defined.

The user properties are a collection of key-value pairs defined and set by the application.

A subset of the broker properties, specifically To, ReplyTo, ReplyToSessionId, MessageId, CorrelationId, and SessionId, help applications route messages to particular destinations. 

* Simple request/reply: A publisher sends a message into a queue and expects a reply from the message consumer.
* Multicast request/reply: As a variation of the prior pattern, a publisher sends the message into a topic and multiple subscribers become eligible to consume the message.
* Multiplexing: This session feature enables multiplexing of streams of related messages through a single queue or subscription [...]
* Multiplexed request/reply: This session feature enables multiplexed replies, allowing several publishers to share a reply queue. 

Routing inside of a Service Bus namespace uses autoforward chaining and topic subscription rules. Routing across namespaces can be performed using Azure LogicApps.

Payload serialization

* When in transit or stored inside of Service Bus, the payload is always an opaque, binary block
* The legacy SBMP protocol serializes objects with the default binary serializer, or with a serializer that is externally supplied. The AMQP protocol serializes objects into an AMQP object.
* [...] and any AMQP client can decode them.

## Explore Azure Queue Storage

Azure Queue Storage is a service for storing large numbers of messages. 
* You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. 
* A queue message can be up to 64 KB in size. 
* A queue may contain millions of messages, up to the total capacity limit of a storage account. 
* Queues are commonly used to create a backlog of work to process asynchronously.

* URL format: Queues are addressable using the URL format https://<storage account>.queue.core.windows.net/<queue>. For example, the following URL addresses a queue in the diagram above https://myaccount.queue.core.windows.net/images-to-download

* Storage account: All access to Azure Storage is done through a storage account.

* Queue: A queue contains a set of messages. All messages must be in a queue. The queue name must be all lowercase.

* Message: A message, in any format, of up to 64 KB. For version 2017-07-29 or later, the maximum time-to-live can be any positive number, or -1 indicating that the message doesn't expire. If this parameter is omitted, the default time-to-live is seven days.

![Knowledge ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/az305bus.jpg)

