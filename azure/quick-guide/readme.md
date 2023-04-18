# Azure Administrator


## Description

Azure Administrator Cheat Sheet quick guide

Most questions will be on Virtual network and Storage

## Mount this in your brain, write it 3 times on paper.



### High level main roles :heavy_check_mark:


* Readers: Readers on Azure can see things in a Resource, Resource Group, or Subscription, but cannot change anything in any of these. This role is useful for people who are typically in an observer type role, such as an auditor. 

* Contributor: Contributors can do pretty much anything a Reader can do, but with the added ability to change resources. Contributors can create new resources.

* Owner: An Owner can do everything a Contributor can do with one additional ability, and that is the ability to assign roles to a Subscription, Resource Group, or Resource, depending on where the ownership role is set. 

![Main roles ](https://github.com/spawnmarvel/quickguides/blob/main/azure/quick-guide/main-roles2.jpg)



### Detail cost for each department :heavy_check_mark:

1. Assign a tag to each resource.
2. From Cost analysis blade, filter the view by tag
3. Download the usage report


![Cost tag filter ](https://github.com/spawnmarvel/quickguides/blob/main/azure/quick-guide/cost-tag-filter.jpg)

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


### Back up a virtual machine in Azure :heavy_check_mark:

1. Create a Recovery Services vault
2. Apply a backup policy
3. Select a VM to back up
4. Enable backup on a VM
5. Start a backup job


Azure backups can be created through the Azure portal. This method provides a browser-based user interface to create and configure Azure backups and all related resources.

https://learn.microsoft.com/en-us/azure/backup/quick-backup-vm-portal


### Recover files from Azure virtual machine backup :heavy_check_mark:

1. On VM open browser->Azure
2. Go to vault-> VM
3. Choose File recovery
4. Select recovery point
5. Download iaas.exe script
6. Click .exe add password
7. Mount
8. Robocopy or copy
9. Unmount

https://learn.microsoft.com/en-us/azure/backup/backup-azure-restore-files-from-vm


### Back up Windows Server to Azure :heavy_check_mark:

1. Create a Recovery Services vault
2. Download Recovery Service agent (Mars)
3. Install and register the agent
4. Configure backup and retention
5. Run on-demand backup

This tutorial describes how to back up on-premises Windows Server to Azure using the Microsoft Azure Recovery Services (MARS) agent.

https://learn.microsoft.com/en-us/azure/backup/tutorial-backup-windows-server-to-azure


### Recover files from Azure to a Windows Server :heavy_check_mark:

1. On VM, Open Azure Recovery Services (MARS) agent
2. Recover data on MS Azure Recovery service
3. Select recover mode-> files and folders
4. Select volume and date
5. Mount
6. Robocopy or copy
7. Unmount

https://learn.microsoft.com/en-us/azure/backup/tutorial-backup-restore-files-windows-server

### Set up disaster recovery for Azure VMs  :heavy_check_mark:

1. Create a Recovery Services vault, create a Recovery Services vault in any region, except in the source region from which you want to replicate VMs.
2. Enable Site Recovery, in the vault settings
3. Enable replication, select the source settings and enable VM replication.
4. Select the VMs
5. Review replication settings
6. Manage, Replication policy, Replication group

![Enable replication](https://github.com/spawnmarvel/quickguides/blob/main/azure/quick-guide/enable_replication.jpg)

https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-enable-replication


### Run a disaster recovery drill for Azure VMs :heavy_check_mark:

1. Check VM settings before the drill, in the vault > Replicated items, select the VM. check that the VM is protected and healthy.
2. Run a test failover, in Test Failover, choose a recovery point. The Azure VM in the target region is created using data from this recovery point.
3. Clean up after the drill

https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-dr-drill

### Fail over Azure VMs to a secondary region :heavy_check_mark:

Learn how to fail over Azure VMs that are enabled for disaster recovery with Azure Site Recovery, to a secondary Azure region. After failover, you reprotect VMs in the target region so that they replicate back to the primary region.

1. Verify the VM settings, check that the VM is protected and healthy, before you run a failover.
2. Run a failover, in Failover, choose a recovery point. The Azure VM in the target region is created using data from this recovery point.
3. Reprotect the VM, after failover, you reprotect the VM in the secondary region, so that it replicates back to the primary region
4. Make sure that VM Status is Failover committed


https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-failover-failback


### Delete an Azure Backup Recovery Services vault :heavy_check_mark:

1. Go to vault Overview, click Delete, and then follow the instructions to complete the removal of Azure Backup and Azure Site Recovery items for vault deletion as shown below
2. Disable the soft delete and Security features
3. Delete Cloud protected items
4. Delete Backup Servers
5. Unregister Storage Accounts if used
6. Remove Private Endpoints if used
7. Delete vault


https://learn.microsoft.com/en-us/azure/backup/backup-azure-delete-vault?tabs=portal#delete-a-recovery-services-vault


### Azure Network Watcher

1. Diagnose network traffic filtering problems to or from a VM, Use IP flow verify
2. Diagnose network routing problems from a VM, next hop
3. Diagnose outbound connections from a VM, Connection monitor also provides the minimum, average, and maximum latency observed over time. 
4. Capture packets to and from a VM, packet capture
5. The effective security rules for a network interface are a combination of all security rules applied to the network interface, and the subnet the network interface is in.
6. Network Monitoring Logs, The NSG flow log capability allows you to log the source and destination IP address, port, protocol, and whether traffic was allowed or denied by an NSG.

https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-monitoring-overview