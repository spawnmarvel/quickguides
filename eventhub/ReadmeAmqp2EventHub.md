# AMQP to Azure Event Hub and Service Bus

## 1 AMQP to Azure Event Hub 

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

## 2 Service Bus with RabbitMQ


Here's a few scenarios in which we can make use of these capabilities:

* Edge Setups: We have an edge setup where we're sending messages to RabbitMQ, but we want to forward those messages to Azure Service Bus for further processing, so we can use many of the Azure Big Data capabilities.
* Hybrid Cloud: Your company just acquired a third party that uses RabbitMQ for their messaging needs. They are on a different cloud. While they transition to Azure you can already start sharing data by bridging RabbitMQ with  Azure Service Bus.
* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.

### Test Service Bus with RabbitMQ

Version:
RabbitMQ 3.10.7, Erlang 25.0

![Rmq version ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/rabbitmqversion.jpg)

Adding a new Azure Service Bus Namespace

* rabbitmq01
* basic
* public endpoint


Creating our Azure Service Bus Queue
* from-rabbitmq01

![Service bus queue ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/servicebusqueue.jpg)

Enabling the RabbitMQ Shovel Plugin
* rabbitmq-plugins enable rabbitmq_shovel_management

The following plugins have been enabled:
* rabbitmq_shovel
* rabbitmq_shovel_management

```log
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0> Server startup complete; 6 plugins started.
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0>  * rabbitmq_shovel_management
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0>  * rabbitmq_shovel
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0>  * rabbitmq_amqp1_0
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0>  * rabbitmq_management
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0>  * rabbitmq_web_dispatch
2023-07-08 18:49:58.048000+02:00 [info] <0.576.0>  * rabbitmq_management_agent

```

Created queue
* telemetry01

![Queue ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/queue.jpg)


Connecting RabbitMQ to Azure Service Bus
* Add SAS Policy, Manage now, tested with just send also.
* rabbitmq-shovel01
* Primary Connection String

Connection String to AMQP
* https://red-mushroom-0f7446a0f.azurestaticapps.net/

Shovel

![Shovel ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/shovel.jpg)

Shovel status

![Shovel status ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/shovel_status.jpg)


Service bus requests is success

![Servicebus requests 01 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/servicebusrequests01.jpg)


TNC
* Test-NetConnection -ComputerName rabbitmq01.servicebus.windows.net -Port 5671 = True
* Test-NetConnection -ComputerName rabbitmq01.servicebus.windows.net -Port 443 = True

Restart RabbitMQ:

