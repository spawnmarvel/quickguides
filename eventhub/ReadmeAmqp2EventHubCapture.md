# Capture events through Azure Event Hubs in Azure Blob Storage or Azure Data Lake Storage

Azure Event Hubs enables you to automatically capture the streaming data in Event Hubs in an Azure Blob storage or Azure Data Lake Storage Gen 1 or Gen 2 account of your choice, with the added flexibility of specifying a time or size interval. Setting up Capture is fast, there are no administrative costs to run it, and it scales automatically with Event Hubs throughput units in the standard tier or processing units in the premium tier. Event Hubs Capture is the easiest way to load streaming data into Azure, and enables you to focus on data processing rather than on data capture.

How Event Hubs Capture works

Event Hubs is a time-retention durable buffer for telemetry ingress, similar to a distributed log. The key to scaling in Event Hubs is the partitioned consumer model. Each partition is an independent segment of data and is consumed independently. Over time this data ages off, based on the configurable retention period. As a result, a given event hub never gets "too full."

Event Hubs Capture enables you to specify your own Azure Blob storage account and container, or Azure Data Lake Storage account, which are used to store the captured data. These accounts can be in the same region as your event hub or in another region, adding to the flexibility of the Event Hubs Capture feature.

Captured data is written in Apache Avro format: a compact, fast, binary format that provides rich data structures with inline schema. This format is widely used in the Hadoop ecosystem, Stream Analytics, and Azure Data Factory. More information about working with Avro is available later in this article.

[...]

How Event Hubs Capture is charged
* The capture feature is included in the premium tier so there is no additional charge for that tier. 
* For the Standard tier, the feature is charged monthly, and the charge is directly proportional to the number of throughput units or processing units purchased for the namespace. 
* As throughput units or processing units are increased and decreased, Event Hubs Capture meters increase and decrease to provide matching performance. The meters occur in tandem. For pricing details, see Event Hubs pricing.

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-capture-overview

## Test

### Create Event Hubs Namespace:

![Eh namespace tier ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/ehtier.jpg)

### Create Event Hub wuth capture

![Eh capture ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/ehcapture.jpg)

### Configure AMQP RabbitMQ Shovel to Azure Event Hub:

* SAS root
* SAS sub
* AMQP queue
* URI (+ certificate)

https://gist.github.com/spawnmarvel

Example URI
```log
amqps://<SUB-SAS-POLICY>:<SAS-TOKEN>@xxxxxxxxx.servicebus.windows.net:5671/?cacertfile=path:/to/cert/ca.bundle&verify=verify_none
```
* Add Shovel

https://github.com/spawnmarvel/quickguides/blob/main/eventhub/ReadmeAmqp2EventHub2ServiceBus.md

### Capture format

![Capture ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/capture.jpg)

### Post message

```json
{
    "Timestamp": "2023-07-17T18:58:00Z", 
    "value": 19, 
    "Name": "Tag1"
}
```

![Post ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/post.jpg)