# Advanced Message Queueing Protocol (AMQP) 1.0 support in Service Bus

AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview

# AMQP to Azure Event Hub and Service Bus

## 1 AMQP to Azure Event Hub 

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

## 2 Service Bus with RabbitMQ


Here's a few scenarios in which we can make use of these capabilities:

* Edge Setups: We have an edge setup where we're sending messages to RabbitMQ, but we want to forward those messages to Azure Service Bus for further processing, so we can use many of the Azure Big Data capabilities.
* Hybrid Cloud: Your company just acquired a third party that uses RabbitMQ for their messaging needs. They are on a different cloud. While they transition to Azure you can already start sharing data by bridging RabbitMQ with  Azure Service Bus.
* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq

## SO

https://stackoverflow.com/questions/76652187/rabbitmq-shovel-to-azure-event-hub-or-service-bus

## Test repos verified result

https://github.com/spawnmarvel/test/blob/main/it_works.jpg

### Test Azure Service Bus or Azure Event hub with RabbitMQ

Note, it does not matter if you use Azure Service Bus or Azure Event hub, bot uses the same foundation for connectivity in both tutorials.



