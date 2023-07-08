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
* Latest RabbitMQ and Erlang
* disable rabbitmq_amqp1_0
* TLS version in ServiceBus and RabbitMQ
* Is the result from https://red-mushroom-0f7446a0f.azurestaticapps.net/ broken?


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


badmatch
5> [X,Y] = {4,5}.
** exception error: no match of right hand side value {4,5}
Badmatch errors happen whenever pattern matching fails. This most likely means you're trying to do impossible pattern matches (such as above), trying to bind a variable for the second time, or just anything that isn't equal on both sides of the = operator (which is pretty much what makes rebinding a variable fail!). Note that this error sometimes happens because the programmer believes that a variable of the form _MyVar is the same as _. Variables with an underscore are normal variables, except the compiler won't complain if they're not used. It is not possible to bind them more than once.

https://learnyousomeerlang.com/errors-and-exceptions


{badmatch,V}, Evaluation of a match expression failed. The value V did not match.


https://www.erlang.org/doc/reference_manual/errors.html














