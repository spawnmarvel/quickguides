# AMQP to Azure Event Hub and Service Bus

## 1 AMQP to Azure Event Hub 

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

## 2 Service Bus with RabbitMQ


Here's a few scenarios in which we can make use of these capabilities:

* Edge Setups: We have an edge setup where we're sending messages to RabbitMQ, but we want to forward those messages to Azure Service Bus for further processing, so we can use many of the Azure Big Data capabilities.
* Hybrid Cloud: Your company just acquired a third party that uses RabbitMQ for their messaging needs. They are on a different cloud. While they transition to Azure you can already start sharing data by bridging RabbitMQ with  Azure Service Bus.
* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.


Version:
RabbitMQ 3.10.7, Erlang 25.0

Adding a new Azure Service Bus Namespace

* rabbitmq01
* basic
* public endpoint

Creating our Azure Service Bus Queue
* from-rabbitmq01

Enabling the RabbitMQ Shovel Plugin
* rabbitmq-plugins enable rabbitmq_shovel_management

The following plugins have been enabled:
* rabbitmq_shovel
* rabbitmq_shovel_management


Connecting RabbitMQ to Azure Service Bus
* Add SAS Policy, Manage
* rabbitmq-shovel01
* Primary Connection String

Connection String to AMQP
* https://red-mushroom-0f7446a0f.azurestaticapps.net/


https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq


## Advanced Message Queueing Protocol (AMQP) 1.0 support in Service Bus

Furthermore, connecting messaging brokers from different vendors is tricky. It typically requires application-level bridging to move messages from one system to another and to translate between their proprietary message formats. It's a common requirement; for example, when you must provide a new unified interface to older disparate systems, or integrate IT systems following a merger. AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview



## Extra

Troubleshoot connectivity issues - Azure Event Hubs

https://learn.microsoft.com/en-us/azure/event-hubs/troubleshooting-guide

Event Hubs Namespace

Firewall

Add IP ranges to allow access from the internet or your on-premises networks. 

https://github.com/rabbitmq/rabbitmq-amqp1.0

Add this content to the "rabbitmq.conf" file that you have created following the above instruction:

amqp1_0.default_user  = guest
amqp1_0.default_vhost = /
amqp1_0.protocol_strict_mode = false











