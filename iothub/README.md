# Azure IoT Hub

Azure IoT Hub is a managed service hosted in the cloud that acts as a central message hub for communication between an IoT application and its attached devices.

https://learn.microsoft.com/en-us/azure/iot-hub/

# Azure Iot Central

Azure IoT Central is an IoT application platform (aPaaS) that simplifies the creation of IoT solutions. Azure IoT Central provides a ready-to-use UX and API surface built to connect, manage, and operate fleets of devices at scale. Learn how to use IoT Central with our quickstarts, tutorials, and REST API documentation.

https://learn.microsoft.com/en-us/azure/iot-central/


## Quickstart: Send telemetry from a device to an IoT hub and monitor it with the Azure CLI

Azure IoT hUB
Free
* Device-to-cloud messages
* Cloud-to-device commands
* IoT Edge
* Device twin
* Daily message limit up to 8000
* Message size 0.5 KB
Public Access
Permission model Shared access policy + RBAC
Device-to-cloud partitions, default 2
* The number of partitions relates the device-to-cloud messages to the number of simultaneous readers of these messages. Most IoT hubs only need 4 partions.
Enable Device Update for IoT Hub (not in free tier)
Enable Defender for IoT, $0.001 per device per month (not in free tier)

Add a device to the IoT hub
* device01

https://learn.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-cli

## 

## Cogent

https://cogentdatahub.com/

CogentDataHub_x64-10.0.2-230302-Windows.exe

Cloud offering:

* Azure Marketplace: https://azuremarketplace.microsoft.com/en-ca/marketplace/apps/cogentreal-timesystemsinc1581352149215.skkynetdatahub?tab=Overview 
* Connect to any MQTT Broker: https://cogentdatahub.com/products/datahub-iot-gateway/ 
* In-plant broker: https://cogentdatahub.com/products/datahub-smart-mqtt-broker/ 
* https://azuremarketplace.microsoft.com/en-ca/marketplace/apps/cogentreal-timesystemsinc1581352149215.skkynetdatahub?tab=Overview


Secure OT to IT networking: https://cogentdatahub.com/connect/secure-ot-it/

## Softwaretoolboc

Video Tutorial: OPC to Azure IoT Hub with Cogent DataHub V9

https://blog.softwaretoolbox.com/video-tutorial-datahub-v9-azure-iot-hub

Download the current release of the Azure IoT Explorer from:

https://github.com/Azure/azure-iot-explorer/releases

Azure.IoT.Explorer.Preview.0.15.9.msi

![Azure Iot Explorer](https://github.com/spawnmarvel/quickguides/blob/main/iothub/images/hubconnect.jpg)

## How in the world do I run DataHub as a service?”

https://blog.softwaretoolbox.com/cogent-datahub-as-windows-service


## Cogent Docs

3.12. MQTT Client

The MQTT Client option lets you configure the DataHub program as an MQTT client to any number of MQTT brokers, with pre-configured connections for Azure IoT Hub, Google IoT, and AWS IoT Core.


3.12.3.1. Azure IoT Hub

IoT Hub Name
Device Name
Tell IoT Hub to treat messages as JSON text instead of binary.
After making your entries, press the Reconfigure button to add that configuration to the list, and clear the fields for another entry. 

CA Certificates
DataHub software supports CA certificates for SSL, in either PEM or PFX format. To use a CA certificate you need to do the following in your Azure IoT Hub configuration.

[...] SAS token, which you can paste verbatim into the DataHub configuration Password field.

3.12.3.4. Sparkplug

https://cogentdatahub.com/library/documentation/






