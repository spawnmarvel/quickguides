# Project Title

Microsoft Certified: Azure Administrator Associate

## Description

Azure Administrator Cheat Sheet

#### Links

https://learn.microsoft.com/en-us/certifications/azure-administrator/


### AZ-104: Prerequisites for Azure administrators

* TBD
* TBD

### AZ-104: Manage identities and governance (15-20%)

* TBD
* TBD

### AZ-104: Implement and manage storage (15-20%)

* TBD
* TBD

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
* Default backup configuration is GEO-redundant (3 copies within singel location in primary region, then 3 copies within secondary location, 16 9's )
* Default security configuration is soft delete enabled
* Must be in same region as rg's


| VM Back Up | Steps | File and folder backup | Steps
| ---- | ----------- | ------- | -----------
| 1 | Recovery service vault is created | 1 | Recovery service vault created
| 2 | Go to backup                      | 2 | On VM, browse to Portal
| 3 | Choose VM Azure                   | 3 | Browse to vault backup on-prem and filed and folders
| 4 | Policy schedule for bck           | 4 | Install MARS agent
| 5 | Backup now                        | 5 | Download vault credentials and register server
| 6 |                                   | 6 | Launce MS Azure Recovery service
| 7 |                                   | 7 | Policy schedule for bck
| 8 |                                   | 8 | Backup now 


| VM recovery snapshop | Steps | File and folder recovery | Steps
| ---- | ----------- | ------- | -----------
| 1 | On vm | 1 | Recovery service vault created
| 2 | Go to backup                      | 2 | On VM, browse to Portal
| 3 | Choose VM Azure                   | 3 | Browse to vault backup on-prem and filed and folders
| 4 | Policy schedule for bck           | 4 | Install MARS agent
| 5 | Backup now                        | 5 | Download vault credentials and register server
| 6 |                                   | 6 | Launce MS Azure Recovery service
| 7 |                                   | 7 | Policy schedule for bck
| 8 |                                   | 8 | Backup now 



### ps1 / cli / aks / cmd

* TBD
* Step-by-step bullets

```
code blocks for commands
```