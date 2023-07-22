# Connect to Azure Service Bus from workflows in Azure Logic Apps

https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-servicebus?tabs=consumption

## Scenario

AMQP->Service Bus->Logic App->File Storage   

## Integration

Service Bus fully integrates with many Microsoft and Azure services, for instance:
* Event Grid
* Logic Apps
* Azure Functions
* Power Platform
* Dynamics 365
* Azure Stream Analytics

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview#integration

## Produce and Consume messages through Service Bus, Event Hubs, and Storage Queues with Azure Functions

https://learn.microsoft.com/en-us/samples/azure-samples/durable-functions-producer-consumer/product-consume-messages-az-functions/

## Connect to Azure Service Bus from workflows in Azure Logic Apps

Applies to: Azure Logic Apps (Consumption + Standard)

* [...]
* Manage messages in queues and topic subscriptions, for example, get, get deferred, complete, defer, abandon, and dead-letter.

Connector technical reference

The Service Bus connector has different versions, based on logic app workflow type and host environment.
* Consumption, [...]
* Consumption, [...]
* Standard, Single-tenant Azure Logic Apps and App Service Environment v3 (Windows plans only)

[...]
Large message support

Large message support is available only for Standard workflows when you use the Service Bus built-in connector operations. For example, you can receive and large messages using the built-in triggers and actions respectively.

For the Service Bus managed connector, the maximum message size is limited to 1 MB, even when you use a premium tier Service Bus namespace.

[...]

## Steps

Step 1 - Check access to Service Bus namespace, create it and the queue, connect it to RabbitMQ.
Step 2 - Get connection authentication requirements
* Get connection string for Service Bus namespace
* Get endpoint URL for Service Bus namespace
* Get fully qualified name for Service Bus namespace
Step 3: Option 2 - Add a Service Bus action

Step 4: Stateful logic app, recurrence each min, Get messages from a queue, for each create a file with the sequence number
* Using managed identity and access keys (service bus namespace endpoint connection string SAS Manage (create SAS on queue also), not used here, if remember correctly))

![logicapp ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicapp.jpg)

App

![Logic app app ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicappapp.jpg)

Auth

![logicappauth ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicappauth.jpg)

Post messages to RabbitMQ:

Steps: https://github.com/spawnmarvel/quickguides/blob/main/eventhub/ReadmeAmqp2ServiceBus.md

```json
{
    "Timestamp": "2023-07-21T21:01:00Z", 
    "Value": 19, 
    "Name": "Tag1"
}
{
    "Timestamp": "2023-07-21T21:02:00Z", 
    "Value": 20, 
    "Name": "Tag1"
}
{
    "Timestamp": "2023-07-21T21:03:00Z", 
    "Value": 21, 
    "Name": "Tag1"
}

```

Messages in Service Bus

![Capture bus ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/capturebus.jpg)

Logic app

![Logic app run ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicapprun.jpg)

Messages in File Storage

![Fs ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/fs1.jpg)

View message

![Tag1 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/tag11.jpg)

Send some more messages with min 04 to 10 and view last message, total is 10.

Bus, all msg still in queue, not completed

![Bus 10 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/bus10.jpg)

File Storage

![File 10 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/file10.jpg)

https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-servicebus?tabs=consumption

## Connect to Azure Service Bus and perform actions such as send to queue, send to topic, receive from queue, receive from subscription, etc.

Complete the message in a queue, The operation completes a message in a queue.

Lets update the logic app

![Complete step ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/completestep.jpg)

Lets send 4 new mesages (it could be a jump in sequence, not doing all at the same time)

Time 00 to 04 min
```json
{
    "Timestamp": "2023-07-21T22:00:00Z", 
    "Value": 21, 
    "Name": "Tag2"
}
```
All completed

![Yea ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/yea3.jpg)

https://learn.microsoft.com/en-us/connectors/servicebus/

Resources

![Resources ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/resources.jpg)


## Welcome to Azure Cosmos DB

APPLIES TO:  NoSQL  MongoDB  Cassandra  Gremlin  Table  PostgreSQL
Azure Cosmos DB is a fully managed NoSQL and relational database for modern app development. Azure Cosmos DB offers single-digit millisecond response times, automatic and instant scalability, along with guaranteed speed at any scale. Business continuity is assured with SLA-backed availability and enterprise-grade security.

https://learn.microsoft.com/en-us/azure/cosmos-db/introduction

## Process and create Azure Cosmos DB documents using Azure Logic Apps

https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-cosmos-db?tabs=consumption


## Scenario

AMQP->Service Bus->Logic App->Cosmos DB  