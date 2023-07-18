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

## Test capture

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

Post some messages on format (UTC):

* Used 2023-07-17T18:58:00Z to 2023-07-17T19:01:00Z

```json
{
    "Timestamp": "2023-07-17T18:58:00Z", 
    "value": 19, 
    "Name": "Tag1"
}
```

![Post ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/post.jpg)

Consumed

![Consumed ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/consumed2.jpg)

And captured yes

![Captured ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/capturedyes.jpg)

## Capturing window

* Event Hubs Capture enables you to set up a window to control capturing. This window is a minimum size and time configuration with a "first wins policy," meaning that the first trigger encountered causes a capture operation.

```log
{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}
```

* The date values are padded with zeroes; an example filename might be:

```log
https://mystorageaccount.blob.core.windows.net/mycontainer/mynamespace/myeventhub/0/2023/07/17/17/27/57.avro
```

Content avro format:
```json
Objavro.codecnullavro.schema�{"type":"record","name":"EventData","namespace":"Microsoft.ServiceBus.Messaging","fields":[
    {"name":"SequenceNumber","type":"long"},{"name":"Offset","type":"string"},{"name":"EnqueuedTimeUtc","type":"string"},{"name":"SystemProperties","type":{"type":"map","values":["long","double","string","bytes"]}},{"name":"Properties","type":{"type":"map","values":["long","double","string","bytes","null"]}},{"name":"Body","type":["null","bytes"]}]} {Data here}
```
Note: If your Azure storage blob is temporarily unavailable, Event Hubs Capture will retain your data for the data retention period configured on your event hub and back fill the data once your storage account is available again.

https://stackoverflow.com/questions/73992965/how-to-read-avro-files-captured-by-azure-event-hubs-from-synapse-sql-serverless

I would recommend you adjust the Event Hubs Capture to write to Parquet files in ADLS Gen2. Then you can query it in Synapse Serverless SQL easily.

## Parquet format

* Send one message to get the format, UTC now = 17:25, Norway time + 2h

```json
{
    "Timestamp": "2023-07-18T17:25:00Z", 
    "value": 19, 
    "Name": "Tag1"
}
```
