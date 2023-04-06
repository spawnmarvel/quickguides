# Azure Administrator

Implement and manage storage (15–20%)

## Description

Azure Administrator Cheat Sheet

## Links

Learn

https://learn.microsoft.com/en-us/training/paths/az-104-manage-storage/

Study Guide

https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104

## Implement and manage storage (15–20%)

## MS learn AZ-104: Implement and manage storage in Azure

## Configure storage accounts

The module concepts are covered in: Implement and manage storage (15–20%)

Secure storage
* Create and configure storage accounts
* Configure network access to storage accounts


#### Things to know about Azure Storage

| Category | Description | Storage example
| -------- | ----------- | ---------------
| Virtual machine data | Disks and files, disks are persistent block storage for IaaS VM's, files are managed fileshare | VM storage is managed disks
| Unstructured data    | Mix of information, format is non-relational | Blob storage (highly scalable, REST-based object store), Data Lake storage (Hadoop distributed file system HDFS)
| Structured data      | Relational format that has shared schema. (Db table, rows, columns and keys)| Table storage, Cosmos, SQL

Storage account tiers
* General purpose Azure storage accounts have two tiers: Standard (HDD) and Premium (SSD).


#### Explore Azure Storage services

Four services:

Azure Blob Storage (containers): A massively scalable object store for text and binary data.
* Text or binary data (images, docs, files, video/audio)
* Storing data for backup and restore, disaster recovery, and archiving.
* Storing data for analysis by an on-premises or Azure-hosted service.
* HTTP(S), access  blobs via URL, REST API, PS1, CLI, SDK.


Azure Files: Managed file shares for cloud or on-premises deployments.
* Highly available network file shares
* Server Message Block (SMB) protocol and the Network File System (NFS) protocol.
* Many on-premises applications use file shares. 
* Configuration files can be stored on a file share and accessed from multiple virtual machines.
* Diagnostic logs, metrics, and crash dumps are just three examples.
* The storage account credentials are used to provide authentication for access to the file share. 


Azure Queue Storage: A messaging store for reliable messaging between application components.
* Queue messages can be up to 64 KB in size.


Azure Table Storage: A NoSQL store for schemaless storage of structured data or relational data.
* Azure Table Storage is now part of Azure Cosmos DB, which is a fully managed NoSQL database service for modern app development.
* NoSQL

Things to consider when choosing Azure Storage services

* Consider storage optimization for massive data. Azure Blob Storage is optimized for storing massive amounts of unstructured data.
* Consider storage with high availability. Azure Files supports highly available network file shares.
* Consider storage for messages. Use Azure Queue Storage to store large numbers of messages
* Consider storage for structured data. Azure Table Storage is ideal for storing structured, non-relational data.

#### Determine storage account types

![Account types ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/account-types.jpg)

#### Determine replication strategies

Locally redundant storage (LRS)
* One Zone

Zone redundant storage (ZRS)
* Replicates your data across three storage clusters (Zones) in a single region.

Geo-redundant storage (GRS)
* Replicates your data to a secondary region (hundreds of miles away from the primary location of the source data).

* If you implement GRS, you have two related options to choose from:
* * GRS replicates your data to another data center in a secondary region. The data is available to be read only if Microsoft initiates a failover from the primary to secondary region.
* * Read-access geo-redundant storage (RA-GRS) is based on GRS. RA-GRS replicates your data to another data center in a secondary region, and also provides you with the option to read from the secondary region.
* * GRS or RA-GRS enabled, all data is first replicated with locally redundant storage.
* * The update is then replicated asynchronously to the secondary region by using GRS,it's also replicated within that location by using LRS. 


Geo-zone-redundant storage (GZRS)
* Data in a GZRS storage account is replicated across three Azure availability zones in the primary region, and also replicated to a secondary geographic region for protection from regional disasters. 
* Each Azure region is paired with another region within the same geography, together making a regional pair.


#### Access storage

| Service | Default endpoint
| -------- | ---------------
| Container service | //mystorageaccount.blob.core.windows.net
| Table service     | //mystorageaccount.table.core.windows.net
| Queue service     | //mystorageaccount.queue.core.windows.net
| File service      | //mystorageaccount.file.core.windows.net

