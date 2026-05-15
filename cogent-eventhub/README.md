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



## Event streams (read) Cogent


Create a new read policy for cogent


![read_policy](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/read_policy.png)


Configure cogent

![cogent hub](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/cogent_hub.png)


Now at the bottom in paration settings press the 3 ..., make the format.

* Test a message, add it to sample input
* Generate a schema
* Add script var name = 
* Test it, and ok

```json
{"tag": "tag3", 
"timestamp": "2026-05-15T12:20:52.399265+00:00",
 "quality": "Bad",
 "value": 0.0
 }
```
![schema](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/schema.png)

Enable the stream and press apply

![enable_cogent](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/enable_cogent.png)


Run the python script again and view data

![view_data](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/view_data.png)

https://cogentdatahub.com/library/documentation/


https://www.youtube.com/watch?v=WK_EO0e1syY

## Hm, get all data in stream

We have more messages then the 3 we just saw.

Earliest Offset

Automatically starts the Event Stream reader from the earliest known offset. This is usually the beginning of the Event Hub stream.

![offset](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/offset.png)

https://cogentdatahub.com/library/documentation/

## Update python to send in a loop

To actually see the timestamps move and the values change in the Cogent Data Browser, we should put the sender into a loop. This simulates a real PLC or sensor pushing data every few seconds.

```py
python send_event.py
Starting live stream... Press Ctrl+C to stop.
Sent batch at: 15:17:33
Sent batch at: 15:17:38
Sent batch at: 15:17:43
Sent batch at: 15:17:48
Sent batch at: 15:17:53
Sent batch at: 15:17:58
Sent batch at: 15:18:03
Sent batch at: 15:18:08
Sent batch at: 15:18:13
Sent batch at: 15:18:18
Sent batch at: 15:18:23
Sent batch at: 15:18:28
```


![stream_live](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/stream_live.png)


## The Difference: Stream vs. Points

It is a common point of confusion when starting with Event Hubs. You are right that a Stream contains every single value from start to finish, like a recorded movie. However, Cogent DataHub (and most SCADA/HMI systems) usually acts like a Projector showing only the "Current Frame."

🔹 The Event Hub (The Firehose)
Event Hub is a Temporal Store. It keeps every message you’ve sent for a specific retention period (e.g., 1 day or 7 days). If you send "Value: 10" and then "Value: 20", the Event Hub keeps both.

🔹 Cogent DataHub (The Point Server)
DataHub is a Real-Time Data Middleware. When it reads from the Event Hub, it maps the "tag" field to a Data Point. By default, the Data Browser only shows you the Current Value of that point.

🔹 When message #1 arrives (tag1 = 10), DataHub shows 10.

🔹 When message #2 arrives (tag1 = 20), DataHub updates the point to 20.

🔹 The "10" is gone from the display, even though it still exists in the Event Hub.

## How to see the History in DataHub
If you want to see the "Start to Finish" history within Cogent, you have two main options:

DataHub Historian: You must enable the Historian feature in Cogent. This will take the live stream and write every change into a local file or SQL database. You can then view the "start to finish" data in a Trend graph or a table.

Event Logs: You can check the internal logs of the Azure Event Hub connection in Cogent to see the raw sequence of incoming strings, but this isn't meant for monitoring values.


Acting as an OPC DA Server
If you don't have an existing OPC DA server and you just want an external OPC DA client (like an old HMI) to read the Azure data, you can make Cogent act as the Server:

* Go to OPC DA -> OPC DA Server.

* Check Act as an OPC DA Server.

* Select the Azure Domain as the source.

* Click on Configure Items or Select Items.

* Highlight your Azure tags (tag1, tag2, tag3) and add them to the "Exposed" list.

Now, any OPC DA client can connect to Cogent directly and see your tag1, tag2, and tag3 as if they were local PLC tags.


![opcda](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/opcda.png)


View data

![opc data](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/opc_data.png)

## Hub stats

![hub stats](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/hub_stats.png)
