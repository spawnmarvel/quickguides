# Prosys OPC UA sim, Cogent OPC UA client, InfluxDB, OPC UA expert, IP21

## OPC DA Address vs. OPC UA Address

OPC (Open Platform Communications) defines two key standards for industrial communication: **OPC Data Access (DA)** and **OPC Unified Architecture (UA)**. Their addressing schemes differ significantly due to architectural differences.

### **1. OPC DA Address (Classic OPC)**
- **Hierarchy**: Flat or simple tree structure (Server → Group → Item).  
- **Address Format**: Uses a **3-level hierarchical path**:  
  ```
  ServerName.ItemGroup.ItemName
  ```
  Example:  
  ```
  OPCServer.PLC1.Temperature
  ```
- **Characteristics**:
  - Tightly coupled with **COM/DCOM** (Windows-only).  
  - Item names are often **tag-based** (e.g., PLC memory addresses).  
  - No built-in metadata or semantic meaning.  

### **2. OPC UA Address**
- **Hierarchy**: Flexible, object-oriented **node-based** structure.  
- **Address Format**: Uses a **Namespace Index (NS) + Node ID** (numeric or string-based):  
  ```
  ns=<NamespaceIndex>;<IdentifierType>=<Identifier>
  ```
  Example (numeric Node ID):  
  ```
  ns=2;i=15025
  ```
  Example (string-based Node ID):  
  ```
  ns=3;s="PLC1/Temperature"
  ```
- **Characteristics**:
  - Platform-independent (cross-platform support).  
  - Supports **browse paths** for human-readable navigation (e.g., `/Objects/PLC1/Temperature`).  
  - Includes **metadata** (data type, description, engineering units).  
  - Supports **complex objects** and **methods** (not just data points).  

### **Key Differences**
| Feature | OPC DA Address | OPC UA Address |
|-----------------|---------------|---------------|
| **Structure** | Flat (Server → Item) | Hierarchical (Nodes, Objects, Variables) |
| **Addressing** | Simple tag path (`Server.Group.Item`) | Namespace + Node ID (`ns=2;i=1234`) |
| **Platform** | Windows-only (DCOM) | Cross-platform (TCP, HTTPS, MQTT) |
| **Metadata** | Limited | Rich (description, data type, units) |
| **Security** | Weak (DCOM issues) | Built-in (encryption, authentication) |
| **Scalability** | Limited | Highly scalable (Pub/Sub, cloud-ready) |

### **Summary**
- **OPC DA** is **tag-based**, simple, but outdated (legacy systems).  
- **OPC UA** is **node-based**, flexible, secure, and future-proof.  

For new systems, **OPC UA is preferred** due to its modern architecture and broader capabilities.


## Prosys OPC UA Simulation Server


Prosys OPC UA Simulation Server 5.6.0-6 Download

* Windows 10 or later, 64-bit
* prosys-opc-ua-simulation-server-windows-x64-5.6.0-6.exe

Installing

Windows

On Windows, run the installer executable prosys-opc-ua-simulation-server-windows-x64-5.6.0-6.exe and follow the instructions. By default, the application is installed to the folder Program Files/ProsysOPC/Prosys OPC UA Simulation Server.

C:\Program Files\ProsysOPC\Prosys OPC UA Simulation Server

![installed](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/procosys.png)

Uninstallation

On Windows the application can be uninstalled through the Control Panel or the Apps & features menu, or optionally with the uninstaller that is located in the installation folder.

https://prosysopc.com/products/opc-ua-simulation-server/evaluate/


![Tag values](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/tag_values.png)


## Prosys Support Forum

https://forum.prosysopc.com/


## Cogent OPC UA

* Cogent DataHub™ can act as both an OPC UA server and client program at the same time.
* This OPC UA server and client support is fully integrated with all other DataHub features. You can use the DataHub to convert between OPC UA and OPC DA, etc...

https://cogentdatahub.com/features/protocols/opc-ua/

Cogent is installed as service, run remote config.

* remotemika, linux100

Copy the prosys OPC UA Simulation Server US TCP url:

opc.tcp://BER-0803.goodtech.local:53530/OPCUA/SimulationServer

And past it into Cogent, Name it OPCUAProsys and test the connection.

![Connection success](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/connection_success.png)

