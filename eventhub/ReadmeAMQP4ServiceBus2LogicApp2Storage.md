# Connect to Azure Service Bus from workflows in Azure Logic Apps

https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-servicebus?tabs=consumption

## Service Bus access control with Shared Access Signatures

Best practices when using SAS

Each Service Bus namespace and each Service Bus entity has a Shared Access Authorization policy made up of rules.

For each authorization policy rule, you decide on three pieces of information: name, scope, and rights.
* 'Send' - Confers the right to send messages to the entity
* 'Listen' - Confers the right to receive (queue, subscriptions) and all related message handling
* 'Manage' - Confers the right to manage the topology of the namespace, including creating and deleting entities
* An authorization rule is assigned a Primary Key and a Secondary Key
* RootManageSharedAccessKey (treat this rule like an administrative root account and don't use it in your application)

Regenerating keys
* It's recommended that you periodically regenerate the keys used in the Shared Access Authorization Policy. The primary and secondary key slots exist so that you can rotate keys gradually.


https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-sas#best-practices-when-using-sas


## Note

All names here for resources, addresses, URI, queues and more may change since I am doing this research on different days.

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

## MS learn Logic Apps

* A business process or workflow is a sequence of tasks that produce a specific outcome.
* Azure Logic Apps is a cloud service that automates the execution of your business processes.
* The components let you connect to hundreds of external services.
* The goal of Azure Logic Apps in one word, we'd choose integration. 

How Azure Logic Apps works
* A connector is a component that provides an interface to an external service. 
* Workflows are built from different types of tasks. 
* Azure Logic Apps uses the terms trigger, action, and control action for these concepts. These operations are the building blocks of Azure Logic Apps.

![Learn logic app ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/learnlogicapp.jpg)

A trigger is an event that occurs when a specific set of conditions is satisfied. Triggers activate automatically when conditions are met. For example, when a timer expires or data becomes available.

An action is an operation that executes a task in your business process. Actions run when a trigger activates or another action completes.

Control actions are special actions built-in to Azure Logic Apps that provides these control constructs:

* Condition statements controlled by a Boolean expression.
* Switch statements.
* For each and until loops.
* Unconditional branch instructions.

### When to use Azure Logic Apps

Decision criteria
* The cases where Azure Logic Apps might not be the best option typically involve real-time requirements, complex business rules, or use of nonstandard services. Here's some discussion of each of these factors.

| Factor      | Description                                            | Note
| ----------- | ------------------------------------------------------ | ---- 
| Integration | Azure Logic Apps works well when you need to get multiple applications and systems to work together. That's what they were designed to do. | If you're building an app with no external connections, Azure Logic Apps is probably not the best option.
| Performance | Execution engine scales your apps automatically. Azure Logic Apps can process large data-sets in parallel to let you achieve high throughput. However, they don't guarantee super-fast activation or enforce real-time constraints on execution time. | If you're looking for low subsecond response time, then Azure Logic Apps may not be the best fit.
| Conditionals | Azure Logic Apps provides control constructs like Boolean expressions, switch statements, and loops so your apps can make decisions based on your data. | There are two reasons you might prefer not to. First, it's often easier to write conditional logic in code rather than using the workflow designer. Second, embedded business rules aren't easily sharable with your other apps. 
| Connectors | Is whether there are prebuilt connectors for all the services you need to access.| If so, then you're ready to go. 

Guidance summary

![Learn logic app guide ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicappguide.jpg)

https://learn.microsoft.com/en-us/training/modules/intro-to-logic-apps/1-introduction

### Logic Apps Standard Performance Benchmark - Burst workloads

Execution Elapsed Time

The chart below represents the total time take to process a batch of 40k and 100k messages, respectively, when using a WS1, WS2 and WS3 app service plan:

![Benchmark ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/benchmark.jpg)

https://techcommunity.microsoft.com/t5/azure-integration-services-blog/logic-apps-standard-performance-benchmark-burst-workloads/ba-p/3317930

## Connect to Azure Service Bus from workflows in Azure Logic Apps

![Learn logic create ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicappcreate.jpg)

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

For the Service Bus managed connector, the maximum message size is limited to 1 MB, even when you use a premium tier Service Bus namespace, ref https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-servicebus?tabs=consumption

Service Bus Messaging, premium tier: up to 100MB, Standard tier up to 256 kb ref https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-premium-messaging

### Size side note

Example message size message.json is 101 kb with 856 matches to tag1, https://github.com/spawnmarvel/quickguides/blob/main/eventhub/message.json

```json
{
 	"Tag1": [

 		{
 			"Name": "Tag1",
 			"Time": "2023-07-21T21:01:00Z", 
            "Value": 19, 
			"Quality": "GOOD"
 		},
		{
 			"Name": "Tag1",
 			"Time": "2023-07-21T21:01:00Z", 
            "Value": 19, 
			"Quality": "GOOD"
 		},
        [...] x 856 total is 101 kb
```

Or 1 small

```json
{
    "Timestamp": "2023-07-21T21:01:00Z", 
    "Value": 19, 
    "Name": "Tag1",
    "Quality": "GOOD"
}
```


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