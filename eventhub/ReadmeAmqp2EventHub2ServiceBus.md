# Advanced Message Queueing Protocol (AMQP) 1.0 support in Service Bus

AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview

# AMQP to Azure Event Hub or Service Bus

## Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

https://techcommunity.microsoft.com/t5/azure-data-explorer-blog/importing-data-from-rabbitmq-into-azure-data-explorer-via-event/ba-p/3777688

## 2 How to integrate Service Bus with RabbitMQ

Here's a few scenarios in which we can make use of these capabilities:

* Edge Setups: We have an edge setup where we're sending messages to RabbitMQ, but we want to forward those messages to Azure Service Bus for further processing, so we can use many of the Azure Big Data capabilities.
* Hybrid Cloud: Your company just acquired a third party that uses RabbitMQ for their messaging needs. They are on a different cloud. While they transition to Azure you can already start sharing data by bridging RabbitMQ with  Azure Service Bus.
* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-integrate-with-rabbitmq

## SO

https://stackoverflow.com/questions/76652187/rabbitmq-shovel-to-azure-event-hub-or-service-bus

## Test repos verified result

Shovel status running and messages transported to Azure Service Bus

https://github.com/spawnmarvel/test/blob/main/it_works.jpg

### Test Azure Service Bus or Azure Event hub with RabbitMQ

Note, it does not matter if you use Azure Service Bus or Azure Event hub, bot uses the same foundation for connectivity in both tutorials and they start the same way.

Ok lets do this for Azure Service Bus, date 15.07.2023.

## Steps

Version RabbitMQ 3.12.1, Erlang 26.0

ASB Namespace

![Namespace ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/namespace.jpg)

Add a new root policy SAS with send access (important step!, not in the tutorials)

![Root policy ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/root.jpg)

Add a new entitie
* Leave default properties, or alter them.
* Enable partitioning, uncheck
* Enable dead lettering on message expiration, uncheck

![Queue ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/queue.jpg)

Add a new policy SAS on the queue with send access (same as in both tutorials)

![Sub policy ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/subroot.jpg)

RabbitMQ queue

![Queue amqp ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/queueamqp.jpg)

Go back to policy on entitie queue, click on it to see the Primary Connection String. We're going to use it to let RabbitMQ talk to Azure Service Bus

"Before you can use that connection string, you'll need to convert it to RabbitMQ's AMQP connection format. So go to the connection string converter tool and paste your connection string in the form, click convert. You'll get a connection string that's RabbitMQ ready."

https://red-mushroom-0f7446a0f.azurestaticapps.net/

"Your connection string looks something like this:"

```log
Endpoint=sb://<your-namespace>.servicebus.windows.net/;SharedAccessKeyName=eh-rmq-bridge;SharedAccessKey=<SharedAccessKey>;EntityPath=event-hubs-kusto-eh
```
"But RabbitMQ Shovel expects a connection string in the AMQP protocol format:"

```log
amqps://eh-rmq-bridge:<SharedAccessKey>@<your-namespace>.servicebus.windows.net:5671/?sasl=plain
```

Result when you make the shovel as in the tutorials:
```log
{error,{options,incompatible,
                [{verify,verify_peer},{cacerts,undefined}]}}
```
The above will not work due to, it has been many updates to RabbitMQ and Erlang.

https://www.erlang.org/blog/otp-26-highlights/

[...] "Erlang/OTP 26 Highlights May 16, 2023 [...] Erlang/OTP 26 Highlights In OTP 26, the default value for the verify option is now verify_peer instead of verify_none. Host verification requires trusted CA certificates to be supplied using one of the options cacerts or cacertsfile. Therefore, a connection attempt with an empty option list will fail in OTP 26"

[...] "The default value for the cacerts option is undefined, which is not compatible with the {verify,verify_peer} option. To make the connection succeed, the recommended way is to use the cacerts option to supply CA certificates to be used for verifying."

So....with that in mind and RabbitMQ URI Query Parameters https://www.rabbitmq.com/uri-query-parameters.html we need to change:

First download MS certificate, we need it in the shovel to trust Azure Service Bus:

https://learn.microsoft.com/en-us/azure/security/fundamentals/azure-ca-details?tabs=root-and-subordinate-cas-list

DigiCert Global Root CA, DigiCertGlobalRootCA.crt.
Convert it to pem with open ssl

```cmd
openssl x509 -inform DER -in path:\to\DigiCertGlobalRootCA.crt -out path:\to\ DigiCertGlobalRootCA.pem -text
```

From:

```log
amqps://eh-rmq-bridge:<SharedAccessKey>@<your-namespace>.servicebus.windows.net:5671/?sasl=plain
```

To:
```log
amqps://eh-rmq-bridge:<SharedAccessKey>@<your-namespace>.servicebus.windows.net?cacertfile=path:/to/folder/DigiCertGlobalRootCA.pem&verify=verify_none

# if we use verify=verify_peer

2023-07-15 19:31:27.467000+02:00 [error] <0.20164.0>     reason: {tls_alert,{unknown_ca,"TLS client: In state certify at ssl_handshake.erl:2109 generated CLIENT ALERT: Fatal - Unknown CA\n"}}

```

TODO: Need to know what root certificate Azure Service Bus uses, since above gives Unknown CA.

Now create a dynamic shovel

![Shovel ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/shovel.jpg)

Shovel status

![Shovel status ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/shovelstatus.jpg)

Post two messages

```json
{
    "Timestamp": "2020-01-01T01:00:00Z", 
    "Temperature": 19, 
    "Humidity": 50
}

{
    "Timestamp": "2020-01-01T02:00:00Z", 
    "Temperature": 20, 
    "Humidity": 49
}

```

![Message ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/message.jpg)

Rate RabbitMQ

![Deliver ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/deliver.jpg)

Azure Service Bus

![Bus Message ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/busmessage.jpg)




