To access the myblob data in the mycontainer location in your storage account:
* //mystorageaccount.blob.core.windows.net/mycontainer/myblob

#### Configure custom domains

Can configure a custom domain to access blob data in your Azure storage account.

1. Direct mapping lets you enable a custom domain for a subdomain to an Azure storage account.
2. Intermediary domain mapping is applied to a domain that's already in use within Azure.

#### Secure storage endpoints

![Secure storage endpoints  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/secure-storage-endpoints.jpg)

Things to know about configuring service endpoints

* The Firewalls and virtual networks settings restrict access to your storage account from specific subnets on virtual networks or public IPs.
* The Firewalls and virtual networks settings restrict access to your storage account from specific subnets on virtual networks or public IPs.
* Subnets and virtual networks must exist in the same Azure region or region pair as your storage account.


## Configure Azure Blob Storage

The module concepts are covered in: Implement and manage storage (15–20%)

Configure Azure Files and Azure Blob Storage
* Configure Azure Blob Storage
* Configure storage tiers for Azure Blob Storage
* Configure Blob lifecycle management

#### Implement Azure Blob Storage

Blob Storage is also referred to as object storage or container storage.

![Configure blob storage  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/configure-blob-storage.jpg)

#### Things to know about containers and blobs

* All blobs must be in a container.
* A container can store an unlimited number of blobs.
* An Azure storage account can contain an unlimited number of containers.

In the Azure portal, you configure two settings to create a container for an Azure storage account:

1. Name (The name must be unique within the Azure storage account.)
2. Public access level:
*  Private: (Default) Prohibit anonymous access to the container and blobs.
*  Blob: Allow anonymous public read access for the blobs only.
*  Container: Allow anonymous public read and list access to the entire container, including the blobs.

#### Assign blob access tiers

Access tiers for blob data, including Hot, Cool, Archive, and Premium Blob Storage.

* Hot tier, frequent reads and writes of objects. (Default)

* Cool tier, data that's infrequently accessed (30 days), short-term backup and disaster recovery datasets and older media content.
* * This content shouldn't be viewed freq
uently, but it needs to be immediately available.
* * Cool tier is more cost-effective, but access more expensive then hot.

* Archive tier
* Offline tier that's optimized for data that can tolerate several hours of retrieval latency.
* Data must remain in the Archive tier for at least 180 days or be subject to an early deletion charge.
* Secondary backups, original raw data, and legally required compliance information.
* Most cost-effective option for storing data, accessing data is more expensive.

* Premium Blob Storage
* * Premium Blob Storage is best suited for I/O intensive workloads that require low and consistent storage latency. (SSD)
* * Workloads that perform many small transactions.

![Compare access tiers  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/compare-access-tiers.jpg)



## Configure Azure Storage Security

## Configure Azure Files and File Sync

## Configure Azure Storage with tools

## Create and Azure Storage account

## Control access to Azure Storage with shared acess signatures

## Upload, download, and manage data with Azure Storage Explorer




## Questions

1. SAS. It looks like you are trying to load a container via the URL in your browser. 

Unfortunately this is not supported by default. 
If you try loading a specific blob then it should work as you are intending. 
If you want to list all blobs in the container you need to use the List Blobs format.

https://learn.microsoft.com/en-us/answers/questions/982062/cannot-access-to-uri-sas-blob-storage-authenticati

2. You can't convert a Standard tier storage account to a Premium tier storage account or vice versa. 

You must create a new storage account with the desired type and copy data, if applicable, to a new storage account.

3. Which storage solution replicates data to a secondary region, maintains six copies of the data, and is the default replication option?

Read-access geo-redundant storage is the default replication option. 
Geo-redundant storage (GRS) copies the data synchronously three times within a single physical location in the primary region by using LRS. The data is then copied asynchronously to a single physical location in the secondary region.

4. To what extent does a storage account name need to be unique?

The storage account name is used as part of the URI for API access, so it must be globally unique.

5. You can also create a blob container with PowerShell by using the New-AzStorageContainer command.

```
 New-AzStorageContainer
```





