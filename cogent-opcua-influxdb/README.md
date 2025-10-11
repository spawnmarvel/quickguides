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

![Expert mode](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua-influxdb/images/export_mode.png)

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
4.  **Restart UaExpert** (close and reopen the application).

---

### 3. Re-Connect

After performing these two steps and restarting both applications, **UaExpert** should be able to connect to the **Prosys OPC UA Simulator** using a secure endpoint (e.g., **Sign & Encrypt**).

### Quick Security Bypass (For Testing)

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

## Prosys to Cim-io server and set up Cim-io for OPC UA to IP21 TODO