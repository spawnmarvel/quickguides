# Choose a messaging model in Azure to loosely connect your services

Storage queues, Event Hubs, Event Grid, and Service Bus

https://learn.microsoft.com/en-us/training/modules/choose-a-messaging-model-in-azure-to-connect-your-services/

## Choose whether to use messages or events

What is a message? :email: :thumbsup:
* A message contains raw data, produced by one component and consumed by another component.
* A message contains the data itself, not just a reference to that data.
* The sending component expects the destination component to process the message content in a certain way.

What is an event? :loudspeaker: :sunrise_over_mountains:
Events are lighter weight than messages, and are most often used for broadcast communications. The components sending the event are known as publishers, and receivers are known as subscribers.
* An event is a lightweight notification that indicates that something happened.
* The event may be sent to multiple receivers, or to none at all.
* Events are often intended to "fan out,".
* The publisher of the event has no expectation about the action a receiving component takes.

### How to choose messages or events

* Events are more likely to be used for broadcasts and are often ephemeral. This means a communication might not be handled by any receiver if none is currently subscribing. 
* Messages are more likely to be used where the distributed application requires a guarantee that the communication will be processed.

For each communication, consider the following question: **Does the sending component expect the communication to be processed in a particular way by the destination component?**

If the answer is yes, choose to use a message. If the answer is no, you may be able to use events.

## Choose a message-based delivery with queues

Azure Queue Storage
* Store large numbers of messages that can be securely accessed from anywhere in the world using a simple REST-based interface
* Queues can contain millions of messages, limited only by the capacity of the storage account that owns it.

Azure Service Bus Queues
* Message broker system intended for enterprise applications.
* Multiple communication protocols, have different data contracts, higher security requirements, and can include both cloud and on-premises services.

Azure Service Bus Topics
* Azure Service Bus topics are like queues, but can have multiple subscribers.
* When a message is sent to a topic instead of a queue, multiple components can be triggered to do their work. 

### Benefits of queues in general

Increased reliability

* Queues are used by distributed applications as a temporary storage location for messages pending delivery to a destination component.

Message delivery guarantees

* At-Least-Once Delivery: In this approach, each message is guaranteed delivery to at least one of the components that retrieve messages from the queue. (Small change of dulicate, if time-out-expires, before worker processed)
* At-Most-Once Delivery: In this approach, each message isn't guaranteed for delivery, and there's a small chance that it may not arrive. (automatic duplicate detection.)
* First-In-First-Out (FIFO): In most messaging systems, messages usually leave the queue in the same order in which they were added.

Transactional support

* Some closely related groups of messages may cause problems when delivery fails for one message in the group. (credit card ananlogy)
* Make sure all messages get processed, or none of them are processed.

### Which service should I choose?

Use Service Bus topics if you:
* Need multiple receivers to handle each message

Use Service Bus queues if you:
* Need an At-Most-Once delivery guarantee.
* Need a FIFO guarantee.
* Need to group messages into transactions.
* Want to receive messages without polling the queue.
* Need to provide a role-based access model to the queues.
* Need to handle messages larger than 64 KB but less than 100 MB. The maximum message size supported by the standard tier is 256 KB and the premium tier is 100 MB.
* Queue size won't grow larger than 1 TB. The maximum queue size for the standard tier is 80 GB and for the premium tier, it's 1 TB.
* Want to publish and consume batches of messages.

Queue storage isn't quite as feature rich, but if you don't need any of those features, it can be a simpler choice. In addition, it's the best solution if your app has any of the following requirements.

Use Queue storage if you:
* Need an audit trail of all messages that pass through the queue.
* Expect the queue to exceed 1 TB in size.
* Want to track progress for processing a message inside of the queue.
* Use a queue to organize messages and gracefully handle unpredictable surges in demand.
* Use Storage queues when you want a simple and easy-to-code queue system. For more advanced needs, use Service Bus queues.


## Choose Azure Event Grid

What is Azure Event Grid?

Many applications use a publish-subscribe model to notify distributed components that something happened, or that some object changed.
The publisher does not need to know aything about the subscriber.

Azure Event Grid is a fully managed event routing service running on top of Azure Service Fabric. Event Grid distributes events from different sources.

Event Grid supports most Azure services as a publisher or subscriber and can be used with third-party services. It provides a dynamically scalable, low-cost, messaging system that allows publishers to notify subscribers about a status change. The following illustration shows Azure Event Grid receiving messages from multiple sources and distributing them to event handlers based on subscription.

![Event grid ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/eventgrid.jpg)


What is an event?