Now that we have connected, lets look at some tag values.

The only field we Change in Cogent on OPCUAProsys is Load all items.

![Load all items](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/load_items.png)

Then we can browse the values from OPC UA server

![prosys and cogent values](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/prosys_and_cogent_values.png)

## Connect to InfluxDB

Follow this guide setp by step

https://cogentdatahub.com/docs/#cdh-connectinginfluxdb.html

After influx is running:

Configure external historian

![Influxdb configure](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/influxdb_conf.png)

Start Chronograf

![Open browser](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/open_browser.png)

And select the tag

![Chronograf](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/chronograf.png)



## UaExpert TODO

UaExpert is a full-featured OPC UA Client which is capable of several OPC UA Profiles and features.

uaexpert-bin-win64-x86_64-ucrt-v1.7.2.584.msi

https://www.unified-automation.com/downloads/opc-ua-clients.html

![opc ua expert](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/uaexpert.jpg)


UaExpert—A Full-Featured OPC UA Client

UaExpert Common Framework

* The basic framework of UaExpert includes general functionality like certificate handling, discovering UA Servers, connecting with UA Servers, browsing the information model, displaying attributes and references of particular UA Nodes.

Lets connect to it:

### Mutually trust

Difficulty connecting an OPC UA client like **UaExpert** to an OPC UA server like **Prosys OPC UA Simulator** when using a secure connection is **almost always a certificate trust issue** 🛡️.

OPC UA clients and servers must **mutually trust** each other's security certificates to establish a secure channel. When a connection attempt fails due to a certificate issue, the public key of the rejected application (client or server) is typically moved to a "rejected" folder on the other application's file system.

Here's the step-by-step process to resolve this mutual trust problem:

---

### 1. Trust the Client Certificate (in Prosys Simulator)

The Prosys OPC UA Simulator (the server) must trust the certificate of the UaExpert (the client).

1.  **Open Prosys OPC UA Simulator** and ensure it's running and accepting connections on the endpoint you're using (e.g., `opc.tcp://localhost:53530/OPCUA/SimulationServer`).
2.  **Attempt to Connect from UaExpert:** Try to establish the connection from UaExpert. It will fail, but this action forces UaExpert to send its certificate to the Prosys Simulator.

Add server

![add server](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/add_server.png)

Add Url

![add url](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/add_url.png)

Add server failed

![add server](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/add_server_failed.png)

