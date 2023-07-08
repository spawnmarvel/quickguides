# AMQP to Azure Event Hub 

Following this:

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

Great tutorial, thanks Microsoft and Alvaro Videla Godoy.

## 1 AMQP to Azure Event Hub 

Version, RabbitMQ 3.10.7, Erlang 25.0

```log
2023-07-08 15:11:26.125000+02:00 [info] <0.219.0>  Starting RabbitMQ 3.10.7 on Erlang 25.0 [jit]
[...]
2023-07-08 15:11:27.703000+02:00 [info] <0.694.0> started TCP listener on [::]:5672
2023-07-08 15:11:27.704000+02:00 [info] <0.712.0> started TCP listener on 0.0.0.0:5672
2023-07-08 15:11:27.705000+02:00 [info] <0.732.0> started TLS (SSL) listener on [::]:5671
2023-07-08 15:11:27.706000+02:00 [info] <0.752.0> started TLS (SSL) listener on 0.0.0.0:5671
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

We must convert it, there is a tool for it, https://red-mushroom-0f7446a0f.azurestaticapps.net/, but it seems like the signs that must be changed is in the SAS for, / to % for RabbitMQ.





## 1 Event consumers

