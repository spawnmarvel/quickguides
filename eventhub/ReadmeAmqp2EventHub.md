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

Queue:
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


## 1 Event consumers