3.  **Locate the Rejected Certificate in Prosys Simulator:**
    * In the Prosys Simulator, go to the **Certificates** tab (you may need to switch to **Expert Mode** under the **Options** menu to see it).
    * Look for the certificate for **UaExpert** (it's usually listed with its application URI, e.g., `urn:UaExpert:UnifiedAutomation:UaExpert`). It will likely be in the **Rejected** list.

Expert mode

![Expert mode](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/expert_mode.png)

4.  **Trust the Certificate:**
    * **Right-click** on the UaExpert certificate in the rejected list.
    * Select **Trust** (or **Move to Trusted**).
5.  **Restart the Prosys Simulator.**

Trust certtificate

![Trust certificate](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/trust_cert.png)

---

### 2. Trust the Server Certificate (in UaExpert)

The UaExpert client must also trust the certificate of the Prosys OPC UA Simulator server.

1.  **Attempt to Connect Again from UaExpert:** If you hadn't already, try connecting to the server's endpoint again.
2.  **Locate the Rejected Certificate in UaExpert:**
    * In UaExpert, you should see a pop-up window or an entry in the **Log** or **Server Diagnostics** window indicating that the server's certificate was rejected.
    * UaExpert manages its trust list via its file system. The certificate from the Prosys Simulator is usually copied to the UaExpert's **rejected** certificates folder. You'll typically find these folders under a path like:
        * `C:\Users\<YourUserName>\AppData\Roaming\unifiedautomation\uaexpert\PKI\rejected\certs` (The `AppData` folder is often hidden).
3.  **Trust the Certificate:**
    * Find the **Prosys Simulator's certificate file** (usually a `.der` file with a name related to `SimulationServer` or `Prosys`) in the UaExpert's `PKI\rejected\certs` folder.
    * **Copy** (or **Move**) this file to the UaExpert's **trusted** certificates folder:
        * `C:\Users\<YourUserName>\AppData\Roaming\unifiedautomation\uaexpert\PKI\trusted\certs`
(4.  **Restart UaExpert** (close and reopen the application).)


We did not have to move any cetificates, we just marked trust.

![Trust certificate 2](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/trust_cert2.png)
---

### 3. Re-Connect

After performing these two steps and restarting both applications, **UaExpert** should be able to connect to the **Prosys OPC UA Simulator** using a secure endpoint (e.g., **Sign & Encrypt**).

Then we have OPC UA Data

![Opc ua data](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/opc_ua_data.png)

#### Quick Security Bypass (For Testing)

If you just need to test the connection without security, you can configure both applications to use **"None"** for the **Security Mode** and **"Anonymous"** for **User Authentication**.

In **Prosys OPC UA Simulator (Expert Mode)**:

1.  Go to the **Endpoints** tab.
2.  Select the relevant endpoint (usually the default `opc.tcp://...`).
3.  Under **Security Modes**, **deselect** `Sign` and `Sign & Encrypt`. **Select** `None`.
4.  Go to the **Users** tab.
5.  Under **User Authentication Methods**, **deselect** all except **Anonymous**.
6.  **Save** and **Restart** the simulator.

Then, ensure you select the **"None"** security policy in UaExpert when adding the server connection.


https://www.unified-automation.com/products/development-tools/uaexpert.html?gad_source=1&gad_campaignid=19807579087&gclid=EAIaIQobChMI-4OLwIKckAMVLBiiAx3vPjbtEAAYASAAEgKfw_D_BwE

### Export the OPC UA address

So we need to get the adresse sapce we talked about the beginning, so we can use it and make tags.

That's great that you've got the certificate issue sorted out!

In **UaExpert**, the primary method to "export the OPC UA address" for an object or a set of objects is to use the built-in **XML Nodeset Export View**. This process exports the structure of the address space as an **OPC UA NodeSet XML file**.

Here are the steps to export the address space for an object:

---

## Exporting the OPC UA Address Space to a NodeSet XML

1.  **Add the Export View:**
    * Go to the **Document** menu in UaExpert.
    * Select **Add...**.
    * In the "Add Document" dialog, choose **XML Nodeset Export View** from the document type dropdown menu.
    * Click **Add Document**. A new tab named "XML Nodeset Export" will appear.

2.  **Select the Namespace(s) to Export:**
    * In the new **XML Nodeset Export** tab, you will see a list of **Namespaces** provided by your connected server (Prosys Simulator).
    * OPC UA servers typically have multiple namespaces. Your custom/simulated objects will reside in a namespace that is *not* index 0 (which is the standard OPC UA namespace).
    * **Check the box** next to the specific Namespace(s) that contain the object(s) you want to export. For the Prosys Simulator, this is usually one of the higher index namespaces.

3.  **Export the NodeSet:**
    * Click the **Export** button at the bottom of the "XML Nodeset Export" view.
    * You will be prompted to select a save location and a file name for the **NodeSet XML file** (e.g., `MyProsysSimulation.xml`).

### What is Exported?

This XML file (**NodeSet2 XML**) contains the complete definition of the selected namespace, which includes the **Node IDs** for the objects, variables, data types, and methods, along with their hierarchical relationships (the address space structure).

* **Node IDs** are the unique addresses used to identify an object (Node) in the OPC UA server.
* **Exporting Node IDs is the standard way** to get a machine-readable "export of the address" in OPC UA.

If you simply want to *copy the string address* of a single node (the **NodeId** or **BrowseName**):

1.  In the **Address Space** window, select the object you are interested in.
2.  In the **Attributes** window on the right, you can copy the values from the following fields:
    * **NodeId:** This is the *unique address* for the node (e.g., `ns=3;i=1001` or `ns=3;s=MyObject.Temperature`). This is the most crucial identifier.
    * **BrowseName:** This is the *hierarchical name* of the node (e.g., `2:Temperature`).

The video below shows how to configure UaExpert, which is the client application you are successfully using.
[UaExpert OPC UA Client](https://www.youtube.com/watch?v=-5rYJpgf_Vc)
http://googleusercontent.com/youtube_content/0



## Prosys to Cim-io server and set up Cim-io for OPC UA to IP21 TODO