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

4 services:

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


![Storage account performance ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/storage-account-performance.jpg)

Locally redundant storage (LRS)
* One zone

Zone redundant storage (ZRS)
* Replicates your data across three storage clusters (Zones) in a single region.

Geo-redundant storage (GRS)
* Replicates your data to a secondary region (hundreds of miles away from the primary location of the source data).

* If you implement GRS, you have two related options to choose from:
* * GRS replicates your data to another data center in a secondary region. The data is available to be read only if Microsoft initiates a failover from the primary to secondary region.
* * * Read-access geo-redundant storage (RA-GRS) is based on GRS. RA-GRS replicates your data to another data center in a secondary region, and also provides you with the option to read from the secondary region.
* * GRS or RA-GRS enabled, all data is first replicated with locally redundant storage.
* * * The update is then replicated asynchronously to the secondary region by using GRS,it's also replicated within that location by using LRS. 


Geo-zone-redundant storage (GZRS)
* Data in a GZRS storage account is replicated across three Azure availability zones in the primary region, and also replicated to a secondary geographic region for protection from regional disasters. 
* Each Azure region is paired with another region within the same geography, together making a regional pair.


![Lrs, zrs, grs, gzrs ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lrs-grs-zrs-gzrs.jpg)

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
* *  Private: (Default) Prohibit anonymous access to the container and blobs.
* *  Blob: Allow anonymous public read access for the blobs only.
* *  Container: Allow anonymous public read and list access to the entire container, including the blobs.

#### Assign blob access tiers

Access tiers for blob data, including Hot, Cool, Archive, and Premium Blob Storage.

* Hot tier, frequent reads and writes of objects. (Default)

* Cool tier, data that's infrequently accessed (30 days), short-term backup and disaster recovery datasets and older media content.
* * This content shouldn't be viewed freq
uently, but it needs to be immediately available.
* * Cool tier is more cost-effective, but access more expensive then hot.

* Archive tier
* * Offline tier that's optimized for data that can tolerate several hours of retrieval latency.
* * Data must remain in the Archive tier for at least 180 days or be subject to an early deletion charge.
* * Secondary backups, original raw data, and legally required compliance information.
* * Most cost-effective option for storing data, accessing data is more expensive.

* Premium Blob Storage
* * Premium Blob Storage is best suited for I/O intensive workloads that require low and consistent storage latency. (SSD)
* * Workloads that perform many small transactions.

![Compare access tiers  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/compare-access-tiers.jpg)

Configure the blob access tier

* Can also change the blob access tier for your account at any time.

![Change access tiers  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/change-access-tiers.jpg)

#### Add blob lifecycle management rules

Azure Blob Storage supports lifecycle management for data sets. It offers a rich rule-based policy for:
* GPv2
* Blob Storage accounts.

Use lifecycle policy rules to transition your data to the appropriate access tiers, and set expiration times for the end of a data set's lifecycle.

#### Things to know about lifecycle management

* Transition blobs to a cooler storage tier (Hot to Cool, Hot to Archive, Cool to Archive) to optimize for performance and cost.
* Delete blobs at the end of their lifecycles.
* Define rule-based conditions to run once per day at the Azure storage account level.
* Apply rule-based conditions to containers or a subset of blobs.

#### Configure lifecycle management policy rules

![Blob lifecycle managment  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/blob-lifecycle-management.jpg)

Rule

* If: The If clause sets the evaluation clause for the policy rule.
* Then: The Then clause sets the action clause for the policy rule.

![Blob lifecycle managment add rule  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/blob-lifecycle-management-add-rule.jpg)

#### Determine blob object replication

Object replication copies blobs in a container asynchronously according to policy rules that you configure.

The following contents are copied from the source container to the destination container:

* The blob contents
* The blob metadata and properties
* Any versions of data associated with the blob

![Blob object replication  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/blob-object-replication.jpg)

#### Things to know about blob object replication

* Object replication requires that blob versioning is enabled on both the source and destination accounts.
* Object replication doesn't support blob snapshots. Any snapshots on a blob in the source account aren't replicated to the destination account.
* Object replication is supported when the source and destination accounts are in the Hot or Cool tier. The source and destination accounts can be in different tiers.
* When you configure object replication, you create a replication policy that specifies the source Azure storage account and the destination storage account.
* A replication policy includes one or more rules that specify a source container and a destination container

#### Upload blobs

Any type of data and any size file.

![Blob select type  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/blob-select-type.jpg)

Block blob (Default, after you create a blob, you can't change its type.)

* A block blob consists of blocks of data that are assembled to make a blob. 
* Ideal for storing text and binary data in the cloud, like files, images, and videos.

Append blob

* An append blob is similar to a block blob because the append blob also consists of blocks of data.
* Optimized for append operations,  logging scenarios.

Page blob

* A page blob can be up to 8 TB in size.
* More efficient for frequent read/write operations.
* Virtual Machines uses page blobs for operating system disks and data disks.

#### Things to consider when using blob upload tools

* Uploading blobs to your Azure storage account with Azure Storage Explorer (Common).
* AzCopy,  Windows and Linux, copy data to and from Blob Storage, across containers, and across storage accounts.
* Azure Data Box Disk, A service for transferring on-premises data to Blob Storage when large datasets or network constraints make uploading data over the wire unrealistic. (Get SSD from MS)
* Azure Import/Export, export large amounts of data from your storage account to hard drives that you provide and that Microsoft then ships back to you with your data.

#### Things to know about pricing for Blob Storage

* Performance tiers. The Blob Storage tier determines the amount of data stored and the cost for storing that data.(When tier gets cooler, per gb cost decreases)
* Data access costs. Data access charges increase as the tier gets cooler. 
* Transaction costs. There's a per-transaction charge for all tiers. The charge increases as the tier gets cooler.
* Geo-replication data transfer costs. This charge only applies to accounts that have geo-replication configured, including GRS and RA-GRS. 
* Outbound data transfer costs. Outbound data transfers (data that's transferred out of an Azure region)
* Changes to the storage tier. If you change the account storage tier from Cool to Hot, you incur a charge equal to reading all the data existing in the storage account. 
* * Changing the account storage tier from Hot to Cool incurs a charge equal to writing all the data into the Cool tier (GPv2 accounts only).

#### Interactive lab simulation

https://learn.microsoft.com/en-us/training/modules/configure-blob-storage/9-simulation-blobs

Task 1: Create a storage account.
* Create a storage account in your region with locally redundant storage.
* Verify the storage account was created.

Task 2: Work with blob storage.
* Create a private blob container.
* Upload a file to the container.

Task 3: Monitor the storage container.

* Review common storage problems and troubleshooting guides.

![Lab monitor Diagnose and solve problems  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-monitor-storage.jpg)


* Review insights for performance, availability, and capacity.

![Lab monitor Insights  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-monitor-storage-insight-1.jpg)



## Configure Azure Storage Security

The module concepts are covered in: Implement and manage storage (15–20%)

Secure storage
* Generate shared access signature (SAS) tokens
* Manage access keys
* Configure Azure Active Directory authentication for an Azure storage account

#### Create shared access signatures

A shared access signature (SAS) is a uniform resource identifier (URI) that grants restricted access rights to Azure Storage resources. 
SAS is a secure way to share your storage resources without compromising your account keys.

SAS provides account-level and service-level control.

Account-level SAS delegates access to resources in one or more Azure Storage services.

![SAS account  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/sas-account.jpg)

Service-level SAS delegates access to a resource in only one Azure Storage service.

![SAS container  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/sas-container.jpg)

#### Identify URI and SAS parameters

Done it in main

#### Configure Azure Storage encryption

In the Azure portal, you configure Azure Storage encryption by specifying the encryption type. 
You can manage the keys yourself, or you can have the keys managed by Microsoft.

#### Apply Azure Storage security best practices

If a SAS is compromised, it can be used by anyone who obtains it, including a malicious user.

If a SAS provided to a client application expires and the application is unable to retrieve a new SAS from your service, the application functionality might be hindered.

Recommendations for managing risks

* Always use HTTPS for creation and distribution
* Reference stored access policies where possible
* Set near-term expiry times for an unplanned SAS
* Require clients automatically renew the SAS
* Plan carefully for the SAS start time
* Define minimum access permissions for resources
* Understand account billing for usage, including a SAS
* Validate data written by using a SAS
* Don't assume a SAS is always the correct choice
* Monitor your applications with Azure Storage Analytics

https://learn.microsoft.com/en-us/training/modules/configure-storage-security/7-apply-best-practices

Stored access policy

https://learn.microsoft.com/en-us/rest/api/storageservices/define-stored-access-policy

The following storage resources support stored access policies:

* Blob containers
* File shares
* Queues
* Tables

![Stored access policy  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/stored-access-policy.jpg)

Generate SAS with policy

![Stored access policy SAS  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/stored-access-policy-sas.jpg)


#### Lab 07 - Manage Azure Storage

https://github.com/MicrosoftLearning/AZ-104-MicrosoftAzureAdministrator/blob/master/Instructions/Labs/LAB_07-Manage_Azure_Storage.md

In this lab, you will:

* Task 1: Provision the lab environment
* Task 2: Create and configure Azure Storage accounts

Default

![Storage redundancy default  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-default-redundancy.jpg)

Read access + GRS
![Storage redundancy  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-redundancy.jpg)



* Task 3: Manage blob storage (after upload a file)

![Container blob edit tier  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-edit-tier.jpg)

* Task 4: Manage authentication and authorization for Azure Storage

![Container blob edit sas  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-sas.jpg)

* Generate SAS token and URL.
* Start date, yesterday's date

![Container blob url  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-url.jpg)

* Switch to the Azure AD User Account link next to the Authentication method label.

![Container blob AD  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-AD.jpg)

* click Access Control (IAM)


![Container blob AD IAM  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-AD-IAM.jpg)

* Add role assignment

![Container blob AD IAM Role  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-role.jpg)

* Verify AD

![Container blob AD IAM Role verify  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/lab-7-container-blob-AD-ok.jpg)

* Task 5: Create and configure an Azure Files shares
* Task 6: Manage network access for Azure Storage

Done it
https://follow-e-lo.com/2023/02/26/azure-lab-07-manage-azure-storage-5-min/

Do it again.

## Configure Azure Files and File Sync

The module concepts are covered in: Implement and manage storage (15–20%)

Configure Azure Files and Azure Blob Storage

* Create an Azure Files share
* Create and configure Azure File Sync

* SMB, 445
* Azure Files shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS.

##### Compare Azure Files to Blob Storage and Azure Disks

![ Compare Azure Files to Blob Storage and Azure Disks ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/compare-files-to-blob-and-disks.jpg)


Create file share snapshots

* Azure Files provides the capability to take share snapshots of file shares. 
* File share snapshots capture a point-in-time, read-only copy of your data.

![ Fileshare ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/fileshare.jpg)

Fileshare snapshot, delete and view / restore with snapshot

![ Fileshare Snapshot ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/fileshare-snapshot.jpg)

#### Azure File Sync components

Azure File Sync is composed of four main components that work together to provide caching for Azure Files shares on an on-premises Windows Server or cloud virtual machine.

![ File sync ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/file-sync.jpg)

* Storage Sync Service
* * The Storage Sync Service forms sync relationships with multiple storage accounts by using multiple sync groups.

* Sync group
* * A sync group defines the sync topology for a set of files. 

* Registered server
* Represents a trust relationship between your server (or cluster) and the Storage Sync Service resource.

* Azure File Sync agent
* * Azure File Sync agent is a downloadable package that enables Windows Server to be synced with an Azure Files share.
* * Three main components:
* * * 1. FileSyncSvc.exe, monitoring changes on server endpoints, and for initiating sync sessions to Azure.
* * * 2. StorageSync.sys, The filter is responsible for tiering files to Azure Files when cloud tiering is enabled. Cloud tiering archives infrequently access files to free up space on the local file share.
* * * 3. PowerShell cmdlets,  allow you to interact with the Microsoft.StorageSync Azure resource provider. You can find the cmdlets at the following (default) locations:
* * * * C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.PowerShell.Cmdlets.dll
* * * * C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.ServerCmdlets.dll

* Server endpoint
* A specific location on a registered server, such as a folder on a server volume. for example, F:\\sync1 and F:\\sync2).

* Cloud endpoint
* * A cloud endpoint is an Azure Files share that's part of a sync group.
* * An Azure Files share can be a member of one cloud endpoint only. (1 JUST 1)
* * An Azure Files share can be a member of one sync group only.  (1 JUST 1)

#### Deploy Azure File Sync

Step 1: Deploy the Storage Sync Service
Step 2: Prepare each Windows Server to use Azure File Sync
Step 3: Install the Azure File Sync agent
Step 4: Register each Windows Server with the Storage Sync Service
 (Cloud endpoint)
 (Server enpoint)

Note :A server (or cluster) can be registered with only one Storage Sync Service resource at a time.

## Configure Azure Storage with tools

The module concepts are covered in: Implement and manage storage (15–20%)

* Use Azure Storage Explorer
* * Work with Azure Storage data on Windows, macOS, and Linux

* Use the Azure Import/Export service
* * import large amounts of data to Azure Blob Storage and Azure Files by shipping disk drives to an Azure datacenter.

* Create an Azure Import job
1. Determine the number of disks needed to accommodate the data to transfer.
2. Identify the computer to use to perform the data copy, and attach the physical disks you intend to ship to Microsoft.
3. Install the WAImportExport tool on the disks
4. Run the WAImportExport tool to copy the data on the disks.
5. In the Azure portal, create an Azure Import job
6. Ship the required number of disks to the Azure region datacenter that hosts the storage account. Note the shipment tracking number.
7. Update the Import job to include the shipment tracking number.

* Create an Azure Export job
1. Identify the data in Azure Blob Storage to export.
2. Determine the number of disks needed to accommodate the data to transfer.
3. In the Azure portal, create an Azure Export job
4. Ship the required number of disks to the Azure region datacenter that hosts the storage account. Note the shipment tracking number.
5. Update the Export job to include the shipment tracking number.

* Use the AzCopy tool
* command-line utility for copying data to and from Azure Blob Storage and Azure Files.
* AzCopy is available on Windows, Linux, and macOS.
* * Azure Active Directory (Azure AD)
* * SAS tokens
* Azure Storage Explorer uses the AzCopy tool for all of its data transfers. 


## Create and Azure Storage account

#### What is Azure Storage?

![Azure storage  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/azure-storage.jpg)

Blobs, Files, Queues, and Tables are contained within storage accounts, while other services are not.

These four data services are all primitive, cloud-based storage services, and are often used together in the same application.

A storage account is a container that groups a set of Azure Storage services together.

#### Storage account settings

* Location: The datacenter that will store the services in the account.
* Performance:
* * 1. Standard allows you to have any data service (Blob, File, Queue, Table) and uses magnetic disk drives. (HDD)
* * 2. Premium provides more services for storing data. For example, storing unstructured object data as block blobs or append blobs, and specialized file storage used to store and create premium file shares. (SSD)
* Replication: Determines the strategy used to make copies of your data to protect against hardware failure or natural disaster.
* Access tier: Controls how quickly you will be able to access the blobs in a storage account. Hot gives quicker access than Cool, but at increased cost. Hot access tier applies only to blobs, and serves as the default value for new blobs.
* Secure transfer required: Enabled requires HTTPS, while disabled allows HTTP.
* Virtual networks: A security feature that allows inbound access requests only from the virtual network(s) you specify.


## Control access to Azure Storage with shared acess signatures

#### Access Azure Storage

Files stored in Azure Storage are accessed by clients over HTTP/HTTPS. Azure checks each client request for authorization to access stored data. 
Four options are available for blob storage:

* Public access

* Azure Active Directory (Azure AD)
* * Use this form of authentication if you're running an app with managed identities or using security principals.
* * First, you authenticate a security principal that returns an OAuth 2.0 token if successful. This token is then passed to Azure Storage to enable authorization to the requested resource.

* Shared key
* These keys grant anyone with access the equivalent of root access to your storage.

* Shared access signature (SAS)
* A SAS lets you grant granular access to files in Azure Storage, such as read-only or read-write access, expiration time, after which the SAS no longer enables the client to access the chosen resources.

#### How shared access signatures work

Done it

#### Use stored access policies to delegate access to Azure Storage


![Stored access policy  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/stored-access-policy.jpg)


## Upload, download, and manage data with Azure Storage Explorer

![Storage explorer  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Implement-and-manage-storage/storage-explorer.jpg)


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

6. Consider a scenario where data is frequently accessed in the early stages of the lifecycle, but only occasionally after two weeks. After the first month, the data set is rarely accessed.

In this scenario, the Hot tier of Blob Storage is best during the early stages. 
Cool tier storage is most appropriate for occasional access. 
Archive tier storage is the best option after the data ages over a month. 
To achieve this transition, lifecycle management policy rules are available to move aging data to cooler tiers.


7. What statement best describes Azure Blob Storage access tiers?

The administrator can switch between hot and cool performance tiers at any time.

8. Which of the following changes between access tiers happens immediately?

Changes between the hot and cool tiers, and to the archive tier, happen immediately

9. How would you describe blob object replication?

Any snapshots on a blob in the source account aren't replicated to the destination account.




