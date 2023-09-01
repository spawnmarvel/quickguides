# Cogent

## Get Cogent
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

##  Change the path the Cogent DataHub uses to store the configuration files. 

https://support.softwaretoolbox.com/app/answers/detail/a_id/3659

By default the Cogent DataHub will store the configuration files at the location below.

"C:\Users\[USERNAME]\AppData\Roaming\Cogent DataHub"

* Stop Cogent
* Create a shortcut to CogentDataHub.exe
* Right-click and go to the Properties of the shortcut.
* Change the Target to include the "-H home_path".  Example: "C:\Program Files (x86)\Cogent\Cogent DataHub\CogentDataHub.exe" -H "C:\CogentBase\Cogent DataHub"

Target path used for version CogentDataHub_x64-10.0.2-230302-Windows.exe:
* Target was: "C:\Program Files\Cogent\Cogent DataHub\CogentDataHub.exe" -P
* Target new: "C:\Program Files\Cogent\Cogent DataHub\CogentDataHub.exe" -H "C:\CogentBase\Cogent DataHub"
* Cogent created all new files
* Config file for all configuration changes: Cogent DataHub.cfg

![Config](https://github.com/spawnmarvel/quickguides/blob/main/iothub/images/config.jpg)


## How in the world do I run DataHub as a service?” and remote config.

https://blog.softwaretoolbox.com/cogent-datahub-as-windows-service

Open Service Manger and change path to for example above mentioned.

* Run as administrator
* Install or uninstall it
* Do some changes in the Gui, verify -H path
* Install or uninstall it

![Service](https://github.com/spawnmarvel/quickguides/blob/main/iothub/images/service.jpg)


## Cogent Docs

3.12. MQTT Client

The MQTT Client option lets you configure the DataHub program as an MQTT client to any number of MQTT brokers, with pre-configured connections for Azure IoT Hub, Google IoT, and AWS IoT Core.

Example localhost:

Client MQTT

![Cogent client](https://github.com/spawnmarvel/quickguides/blob/main/iothub/images/cogentclient.jpg)

Broker MQTT

![Cogent broker](https://github.com/spawnmarvel/quickguides/blob/main/iothub/images/cogentbroker.jpg)

Data:



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


## Features

![Cogent features ](https://github.com/spawnmarvel/quickguides/blob/main/iothub/images/features.jpg)