```log

2023-07-08 19:08:56.406000+02:00 [info] <0.578.0> Server startup complete; 6 plugins started.
2023-07-08 19:08:56.406000+02:00 [info] <0.578.0>  * rabbitmq_shovel_management
2023-07-08 19:08:56.406000+02:00 [info] <0.578.0>  * rabbitmq_shovel
2023-07-08 19:08:56.406000+02:00 [info] <0.578.0>  * rabbitmq_amqp1_0
2023-07-08 19:08:56.406000+02:00 [info] <0.578.0>  * rabbitmq_management
2023-07-08 19:08:56.406000+02:00 [info] <0.578.0>  * rabbitmq_web_dispatch
2023-07-08 19:08:56.406000+02:00 [info] <0.578.0>  * rabbitmq_management_agent
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>     supervisor: {<0.742.0>,amqp10_client_connection_sup}
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>     errorContext: start_error
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>     reason: {badmatch,{error,closed}}
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>     offender: [{pid,undefined},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                {id,reader},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                {mfargs,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                    {amqp10_client_frame_reader,start_link,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                        [<0.742.0>,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                         #{address => "rabbitmq01.servicebus.windows.net",
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                           hostname => <<"rabbitmq01.servicebus.windows.net">>,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                           notify => <0.688.0>,notify_when_closed => <0.688.0>,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                           notify_when_opened => <0.688.0>,port => 5671,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                           sasl =>
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                               {plain,<<"rabbitmq-shovel01">>,
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                                   <<"TEXT-HERE-TEXT-HERE">>},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                           tls_opts => {secure_port,[]}}]}},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                {restart_type,transient},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                {significant,false},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                {shutdown,5000},
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0>                {child_type,worker}]
2023-07-08 19:09:56.385000+02:00 [error] <0.742.0> 
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> ** State machine <0.744.0> terminating
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> ** When server state  = {undefined,undefined}
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> ** Reason for termination = error:{badmatch,{error,closed}}
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> ** Callback modules = [amqp10_client_frame_reader]
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> ** Callback mode = undefined
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> ** Stacktrace =
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> **  [{amqp10_client_frame_reader,init,1,
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0>                                  [{file,"amqp10_client_frame_reader.erl"},
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0>                                   {line,109}]},
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0>      {gen_statem,init_it,6,[{file,"gen_statem.erl"},{line,1001}]},
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0>      {proc_lib,init_p_do_apply,3,[{file,"proc_lib.erl"},{line,240}]}]
2023-07-08 19:09:56.386000+02:00 [error] <0.744.0> 
2023-07-08 19:09:56.386000+02:00 [error] <0.688.0> Shovel 'rmq-2-sb' could not connect to destination
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>     supervisor: {<0.687.0>,rabbit_shovel_dyn_worker_sup}
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>     errorContext: child_terminated
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>     reason: shutdown
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>     offender: [{pid,<0.688.0>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                {id,{<<"/">>,<<"rmq-2-sb">>}},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                {mfargs,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                    {rabbit_shovel_worker,start_link,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                        [dynamic,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                         {<<"/">>,<<"rmq-2-sb">>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                         [{<<"dest-uri">>,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                           [{encrypted,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                                <<"TEXT-HERE-TEXT-HERE">>}]},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"src-uri">>,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                           [{encrypted,
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                                <<"TEXT-HERE-TEXT-HERE">>}]},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"ack-mode">>,<<"on-confirm">>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"dest-add-forward-headers">>,false},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"dest-address">>,<<"from-rabbitmq01">>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"dest-protocol">>,<<"amqp10">>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"reconnect-delay">>,30},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"src-delete-after">>,<<"never">>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"src-protocol">>,<<"amqp091">>},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                          {<<"src-queue">>,<<"telemetry01">>}]]}},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                {restart_type,{permanent,30}},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                {shutdown,4294967295},
2023-07-08 19:09:56.387000+02:00 [error] <0.687.0>                {child_type,worker}]
2023-07-08 19:09:56.452000+02:00 [warning] <0.818.0> Description: "Authenticity is not established by certificate path validation"
2023-07-08 19:09:56.452000+02:00 [warning] <0.818.0>      Reason: "Option {verify, verify_peer} and cacertfile/cacerts is missing"
2023-07-08 19:09:56.452000+02:00 [warning] <0.818.0> 



```

Rabbitmq.conf

```log
amqp1_0.default_user  = guest
amqp1_0.default_vhost = /
amqp1_0.protocol_strict_mode = false
```

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq


## Advanced Message Queueing Protocol (AMQP) 1.0 support in Service Bus

Furthermore, connecting messaging brokers from different vendors is tricky. It typically requires application-level bridging to move messages from one system to another and to translate between their proprietary message formats. It's a common requirement; for example, when you must provide a new unified interface to older disparate systems, or integrate IT systems following a merger. AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview


## TODO
* Same queue name in RabbitMQ and Service Bus = 
* Latest RabbitMQ and Erlang = 
* disable rabbitmq_amqp1_0 = 
* TLS version in ServiceBus and RabbitMQ = 
* Is the result from https://red-mushroom-0f7446a0f.azurestaticapps.net/ broken? = 


## Test 05

Namespace
* amqptest05.servicebus.windows.net

Queue
* from-amqp05
* Enable partitioning, default unchecked

Policy
* send-policy05

RabbitMQ
* Queue, from-amqp05

Primary connection string
* Get it from SAS

Url Encoding
* https://www.w3schools.com/tags/ref_urlencode.ASP#:~:text=URL%20Encoding%20(Percent%20Encoding)&text=URL%20encoding%20replaces%20unsafe%20ASCII,(%2B)%20sign%20or%20with%20%20
* SAS only had one special char now, +
* Verify it in Url Encoding
* + = %2B

Make shovel
* amqp 0.9.1
* rmq-test05
* from-amqp05
* amqp 1.0
* URI, converted SAS, from Connection String from above generator
* Address from-amqp05
* Recconnect delay, 20 s


![Servicebus requests 05 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/servicebusrequests05.jpg)

