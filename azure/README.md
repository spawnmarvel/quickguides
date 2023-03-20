# Microsoft Certified: Azure Administrator

Microsoft Certified: Azure Administrator

## Description

Azure Administrator Cheat Sheet

## Links

Learn

https://learn.microsoft.com/en-us/certifications/azure-administrator/

Study Guide

https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104

Tips and Tricks to pass the Microsoft Azure AZ-104 Exam

https://www.testpreptraining.com/blog/tips-and-tricks-to-pass-the-microsoft-azure-az-104-exam/




## AZ-104: Prerequisites for Azure administrators

* TBD
* TBD

## AZ-104: Manage identities and governance (15-20%)

### Manage Azure AD objects

Create users and groups

Manage licenses in Azure AD

Create administrative units

Manage user and group properties

Manage device settings and device identity

Perform bulk updates

Manage guest accounts

Configure self-service password reset

https://follow-e-lo.com/2023/03/15/az-lab-add-your-custom-domain-name-to-azure-ad/


### Manage access control

Create custom role-based access control (RBAC) and Azure AD roles

Provide access to Azure resources by assigning roles at different scopes

Interpret access assignments

### Manage Azure subscriptions and governance

Configure and manage Azure Policy

Configure resource locks

Apply and manage tags on resources

Manage resource groups

Manage subscriptions

Manage costs by using alerts, budgets, and recommendations

Configure management groups

## AZ-104: Implement and manage storage (15-20%)

### Configure access to storage

Configure network access to storage accounts

Create and configure storage accounts

Generate shared access signature tokens

Configure stored access policies

Manage access keys

Configure Azure AD authentication for a storage account

Configure storage encryption

### Manage data in Azure storage accounts

Create import and export jobs

Manage data by using Azure Storage Explorer and AzCopy

Implement Azure Storage redundancy

Configure object replication

### Configure Azure Files and Azure Blob Storage

#### Create an Azure file share

https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal%2Cproactive-portal

https://follow-e-lo.com/2023/02/26/azure-lab-07-manage-azure-storage-5-min/

Configure Azure Blob Storage

Configure storage tiers

Configure blob lifecycle management

#### Deploy Azure File Sync

Azure File Sync transforms Windows Server into a quick cache of your Azure file share.

| Azure File Sync | Steps 
| ---- | -------
| 1 | Deploy the storage sync service (Create a resource and then search for Azure File Sync.)
| 2 | Install the Azure File sync agent (Azure File Sync agent (downloadable package) enables Win Server to synced with Azure fileshare.)                 
| 3 | Register Windows server with Storage Sync Service (Establishes a trust relationship between your server (or cluster) and the Storage Sync Service)
| 4 | Create a sync group and clound endpoint (A sync group defines the sync topology for a set of files.)
| 5 | Create server endpoint (such as a folder on a server volume)
                                  

## AZ-104: Deploy and manage Azure compute resources (20-25%)

### Automate deployment of resources by using templates

Modify an ARM template

Deploy a template

Save a deployment as an ARM template

#### Deploy virtual machine (VM) extensions

https://follow-e-lo.com/2023/03/18/az-lab-08-manage-virtual-machines/

### Create and configure VMs

Create a VM

Manage images by using the Azure Compute Gallery

Configure Azure Disk Encryption

#### Move VMs from one resource group to another

* A virtual machine that is integrated with a key vault to implement Azure Disk Encryption for Linux VMs or Azure Disk Encryption for Windows VMs can be moved to another resource group when it is in deallocated state.
* 

https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations?tabs=azure-cli

Manage VM sizes

Add data disks

Configure VM network settings

Configure VM availability options

#### Deploy and configure VM scale sets

https://follow-e-lo.com/2023/03/18/az-lab-08-manage-virtual-machines/



###  Create and configure containers

Configure sizing and scaling for Azure Container Instances

Configure container groups for Azure Container Instances

Create and configure Azure Container Apps

Configure storage for Azure Kubernetes Service (AKS)

Configure scaling for AKS

Configure network connections for AKS

Upgrade an AKS cluster

###  Create and configure an Azure App Service

Create an App Service plan

Configure scaling settings in an App Service plan

Create an App Service

Secure an App Service

Configure custom domain names

Configure backup for an App Service

Configure networking settings

Configure deployment settings

## AZ-104: Configure and manage virtual networking (20-25%)

### Configure virtual networks

#### Create and configure virtual networks and subnets
#### Create and configure virtual network peering

https://follow-e-lo.com/2023/03/11/azure-lab-05-implement-intersite-connectivity/

#### Configure private and public IP addresses

https://follow-e-lo.com/2023/03/07/azure-lab-04-implement-virtual-networking/

#### Configure user-defined network routes

https://follow-e-lo.com/2023/03/17/azure-lab-06-implement-traffic-management/

#### Configure Azure DNS

https://follow-e-lo.com/2023/03/07/azure-lab-04-implement-virtual-networking/


### Configure secure access to virtual networks

Create and configure network security groups (NSGs) and application security groups (ASGs)

Evaluate effective security rules

Implement Azure Bastion

Configure service endpoints on subnets

Configure private endpoints

### Configure load balancing

#### Configure Azure Application Gateway

https://follow-e-lo.com/2023/03/17/azure-lab-06-implement-traffic-management/

Configure an internal or public load balancer

Troubleshoot load balancing

### Monitor virtual networking

Monitor on-premises connectivity

Configure and use Azure Monitor for networks

#### Use Azure Network Watcher

| Type | Description | Info
| ---- | ------------| -------
| Connection Monitor                | Monitor connectivity and latency between a VM and another network resource.                  | 
| IP Flow                           | Allows you to detect traffic filtering issues at a VM level.                                 |  Protocol, local IP, remote IP, local port, and a remote port.
| Next Hop                          | Helps you verify traffic routes and detect routing issues.                                   |
| Connection Troubleshoot           | Enables a one-time connectivity and latency check between a VM and another network resource  | 
| Packet Capture                    | Enables you to capture all traffic on a VM in your virtual network.                          | 

https://follow-e-lo.com/2023/02/11/azure-network-watcher/

Troubleshoot external networking

Troubleshoot virtual network connectivity

## AZ-104: Monitor and back up Azure resources (10-15%)

### Monitor resources by using Azure Monitor

Configure and interpret metrics

Configure Azure Monitor Logs

Query and analyze logs

https://follow-e-lo.com/2023/01/28/5-min-azure-functions-compute-with-powershell-log-analytics-workspace/

Set up alerts and actions

Configure monitoring of VMs, storage accounts, and networks by using VM insights

### Implement backup and recovery

### Create an Azure Recovery Services vault

Create an Azure Backup vault

#### Create and configure backup policy
#### Perform backup and restore operations by using Azure Backup

https://learn.microsoft.com/en-us/answers/questions/405915/what-is-difference-between-recovery-services-vault

https://follow-e-lo.com/2023/03/19/az-lab-10-backup-virtual-machines/


* Recovery service vault:
* * Default backup configuration is GEO-redundant (3 copies within singel location in primary region, then 3 copies within secondary location, 16 9's )
* * Default security configuration is soft delete enabled
* * Must be in same region as rg's

#### Backup

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

#### Backup recovery

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


Configure Azure Site Recovery for Azure resources

Perform failover to a secondary region by using Azure Site Recovery

Configure and review backup reports


### ps1 / cli / aks / cmd

* TBD
* Step-by-step bullets

```
code blocks for commands
```