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