Test with TLS version in URI
* amqps://send-policy05:SAS-KEY@amqptest05.servicebus.windows.net:5671/?sasl=plain
* https://gist.github.com/kjnilsson/159c643fb34604f8ea20be336109261b
* amqps://send-policy05:SAS-KEY@amqptest05.servicebus.windows.net:5671=versions=tlsv1.0,tlsv1.1,tlsv1.2
* * Validation failed, malformed_uri
* amqps://send-policy05:SAS-KEY@amqptest05.servicebus.windows.net:5671=versions=tlsv1.2
* * Validation failed, malformed_uri
* amqps://send-policy05:SAS-KEY@amqptest05.servicebus.windows.net:5671/?sasl=plain&=versions=tlsv1.2

This URI can now be used to configure the shovel URI together with the queue name as either the source or destination assuming the SB queue is not configured to use sessions or partitions.

```log
2023-07-09 11:32:40.033000+02:00 [error] <0.3174.0>     supervisor: {<0.3174.0>,amqp10_client_connection_sup}
2023-07-09 11:32:40.033000+02:00 [error] <0.3174.0>     errorContext: start_error
2023-07-09 11:32:40.033000+02:00 [error] <0.3174.0>     reason: {badmatch,{error,closed}}

```

Simple shovel:

![Simple shovel ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/simpleshovel.jpg)

Forward messages is true, all that is published to queue01 goes to queue01a.

![Queue 01 ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/queue01.jpg)


## Test 06



amqp1_0.default_user  = guest
amqp1_0.default_vhost = /
amqp1_0.protocol_strict_mode = false

https://github.com/rabbitmq/rabbitmq-amqp1.0

Configure connection string to use AMQP 1.0
Append your connection string with ;TransportType=Amqp to instruct the client to make its connection to Service Bus using AMQP 1.0. For example,

Endpoint=sb://[namespace].servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=[SAS key];TransportType=Amqp

Where namespace and SAS key are obtained from the Azure portal when you create a Service Bus namespace. 

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-dotnet


Namespace
* rmqsb456
* Tls 1.2
* Public

Queue
* from-amqp06

RabbitMQ queue
* from-amqp06

Policy
* policy-06

Primary Connection String
* convert

same even when added &transporttype=amqp

## Extra

Troubleshoot connectivity issues - Azure Event Hubs

https://learn.microsoft.com/en-us/azure/event-hubs/troubleshooting-guide

Event Hubs Namespace

Firewall

Add IP ranges to allow access from the internet or your on-premises networks. 


Azure ServiceBus can be used with the AMQP 1.0 protocol. Since version 3.7 RabbitMQ supports shovels where either the source or destination (or both) uses AMQP 1.0. Hence it is possible to connect the two systems together using shovels. In this brief tutorial we are going to shovel a message from a RabbitMQ queue to a queue in Azure ServiceBus (SB).

Sessions, To use sessions the group-id property needs to be set apropriately. E.g:

```log
{destination,
   [{protocol, amqp10},
    {uris, ["amqps://TheUser:Some%2FString=@shoveltest.servicebus.windows.net:5671?versions=tlsv1.0,tlsv1.1,tlsv1.2"]},
    {target_address, <<"aqueue1">>}
    {properties, [{group_id, <<"some-group">>}]},
```
Partitions, To use a partition the x-opt-partition-key property needs to be set apropriately. E.g:

```log
{destination,
   [{protocol, amqp10},
    {uris, ["amqps://TheUser:Some%2FString=@shoveltest.servicebus.windows.net:5671?versions=tlsv1.0,tlsv1.1,tlsv1.2"]},
    {target_address, <<"aqueue1">>}
    {message_annotations, [{"x-opt-partition-key", 12345}]},  
```
https://gist.github.com/kjnilsson/159c643fb34604f8ea20be336109261b


RabbitMQ server

https://github.com/rabbitmq/rabbitmq-amqp1.0

Add this content to the "rabbitmq.conf" file that you have created following the above instruction:

amqp1_0.default_user  = guest
amqp1_0.default_vhost = /
amqp1_0.protocol_strict_mode = false

Moved to https://github.com/rabbitmq/rabbitmq-server and AMQP 1.0 is supported.


### Test 7 Event hub

Install RMQ and Erlang:
* otp_win64_26.0.exe
* Set ERLANG_HOME
* Set RABBITMQ environment vars
* rabbitmq-server-3.12.1.exe
* rabbitmq-plugins enable rabbitmq_management
* rabbitmq-plugins enable rabbitmq_shovel_management
* RabbitMQ 3.12.1,Erlang 26.0
* advance.config = [].
* rabbitmq.conf = simple

Quickstart: Create an event hub using Azure CLI

