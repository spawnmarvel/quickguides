# AMQP to Azure Event Hub 

## Following this: Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

## 1 AMQP to Azure Event Hub 

Version, RabbitMQ 3.10.7, Erlang 25.0

Topology

![Topology ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/topology.jpg)

Case:
* Imagine you have sensor data that’s being sent to RabbitMQ from various IoT devices. These devices capture temperature and humidity readings. 
* Getting the data out of RabbitMQ and into Azure. Using Azure Event Hubs, you can bridge RabbitMQ.

Queue example:
* telemetry01

Example json:

```json
{
    "Timestamp": <Timestamp>, 
    "Temperature": <Temperature>, 
    "Humidity": <Humidity>
}

```
Send data using shovel plugin,  AMQP 1.0 protocol supported both by RabbitMQ and Event Hubs.

Create an event hub:
* Create a resource group
* Create Event Hubs namespace
* Create event hub

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-create


Scaling with Event Hubs

There are two factors which influence scaling with Event Hubs.
* Throughput units (standard tier) or processing units (premium tier)
* Partitions

The throughput capacity of Event Hubs is controlled by throughput units. Throughput units are pre-purchased units of capacity. A single throughput unit lets you:
* Ingress: Up to 1 MB per second or 1000 events per second (whichever comes first).
* Egress: Up to 2 MB per second or 4096 events per second.


Partitions
* Event Hubs organizes sequences of events sent to an event hub into one or more partitions. As newer events arrive, they're added to the end of this sequence.

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-scalability


## 1 Event consumers

