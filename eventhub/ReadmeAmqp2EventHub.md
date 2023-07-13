# AMQP to Azure Event Hub and Service Bus

## 1 AMQP to Azure Event Hub 

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

## 2 Service Bus with RabbitMQ


Here's a few scenarios in which we can make use of these capabilities:

* Edge Setups: We have an edge setup where we're sending messages to RabbitMQ, but we want to forward those messages to Azure Service Bus for further processing, so we can use many of the Azure Big Data capabilities.
* Hybrid Cloud: Your company just acquired a third party that uses RabbitMQ for their messaging needs. They are on a different cloud. While they transition to Azure you can already start sharing data by bridging RabbitMQ with  Azure Service Bus.
* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.


## SO

https://stackoverflow.com/questions/76652187/rabbitmq-shovel-to-azure-event-hub-or-service-bus

## Test repos with pdf steps

https://github.com/spawnmarvel/test


### Test Service Bus with RabbitMQ

Version:
RabbitMQ 3.10.7, Erlang 25.0

```log
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

## Test 05

```log
2023-07-09 11:32:40.033000+02:00 [error] <0.3174.0>     supervisor: {<0.3174.0>,amqp10_client_connection_sup}
2023-07-09 11:32:40.033000+02:00 [error] <0.3174.0>     errorContext: start_error
2023-07-09 11:32:40.033000+02:00 [error] <0.3174.0>     reason: {badmatch,{error,closed}}

```
### Test 7 Event hub

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

Update New RabbitMQ 3.12.1 and Erlang 26.0

```log
2023-07-11 10:01:57.638000+02:00 [error] <0.2006.0>     supervisor: {<0.2006.0>,amqp10_client_connection_sup}
2023-07-11 10:01:57.638000+02:00 [error] <0.2006.0>     errorContext: start_error
2023-07-11 10:01:57.638000+02:00 [error] <0.2006.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
[...]
2023-07-11 10:09:27.788000+02:00 [error] <0.2476.0> Shovel 'shovel-07' could not connect to destination

```

### Test 8 Service bus

Update New RabbitMQ 3.12.1 and Erlang 26.0

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq

```log
2023-07-11 11:03:39.526000+02:00 [error] <0.8648.0>     supervisor: {<0.8648.0>,amqp10_client_connection_sup}
2023-07-11 11:03:39.526000+02:00 [error] <0.8648.0>     errorContext: start_error
2023-07-11 11:03:39.526000+02:00 [error] <0.8648.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
[...]
2023-07-11 11:03:39.526000+02:00 [error] <0.8629.0> Shovel 'shovel_02' could not connect to destination

```

### Test 9 service bus with

```log
2023-07-11 11:14:58.438000+02:00 [error] <0.9613.0>     supervisor: {<0.9613.0>,amqp10_client_connection_sup}
2023-07-11 11:14:58.438000+02:00 [error] <0.9613.0>     errorContext: start_error
2023-07-11 11:14:58.438000+02:00 [error] <0.9613.0>     reason: {options,incompatible,[{verify,verify_peer},{cacerts,undefined}]}
[...]
2023-07-11 11:14:58.438000+02:00 [error] <0.9582.0> Shovel 'shovel_03' could not connect to destination
```

## TODO

Understand this
AMQP 1.0 support for RabbitMQ

https://github.com/rabbitmq/rabbitmq-server/tree/main/deps/rabbitmq_amqp1_0

Understand this

Azure ServiceBus can be used with the AMQP 1.0 protocol. Since version 3.7 RabbitMQ supports shovels where either the source or destination (or both) uses AMQP 1.0.

https://gist.github.com/kjnilsson/159c643fb34604f8ea20be336109261b

It shall work
* https://gist.github.com/kjnilsson/159c643fb34604f8ea20be336109261b
* That was terrific - I was able to get it working using a dynamic shovel definition. Many

https://groups.google.com/g/rabbitmq-users/c/MLL70ibzoOE/m/hW2-s1ZFAgAJ

It shall work 2
* It turns out that I had the connection string incorrect, AMQP essentially uses the same connection string as NetMessaging with the exception of the runtime port and the TransportType.
* https://stackoverflow.com/questions/27986958/using-aqmp-with-on-prem-windows-service-bus?rq=1

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













