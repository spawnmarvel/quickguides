# Azure Functions scenarios

https://learn.microsoft.com/en-us/azure/azure-functions/functions-scenarios?pivots=programming-language-csharp#real-time-stream-and-event-processing

## Scenario

AMQP->Service Bus->Logic App->File Storage   

## Integration

Service Bus fully integrates with many Microsoft and Azure services, for instance:
* Event Grid
* Logic Apps
* Azure Functions
* Power Platform
* Dynamics 365
* Azure Stream Analytics

https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview#integration

## Produce and Consume messages through Service Bus, Event Hubs, and Storage Queues with Azure Functions

https://learn.microsoft.com/en-us/samples/azure-samples/durable-functions-producer-consumer/product-consume-messages-az-functions/

## Connect to Azure Service Bus from workflows in Azure Logic Apps

Applies to: Azure Logic Apps (Consumption + Standard)

* [...]
* Manage messages in queues and topic subscriptions, for example, get, get deferred, complete, defer, abandon, and dead-letter.

Connector technical reference

The Service Bus connector has different versions, based on logic app workflow type and host environment.
* Consumption, [...]
* Consumption, [...]
* Standard, Single-tenant Azure Logic Apps and App Service Environment v3 (Windows plans only)

[...]
Large message support

Large message support is available only for Standard workflows when you use the Service Bus built-in connector operations. For example, you can receive and large messages using the built-in triggers and actions respectively.

For the Service Bus managed connector, the maximum message size is limited to 1 MB, even when you use a premium tier Service Bus namespace.

[...]

## Steps

Step 1 - Check access to Service Bus namespace
Step 2 - Get connection authentication requirements
* Get connection string for Service Bus namespace
* Get endpoint URL for Service Bus namespace
* Get fully qualified name for Service Bus namespace
Step 3: Option 2 - Add a Service Bus action


![logicapp ](https://github.com/spawnmarvel/quickguides/blob/main/eventhub/images/logicapp.jpg)

https://learn.microsoft.com/en-us/azure/connectors/connectors-create-api-servicebus?tabs=consumption