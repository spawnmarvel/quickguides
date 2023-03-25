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
* Hard work, work with Azure, repeat stuff, words, concepts and steps.

## AZ-104: Prerequisites for Azure administrators


| Type or # | Description | How | Responsibility
| ---- | ------------| ------- | -------------
| IAAS | IaaS places the most responsibility on the consumer, with the cloud provider being responsible for the basics of physical security, power, and connectivity. | Msts, RDP | You most 70%
| PAAS | PaaS, being a middle ground between IaaS and SaaS, rests somewhere in the middle and evenly distributes responsibility between the cloud provider and the consumer. | Connection string | Middle you and cloud 50-50 %
| SAAS | On the other end of the spectrum, SaaS places most of the responsibility with the cloud provider. | Login | Cloud 70%
| Data | Information and data, Devices that are allowed to connect, Accounts and identities. | | You 100%
| Infrastructure | Physical datacenter, physical network, physical hosts. | | Cloud 100%
| CLI | The CLI is cross-platform and can be installed on Linux, macOS, and Windows. | |
| PS1 | On both Linux and macOS, you'll use a package manager to install PowerShell Core. On macOS, you'll use Homebrew to install PowerShell. | |
| ARM Template | JSON file that defines the infrastructure and configuration for the deployment. Templates declare what will be deployed without having to write the sequence of programming commands to create it.  | |
| Idempotent | What happens if the same template is run a second time?  | | 
| 1. | If the resource already exists and no change is detected in the properties, no action is taken. | |
| 2. | If the resource already exists and a property has changed, the resource is updated. | | 
| 3. |If the resource doesn't exist, it's created. ||
| Geography   | a discrete market, typically containing 2+ regions, that preserves data residency and compliance boundaries. | |
| Azure region  | a set of datacenters deployed within a latency-defined perimeter and connected through a dedicated regional low-latency network | |
| Region pair   | each Azure region is paired with another region within the same geography. | |
| Availability zone | a physically separate location within an Azure region. Each AZ is made up of 1+ datacenters with independent power, cooling, and networking.|  |
| Availability   | recoverability and protection from system failures, natural disasters or malicious attacks. |   |
| RPO  | Recovery point objective (RPO) - the amount of data which can be lost while bringing the system back online after a critical failure, i.e. the point in time to which the data can be recovered.|  |
| RTO   | Recovery time objective (RTO) - the amount of time that it takes to get the system back online after a critical failure, i.e. how long you can sustain a service interruption before you absolutely need to be back online. | |
|     | https://techcommunity.microsoft.com/t5/azure-storage-blog/understanding-azure-storage-redundancy-offerings/ba-p/1431700 | |
| LRS | Locally redundant storage (LRS) replicates your storage account three times within a single data center in the primary region | 99.999999999%  | 11 nines
| ZRS |  Zone-redundant storage (ZRS) replicates your storage account synchronously across three Azure availability zones in the primary region. | 99.9999999999% | 12 9's
| GRS | Geo-Redundant Storage (GRS) is like the LRS option, but it adds a secondary region for durability. | 9.9999999999999999 | 16 9's
| GZRS | Geo-Zone-Redundant Storage (GZRS) protects your data by copying it to three availability zones in the primary region using ZRS. It then replicates data asynchronously to a single data center in the secondary region using LRS. | |
| RA-GRS | Read-Access Geo-Redundant Storage (RA-GRS) is almost the same as GRS, but it provides read-only access to data in the secondary region during an outage in the primary region. | |
| | https://tutorialsdojo.com/azure-storage-redundancy-options/ | |
| SLA | https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/business-metrics | 99% = 1.68 h, 99.999% = 6 sec week |

#### More fun

| Term | Description | Note |
| -----| ------------ | --
| Tenant | A tenant represents an organization. Each Azure AD tenant is distinct and separate from other Azure AD tenants. | |
|  *    | An organization can have multiple subscriptions | https://learn.microsoft.com/en-us/microsoft-365/enterprise/subscriptions-licenses-accounts-and-tenants-for-microsoft-cloud-offerings?view=o365-worldwide |
|   *   | Licenses can be assigned to individual user accounts | 
|  *    | User accounts are stored in an Azure AD tenant |
| Subscription | An Azure Subscription is a logical container for your resources. Each Azure resource is associated with only one subscription. |  Cost/Billing: If you want to view other subscriptions, you'll have to switch to that specific tenant.


