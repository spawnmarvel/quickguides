# Azure Service Bus with Logic App connector to Cosmos DB

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

Cosmos db was create here with teh follwoing schema:

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

When posting a message to ASB public ip of cosmos db was not added to FW, (and did not configure private endpoint), add pub ip

![Pub ip ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/pubip.jpg)

Result when the above was fixed

![Result ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/result.jpg)
