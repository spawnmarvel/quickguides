# Discover Azure message queues AZ-305

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

The primary wire protocol for Service Bus is Advanced Messaging Queueing Protocol (AMQP) 1.0, an open ISO/IEC standard. 

The primary wire protocol for Service Bus is Advanced Messaging Queueing Protocol (AMQP) 1.0, an open ISO/IEC standard. It allows customers to write applications that work against Service Bus and on-premises brokers such as ActiveMQ or RabbitMQ. The AMQP protocol guide provides detailed information in case you want to build such an abstraction.

AMQP 1.0 in Azure Service Bus and Event Hubs protocol guide https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-protocol-guide




## TODO