#### ps1 / cli

* TBD
* Step-by-step bullets

```
Get 
# : Retrieves information about a resource or object. 
# For example, Get-AzResourceGroup retrieves information about a specific resource group.

Set 
# : Modifies the properties of an existing resource or object. 
# For example, Set-AzVM modifies the properties of an existing virtual machine.

New 
# : Creates a new resource or object. 
# For example, New-AzResourceGroup creates a new resource group.

Remove 
# : Deletes an existing resource or object. 
# For example, Remove-AzResourceGroup deletes a specific resource group.

Start, Stop, Restart, Suspend, Resume # 
```

#### Get started with AzCopy
AzCopy is a command-line utility that you can use to copy blobs or files to or from a storage account.


```
azcopy copy	
# Copies source data to a destination location

azcopy login
# Logs in to Azure Active Directory to access Azure Storage resources.

azcopy make	
# Creates a container or file share.

# There is a requirement to copy a virtual machine image to a container named tdimage from your on-premises datacenter. You need to provision an Azure Container instance to host the container image.

AzCopy make "url.core.windows.net" blob

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#transfer-data

```
#### Transfer data with AzCopy and file storage

```

azcopy copy '<local-file-path>' 'https://<storage-account-name>.file.core.windows.net/<file-share-name>/<file-name><SAS-token>'
# Upload a file

azcopy copy '<local-directory-path>' 'https://<storage-account-name>.file.core.windows.net/<file-share-name><SAS-token>' --recursive
# Upload a directory

azcopy copy '<local-directory-path>' 'https://<storage-account-name>.file.core.windows.net/<file-share-or-directory-name><SAS-token>' --include-path <semicolon-separated-file-list>
# Upload specific files

azcopy copy 'https://<storage-account-name>.file.core.windows.net/<file-share-name>/<file-path><SAS-token>' '<local-file-path>'
# Download a file

```
https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files

## 
## Skills measured
Manage Azure identities and governance (15–20%) :round_pushpin:

Implement and manage storage (15–20%) :round_pushpin:

Deploy and manage Azure compute resources (20–25%) :triangular_flag_on_post:

Configure and manage virtual networking (20-25%) :triangular_flag_on_post:

Monitor and maintain Azure resources (10–15%) :small_red_triangle:


## AZ-104: Manage identities and governance (15-20%)

### Manage Azure AD objects

Create users and groups

##### MFA

* The recommended way to enable and use Azure AD Multi-Factor Authentication is with Conditional Access policies.
* Conditional Access policies can be applied to specific users, groups, and apps.

https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-azure-mfa


* Enable cloud sync self-service password reset writeback to an on-premises environment
* With Azure Active Directory (Azure AD) self-service password reset (SSPR), users can update their password or unlock their account using a web browser.

https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-sspr-writeback



Manage licenses in Azure AD

Create administrative units

Manage user and group properties

* You need to grant several users that must belong to the same Azure group temporary access to the Microsoft SharePoint document library. 
* The group must automatically be deleted after 180 days for compliance purposes.
* * Set up a dynamic membership on Microsoft 365 groups.
* * Set up an assigned membership on Microsoft 365 groups.
* * Set up an assigned membership on security groups and Set up a dynamic membership on security groups are incorrect because security groups can only be used for devices or users and not for groups.

| Role | Description | Note
| ---- | ----------- | -----
| Contributor| Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries. | Example: Classic Virtual Machine Contributor, CDN Endpoint Contributor, Network Contributor
|  Owner    | Grants full access to manage all resources, including the ability to assign roles in Azure RBAC.
|  Reader    | View all resources, but does not allow you to make any changes. | Example: Disk Backup Reader, Backup Reader, Storage Blob Data Reader
|   User Access Administrator   | Lets you manage user access to Azure resources.
| Operator |  Lets you manage backup services, except removal of backup, vault creation and giving access to others  | Example: Backup Operator
|Cloud device administrator |Can enable, disable, and delete devices in Azure AD. The role does not grant permission to manage any other properties on the device. |
|Security administrator | has permissions to manage security-related features in the Microsoft 365 security center, Azure Active Directory Identity Protection, Azure Active Directory Authentication, Azure Information Protection, and Office 365 Security & Compliance Center.|


