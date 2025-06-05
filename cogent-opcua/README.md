# OPC UA

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


## UaExpert

UaExpert is a full-featured OPC UA Client which is capable of several OPC UA Profiles and features.

uaexpert-bin-win64-x86_64-ucrt-v1.7.2.584.msi

https://www.unified-automation.com/downloads/opc-ua-clients.html

![uaexpert](https://github.com/spawnmarvel/quickguides/blob/main/cogent-opcua/uaexpert.jpg)

## Cogent OPC UA

* Cogent DataHub™ can act as both an OPC UA server and client program at the same time.
* This OPC UA server and client support is fully integrated with all other DataHub features. You can use the DataHub to convert between OPC UA and OPC DA, etc...

https://cogentdatahub.com/features/protocols/opc-ua/

## Cogent datahub-configuration-videos

https://cogentdatahub.com/library/videos/#datahub-configuration-videos

## CIMIO

## IP21

