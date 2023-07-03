# AMQP, Event Grid, Event Hubs and Service Bus

## Choose between Azure messaging services - Event Grid, Event Hubs, and Service Bus

Azure offers three services that assist with delivering events or messages throughout a solution. These services are:

* Azure Event Grid
* Azure Event Hubs
* Azure Service Bus

| Service   | Purpose | Type | When to use
| ---------- | ------- | ---- | -----------
| Event Grid | Reactive programming | Event distribution(discrete) | React to status changes
| Event Hubs | Big data pipeline | Event streaming (series) | Telemetry and distributed data streaming
| Service Bus | High-value entrerprise messaging | Messages | Order processing and finacial transactions

https://learn.microsoft.com/en-us/azure/service-bus-messaging/compare-messaging-services


## Azure Event Hubs *

![MS Learn ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/mslearn.jpg)

https://learn.microsoft.com/en-us/training/browse/?filter-products=event&products=azure-event-hubs


## Introduction to Event Hubs

* Azure Event Hubs connects events from any source to your software systems. This acts as a buffer to provide modular solutions that avoid overwhelming your system during traffic spikes, while still enabling near real-time data pipelines. 
* Event Hubs is fast to set up and designed to allow you to focus on drawing insights from data instead of managing infrastructure.
* Able to process millions of events per second with low latency.
* Event Hubs is a modern big data message and event ingestion service that can be seamlessly integrated with other Azure and Microsoft services, such as Stream Analytics, Power BI, and Event Grids, along with outside services like Apache Spark.

https://learn.microsoft.com/en-us/training/modules/intro-to-event-hubs/

How to integrate Service Bus with RabbitMQ

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq


Network security for Azure Service Bus

https://learn.microsoft.com/en-us/azure/service-bus-messaging/network-security


Exchange events between consumers and producers that use different protocols: AMQP, Kafka, and HTTPS

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-exchange-events-different-protocols


Azure Event Hubs—A big data streaming platform and event ingestion service

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-about


Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688



Service Bus pricing

https://azure.microsoft.com/en-us/pricing/details/service-bus/