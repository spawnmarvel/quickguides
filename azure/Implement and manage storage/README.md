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

### Configure storage accounts

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

![Account types ](https://github.com/spawnmarvel/quickguides/blob/main/azure/images/administrative-unit.jpg)

## Questions

1. SAS. It looks like you are trying to load a container via the URL in your browser. 
Unfortunately this is not supported by default. 
If you try loading a specific blob then it should work as you are intending. 
If you want to list all blobs in the container you need to use the List Blobs format.

https://learn.microsoft.com/en-us/answers/questions/982062/cannot-access-to-uri-sas-blob-storage-authenticati

2. You can't convert a Standard tier storage account to a Premium tier storage account or vice versa. 
You must create a new storage account with the desired type and copy data, if applicable, to a new storage account.


