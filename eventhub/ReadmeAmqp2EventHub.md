# AMQP to Azure Event Hub 

Following this:

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

Great tutorial, thanks Microsoft and Alvaro Videla Godoy. (Published Mar 29 2023 03:08 AM )

## 1 AMQP to Azure Event Hub 

Version, RabbitMQ 3.10.7, Erlang 25.0

```log
2023-07-08 15:11:26.125000+02:00 [info] <0.219.0>  Starting RabbitMQ 3.10.7 on Erlang 25.0 [jit]
[...]
2023-07-08 15:11:27.703000+02:00 [info] <0.694.0> started TCP listener on [::]:5672
2023-07-08 15:11:27.704000+02:00 [info] <0.712.0> started TCP listener on 0.0.0.0:5672
2023-07-08 15:11:27.803000+02:00 [info] <0.567.0> Server startup complete; 5 plugins started.
2023-07-08 15:11:27.803000+02:00 [info] <0.567.0>  * rabbitmq_shovel_management
2023-07-08 15:11:27.803000+02:00 [info] <0.567.0>  * rabbitmq_shovel
2023-07-08 15:11:27.803000+02:00 [info] <0.567.0>  * rabbitmq_management
2023-07-08 15:11:27.803000+02:00 [info] <0.567.0>  * rabbitmq_web_dispatch
2023-07-08 15:11:27.803000+02:00 [info] <0.567.0>  * rabbitmq_management_agent
```

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

### Create an Event Hubs namespace: amqps2azure

![Event Hub ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/eventhubnamespace.jpg)

### Create an event hub: event-amqps-telemetry01

![Event Hub ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/eventhub.jpg)


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


### Create a Shared Access Signature for Event Hubs

A shared access signature (SAS) provides secure delegated access to resources.

Go to the event hub, event-amqps-telemetry01 , and in the left panel click on Shared Access Policies.

![SAS ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/sas.jpg)

### Connecting RabbitMQ to Event Hubs

Once the SAS key has been created, select it, and copy to the clipboard the one called Connection string-primary key.


```cmd
# Connection string 
Endpoint=sb://<your-namespace.servicebus.windows.net/;SharedAccessKeyName=send-event-amqps;SharedAccessKey=<SharedAccessKey>=;EntityPath=event-amqps-telemetry01

# RabbitMQ shovel format
amqps://send-event-amqps:<SharedAccessKey>@<your-namespace>.servicebus.windows.net:5671/?sasl=plain
```

We must convert it, there is a tool for it, https://red-mushroom-0f7446a0f.azurestaticapps.net/, but it seems like the signs that must be changed is in the SAS: / to % for RabbitMQ.

hmmmmmm...

![Shovel error ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/shovel_error.jpg)



Troubleshoot connectivity issues - Azure Event Hubs

https://learn.microsoft.com/en-us/azure/event-hubs/troubleshooting-guide

Event Hubs Namespace

Firewall

Add IP ranges to allow access from the internet or your on-premises networks. 

![Requests ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/requests.jpg)


rabbitmq-plugins enable rabbitmq_amqp1_0

2023-07-08 17:40:47.236000+02:00 [info] <0.572.0> Server startup complete; 6 plugins started.
2023-07-08 17:40:47.236000+02:00 [info] <0.572.0>  * rabbitmq_shovel_management
2023-07-08 17:40:47.236000+02:00 [info] <0.572.0>  * rabbitmq_shovel
2023-07-08 17:40:47.236000+02:00 [info] <0.572.0>  * rabbitmq_amqp1_0
2023-07-08 17:40:47.236000+02:00 [info] <0.572.0>  * rabbitmq_management
2023-07-08 17:40:47.236000+02:00 [info] <0.572.0>  * rabbitmq_web_dispatch
2023-07-08 17:40:47.236000+02:00 [info] <0.572.0>  * rabbitmq_management_agent


https://github.com/rabbitmq/rabbitmq-amqp1.0

Add this content to the "rabbitmq.conf" file that you have created following the above instruction:

amqp1_0.default_user  = guest
amqp1_0.default_vhost = /
amqp1_0.protocol_strict_mode = false


Furthermore, connecting messaging brokers from different vendors is tricky. It typically requires application-level bridging to move messages from one system to another and to translate between their proprietary message formats. It's a common requirement; for example, when you must provide a new unified interface to older disparate systems, or integrate IT systems following a merger. AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview


## How to integrate Service Bus with RabbitMQ


Here's a few scenarios in which we can make use of these capabilities:

* Edge Setups: We have an edge setup where we're sending messages to RabbitMQ, but we want to forward those messages to Azure Service Bus for further processing, so we can use many of the Azure Big Data capabilities.
* Hybrid Cloud: Your company just acquired a third party that uses RabbitMQ for their messaging needs. They are on a different cloud. While they transition to Azure you can already start sharing data by bridging RabbitMQ with  Azure Service Bus.
* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.


https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq


TODO

Update RabbitMQ and Erlang to same version or latest.


## 1 Event consumers

