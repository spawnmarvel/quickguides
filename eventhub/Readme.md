# AMQP, Event Grid, Event Hubs and Service Bus

## Choose between Azure messaging services - Event Grid, Event Hubs, and Service Bus

Azure offers three services that assist with delivering events or messages throughout a solution. These services are:

* Azure Event Grid
* Azure Event Hubs
* Azure Service Bus

| Service   | Purpose | Type | When to use | Info
| ---------- | ------- | ---- | -----------| ----
| Event Grid | Reactive programming | Event distribution(discrete) | React to status changes | Dynamically scalable<br/>Low cost <br/>Serverless<br>At least once delivery of an event
| Event Hubs | Big data pipeline | Event streaming (series) | Telemetry and distributed data streaming | Low latency <br/>Can receive and process millions of events per second<br/>At least once delivery of an event
| Service Bus | High-value entrerprise messaging | Messages | Order processing and finacial transactions | Reliable asynchronous message delivery (enterprise messaging as a service) that requires polling<br/>Advanced messaging features like first-in and first-out (FIFO), batching/sessions, transactions, dead-lettering, temporal control, routing and filtering, and duplicate detection<br/>At least once delivery of a message<br/>Optional ordered delivery of messages


* Event Grid isn't a data pipeline, and doesn't deliver the actual object that was updated.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/compare-messaging-services


## Introduction to Event Hubs (is a fully managed platform-as-a-service)

* Azure Event Hubs connects events from any source to your software systems. This acts as a buffer to provide modular solutions that avoid overwhelming your system during traffic spikes, while still enabling near real-time data pipelines. 
* Event Hubs is fast to set up and designed to allow you to focus on drawing insights from data instead of managing infrastructure.
* Able to process millions of events per second with low latency.
* Event Hubs is a modern big data message and event ingestion service that can be seamlessly integrated with other Azure and Microsoft services, such as Stream Analytics, Power BI, and Event Grids, along with outside services like Apache Spark.

Introduction

* You can think of Event Hubs as an event ingestor and a front door for event pipelines. 

As an example use-case scenario, consider a home security company that monitors 100,000 homes. Each home has various sensors – such as a motion-detectors, door/window open sensors, and glass break detectors. These devices report back to a common server. 

What is Event Hubs

* Event Hubs is one of three types of message broker available on Azure.
* Message brokers logically and temporally decouple event producers from event consumers. Decoupling creates an event pipeline that is more modular. So that it scales more easily.

Temporal Decoupling

* The temporal decoupling provided by message brokers means that the event producer and event consumers don’t need to run concurrently. 
* Temporal decoupling can provide a stronger guarantee that messages are received and it means that producers aren't blocked while consumers are processing data.
* Load Balancing and Load Leveling, multiple concurrent consumers, potentially making it simpler to achieve load balancing.

Event Hubs is a versatile service

* Event Hubs is compatible with a wide variety of languages and tools. Data can be read and processed using languages such as Python and Go, and it’s compatible with common protocols.

When is Event Hubs a suitable solution?

* Ingesting high volumes of messages quickly and reliably
* Suitable for receiving data from thousands, or more, event publishers simultaneously and ensuring the data is stored in a non-volatile state.
* It supports connection mechanisms like Advanced Message Queuing Protocol (AMQP) and WebSockets to support low-bandwidth and low-latency message delivery
* There are scenarios where other message brokers are more suitable than Event Hubs. Event Hubs can enable near real-time responses to messages. However, due to its asynchronous nature, Event Hubs isn't always the best choice if the event creators are critically dependent on specific actions taking place in a specific window of time.
* Event Hubs is also not the best choice when delivery of all information is absolutely business critical. Event Hubs can guarantee at least once delivery to its singular Capture consumer. But, if your application has multiple groups that consume the same messages. Then your client application is responsible for connecting to and consuming the events while they're still in the cache. The cache lifetime is configurable, and defaults to 24 hours, but if some downtime prevents your consumer applications from running, you may miss those events.


#### If Event Hubs isn't the perfect fit for your problem, Azure provides other messaging services. Including:

Azure Service Bus, which uses a pull model, similarly to Event Hubs, but is designed for the delivery of mission-critical commands for which a delivery guarantee is required.

Azure Event Grid, which uses a push rather than pull model. A push model follows a publisher-subscriber pattern. In this pattern, a source (such as a mobile app) triggers an event that is pushed to all subscribers, or is discarded if no subscribers exist.


https://learn.microsoft.com/en-us/training/modules/intro-to-event-hubs/3-how-event-hubs-works

#### When to use Event Hubs

https://learn.microsoft.com/en-us/training/modules/intro-to-event-hubs/4-when-to-use-event-hubs


## What is Azure Service Bus? (As Service Bus is a platform-as-a-service (PaaS))

* Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics (in a namespace). Service Bus is used to decouple applications and services from each other, providing the following benefits:
* * Load-balancing work across competing workers
* * Safely routing and transferring data and control across service and application boundaries
* * Coordinating transactional work that requires a high-degree of reliability

### Overview

* Data is transferred between different applications and services using messages.
* JSON, XML, Apache Avro, Plain Text.
* Messaging, decouple applications, load balancing, topics and subscription, transactions
* If you're familiar with other message brokers like Apache ActiveMQ, Service Bus concepts are similar to what you know.
* Message sessions. Implement high-scale coordination of workflows and multiplexed transfers that require strict message ordering or message deferral.


If you're familiar with other message brokers like Apache ActiveMQ, Service Bus concepts are similar to what you know. 

As Service Bus is a platform-as-a-service (PaaS) offering, a key difference is that you don't need to worry about the following actions. Azure takes care of those chores for you.
* Worrying about hardware failures
* Keeping the operating systems or the products patched
* Placing logs and managing disk space
* Handling backups
* Failing over to a reserve machine 

### Concepts

Queue

* Messages are sent to and received from queues. Queues store messages until the receiving application is available to receive and process them.
* Messages in queues are ordered and timestamped on arrival. Once the broker accepts the message, the message is always held durably in triple-redundant storage, spread across availability zones if the namespace is zone-enabled.
* Service Bus keeps messages in memory or volatile storage until they've been reported by the client as accepted.

Note: For a comparison of Service Bus queues with Storage queues, see https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted

Topics

* While a queue is often used for point-to-point communication
* Topics are useful in publish/subscribe scenarios.
* * A subscriber to a topic can receive a copy of each message sent to that topic. Subscriptions are named entities.
* * A subscription rule has a filter to define a condition for the message to be copied into the subscription and an optional action that can modify message metadata.

Namespaces

* A namespace is a container for all messaging components (queues and topics).
* A namespace can be compared to a server in the terminology of other brokers, but the concepts aren't directly equivalent. 
* A Service Bus namespace is your own capacity slice of a large cluster made up of dozens of all-active virtual machines. 
* It may optionally span three Azure availability zones. So, you get all the availability and robustness benefits of running the message broker at enormous scale. And, you don't need to worry about underlying complexities.
* Service Bus is serverless messaging.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview
