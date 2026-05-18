# Cogent and event hub / kafka v11 with python as sender

* Local machine running Cogent
* Azure Infrastructure Setup
* Data Production with Python
* Cogent DataHub Configuration (Read)
* Streaming Logic: Earliest Offset & Loops
* Bridging to Industrial Standards (OPC DA)


![toplogy](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/topology1.png)

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

The code to read a message

```cs
var name = input.Json["tag"];
var timestamp = input.Json["timestamp"];
var quality = input.Json["quality"];
var value = input.Json["value"];

app.WritePoint (name, value, quality, timestamp)

```

* Save the single point template.

![schema](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/schema.png)

Enable the stream and press apply

![enable_cogent](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/enable_cogent.png)


Run the python script again and view data

![view_data](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/view_data.png)

https://cogentdatahub.com/library/documentation/


https://www.youtube.com/watch?v=WK_EO0e1syY

## Earliest Offset

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

* Create a new OPC DA node,  OPC003

* Create a new domain azhub01OpcDa1

* Check Manually select items, ok

![opcda node](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/opcdanode.png)

* Go to OPC DA -> OPC DA Server.

* Check Act as an OPC DA Server.

Now configure the bridges

* Source tag1 to destination tag1, tag2, tag3

* Forward (source to destination)

* Apply

Now, any OPC DA client can connect to Cogent directly and see your tag1, tag2, and tag3 as if they were local PLC tags.


![bridge](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/bridge.png)

## Hub stats

![hub stats](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/hub_stats.png)


## Verify in Cogent

Event hub reads.

![cogent event](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/cogent_event.png)

Bridge to OPC DA

![cogent da](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/cogent_da.png)


## Verify in Matricon

### The event hub data and OPC Da data

Iter x.

![matricon_both](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/matricon_both.png)

Iter x + x.

![matricon_both2](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/matricon_both2.png)

Restart Cogent and verify reconnect to event hub after.

![restart](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/restart.png)

Data success

![after restart](https://github.com/spawnmarvel/quickguides/blob/main/cogent-eventhub/images/after_restart.png)


## Read the full partion with python

* Edit the policy to also have listen, not only send.

run script
```py
python .\read_all.py
Connecting directly to Partition 0 from the START of the window...
[2026-05-18T18:07:36.317979+00:00] Part: 0 | Tag: tag1 | Value: 42.95 | Quality: Good
[2026-05-18T18:07:36.318225+00:00] Part: 0 | Tag: tag2 | Value: 11.14 | Quality: Good
[2026-05-18T18:07:36.318334+00:00] Part: 0 | Tag: tag3 | Value: 1.71 | Quality: Good
[2026-05-18T18:07:41.353198+00:00] Part: 0 | Tag: tag1 | Value: 40.51 | Quality: Good
[2026-05-18T18:07:41.353494+00:00] Part: 0 | Tag: tag2 | Value: 17.64 | Quality: Good
[2026-05-18T18:07:41.353605+00:00] Part: 0 | Tag: tag3 | Value: 0.09 | Quality: Good
[2026-05-18T18:07:46.404679+00:00] Part: 0 | Tag: tag1 | Value: 48.31 | Quality: Good
[2026-05-18T18:07:46.404773+00:00] Part: 0 | Tag: tag2 | Value: 12.18 | Quality: Good
[2026-05-18T18:07:46.404802+00:00] Part: 0 | Tag: tag3 | Value: 2.13 | Quality: Good
[2026-05-18T18:07:51.437593+00:00] Part: 0 | Tag: tag1 | Value: 44.65 | Quality: Good
[2026-05-18T18:07:51.437865+00:00] Part: 0 | Tag: tag2 | Value: 17.63 | Quality: Good
[2026-05-18T18:07:51.437996+00:00] Part: 0 | Tag: tag3 | Value: 4.77 | Quality: Good
[2026-05-18T18:07:56.467679+00:00] Part: 0 | Tag: tag1 | Value: 44.21 | Quality: Good
[2026-05-18T18:07:56.467774+00:00] Part: 0 | Tag: tag2 | Value: 11.73 | Quality: Good
[2026-05-18T18:07:56.467804+00:00] Part: 0 | Tag: tag3 | Value: 0.81 | Quality: Good
[2026-05-18T18:08:01.499738+00:00] Part: 0 | Tag: tag1 | Value: 46.03 | Quality: Good
[2026-05-18T18:08:01.499999+00:00] Part: 0 | Tag: tag2 | Value: 18.97 | Quality: Good
[2026-05-18T18:08:01.500110+00:00] Part: 0 | Tag: tag3 | Value: 1.19 | Quality: Good
[2026-05-18T18:08:06.536081+00:00] Part: 0 | Tag: tag1 | Value: 48.78 | Quality: Good
[2026-05-18T18:08:06.536336+00:00] Part: 0 | Tag: tag2 | Value: 18.91 | Quality: Good
[2026-05-18T18:08:06.536447+00:00] Part: 0 | Tag: tag3 | Value: 3.32 | Quality: Good
```


