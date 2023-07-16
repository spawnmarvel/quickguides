# Advanced Message Queueing Protocol (AMQP) 1.0 support in Service Bus

AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview

## Note

All names here for resources, addresses, URI, queues and more may change since I am doing this research on different days.

# AMQP to Azure Event Hub or Service Bus

## 1 Importing Data from RabbitMQ into Azure Data Explorer via Event Hubs

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

Shovel status running and messages transported to Azure Service Bus and Azure Event Hub

https://github.com/spawnmarvel/test/blob/main/it_works.jpg

### Test Azure Service Bus or Azure Event hub with RabbitMQ

Note, it does not matter if you use Azure Service Bus or Azure Event hub, bot uses the same foundation for connectivity in both tutorials and they start the same way.

Ok lets do this for Azure Service Bus, date 15.07.2023.

## Steps

:warning: :warning: This is for test, it is best to use VPN / ExpressRoute or use a Private access with a private link.
But we are testing scenario mentioned above:

* Third-Party Integration: A third party uses RabbitMQ as a broker, and wants to send their data to us, but they are outside our organization. We can provide them with SAS Key giving them access to a limited set of Azure Service Bus queues where they can forward their messages to.

![Topology ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/topology.jpg)

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


URL Encoding

https://www.w3schools.com/tags/ref_urlencode.ASP

```log
+ becomes %2B
= becomes %3D
/ becomes %2F
etc
```

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

![Bus Messages ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/busmessages.jpg)


Go to Service Bus explorer and view messages

![Success ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/success.jpg)


## Troubleshoot
1. Check if Erlang or RabbitMQ has had any updates
2. Check if Azure Service Bus has had any updates
3. https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-faq#what-ports-do-i-need-to-open-on-the-firewall--

What ports do I need to open on the firewall?
You can use the following protocols with Azure Service Bus to send and receive messages:
* Advanced Message Queuing Protocol 1.0 (AMQP). AMQP	5671, 5672	AMQP with TLS See https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-protocol-guide
* Hypertext Transfer Protocol 1.1 with TLS (HTTPS), HTTPS	443, This port is used for the HTTP/REST API and for AMQP-over-WebSockets



## Further enhance the security. ref verify=verify_peer Fatal - Unknown CA, TLS 1.2 and SNI

So the certificate is not for a service bus, maybe it is a general certificate with reference to CN, let's check the certificate.

Found this nice script from jstangroome.

https://gist.github.com/jstangroome/5945820

If we run it with (hostname): Azure Portal->Service Bus Namespace->Host name: xxxxxxxxx.servicebus.windows.net port 443:

```ps1
$ComputerName = "xxxxxxxxx.servicebus.windows.net"
$Port = 443

# We get back
.\Get-remotesslcertificate.ps1
CN=servicebus.windows.net, O=Microsoft Corporation, L=Redmond, S=WA, C=US
```

So I do not think verify=verify_peer will work since, https://www.rabbitmq.com/ssl.html#peer-verification-configuration
* When the ssl_options.verify option is set to verify_peer, the client does send us a certificate, the node must perform peer verification. 
* When set to verify_none, peer verification will be disabled and certificate exchange won't be performed.
* When peer verification is enabled, it is common for clients to also check whether the hostname of the server they are connecting to matches one of two fields in the server certificate: the SAN (Subject Alternative Name) or CN (Common Name). 
* When wildcard certificates are used, the hostname is matched against a pattern. If there is no match, peer verification will also be failed by the client. 

It could work if the ASB certificate was obtainable and had SAN of *.servicebus.windows.net for example.

Found this nice script from notesbytom

https://gist.github.com/notesbytom/2850d97fa5038053f8580730b8ee6e05

```ps1
# modified

$fqdn = "your.fqdn.com" 
$port = 443

$tcpsocket = New-Object Net.Sockets.TcpClient($fqdn, $port)
$tcpstream = $tcpsocket.GetStream()
$sslStream = New-Object Net.Security.SslStream($tcpstream, $false)
$sslStream.AuthenticateAsClient($fqdn)
$certinfo = New-Object security.cryptography.x509certificates.x509certificate2($sslStream.RemoteCertificate)
# look at $tcpsocket.Client.RemoteEndPoint to see Server IP the client is using for connection
$certinfo | fl
$certinfo.Extensions | where {$_.Oid.FriendlyName -like 'subject alt*'} | ` foreach { $_.Oid.FriendlyName; $_.Format($true) }
$tcpsocket.Close() # Dispose() missing from older .NET, use Close()

Subject      : CN=servicebus.windows.net, O=Microsoft Corporation, L=Redmond, S=WA, C=US
[...]
Subject Alternative Name
DNS Name=*.servicebus.windows.net
DNS Name=servicebus.windows.net
```
Where do we get that certificate.....How to obtain wildcard certificate for Azure Service Bus?, look down to section: NOTE:Obtain certificate


Ok, let's try to add tls version first.


Found this gist from kjnilsson

Azure ServiceBus can be used with the AMQP 1.0 protocol. Since version 3.7 RabbitMQ supports shovels where either the source or destination (or both) uses AMQP 1.0.

https://gist.github.com/kjnilsson/159c643fb34604f8ea20be336109261b

```log
[...]versions=tlsv1.0,tlsv1.1,tlsv1.2

```

Remember two SAS policy's with Send access.

Convert the ASB endpoint using above mentioned tool and:

Append:
```log
&versions=tlsv1.2
```
Now we enforce TLS 1.2

It works perfect:

![TLS URI ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/tlsuri.jpg)

Send a message to ASB

![TLS asv ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/tlsasb.jpg)


NOTE:Obtain certificate

https://stackoverflow.com/questions/22233702/how-to-download-the-ssl-certificate-from-a-website-using-powershell

```ps1
# powershell 5.1

$webRequest = [Net.WebRequest]::Create("https://www.google.no/")
try { $webRequest.GetResponse() } catch {}
$cert = $webRequest.ServicePoint.Certificate
$bytes = $cert.Export([Security.Cryptography.X509Certificates.X509ContentType]::Cert)
set-content -value $bytes -encoding byte -path "c:\temp\downloaded.cer"

# edit to correct url
$webRequest = [Net.WebRequest]::Create("https://xxxxxxx.servicebus.windows.net")

```
![Cert ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/cert.jpg)

Root CA and intermediate

![Cert root ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/certroot.jpg)

Now use that cert in the URI

```log
cacertfile=path:/to/folder/downloaded.pem&verify=verify_peer
```

Server Name Indication, SNI

https://www.rabbitmq.com/ssl.html#erlang-client

* server_name_indication - set this option to the host name of the server to which a TLS connection will be made to enable "Server Name Indication" verification of the certificate presented by the server. 
* This ensures that the server certificate's CN= value will be verified during TLS connection establishment. 
* You can override this behavior by setting server_name_indication to a different host name or to the special value disable to disable this verification. 
* Note that, by default, SNI is not enabled. This default will change in a future RabbitMQ Erlang client release.

```log
&server_name_indication=hostname
```




