```bash
# Create a resource group
rgName="Rg-ampq-eh-089"
region="uksouth"
az group create --name $rgName --location $region

"properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {
    "Hello": "World"
# Create an Event Hubs namespace
namespaceName="ns-rmq-2-eh"
az eventhubs namespace create --name $namespaceName --resource-group $rgName -l $region

 "provisioningState": "Succeeded",
  "publicNetworkAccess": "Enabled",
  "resourceGroup": "Rg-ampq-eh-089",
  "serviceBusEndpoint": "https://ns-rmq-2-eh.servicebus.windows.net:443/",
  "sku": {
    "capacity": 1,
    "name": "Standard",
    "tier": "Standard"

# Endpoint is https:443

# Create an event hub
eventhubName="ehn-from-rmq"
az eventhubs eventhub create --name $eventhubName --resource-group $rgName --namespace-name $namespaceName

 "location": "uksouth",
  "messageRetentionInDays": 7,
  "name": "ehn-from-rmq",
  "partitionCount": 4,
  "partitionIds": [
    "0",
    "1",
    "2",
    "3"
  ],
  "resourceGroup": "Rg-ampq-eh-089",
  "retentionDescription": {
    "cleanupPolicy": "Delete",
    "retentionTimeInHours": 168
  },
  "status": "Active",


```
Create policy for send
* policy-02
* Copy Connection string-primary key
* Convert it, https://red-mushroom-0f7446a0f.azurestaticapps.net/

RabbitMQ
* Queue ehn-from-rmq

Shovel
* shovel-07
* Source queue
* * ehn-from-rmq
* Destination AMQP 1.0
* uri
* address
* Reconnect delay 45 s

```log
2023-07-11 10:01:57.638000+02:00 [error] <0.2006.0>     supervisor: {<0.2006.0>,amqp10_client_connection_sup}
2023-07-11 10:01:57.638000+02:00 [error] <0.2006.0>     errorContext: start_error
2023-07-11 10:01:57.638000+02:00 [error] <0.2006.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
[...]
2023-07-11 10:09:27.788000+02:00 [error] <0.2476.0> Shovel 'shovel-07' could not connect to destination


```

### Test 8 Service bus

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq

Adding a new Azure Service Bus Namespace
* Rg-amqp-sb-007
* Service bus
* Use rabbitmq07 for Namespace name
* TLS 1.2, default
* Connectivity, Public access, default

Creating our Azure Service Bus Queue
* from-rabbitmq01

Enabling the RabbitMQ Shovel Plugin
* Done

Connecting RabbitMQ to Azure Service Bus
* from-rabbitmq01 (rabbitmq07/from-rabbitmq01) | Shared access policies
* policy-07, send

Convert string
* Primary Connection String
* https://red-mushroom-0f7446a0f.azurestaticapps.net/

RabbitMQ
* Created queue, with same name as Azure Service Bus Queue
* from-rabbitmq01
* /, from-rabbitmq01, classic, features D

Now open the RabbitMQ management plugin in our browsers
* Name shovel_07
* Source AMQP 0.9.1
* URI, default
* Queue, from-rabbitmq01
* Destination, AMQP 1.0
* URI Primary Connection String from above generator
* Address, from-rabbitmq01
* Reconnect delay, 30s
* Add shovel

Shovel status is starting, never goes to running

Log from RabbitMQ:

```log
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>     supervisor: {<0.3627.0>,amqp10_client_connection_sup}
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>     errorContext: start_error
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>     offender: [{pid,undefined},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                {id,reader},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                {mfargs,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                    {amqp10_client_frame_reader,start_link,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                        [<0.3627.0>,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                         #{notify => <0.3610.0>,port => 5671,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                           address => "rabbitmq07.servicebus.windows.net",
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                           sasl =>
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                               {plain,<<"policy-07">>,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                                   <<"TOKEN WAS HERE">>},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                           hostname => <<"rabbitmq07.servicebus.windows.net">>,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                           notify_when_opened => <0.3610.0>,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                           notify_when_closed => <0.3610.0>,
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                           tls_opts => {secure_port,[]}}]}},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                {restart_type,transient},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                {significant,false},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                {shutdown,5000},
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0>                {child_type,worker}]
2023-07-11 10:44:41.042000+02:00 [error] <0.3627.0> 
2023-07-11 10:44:41.043000+02:00 [error] <0.3610.0> Shovel 'shovel_01' could not connect to destination
```

[...]

