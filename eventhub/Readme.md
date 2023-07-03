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


## Introduction to Event Hubs (is a fully managed platform-as-a-service)

* Azure Event Hubs connects events from any source to your software systems. This acts as a buffer to provide modular solutions that avoid overwhelming your system during traffic spikes, while still enabling near real-time data pipelines. 
* Event Hubs is fast to set up and designed to allow you to focus on drawing insights from data instead of managing infrastructure.
* Able to process millions of events per second with low latency.
* Event Hubs is a modern big data message and event ingestion service that can be seamlessly integrated with other Azure and Microsoft services, such as Stream Analytics, Power BI, and Event Grids, along with outside services like Apache Spark.

Introduction

* You can think of Event Hubs as an event ingestor and a front door for event pipelines. 

As an example use-case scenario, consider a home security company that monitors 100,000 homes. Each home has various sensors – such as a motion-detectors, door/window open sensors, and glass break detectors. These devices report back to a common server. 

What is Event Hubs

* Event Hubs is one of three types of message broker available on Azure.
* Message brokers logically and temporally decouple event producers from event consumers. Decoupling creates an event pipeline that is more modular. So that it scales more easily.

Temporal Decoupling

* The temporal decoupling provided by message brokers means that the event producer and event consumers don’t need to run concurrently. 
* Temporal decoupling can provide a stronger guarantee that messages are received and it means that producers aren't blocked while consumers are processing data.
* Load Balancing and Load Leveling, multiple concurrent consumers, potentially making it simpler to achieve load balancing.

Event Hubs is a versatile service

* Event Hubs is compatible with a wide variety of languages and tools. Data can be read and processed using languages such as Python and Go, and it’s compatible with common protocols.

When is Event Hubs a suitable solution?

* Ingesting high volumes of messages quickly and reliably
* Suitable for receiving data from thousands, or more, event publishers simultaneously and ensuring the data is stored in a non-volatile state.
* It supports connection mechanisms like Advanced Message Queuing Protocol (AMQP) and WebSockets to support low-bandwidth and low-latency message delivery
* There are scenarios where other message brokers are more suitable than Event Hubs. Event Hubs can enable near real-time responses to messages. However, due to its asynchronous nature, Event Hubs isn't always the best choice if the event creators are critically dependent on specific actions taking place in a specific window of time.
* Event Hubs is also not the best choice when delivery of all information is absolutely business critical. Event Hubs can guarantee at least once delivery to its singular Capture consumer. But, if your application has multiple groups that consume the same messages. Then your client application is responsible for connecting to and consuming the events while they're still in the cache. The cache lifetime is configurable, and defaults to 24 hours, but if some downtime prevents your consumer applications from running, you may miss those events.


### If Event Hubs isn't the perfect fit for your problem, Azure provides other messaging services. Including:








https://learn.microsoft.com/en-us/training/modules/intro-to-event-hubs/


Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688


Event Hub Consumer Telegraf Plugin InfluxDB

https://www.influxdata.com/integration/event-hub-consumer/

Install Telegraf

https://docs.influxdata.com/telegraf/v1.21/introduction/installation/



How to integrate Service Bus with RabbitMQ

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq


Network security for Azure Service Bus

https://learn.microsoft.com/en-us/azure/service-bus-messaging/network-security


Exchange events between consumers and producers that use different protocols: AMQP, Kafka, and HTTPS

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-exchange-events-different-protocols


Azure Event Hubs—A big data streaming platform and event ingestion service

https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-about



Service Bus pricing

https://azure.microsoft.com/en-us/pricing/details/service-bus/