https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles



Manage device settings and device identity

* You plan to add a local administrator to manage all the computers and devices that will join your domain?
* * Configure the settings

##### Perform bulk updates

https://follow-e-lo.com/2023/02/06/azure-manage-azure-active-directory-identities/

Manage guest accounts

Configure self-service password reset

https://follow-e-lo.com/2023/03/15/az-lab-add-your-custom-domain-name-to-azure-ad/


### Manage access control

Create custom role-based access control (RBAC) and Azure AD roles

#### Provide access to Azure resources by assigning roles at different scopes

* 4 scopes
* * Broad to narrow: management group, subscription, resource group, and resource.

https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal

Interpret access assignments

### Manage Azure subscriptions and governance

Configure and manage Azure Policy

* Policy
* With an initiative definition, you can group several policy definitions to achieve one overarching goal. 

https://follow-e-lo.com/2023/02/07/azure-management-groups/


#### Configure resource locks

* You can use delete locks to block the deletion
* * virtual machines, subscriptions and resource groups

* Types of Resource Locks
* * Delete means authorized users can still read and modify a resource, but they can’t delete the resource.
* * ReadOnly, The resource group is read only and tags on the resource group can’t be modified.

* To modify a locked resource, you must first remove the lock. After you remove the lock, you can apply any action you have permissions to perform. 
* * Resource locks apply regardless of RBAC permissions.

https://follow-e-lo.com/2022/12/20/az-900-fundamentals/



#### Apply and manage tags on resources

Done it

#### Manage resource groups

Done it

#### Manage subscriptions

Manage costs by using alerts, budgets, and recommendations

#### Configure management groups

* Management groups provide a governance scope above subscriptions. 
* Policy
* With an initiative definition, you can group several policy definitions to achieve one overarching goal. 

https://follow-e-lo.com/2023/02/07/azure-management-groups/

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

* Versioning must be enabled for both the source and destination accounts.


### Configure Azure Files and Azure Blob Storage

#### Create an Azure file share

https://follow-e-lo.com/2023/02/26/azure-lab-07-manage-azure-storage-5-min/

Configure Azure Blob Storage

* Encryption scope enables you to manage encryption at the level of an individual blob or container. 
* You can use encryption scopes to create secure boundaries between data that resides in the same storage account but belongs to different customers.
* https://learn.microsoft.com/en-us/azure/storage/blobs/encryption-scope-overview

Configure storage tiers

* Type of storage account, Supported storage services, Redundancy options and usage

