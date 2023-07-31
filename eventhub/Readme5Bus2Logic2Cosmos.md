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

Overview

![Cosmos view ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/cosmosview.jpg)