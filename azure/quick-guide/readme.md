# Azure Administrator


## Description

Azure Administrator Cheat Sheet quick guide

Most questions will be on Virtual network and Storage

## Mount this in your brain, write it 3 times on paper.


### Detail cost for each department :heavy_check_mark:

1. Assign a tag to each resource.
2. From Cost analysis blade, filter the view by tag
3. Download the usage report

https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json


### Deploy Azure File Sync :heavy_check_mark:

1. Deploy the Storage Sync Service
2. Install the Azure File Sync agent
3. Register Windows Server with Storage Sync Service
4. Create a sync group and a cloud endpoint
5. Create a server endpoint

Use Azure File Sync to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. 

https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal%2Cproactive-portal


### Transfer data to Azure Files with Azure Import/Export :heavy_check_mark:

1. Prepare the drives, driveset.csv
2. Create an import job, WAImportExport tool.
3. Ship the drives to the Azure datacenter
4. Update the job with tracking information
5. Verify data upload to Azure

This article provides step-by-step instructions on how to use the Azure Import/Export service to securely import large amounts of data into Azure Files.

https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-files?tabs=azure-portal-preview


### Live migration storage account

When planning to change your replication settings, consider the following limitations related to the storage account type.

![Live migration ](https://github.com/spawnmarvel/quickguides/blob/main/azure/quick-guide/live-migration.jpg)

https://learn.microsoft.com/en-us/azure/storage/common/redundancy-migration?tabs=portal#limitations-for-changing-replication-types



### Back up a virtual machine in Azure :heavy_check_mark:

1. Create a Recovery Services vault
2. Apply a backup policy
3. Select a VM to back up
4. Enable backup on a VM
5. Start a backup job


Azure backups can be created through the Azure portal. This method provides a browser-based user interface to create and configure Azure backups and all related resources.

https://learn.microsoft.com/en-us/azure/backup/quick-backup-vm-portal


### Back up Windows Server to Azure :heavy_check_mark:

1. Create a Recovery Services vault
2. Download Recovery Service agent (Mars)
3. Install and register the agent
4. Configure backup and retention
5. Run on-demand backup

This tutorial describes how to back up on-premises Windows Server to Azure using the Microsoft Azure Recovery Services (MARS) agent.

https://learn.microsoft.com/en-us/azure/backup/tutorial-backup-windows-server-to-azure


### Configure VM availability options SLA :heavy_check_mark:


![Vm avaliability options](https://github.com/spawnmarvel/quickguides/blob/main/azure/quick-guide/vm-availability-options.jpg)

https://learn.microsoft.com/en-us/azure/virtual-machines/availability

### Availability set :heavy_check_mark:

Each virtual machine in your availability set is assigned an update domain and a fault domain by the underlying Azure platform. 

Each availability set can be configured with up to three fault domains and twenty update domains. 

When more than five virtual machines are configured within a single availability set with five update domains, the sixth virtual machine is placed into the same update domain as the first virtual machine, the seventh in the same update domain as the second virtual machine, and so on. 

Only one update domain is rebooted at a time.

Fault domains define the group of virtual machines that share a common power source and network switch. By default, the virtual machines configured within your availability set are separated across up to three fault domains.


![Vm avaliability options](https://github.com/spawnmarvel/quickguides/blob/main/azure/quick-guide/availability-fault-and-update-domain.jpg)


https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview


### Scale Sets :heavy_check_mark:

Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. Scale sets provide the following key benefits:

* Easy to create and manage multiple VMs
* Provides high availability and application resiliency by distributing VMs across availability zones or fault domains
* Allows your application to automatically scale as resource demand changes
* Works at large-scale


https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview
