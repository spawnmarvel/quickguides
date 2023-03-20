# Microsoft Certified: Azure Administrator

Microsoft Certified: Azure Administrator

## Description

Azure Administrator Cheat Sheet

#### Links

Learn

https://learn.microsoft.com/en-us/certifications/azure-administrator/

Study Guide

https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104

Tips and Tricks to pass the Microsoft Azure AZ-104 Exam

https://www.testpreptraining.com/blog/tips-and-tricks-to-pass-the-microsoft-azure-az-104-exam/




### AZ-104: Prerequisites for Azure administrators

* TBD
* TBD

### AZ-104: Manage identities and governance (15-20%)

* TBD
* TBD

### AZ-104: Implement and manage storage (15-20%)

#### Configure access to storage
#### Manage data in Azure storage accounts
#### Configure Azure Files and Azure Blob Storage

##### Create an Azure file share

https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal%2Cproactive-portal

https://follow-e-lo.com/2023/02/26/azure-lab-07-manage-azure-storage-5-min/

##### Deploy Azure File Sync

Azure File Sync transforms Windows Server into a quick cache of your Azure file share.

| Azure File Sync | Steps 
| ---- | -------
| 1 | Deploy the storage sync service (Create a resource and then search for Azure File Sync.)
| 2 | Install the Azure File sync agent (Azure File Sync agent (downloadable package) enables Win Server to synced with Azure fileshare.)                 
| 3 | Register Windows server with Storage Sync Service (Establishes a trust relationship between your server (or cluster) and the Storage Sync Service)
| 4 | Create a sync group and clound endpoint (A sync group defines the sync topology for a set of files.)
| 5 | Create server endpoint (such as a folder on a server volume)
                                  




### AZ-104: Deploy and manage Azure compute resources (20-25%)

* TBD
* TBD

### AZ-104: Configure and manage virtual networking (20-25%)

* TBD
* TBD

### AZ-104: Monitor and back up Azure resources (10-15%)

#### Monitor resources by using Azure Monitor
#### Implement backup and recovery

* Create an Azure Recovery Services vault
* Create and configure backup policy
* Perform backup and restore operations by using Azure Backup

https://learn.microsoft.com/en-us/answers/questions/405915/what-is-difference-between-recovery-services-vault

https://follow-e-lo.com/2023/03/19/az-lab-10-backup-virtual-machines/


* Recovery service vault:
* * Default backup configuration is GEO-redundant (3 copies within singel location in primary region, then 3 copies within secondary location, 16 9's )
* * Default security configuration is soft delete enabled
* * Must be in same region as rg's

##### Backup

| VM Back Up | Steps | File and folder backup | Steps
| ---- | ----------- | ------- | -----------
| 1 | Recovery service vault is created | 1 | Recovery service vault created
| 2 | Go to backup                      | 2 | On VM -> browse to Portal
| 3 | Choose VM Azure                   | 3 | Browse to vault backup on-prem and filed and folders
| 4 | Policy schedule for bck           | 4 | Install MARS agent
| 5 | Backup now                        | 5 | Download vault credentials and register server
| 6 |                                   | 6 | Launce MS Azure Recovery service
| 7 |                                   | 7 | Policy schedule for bck
| 8 |                                   | 8 | Backup now 

##### Backup recovery

| VM recovery snapshop | Steps | File and folder recovery | Steps
| ---- | ----------- | ------- | -----------
| 1 | On VM open browser->Azure          | 1 | On VM open browser->Azure 
| 2 | Go to vault-> VM                   | 2 | Recover data on MS Azure Recovery service
| 3 | Choose File recovery               | 3 | Select recover mode-> files and folders
| 4 | Select recovery point              | 4 | Select volume and date
| 5 | Download iaas.exe script           | 5 | Mount
| 6 | Click .exe add password            | 6 | Robocopy
| 7 | Mount                              | 7 | Unmount
| 8 | Robocopy                           | 8 |  
| 9 | Unmount                            | 9 |


#### Configure Azure Site Recovery for Azure resources
#### Perform failover to a secondary region by using Azure Site Recovery
#### Configure and review backup reports


### ps1 / cli / aks / cmd

* TBD
* Step-by-step bullets

```
code blocks for commands
```