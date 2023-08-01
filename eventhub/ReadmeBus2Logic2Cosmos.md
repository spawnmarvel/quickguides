# Azure Service Bus with Logic App connector to Cosmos DB NoSQL


Resources

![Resources cosmos ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/resourcescosmos.jpg)


API for NoSQL
* The Azure Cosmos DB API for NoSQL stores data in document format. 
* It offers the best end-to-end experience as we have full control over the interface, service, and the SDK client libraries. 
* Any new feature that is rolled out to Azure Cosmos DB is first available on API for NoSQL accounts.

https://learn.microsoft.com/en-us/azure/cosmos-db/choose-api

Process and create Azure Cosmos DB documents using Azure Logic Apps

https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-cosmos-db?tabs=consumption

Databases, containers, and items in Azure Cosmos DB

https://learn.microsoft.com/en-us/azure/cosmos-db/resource-model

Built-in connectors in Azure Logic Apps

https://learn.microsoft.com/en-us/azure/connectors/built-in

Service Bus

https://learn.microsoft.com/en-us/connectors/servicebus/

## APPLIES TO:  NoSQL  MongoDB  Gremlin

Azure Synapse Link for Azure Cosmos DB is a cloud-native hybrid transactional and analytical processing (HTAP) capability that enables near real time analytics over operational data in Azure Cosmos DB. 

Azure Synapse Link creates a tight seamless integration between Azure Cosmos DB and Azure Synapse Analytics.

Limitations
* Azure Synapse Link for Azure Cosmos DB is supported for NoSQL and MongoDB APIs.
* Enabling Azure Synapse Link on existing Azure Cosmos DB containers is only supported for API for NoSQL accounts. 
* Azure Synapse Link can be enabled on new containers for both API for NoSQL and MongoDB accounts.
* [...]

![Synapse ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/synapse.jpg)

https://learn.microsoft.com/en-us/azure/cosmos-db/synapse-link

## Steps

Service Bus information
* NS Pricing tier Standard
* Queue default expect days 1, no session
* Create a NS Policy RootExt Manage, use that in the "Get messages from a queue"
* Create a Q Policy SubExt Manage, use that in "Complete the message in a queue"

Cosmos DB
* Capacity mode Serverless
* Backup Policy Continuous (7 days)
* Db Historian
* Container tags

Cosmos db was create here with the following schema:

Database id Historian, container tags, Partition key /type (could also add hierarchical partition key with system)

TAG-12 type=analog, system=12

TAG-13 type=analog, system=13

https://follow-e-lo.com/2023/07/30/azure-cosmos-db-101/


Logic APP
* Operating System Windows
* App Service Plan ASP-Rgcosmosdb089-b0b1 (WS1: 1)
* Create a new statful workflow 3
* Logic
* * Recurrence each min 1
* * Get messages from a queue 2
* * for each message 
* * * Create (or update) item in the db Historian, container id tags, with item = Message Content 3
* * * After Complete the message in the queue 4


Data

```json
{
    "id": "16",
    "type": "analog",
    "name": "TAG-12",
    "quality": "GOOD",
    "value" : 99.35,
    "ts": "2023-07-31T-12:11:00.245Z"
}


```
Overview

![Cosmos view ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/cosmosview.jpg)

Logic App

![Logic app ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicappcosmos.jpg)

Issues on the path

When posting a message to ASB wrong connection string format was used,.i.e ************ and not the actual string

![Bad con str ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/badconstr.jpg)

When posting a message to ASB public ip of cosmos db was not added to FW, (and did not configure private endpoint), added pub ip for test

![Pub ip ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/pubip.jpg)

Result when the above was fixed

![Result ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/result.jpg)


Test corrupt json

```json
{
    "wrong_id_filed": "17",
    "type": "analog",
    "name": "TAG-12",
    "quality": "GOOD",
    "value" : 99.35,
    "ts": "2023-07-31T-12:11:00.245Z"
}
```
It fails on insert, correct and it does not complete the message, it will be moved to DLQ.

![Failed ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/failed.jpg)

Send a new OK message

```json
{
    "id": "17",
    "type": "analog",
    "name": "TAG-12",
    "quality": "GOOD",
    "value" : 99.35,
    "ts": "2023-07-31T-12:11:00.245Z"
}
```

Two messages in the queue

![Send 2 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/send2.jpg)

The OK message has arrived and the error message is still in the queue, ref time out DLQ

![Send 2 yes ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/send2yes.jpg)

