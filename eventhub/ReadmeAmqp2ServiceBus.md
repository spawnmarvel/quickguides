# Advanced Message Queueing Protocol (AMQP) 1.0 support in Service Bus

AMQP allows for interconnecting connecting brokers directly, for instance using routers like Apache Qpid Dispatch Router or broker-native "shovels" like the one of RabbitMQ.

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-amqp-overview

## Service Bus access control with Shared Access Signatures

Best practices when using SAS

Each Service Bus namespace and each Service Bus entity has a Shared Access Authorization policy made up of rules.

For each authorization policy rule, you decide on three pieces of information: name, scope, and rights.
* 'Send' - Confers the right to send messages to the entity
* 'Listen' - Confers the right to receive (queue, subscriptions) and all related message handling
* 'Manage' - Confers the right to manage the topology of the namespace, including creating and deleting entities
* An authorization rule is assigned a Primary Key and a Secondary Key
* RootManageSharedAccessKey (treat this rule like an administrative root account and don't use it in your application)

Regenerating keys
* It's recommended that you periodically regenerate the keys used in the Shared Access Authorization Policy. The primary and secondary key slots exist so that you can rotate keys gradually.


https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-sas#best-practices-when-using-sas


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

https://github.com/MicrosoftDocs/azure-docs/issues/112061

## Test repos verified result

Shovel status running and messages transported to Azure Service Bus and Azure Event Hub

https://github.com/spawnmarvel/test/blob/main/it_works.jpg

### Test Azure Service Bus or Azure Event hub with RabbitMQ

Note, it does not matter if you use Azure Service Bus or Azure Event hub, bot uses the same foundation for connectivity in both tutorials and they start the same way.

Ok lets do this for Azure Service Bus, date 15.07.2023.

## Steps

:warning: This is for test, it is best to use VPN / ExpressRoute or use a Private access with a private link if possible.
Always follow the governance policy for security.

Here we are testing scenario mentioned above:

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
amqps://eh-rmq-bridge:<SharedAccessKey>@<your-namespace>.servicebus.windows.net:5761?cacertfile=path:/to/folder/DigiCertGlobalRootCA.pem&verify=verify_none
```

---- This is just a place holder for the shovel application format after Erlang 26 --
Shovel update tls 04.10.2024, not mtls (and nothing to do with AEH or ASB, just plain shovel stuff):

* Windows OS: Client app (running shovel) AMQP and Erlang > 26, (VERIFY_PEER by default)
* Windows OS: Server app AMQP and Erlang <=> 26 with tls enabled
* Copy the root cert from server app to client app on serverca.pem format
* Build the shovel string

You will have to use this format for the shovel or client at least.
You can also check with true and add SNI:

verify=verify_peer&fail_if_no_peer_cert=true&server_name_indication=pdp-shovel-2

Shovel:
```log
amqps://user:password@xx.xx.xx.xx:5671?cacertfile=path:\\to\\folder\\serverca.pem&verify=verify_none
```

---- This is just a place holder for the shovel application format after Erlang 26 --

###  (Note Url encode Python helper)

(https://gist.github.com/spawnmarvel/15d124a63030c5743c50895926d1e221)


```log

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

Now go to Azure Cert store and download both and create ca.bundle file of the two.

https://learn.microsoft.com/en-us/azure/security/fundamentals/azure-ca-details?tabs=root-and-subordinate-cas-list

* DigiCertGlobalRootG2.crt
* 2616326057.crt (Microsoft Azure TLS Issuing CA 05)

Look above to the open ssl cmd, if you get

```cmd
openssl x509 -inform DER -in path:\to\2616326057.crt -out path:\to\2616326057.pem -text

unable to load certificate
4076:error:0D0680A8:asn1 encoding routines:asn1_check_tlen:wrong tag:crypto\asn1\tasn_dec.c:1149:
4076:error:0D07803A:asn1 encoding routines:asn1_item_embed_d2i:nested asn1 error:crypto\asn1\tasn_dec.c:309:Type=X509

Then the certificate is already in PEM format, you can just open it.
```


https://www.rabbitmq.com/ssl.html#erlang-client

* server_name_indication - set this option to the host name of the server to which a TLS connection will be made to enable "Server Name Indication" verification of the certificate presented by the server. 
* This ensures that the server certificate's CN= value will be verified during TLS connection establishment. 
* You can override this behavior by setting server_name_indication to a different host name or to the special value disable to disable this verification. 
* Note that, by default, SNI is not enabled. This default will change in a future RabbitMQ Erlang client release.

```log
&server_name_indication=hostname
```


Now create the bundle with just the root.


```log
cacertfile=path:/to/folder/ca.bundle&verify=verify_peer
```

Result
```log
2023-07-16 20:09:45.372000+02:00 [error] <0.25782.0>     errorContext: start_error
2023-07-16 20:09:45.372000+02:00 [error] <0.25782.0>     reason: {tls_alert,
2023-07-16 20:09:45.372000+02:00 [error] <0.25782.0>                 {handshake_failure,
2023-07-16 20:09:45.372000+02:00 [error] <0.25782.0>                     "TLS client: In state certify at ssl_handshake.erl:2111 generated CLIENT ALERT: Fatal - Handshake Failure\n {bad_cert,hostname_check_failed}"}}

```
Add the 2616326057 content to the bundle. (Maybe we dont need this, could set depth also)


Server Name Indication, SNI test FQDN

```log
cacertfile=path:/to/folder/ca.bundle&verify=verify_peer&server_name_indication=xxxxx.servicebus.windows.net
```

```log
2023-07-16 20:33:45.615000+02:00 [error] <0.5122.0>     exception exit: {tls_alert,
2023-07-16 20:33:45.615000+02:00 [error] <0.5122.0>                         {handshake_failure,
2023-07-16 20:33:45.615000+02:00 [error] <0.5122.0>                             "TLS client: In state certify at ssl_handshake.erl:2111 generated CLIENT ALERT: Fatal - Handshake Failure\n {bad_cert,hostname_check_failed}"}}

```
Server Name Indication, SNI, set to DNS Name=servicebus.windows.net

```log
cacertfile=c:/RabbitMQBaseFolder/cert/ca.bundle&verify=verify_peer&server_name_indication=servicebus.windows.net

```
![SNI ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/sni.jpg)

Lets add the TLS parameter and heartbeat

```log
cacertfile=c:/RabbitMQBaseFolder/cert/ca.bundle&verify=verify_peer&server_name_indication=servicebus.windows.net&versions=tlsv1.2&heartbeat=15

```

Finale URI
```log
amqps://<SasSubPolicy>:<SharedAccessKey>@<your-namespace>.servicebus.windows.net:5761?cacertfile=c:/RabbitMQBaseFolder/cert/ca.bundle&verify=verify_peer&server_name_indication=servicebus.windows.net&versions=tlsv1.2&heartbeat=15
```

![Final URI ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/finaleuri1.jpg)

* c:/RabbitMQBaseFolder/cert/ca.bundle
* verify=verify_peer
* server_name_indication=servicebus.windows.net
* versions=tlsv1.2

During peer verification TLS connection client (or server) traverses the chain of certificates presented by the peer and if a trusted certificate is found, considers the peer trusted.

verify - set this option to verify_peer to enable X509 certificate chain verification. The depth option configures certificate verification depth. 

server_name_indication - set this option to the host name of the server to which a TLS connection will be made to enable "Server Name Indication" verification of the certificate presented by the server. This ensures that the server certificate's CN= value will be verified during TLS connection establishment.


Post last messages, this was fun!

![Final ASB ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/finaleasb.jpg)

## Static Shovel

### Example Configuration (1.0 Source - 0.9.1 Destination)

A reasonably complete shovel configuration between an AMQP 1.0 source and an AMQP 0.9.1 destination might look like this:

```log
{rabbitmq_shovel,
 [ {shovels, [ {my_first_shovel,
                [ {source,
                   [ {protocol, amqp10},
                     {uris, [ "amqp://fred:secret@host1.domain/my_vhost",
                            ]},
                     {source_address, <<"my-source">>},
                     {prefetch_count, 10}
                   ]},
                  {destination,
                     [ {protocol, amqp091},
                       {uris, ["amqp://"]},
                       {declarations, [ {'exchange.declare',
                                         [ {exchange, <<"my_direct">>},
                                           {type, <<"direct">>},
                                           durable
                                         ]}
                                      ]},
                       {publish_properties, [ {delivery_mode, 2} ]},
                       {add_forward_headers, true},
                       {publish_fields, [ {exchange, <<"my_direct">>},
                                          {routing_key, <<"from_shovel">>}
                                        ]}
                     ]},
                  {ack_mode, on_confirm},
                  {reconnect_delay, 5}
                ]}
             ]}
 ]}
```

## Example Configuration (0.9.1 Source — 1.0 Destination)

A more extensive shovel configuration between an AMQP 0.9.1 Source and an AMQP 1.0 destination might look like this:

```log
{rabbitmq_shovel,
 [{shovels, [{my_first_shovel,
              {source,
               [{protocol, amqp091},
                {uris, ["amqp://fred:secret@host1.domain/my_vhost",
                        "amqp://john:secret@host2.domain/my_vhost"]},
                {declarations, [{'exchange.declare',
                                   [{exchange, <<"my_fanout">>},
                                    {type, <<"fanout">>},
                                    durable]},
                                {'queue.declare',
                                   [{arguments,
                                      [{<<"x-message-ttl">>, long, 60000}]}]},
                                {'queue.bind',
                                   [{exchange, <<"my_fanout">>},
                                    {queue,    <<>>}
                                    ]}
                               ]},
                {queue, <<>>},
                {prefetch_count, 10}
               ]},
              {destination,
               [{protocol, amqp10},
                %% Note: for plain text SASL authentication, use
                % {uris, ["amqp://user:pass@host:5672?sasl=plain"]},
                %% Note: this relies on default user credentials
                %%       which has remote access restrictions, see
                %%       https://www.rabbitmq.com/access-control.html to learn more
                {uris, ["amqp://host:5672"]},
                {properties, [{user_id, <<"my-user">>}]},
                {application_properties, [{<<"my-prop">>, <<"my-prop-value">>}]},
                {add_forward_headers, true},
                {target_address, <<"destination-queue">>}
               ]},
              {ack_mode, on_confirm},
              {reconnect_delay, 5}
             }]}
 ]}
}
````

https://www.rabbitmq.com/shovel-static.html



