Test same but set sasl=plain, to sasl=true
```log
2023-07-11 11:03:39.526000+02:00 [error] <0.8648.0>     supervisor: {<0.8648.0>,amqp10_client_connection_sup}
2023-07-11 11:03:39.526000+02:00 [error] <0.8648.0>     errorContext: start_error
2023-07-11 11:03:39.526000+02:00 [error] <0.8648.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
[...]
2023-07-11 11:03:39.526000+02:00 [error] <0.8629.0> Shovel 'shovel_02' could not connect to destination

```

### Test 9 service bus with
Using same as above, but now set source to AMQP 1.0, same as destination.
* shovel_03
* Source AMQP 1.0
* Address from-rabbitmq01
* URI Primary Connection String from above generator
* Address, from-rabbitmq01
* Reconnect delay, 30s
* Add shovel

Shovel status is starting, never goes to running

Log from RabbitMQ:
```log
2023-07-11 11:08:18.155000+02:00 [info] <0.8999.0> accepting AMQP connection <0.8999.0> (127.0.0.1:59170 -> 127.0.0.1:5672)
2023-07-11 11:08:18.155000+02:00 [error] <0.8999.0> closing AMQP connection <0.8999.0> (127.0.0.1:59170 -> 127.0.0.1:5672):
2023-07-11 11:08:18.155000+02:00 [error] <0.8999.0> amqp1_0_plugin_not_enabled
2023-07-11 11:08:18.155000+02:00 [warning] <0.8994.0> Unsupported protocol version: 0 0.9.1
2023-07-11 11:08:18.155000+02:00 [warning] <0.8995.0> AMQP 1.0 connection socket was closed, connection state: 'expecting_frame_header'
2023-07-11 11:08:18.156000+02:00 [error] <0.8992.0> Shovel 'shovel_03' could not connect to source

```
Enable AMQP 1.0
PS C:\Program Files\RabbitMQ Server\rabbitmq_server-3.12.1\sbin>
.\rabbitmq-plugins list
.\rabbitmq-plugins enable rabbitmq_amqp1_0
The following plugins have been configured:
  rabbitmq_amqp1_0
  rabbitmq_management
  rabbitmq_management_agent
  rabbitmq_shovel
  rabbitmq_shovel_management
  rabbitmq_web_dispatch


```log
2023-07-11 11:14:58.438000+02:00 [error] <0.9613.0>     supervisor: {<0.9613.0>,amqp10_client_connection_sup}
2023-07-11 11:14:58.438000+02:00 [error] <0.9613.0>     errorContext: start_error
2023-07-11 11:14:58.438000+02:00 [error] <0.9613.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
[...]
2023-07-11 11:14:58.438000+02:00 [error] <0.9582.0> Shovel 'shovel_03' could not connect to destination

```

TODO

Read this
https://github.com/rabbitmq/rabbitmq-server/tree/main/deps/rabbitmq_amqp1_0
Enable TLS
Test again.

## Troubleshoot

Reason for termination = error:{badmatch,{error,closed}}

badmatch
5> [X,Y] = {4,5}.
** exception error: no match of right hand side value {4,5}
Badmatch errors happen whenever pattern matching fails. This most likely means you're trying to do impossible pattern matches (such as above), trying to bind a variable for the second time, or just anything that isn't equal on both sides of the = operator (which is pretty much what makes rebinding a variable fail!). Note that this error sometimes happens because the programmer believes that a variable of the form _MyVar is the same as _. Variables with an underscore are normal variables, except the compiler won't complain if they're not used. It is not possible to bind them more than once.

https://learnyousomeerlang.com/errors-and-exceptions

{badmatch,V}, Evaluation of a match expression failed. The value V did not match.

https://www.erlang.org/doc/reference_manual/errors.html


Azure Service Bus AMQP Exception
* Yes, you can use SAS with AMQP. Policy name instead of username, and URL encoded key instead password. 
* The URL encoding is required to handle any non-alphanumeric characters in key value as +, /, or =.


The URL format is:

```log
amqps://<policyname>:<urlencoded(key)>@<namespace>.servicebus.windows.net
```

Make sure your queue does not have partitioning enabled. ServiceBus does not support AMQP with partitioned queues, however queues are created with partitioning enabled by default.

I had this exact same error, and re-creating the queue with "Enable Partitioning" unchecked solved it for me.


https://stackoverflow.com/questions/27692070/azure-service-bus-amqp-exception/28056479#28056479