![Storage account over view ](https://github.com/spawnmarvel/quickguides/blob/main/azure/storage-overview.jpg)

https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview

Configure blob lifecycle management

#### Deploy Azure File Sync

Azure File Sync transforms Windows Server into a quick cache of your Azure file share.
* Azure File Sync will not overwrite any files in your endpoints. 
* It will simply append a conflict number to the filename of the older file, while the most recent change will retain the original file name.

![Implement Azure File Sync manually ](https://github.com/spawnmarvel/quickguides/blob/main/azure/az-file-sync.jpg)

https://learn.microsoft.com/en-us/training/modules/implement-hybrid-file-server-infrastructure/6-implement-azure-file-synchronization


| Azure File Sync | Steps 
| ---- | -------
| 1 | Deploy the storage sync service (Create a resource and then search for Azure File Sync.)
| 2 | Install the Azure File sync agent (Azure File Sync agent (downloadable package) enables Win Server to synced with Azure fileshare.)                 
| 3 | Register Windows server with Storage Sync Service (Establishes a trust relationship between your server (or cluster) and the Storage Sync Service)
| 4 | Create a sync group and clound endpoint (A sync group defines the sync topology for a set of files.)
| 5 | Create server endpoint (such as a folder on a server volume)

https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide?tabs=azure-portal%2Cproactive-portal
                                  

## AZ-104: Deploy and manage Azure compute resources (20-25%)

### Automate deployment of resources by using templates

Modify an ARM template

Deploy a template

Save a deployment as an ARM template

#### Deploy virtual machine (VM) extensions

https://follow-e-lo.com/2023/03/18/az-lab-08-manage-virtual-machines/

### Create and configure VMs

#### Create a VM

* Done it 100 times

* You need to use VM1 as a template to create a new Azure virtual machine. Which three methods can you use to complete the task?
* * From RG source, select Export template, select download, and then, from Azure Cloud Shell run the New-AzResourceGroupDeployment
* * From Azure Cloud Shell, run the Save-AzDeploymentTemplate and New-AzResourceGroupDeployment cmd
* * From VM Source, select Export template, and then select Deploy

* You need to move the virtual machine to a different host to avoid a service interruption?
* * Redeploy the VM

* You have Virtual machine, Virtual network, Recovery Services vault, and Storage account and plan to move all?
* * Take note that when you move a resource to a new resource group or subscription, the location of the resource won’t change.
* * Virtual machine, Virtual network, Recovery Services vault, and Storage account can be moved.
* * https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription#checklist-before-moving-resources

#### Manage images by using the Azure Compute Gallery

* An Azure Compute Gallery helps you build structure and organization around your Azure resources, like images and applications
* Create a gallery for storing and sharing resources
* https://learn.microsoft.com/en-us/azure/virtual-machines/create-gallery?tabs=portal%2Cportaldirect%2Ccli2


https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery

#### Configure Azure Disk Encryption


* Azure Disk Encryption for Windows VMs
* * BitLocker
* * Integrated with Azure Key Vault (manage the disk encryption keys and secrets.)

https://learn.microsoft.com/en-us/azure/virtual-machines/windows/disk-encryption-overview

* Azure Disk Encryption for Linux VMs
* * DM-Crypt
* * Integrated with Azure Key Vault (manage the disk encryption keys and secrets.)

https://learn.microsoft.com/en-us/azure/virtual-machines/linux/disk-encryption-overview



#### Move VMs from one resource group to another

* A virtual machine that is integrated with a key vault to implement Azure Disk Encryption for Linux VMs or Azure Disk Encryption for Windows VMs can be moved to another resource group when it is in deallocated state.


https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations?tabs=azure-cli

#### Manage VM sizes

* Change the VM size
* Pick a new size from the list of available sizes and then select Resize.
* If the virtual machine is currently running, changing its size will cause it to restart.
* You can't resize a VM size that has a local temp disk to a VM size with no local temp disk and vice versa.

https://learn.microsoft.com/en-us/azure/virtual-machines/resize-vm?tabs=portal

#### Add data disks

* On the Virtual machine pane, select Disks.
* On the Disks pane, select Create and attach a new disk. 
* Make disk selection
* Select Save to create and attach the new data disk to the VM.

Initialize a new data disk

* On vm, diskmgt
* Select the new disk, initialize disk
* Disk is now unallocated, click it and New simple volume and close diskmgt
* Format disk, start it and erase all, name the volume.

https://learn.microsoft.com/en-us/azure/virtual-machines/windows/attach-managed-disk-portal

Configure VM network settings

Configure VM availability options

#### Deploy and configure VM scale sets

* A proximity placement group is a logical grouping used to make sure that Azure compute resources are physically located close to each other. 
* Proximity placement groups are useful for workloads where low latency is a requirement. 
* When you assign your virtual machines to a proximity placement group, the virtual machines are placed in the same data center, 
* resulting in lower and deterministic latency for your applications.
* https://learn.microsoft.com/en-us/azure/virtual-machines/windows/proximity-placement-groups-portal

https://follow-e-lo.com/2023/03/18/az-lab-08-manage-virtual-machines/



###  Create and configure containers

Configure sizing and scaling for Azure Container Instances

Configure container groups for Azure Container Instances

Create and configure Azure Container Apps

Configure storage for Azure Kubernetes Service (AKS)

#### Configure scaling for AKS

* A Pod always runs on a Node.
* A Node is a worker machine in Kubernetes and may be either a virtual or a physical machine, depending on the cluster. Each Node is managed by the control plane

* Register-AzResourceProvider -ProviderNamespace Microsoft.Kubernetes
* Register-AzResourceProvider -ProviderNamespace Microsoft.KubernetesConfiguration

https://follow-e-lo.com/2023/03/20/az-lab-09c-implement-azure-kubernetes-service/

#### ps1 / cli / aks / cmd

* TBD
* Step-by-step bullets

```
# The following example creates an AKS cluster with a single node pool backed by a virtual machine scale set. 
# It also enables the cluster autoscaler on the node pool for the cluster and sets a minimum of 1 and maximum of 3 nodes:

# First create a resource group
az group create --name myResourceGroup --location eastus

# Now create the AKS cluster and enable the cluster autoscaler
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --node-count 1 \
  --vm-set-type VirtualMachineScaleSets \
  --load-balancer-sku standard \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3


# To enable and configure the cluster autoscaler on the node pool for the existing cluster
az aks update \ 
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --enable-cluster-autoscaler \ # Use the --enable-cluster-autoscaler
  --min-count 1 \ # specify a node --min-count
  --max-count 3   # specify a node --max-count

# To change the node count, use the az aks update command.
az aks update \ 
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --update-cluster-autoscaler \
  --min-count 1 \
  --max-count 5

# From the Cloud Shell pane, and run the following to scale the deployment by increasing of the number of pods to 2:
kubectl scale --replicas=2 deployment/nginx-deployment

kubectl get pods

NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-85c6d5f6dd-p4b29   1/1     Running   0          23s
nginx-deployment-85c6d5f6dd-xrbhp   1/1     Running   0          9m29s

# From the Cloud Shell pane, run the following to scale out the cluster by increasing the number of nodes to 2:

az aks scale --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --node-count 2

kubectl get nodes

NAME                                STATUS   ROLES   AGE     VERSION
aks-agentpool-37282351-vmss000000   Ready    agent   28m     v1.24.6
aks-agentpool-37282351-vmss000001   Ready    agent   2m58s   v1.24.6

# From the Cloud Shell pane, run the following to scale the deployment:

kubectl scale --replicas=10 deployment/nginx-deployment


nginx-deployment-85c6d5f6dd-lqvdj   1/1     Running   0          26s
nginx-deployment-85c6d5f6dd-nrc9n   1/1     Running   0          26s
nginx-deployment-85c6d5f6dd-p4b29   1/1     Running   0          10m
nginx-deployment-85c6d5f6dd-pbxqk   1/1     Running   0          26s
nginx-deployment-85c6d5f6dd-prqw8   1/1     Running   0          26s
nginx-deployment-85c6d5f6dd-tcrjs   1/1     Running   0          26s
nginx-deployment-85c6d5f6dd-wmjn8   1/1     Running   0          26s
nginx-deployment-85c6d5f6dd-xrbhp   1/1     Running   0          19m
nginx-deployment-85c6d5f6dd-zxvgf   1/1     Running   0          26s

```

https://learn.microsoft.com/en-us/azure/aks/cluster-autoscaler


* You have an Azure subscription that contains an Azure Kubernetes Service (AKS) cluster named AKS1. The autoscaling feature is enabled.
* You need to configure the minimum and maximum node counts for AKS1.
* Set-AzAKsCluster
* * Set-AzAKsCluster: Configures minimum and maximum node values for AKS autoscaling
* * Update-AzAksNodePool: Updates a node pool in a managed cluster


#### Configure network connections for AKS

* You can connect to and expose applications internally or externally.
* You can build highly available applications by load balancing your applications.

From the Cloud Shell pane, run the following to make the pod available from Internet:

#### ps1 / cli / aks / cmd
```
kubectl create deployment nginx-deployment --image=nginx
# From the Cloud Shell pane, run the following to deploy the nginx image from the Docker Hub:

kubectl expose deployment nginx-deployment --port=80 --type=LoadBalancer
# service/nginx-deployment exposed

```

https://learn.microsoft.com/en-us/azure/aks/concepts-network



Upgrade an AKS cluster

#### ps1 / cli / aks / cmd

* TBD
* Step-by-step bullets

```
code blocks for commands
```

###  Create and configure an Azure App Service

##### Create an App Service plan

* 1 For Windows (so Windows is the only alternative if using ASP.NET)
* 1 For Linux (.Net core, Pyton, Ruby, PHP etc)

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

| # | Comment | Note
|-- | -- | ---
| Subnet address range | The range must be unique within the address space and can't overlap with other subnet address ranges in the virtual network. You must specify the address space by using Classless Inter-Domain Routing (CIDR) notation. | For example, in a virtual network with address space 10.0.0.0/16, you might define a subnet address space of 10.0.0.0/22
| Address space 10.50.0.0/24 | Address range 10.50.0.0 - 10.50.0.255 | Address count 256 |
| | subnet31 | 10.50.0.0/27, IP's 27
| | subnet95 | 10.50.0.64/27 , IP's 27
| Address space 10.0.0.0/16  | Address range 10.0.0.0 - 10.0.255.255  |Address count 65536
| | default | 10.0.0.0/28, IP's 11
| | pass-subnet | 10.0.1.0/28, IP's 11
| | vm-subnet |  10.0.2.0/28, IP's 11


https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet?tabs=azure-portal#add-a-subnet


You need to connect your on-premises network to Azure by using a site-to-site VPN.
* Which four actions should you perform in sequence?

| Steps | Description
| --- |------
| 1   | Deploy a gateway subnet
| 2   | Deploy a VPN gateway
| 3   | Deploy a local network gateway
| 4   | Deploy a VPN Connection


#### Create and configure virtual network peering

https://follow-e-lo.com/2023/03/11/azure-lab-05-implement-intersite-connectivity/

#### Configure private and public IP addresses

https://follow-e-lo.com/2023/03/07/azure-lab-04-implement-virtual-networking/

#### Configure user-defined network routes

https://follow-e-lo.com/2023/03/17/azure-lab-06-implement-traffic-management/

#### Configure Azure DNS

https://follow-e-lo.com/2023/03/07/azure-lab-04-implement-virtual-networking/


### Configure secure access to virtual networks

#### Create and configure network security groups (NSGs) and application security groups (ASGs)

##### NSG / ASG

| Field | Description | Note
| --- |---------------| ---
| Name | Unique |
| Priority | A number between 100 and 4096. Rules are processed in priority order, with lower numbers processed before higher numbers, because lower numbers have higher priority. | Once traffic matches a rule, processing stops.
| Source or destination | Any, or an individual IP address, classless inter-domain routing (CIDR) block (10.0.0.0/24, for example), service tag, or application security group | 
| Protocol | TCP, UDP, ICMP, ESP, AH, or Any. |
|Direction | Rule applies to inbound, or outbound traffic.|
| Port range |specify 80 or 10000-10005. |
| Action | Allow or deny |


* Default security rules:
* * Inbound
* * * AllowVNetInBound
* * * AllowAzureLoadBalancerInBound
* * * DenyAllInbound (Internet)
* * Outbound
* * * AllowVnetOutBound
* * * AllowInternetOutBound (Internet)

![NSG Default](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg-default1.jpg)

* Associate network security group to:
* * Associate to vnet->subnet or nic
* * To delete the NSG you must dissociate


![NSG Associate](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg-associate1.jpg)


* Any

* IP Addresses

* Service tags
* * A service tag represents a group of IP address prefixes from a given Azure service. It helps to minimize the complexity of frequent updates on network security rules.

* ASG
* * Application security groups allow you to group together the network interfaces from multiple virtual machines, 
* * and then use the group as the source or destination in an NSG rule. The network interfaces must be in the same virtual network.


Create security rules
* * Create a security rule that allows ports 80 and 443 to the web and 3389 to mgmt application security group s

![NSG](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg1.jpg)

* * ASG

![ASG](https://github.com/spawnmarvel/quickguides/blob/main/azure/asg1.jpg)

* Inbound
![Destination ASG Done](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg-asg-inbound.jpg)

* * Create VM
* * Associate network interfaces to an ASG
![Destination VM ASG Assosicate](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg-asg-assosicate-to-vm.jpg)


https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview

Tutorial: Filter network traffic with a network security group using the Azure portal

https://follow-e-lo.com/2023/03/25/az-lab-filter-network-traffic-with-a-network-security-group-using-the-azure-portal/


##### How network security groups filter network traffic

* Inbound traffic
* * Azure processes the rules in a network security group associated to a subnet first, if there's one, 
* * and then the rules in a network security group associated to the network interface, if there's one. 

* Outbound traffic
* * For outbound traffic, Azure processes the rules in a network security group associated to a network interface first, if there's one, 
* * and then the rules in a network security group associated to the subnet, if there's one.

![NSG](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg.jpg)

https://learn.microsoft.com/en-us/azure/virtual-network/network-security-group-how-it-works



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
| Connection Monitor                | Monitor connectivity and latency between a VM and another network resource, and to track the average round-trip time (RTT)                 | 
| IP Flow                           | Allows you to detect traffic filtering issues at a VM level.                                 |  Protocol, local IP, remote IP, local port, and a remote port.
| Next Hop                          | Helps you verify traffic routes and detect routing issues.                                   |
| Connection Troubleshoot           | Enables a one-time connectivity and latency check between a VM and another network resource  | 
| Packet Capture                    | Enables you to capture all traffic on a VM in your virtual network.                          | 

https://follow-e-lo.com/2023/02/11/azure-network-watcher/

Troubleshoot external networking

Troubleshoot virtual network connectivity

## AZ-104: Monitor and back up Azure resources (10-15%)

### Monitor resources by using Azure Monitor

#### Configure and interpret metrics

https://follow-e-lo.com/2023/03/20/az-lab-11-implement-monitoring/

#### Configure Azure Monitor Logs

https://follow-e-lo.com/2023/03/20/az-lab-11-implement-monitoring/

#### Query and analyze logs

* Write your first query with Kusto Query Language
* * Count the number of records by using the count operator.
* * Return a specific number or rows by using the take operator.
* * Select columns to return by using the project operator.
* * Filter data by using the where operator.
* * Reorder returned data by using the sort operator.
* *  This query searches the “TableName” table for records that contains the word “value”: search in (TableName) "value"

* There is a requirement that requires you to configure Azure Backup reports using XXBackup1 (RSV in Southeast Asia) to determine which backup items consume the most storage.
* Take note that when you create a Log Analytics workspace, it does not matter if the vault is located in a different region or subscription.

https://learn.microsoft.com/en-us/training/modules/write-first-query-kusto-query-language/

https://follow-e-lo.com/2023/03/20/az-lab-11-implement-monitoring/

https://follow-e-lo.com/2023/01/28/5-min-azure-functions-compute-with-powershell-log-analytics-workspace/

#### Set up alerts and actions

https://follow-e-lo.com/2023/03/20/az-lab-11-implement-monitoring/

Configure monitoring of VMs, storage accounts, and networks by using VM insights

### Implement backup and recovery

### Create an Azure Recovery Services vault

* Recovery service vault create:
* * Default backup configuration is GEO-redundant (3 copies within singel location in primary region, then 3 copies within secondary location, 16 9's )
* * Default security configuration is soft delete enabled
* * Must be in same region as rg's

* Recovery service vault delete:
* * Stop the backups
* * Disable the soft delete feature and delete all data
* * Permanently remove any items in the soft delete state

### Create an Azure Backup vault

*  What is difference between Recovery Services vault and backup vault
1. The first difference between an Azure Recovery Services Vault (ARSV) and an Azure Backup Vault (ABV) is are the available datasources of each vault.
2. The second difference is: In an ARSV you can be used for Azure Backup and Azure Site Recovery data. An ABV is for Azure Backup data only.


https://learn.microsoft.com/en-us/answers/questions/405915/what-is-difference-between-recovery-services-vault


#### Create and configure backup policy
#### Perform backup and restore operations by using Azure Backup

https://follow-e-lo.com/2023/03/19/az-lab-10-backup-virtual-machines/


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

![Backup vm ](https://github.com/spawnmarvel/quickguides/blob/main/azure/backup-vm.jpg)

https://learn.microsoft.com/en-us/azure/backup/quick-backup-vm-portal

![Backup vm files and folders ](https://github.com/spawnmarvel/quickguides/blob/main/azure/backup-vm-files-and-folders.jpg)

https://learn.microsoft.com/en-us/azure/backup/tutorial-backup-windows-server-to-azure



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

* You need to reprotect VM1 after the failover so that VM1 will replicate back to the primary region.
* * Before you begin, you must ensure that the virtual machine status is Failover committed. This will ensure replication back to the primary region.

Configure and review backup reports