```json
[
  {
    "topic": string,
    "subject": string,
    "id": string,
    "eventType": string,
    "eventTime": string,
    "data":{
      object-unique-to-each-publisher
    },
    "dataVersion": string,
    "metadataVersion": string
  }
]
```

What is an event source?
* Event sources are responsible for sending events to Event Grid. Each event source is related to one or more event types.
* An event publisher is the user or organization that decides to send events to Event Grid (example applications)

What is an event topic?
* Event topics categorize events into groups. Topics are represented by a public endpoint and are where the event source sends events to.
* System topics are built-in topics provided by Azure services.
* Custom topics are application and third-party topics.

What is an event subscription?
* Event Subscriptions define which events on a topic an event handler wants to receive.

What is an event handler?
* An event handler (sometimes referred to as an event "subscriber") is any component (application or resource) that can receive events from Event Grid.

Types of event sources
* [...]
* Service Bus: Service bus can generate events to Event Grid when there are active messages with no active listeners.
* For the full list of Azure services that support system topics, see https://learn.microsoft.com/en-us/azure/event-grid/system-topics

Custom topics
* Custom events can be generated using the REST API, or with the Azure SDK on Java, GO, .NET, Node, Python, and Ruby.

Event handlers
* Azure Functions
* Azure Logic apps
* Webhooks
* Event Hubs
* Service Bus
* Storage Queue
* Power Automate

Should you use Event Grid?
* Simplicity: It's straightforward to connect sources to subscribers in Event Grid.
* Advanced filtering: Subscriptions have close control over the events they receive from a topic.
* Fan-out: You can subscribe to an unlimited number of endpoints to the same events and topics.
* Reliability: Event Grid retries event delivery for up to 24 hours for each subscription.
* Pay-per-event: Pay only for the number of events that you transmit.

## Chooose Azure Event Hubs

What is Azure Event Hubs?

Event Hubs is an intermediary for the publish-subscribe communication pattern. Unlike Event Grid, however, it's optimized for extremely high throughput, a large number of publishers, security, and resiliency.

Event Hubs has support for pipelining event streams to other Azure services. Using it with Azure Stream Analytics, for instance, allows complex analysis of data in near real time.

Whereas Event Grid fits perfectly into the publish-subscribe pattern in that it simply manages subscriptions and routes communications to those subscribers, Event Hubs performs quite a few extra services. These extra services make it look more like a service bus or message queue, than a simple event broadcaster.

Partitions
* As Event Hubs receives communications, it divides them into partitions. Partitions are buffers into which the communications are saved. 

Capture
* Event Hubs can send all your events immediately to Azure Data Lake or Azure Blob storage for inexpensive, permanent persistence.

Authentication
* All publishers are authenticated and issued a token. This means Event Hubs can accept events from external devices and mobile apps, without worrying that fraudulent data from prankers could ruin our analysis.

Which service should I choose?
* You need to support authenticating a large number of publishers.
* You need to save a stream of events to Data Lake or Blob storage.
* You need aggregation or analytics on your event stream.
* You need reliable messaging or resiliency.


# Resilient Event Hubs and Functions design

Error handling, designing for idempotency and managing retry behavior are a few of the critical measures you can take to ensure Event Hubs triggered functions are resilient and capable of handling large volumes of data.

Azure Event Hubs is commonly used for event streaming and big data scenarios.

Streaming benefits and challenges:
* Azure Event Hubs is commonly used for event streaming and big data scenarios.
* Missing inherent dead-letter support: A dead-letter channel is not a native feature in Event Hubs or Kafka.
* A unit of work is a partition: In a traditional message broker, a unit of work is a single message. In a streaming solution, a partition is often considered the unit of work.
* No server-side filtering: One of the reasons Event Hubs is capable of tremendous scale and throughput is due to the low overhead on the service itself.
* Every reader must read all data: Since server-side filtering is unavailable, a consumer sequentially reads all the data in a partition. This includes data that may not be relevant or could even be malformed.

Idempotency
* One of the core tenets of Azure Event Hubs is the concept of at-least once delivery. This approach ensures that events will always be delivered. It also means that events can be received more than once, even repeatedly, by consumers such as a function.

Note: Your function must be idempotent so that the outcome of processing the same event multiple times is the same as processing it once.

Duplicate events
* Checkpointing
* Duplicate events published: There are many techniques that could alleviate the possibility of the same event being published to a stream, however, it's still the responsibility of the consumer to idempotently handle duplicates.
* Missing acknowledgments



https://learn.microsoft.com/en-us/azure/architecture/serverless/event-hubs-functions/resilient-design
