# Choose a messaging model in Azure to loosely connect your services

Storage queues, Event Hubs, Event Grid, and Service Bus

https://learn.microsoft.com/en-us/training/modules/choose-a-messaging-model-in-azure-to-connect-your-services/

## Choose whether to use messages or events

What is a message?
* A message contains raw data, produced by one component and consumed by another component.
* A message contains the data itself, not just a reference to that data.
* The sending component expects the destination component to process the message content in a certain way.

What is an event?
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

Benefits of queues in general
* Increased reliability
* * Queues are used by distributed applications as a temporary storage location for messages pending delivery to a destination component.
* Message delivery guarantees
* * At-Least-Once Delivery: In this approach, each message is guaranteed delivery to at least one of the components that retrieve messages from the queue. (Smal change of dulicate, if time-oyt-expires, before worker processed)
* * At-Most-Once Delivery: In this approach, each message isn't guaranteed for delivery, and there's a small chance that it may not arrive. (automatic duplicate detection.)
* * First-In-First-Out (FIFO): In most messaging systems, messages usually leave the queue in the same order in which they were added.