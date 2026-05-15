# Cogent and event hub / kafka v11


## Event streams (read)


https://cogentdatahub.com/features/utilities/event-streams/

Connect to event streams from Apache Kafka and Azure Event Hubs for real-time ingestion, distribution, and processing of events or messages from a range of sources to multiple consumers, facilitating data integration, event-driven architecture, and real-time analytics.

* Leverage the value of Apache Kafka and Azure Event Hubs.

* Collect data in real time and redistribute it to other locations.

* Integrate data from multiple streams into a single unified namespace.

The Event Streams option lets you connect a DataHub instance to event streams from various providers, currently Apache Kafka and Azure Event Hubs.

To write data to Kafka or Event Hubs, you can use the External Historian feature. Please see Apache Kafka or Azure Event Hubs in the External Historian section for more details.

https://cogentdatahub.com/docs/#cdh-eventstreams.html

![read](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/stream.png)

## External historians (write)

This option is used for writing data to Event Hubs. To collect data from an Event Hubs stream, please see Event Streams.


https://cogentdatahub.com/docs/#cdh-propexthisteventhubs.html


This option is used for writing data to Kafka. To collect data from a Kafka event stream, please see Event Streams.


https://cogentdatahub.com/docs/#cdh-propexthistkafka.html

![write](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/write.png)

## Video event hub

* Write
* Read

https://www.youtube.com/watch?v=ZLSYUvFihgA

## Quickstart: Create an event hub using Azure portal

* Choose Basic for the pricing tier. If you plan to use the namespace from Apache Kafka apps, use the Standard tier. The basic tier doesn't support Apache Kafka workloads

* Leave the throughput units (for standard tier) or processing units (for premium tier) settings as it is. 


https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-create


### Create an Event Hubs namespace

![eventhub](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/eventhub.png)

### Now create the event hub

![eventhub create](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/create_hub.png)

## On the hub, create a send policy.

![send policy](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/send_policy.png)



## Check data in hub (after excute py script)

![data_in_hub](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/data_in_hub.png)



## Insert some data using python


```cmd
python --version
Python 3.13.2

pip install azure-eventhub
pip install azure-identity
pip install aiohttp
```

Get the connection string and update script, using the send2_policy


Test connection
```ps1
# Test connection to the Event Hub Namespace
Test-NetConnection -ComputerName swceventhub03.servicebus.windows.net -Port 5671

```


Run the python script

```py
python .\send_event.py
Successfully authenticated and sent events.

```

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-python-get-started-send?tabs=passwordless%2Croles-azure-portal


