# Azure Administrator

Azure Administrator

## Description

Azure Administrator Cheat Sheet

## Links

Learn

https://learn.microsoft.com/en-us/certifications/azure-administrator/

Study Guide

https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104

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


## Skills measured
Manage Azure identities and governance (15–20%) :round_pushpin:

Implement and manage storage (15–20%) :round_pushpin:

Deploy and manage Azure compute resources (20–25%) :triangular_flag_on_post:

Configure and manage virtual networking (20-25%) :triangular_flag_on_post:

Monitor and maintain Azure resources (10–15%) :small_red_triangle:


## AZ-104: Manage identities and governance (15-20%)

### Manage Azure AD objects

#### Create users and groups

##### MFA

* The recommended way to enable and use Azure AD Multi-Factor Authentication is with Conditional Access policies.
* Conditional Access policies can be applied to specific users, groups, and apps.

| Step | Description
| ----- |-------
|   | An account with Conditional Access Administrator, Security Administrator, or Global Administrator privileges.
| 1 | Create a Conditional Access policy
|   | Under What does this policy apply to?, verify that Users and groups is selected.
| 2 | Configure the conditions for multi-factor authentication
|   | Now that the Conditional Access policy is created and a test group of users is assigned, define the cloud apps or actions that trigger the policy.
|   | Configure which apps require multi-factor authentication
|   | Configure multi-factor authentication for access
|   | Under Access controls, select the current value under Grant, and then select Grant access.
|   | Select Require multi-factor authentication, and then choose Select.


![Ad conditional policy ](https://github.com/spawnmarvel/quickguides/blob/main/azure/ad-conditional-policy.jpg)

https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-azure-mfa


* Enable cloud sync self-service password reset writeback to an on-premises environment
* With Azure Active Directory (Azure AD) self-service password reset (SSPR), users can update their password or unlock their account using a web browser.

https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-sspr-writeback



#### Manage licenses in Azure AD

#### Create administrative units

* Administrative units are containers used for delegating administrative roles to mange a spesfic portion of Azure AD.
* An administrative unit is an Azure AD resource that can be a container for other Azure AD resources. 
* An administrative unit can contain only users, groups, or devices.
* Administrative units restrict permissions in a role to any portion of your organization that you define.
* Azure AD administrative units are used to restrict the scope of administrative role assignments whereas Azure AD groups are used to manage users' access to apps and resources

https://learn.microsoft.com/en-us/azure/active-directory/roles/administrative-units

* Create or delete administrative units
* Administrative units let you subdivide your organization into any unit that you want, and then assign specific administrators that can manage only the members of that unit. 
* * For example, you could use administrative units to delegate permissions to administrators of each lab department at a hospital, so they can manage users and control access and policies in the bone lab only.


![Administrative units ](https://github.com/spawnmarvel/quickguides/blob/main/azure/administrative-unit.jpg)


https://learn.microsoft.com/en-us/azure/active-directory/roles/admin-units-manage#next-steps


##### Manage user and group properties

* You need to grant several users that must belong to the same Azure group temporary access to the Microsoft SharePoint document library. 
* The group must automatically be deleted after 180 days for compliance purposes.
* * Set up a dynamic membership on Microsoft 365 groups.
* * Set up an assigned membership on Microsoft 365 groups.
* * Set up an assigned membership on security groups and Set up a dynamic membership on security groups are incorrect because security groups can only be used for devices or users and not for groups.

| Role | Description | Note
| ---- | ----------- | -----
| Global Administrator| | Can manage all aspects of Azure AD and Microsoft services that use Azure AD identities. |
| Contributor| Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries. | Example: Classic Virtual Machine Contributor, CDN Endpoint Contributor, Network Contributor
|  Owner    | Grants full access to manage all resources, including the ability to assign roles in Azure RBAC.
|  Reader    | View all resources, but does not allow you to make any changes. | Example: Disk Backup Reader, Backup Reader, Storage Blob Data Reader
|   User Administrator   | Lets you manage user access to Azure resources. | Take note that the User Administrator role does not have permission to modify security questions. -> Global Administrator
| Operator |  Lets you manage backup services, except removal of backup, vault creation and giving access to others  | Example: Backup Operator
|Cloud device administrator |Can enable, disable, and delete devices in Azure AD. The role does not grant permission to manage any other properties on the device. |
|Security administrator | has permissions to manage security-related features in the Microsoft 365 security center, Azure Active Directory Identity Protection, Azure Active Directory Authentication, Azure Information Protection, and Office 365 Security & Compliance Center.|


https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles

Manage device settings and device identity

* You plan to add a local administrator to manage all the computers and devices that will join your domain?
* * Configure the settings

##### Perform bulk updates

| Example csv
| ------- 
| Name [displayName], Required	User name [userPrincipalName], Required	Initial password [passwordProfile], Required	Block sign in (Yes/No) [accountEnabled] 
| Chris Green,	chrisg@corpcompany.onmicrosoft.com,	Thewordis42Hesaid,	 No

![Ad users ](https://github.com/spawnmarvel/quickguides/blob/main/azure/ad-users.jpg)

Properties

![Ad users properties ](https://github.com/spawnmarvel/quickguides/blob/main/azure/ad-user-properties.jpg)


https://follow-e-lo.com/2023/02/06/azure-manage-azure-active-directory-identities/

Manage guest accounts

#### Configure self-service password reset

* You can enable it for all users in the Azure AD organization or for selected users.
* To enable for selected users, you must specify the security group. Members of this group can use SSPR.

1. Authentication methods (require one or two authentication methods), mobile app, email, sms, security questions
2. Registration (Specify whether users are required to register for SSPR when they next sign in.Specify how often users are asked to reconfirm their authentication information )
3. Notifications: Choose whether to notify users and administrators of password resets.
4. Customization: Provide an email address or web page URL where your users can get help.

https://learn.microsoft.com/en-us/training/modules/allow-users-reset-their-password/3-implement-azure-ad-self-service-password-reset

Custom domain
* custom domain name by using TXT or MX record types.

* How to delegate a subdomain?
* Navigate to the yourdomain.com DNS zone and add an NS record named portal
* PTR, CNAME, and TXT records are not used to delegate an Azure DNS subdomain.

| Record | Description
| -------| -----------
| A     | IPV4
| AAAA  | IPV6
| CNAME | Canonical Name record
| MX    | Mail Exchange server
| NS    | Nameserver record
| TXT   | Text record

![Custom domain ](https://github.com/spawnmarvel/quickguides/blob/main/azure/domain.jpg)

https://follow-e-lo.com/2023/03/15/az-lab-add-your-custom-domain-name-to-azure-ad/


### Manage access control

Create custom role-based access control (RBAC) and Azure AD roles

User access administrator

![Rbac role User access administrator ](https://github.com/spawnmarvel/quickguides/blob/main/azure/rbac-role.jpg)

| Property | Descriptions
| --------- |------------
|Name, IsCustom(true / false), description
| Actions, actions | An array of strings that specifies the control plane actions that the role allows to be performed.
| NotActions, notActions | An array of strings that specifies the control plane actions that are excluded from the allowed Actions.
| DataActions, dataActions | An array of strings that specifies the data plane actions that the role allows to be performed to your data within that object.
| NotDataActions, notDataActions| An array of strings that specifies the data plane actions that are excluded from the allowed DataActions.
| AssignableScopes, assignableScopes |An array of strings that specifies the scopes that the role is available for assignment.

#### Provide access to Azure resources by assigning roles at different scopes

* 4 scopes
* * Broad to narrow: management group, subscription, resource group, and resource.


![RBAC Scope ](https://github.com/spawnmarvel/quickguides/blob/main/azure/rbac1.jpg)

#### Interpret access assignments

Storage Account Contributor

![RBAC st account contributor ](https://github.com/spawnmarvel/quickguides/blob/main/azure/rbac-role-storage-account-contributor-1.jpg)

Storage Blob Data Reader

![RBAC st account contributor ](https://github.com/spawnmarvel/quickguides/blob/main/azure/rbac-role-storage-account-data-reader-1.jpg)

https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal



### Manage Azure subscriptions and governance

#### Configure and manage Azure Policy

* Policy
* With an initiative definition, you can group several policy definitions to achieve one overarching goal. 

https://follow-e-lo.com/2023/02/07/azure-management-groups/


#### Configure resource locks

* You can use delete locks to block the deletion
* * Subscriptions, resource groups and resources
* *  the only resource that we cannot apply a tag and lock is the Management Group

* Types of Resource Locks
* * Delete means authorized users can still read and modify a resource, but they can’t delete the resource.
* * ReadOnly, The resource group is read only and tags on the resource group can’t be modified.

* To modify a locked resource, you must first remove the lock. After you remove the lock, you can apply any action you have permissions to perform. 
* * Resource locks apply regardless of RBAC permissions.

https://follow-e-lo.com/2022/12/20/az-900-fundamentals/



#### Apply and manage tags on resources

* Tags are metadata elements that can be applied to resources, can be used for tracking resources: vm's, and associate to a dept. for billing and reporting.
* Subscriptions, resource groups and resources
* * the only resource that we cannot apply a tag and lock is the Management Group

#### Manage resource groups

Done it

#### Manage subscriptions

Manage costs by using alerts, budgets, and recommendations

#### Configure management groups

* Management groups provide a governance scope above subscriptions. 
* Management groups are containers tha can be used to manage access, policy and compliance across multiple subscriptions.
* If your organization has many Azure subscriptions, you may need a way to efficiently manage access, policies, and compliance for those subscriptions.
* Organize your resources into a hierarchy for unified policy and access management
* You can create a hierarchy that applies a policy, for example, which limits VM locations to the West Europe region in the management group called "Corp".
* Azure management groups support Azure RBAC for all resource accesses and role definitions. 
* These permissions are inherited to child resources that exist in the hierarchy. 



* You can create a virtual network in MK-Subscription1 ? = no
* * Deny overrides allow

* You can create a virtual machine in MK-Subscription2 ? = no
* * Tenant Root Group has a Deny policy that restricts it, as well as its related resource groups (e.g. MK-Management-Group11), from deploying virtual networks. If you can’t create a vnet, then you also can’t deploy a vm.

* You can move TD-Subscription3 to MK-Management-Group20 ? = yes
* * You are allowed to move subscriptions between management groups, but can only have one parent.


![Management groups quiz ](https://github.com/spawnmarvel/quickguides/blob/main/azure/management-groups-quiz.jpg)

* For example, the Azure role VM contributor can be assigned to a management group. 
* * This role has no action on the management group, but will inherit to all VMs under that management group.


![Management groups ](https://github.com/spawnmarvel/quickguides/blob/main/azure/management-groups.jpg)

Policy in Root->Finance

![Management groups policy ](https://github.com/spawnmarvel/quickguides/blob/main/azure/management-groups-policy.jpg)

https://follow-e-lo.com/2023/02/07/azure-management-groups/

## AZ-104: Implement and manage storage (15-20%)

### Configure access to storage

##### Configure network access to storage accounts

* Storage provides a layered security model
* You can limit access to your storage account to requests originating from:
* * specified IP addresses, IP ranges, subnets in an Azure Virtual Network (VNet), or resource instances of some Azure services.

* Storage accounts have a public endpoint that is accessible through the internet.
* Private Endpoints can also be enabled for storage account, which assigns a private IP address from your VNet to the storage account, and secures all traffic between your VNet and the storage account over a private link.


https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal

![Storage secure ](https://github.com/spawnmarvel/quickguides/blob/main/azure/storage-secure-1.jpg)

##### Create and configure storage accounts

Done it

##### Generate shared access signature tokens

* By using a shared access signature (SAS), you can delegate access to your resources. Clients don't have direct access to your storage account credentials and, at a granular level, you control what they access.
* A SAS has two components, a URI that points to one or more storage resources, and a token that indicates how the resources may be accessed by the client.

| Uri | SAS Token
| --- |---
| https://medicalrecords.blob.core.windows.net/patient-images/patient-116139-nq8z7f.jpg? | sp=r&st=2020-01-20T11:42:32Z&se=2020-01-20T19:42:32Z&spr=https&sv=2019-02-02&sr=b&sig=SrW1HZ5Nb6MbRzTbXCaPm%2BJiSEn15tC91Y4umMPwVZs%3D

The SAS token contains the following components, or query parameters.

| Query parmeter | Field name | Example | Description
| --- | --- | --- | ---
| sp | signed premission| sp=r | a (add), c (create), d (delete), l (list), r (read), and w (write). sp=r is read only; sp=acdlrw grants all the available rights.
| st | start time | st=2020-01-20T11:42:32Z | Start
| se | expiry time | se=2020-01-20T19:42:32Z | End
| spr | signed protocol | spr=https | HTTPS and HTTP (the default value), or HTTPS only.
| sv | signed version | sv=2019-02-02 | The service version of the storage API to use.
| sr | scope of resource | sr=b |  b (blob), c (container), d (directory), f (file) s (share)
| sig  | signature | sig=SrW1...wVZs%3D | The cryptographic signature.

* Which two parameters are required for the SAS token?
* * SignedServices (ss) is required to refer blobs, queues, tables, and files. 
* * SignedResourceTypes (srt) is required to refer services, containers, or objects. 
* * st (start) and sip () signed ip

https://learn.microsoft.com/en-us/training/modules/control-access-to-azure-storage-with-sas/3-use-shared-access-signatures

https://follow-e-lo.com/2022/01/24/5-min-azure-storage-explorer/



#### Configure stored access policies

* A stored access policy provides an additional level of control over service-level shared access signatures (SASs) on the server side.
*  Stored access policy serves to group shared access signatures and to provide additional restrictions for signatures that are bound by the policy.
* Use a stored access policy to:
* * change the start time, expiry time
* * permissions for a signature.
* * revoke a signature after it has been issued
* * For Blob containers, File Shares, Queues, Tables

https://learn.microsoft.com/en-us/rest/api/storageservices/define-stored-access-policy

#### Manage access keys

* Storage account access keys provide full access to the configuration of a storage account, as well as the data.
* Use Azure Key Vault to manage and rotate your keys securely

* Manually rotate access keys
* * Update the connection strings in your application code to reference the secondary access key for the storage account.
* *  Regenerate primary access key 
* * Update the connection strings in your code to reference the new primary access key.
* * Regenerate the secondary access key in the same manner.

* Create a key expiration policy
* * A key expiration policy enables you to set a reminder for the rotation of the account access keys.
* Monitor your storage accounts for compliance to ensure that the account access keys are rotated regularly.

https://learn.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal

#### Configure Azure AD authentication for a storage account

*  Setting this property implicitly "domain joins" the storage account with the associated Azure AD DS deployment

![Storage AD ](https://github.com/spawnmarvel/quickguides/blob/main/azure/storage-ad.jpg)

https://learn.microsoft.com/en-us/azure/storage/files/storage-files-identity-auth-active-directory-domain-service-enable?tabs=azure-portal

#### Configure storage encryption

* Azure Storage uses service-side encryption (SSE) to automatically encrypt your data when it is persisted to the cloud.
* Data in Azure Storage is encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant. Azure Storage encryption is similar to BitLocker encryption on Windows.
* Azure Storage encryption is enabled for all storage accounts.
* Azure Storage encryption cannot be disabled. 
* You can continue to rely on Microsoft-managed keys for the encryption of your data, or you can manage encryption with your own keys.

https://learn.microsoft.com/en-us/azure/storage/common/storage-service-encryption


### Manage data in Azure storage accounts

#### Create import and export jobs

* Azure Import/Export service is used to securely import large amounts of data to:
* * Azure Blob storage
* * Azure Files
* * by shipping disk drives to an Azure datacenter. 


https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-service

Import data to Blob Storage with Azure Import/Export service

| Step for drives | Description
| --- | ---
| 1   |  Prepare the drives, generates a journal file. The journal file stores basic information such as drive serial number, encryption key, and storage account details. Together with the journal file, a <Journal file name>_DriveInfo_<Drive serial ID>.xml
| 2   |  Create an import job, Azure Data Box, in Job Details WAImportExport tool
| 3   |  (Optional): Configure customer managed key
| 4   | Ship the drives
| 5   | Update the job with tracking information, fill in the tracking information
| 6   | Verify data upload to Azure

https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-blobs?tabs=azure-portal-preview

| Step for files | Description
| --- | ---
| 1   | Prepare the drives, This step generates a journal file. The journal file stores basic information such as drive serial number, encryption key, and storage account details. dataset.csv
| 2   | Create an import job
| 3   | Ship the drives to the Azure datacenter
| 4   | Update the job with tracking information
| 5   | Verify data upload to Azure

https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-files?tabs=azure-portal-preview


Manage data by using Azure Storage Explorer and AzCopy

#### Azure Storage Explorer

* Azure Storage Explorer allows you to quickly view all the storage services under your account. 
* You can browse through, read, and edit data stored in those services through a user-friendly graphical interface.

![Storage Explorer ](https://github.com/spawnmarvel/quickguides/blob/main/azure/storage-explorer.jpg)

https://learn.microsoft.com/en-us/azure/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows

#### Get started with AzCopy
AzCopy is a command-line utility that you can use to copy blobs or files to or from a storage account.


```
# Copies source data to a destination location
azcopy copy [source] [destination] [flags]

# Logs in to Azure Active Directory to access Azure Storage resources.
azcopy login

# Creates a container or file share.
azcopy make

# There is a requirement to copy a virtual machine image to a container named container1 from your on-premises datacenter. 
# You need to provision an Azure Container instance to host the container image.

azcopy make "https://[account-name].[blob,file,dfs].core.windows.net/[top-level-resource-name]"

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#transfer-data

```
#### Transfer data with AzCopy and file storage

```
# Upload a file
azcopy copy '<local-file-path>' 'https://<storage-account-name>.file.core.windows.net/<file-share-name>/<file-name><SAS-token>'

# Upload a directory
azcopy copy '<local-directory-path>' 'https://<storage-account-name>.file.core.windows.net/<file-share-name><SAS-token>' --recursive

# Upload specific files
azcopy copy '<local-directory-path>' 'https://<storage-account-name>.file.core.windows.net/<file-share-or-directory-name><SAS-token>' --include-path <semicolon-separated-file-list>

# Download a file
azcopy copy 'https://<storage-account-name>.file.core.windows.net/<file-share-name>/<file-path><SAS-token>' '<local-file-path>'


```
https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files


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

#### Configure blob lifecycle management

```

$staccount = "staccount0041"
$rgName = "rg0041exam"
Get-AzStorageAccount -Name $staccount -resourceGroupName $rgName

Set-AzCurrentStorageAccount -ResourceGroupName $rgName -Name $staccount 
# Modifies the current Storage account of the specified subscription.

Get-AzStorageContainer -Name testco0041

Set-azStorageBlobContent -Container testco0041 -File ./toblob0041/test.txt -Blob "test.txt"
# Uploads a local file to an Azure Storage blob.

```
* Azure Storage lifecycle management offers a rule-based policy that you can use to transition blob data to the appropriate access tiers or to expire data at the end of the data lifecycle. 
* A lifecycle policy acts on a base blob, and optionally on the blob's versions or snapshots.
* One or more rules that define a set of actions o take based on a condition being met:
* * number of days since the blob was created.
* * number of days since the blob was last modified.
* * number of days since the blob was last accessed (x)
* * (x) To use this condition in an action, you should first optionally enable last access time tracking.

![Storage blob lifecycle ](https://github.com/spawnmarvel/quickguides/blob/main/azure/storage-blob-lifecycle1.jpg)


https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal#see-also


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

#### Configure VM network settings


* Communicate between Azure resources
* * Virtual networks and virtual network peering (These virtual networks can be in separate regions)
* * Virtual networks can connect to App Service Environment, Azure Kubernetes Service, and Azure virtual machine scale sets.
* * Service endpoints to Storage, SQL

* Communicate with on-premises resources
* * Link resources together in your on-premises environment and within your Azure subscription, 3 types

| Type | Description | Route
| ---  | ----------- | -----
| Point-to-site Virtual Private Networks | Similar to VPN, but client pc initiates VPN connection to Azure | Encrypted, IPsec/IKE (IKEv1 or IKEv2) (OpenVPN, Secure Socket Tunneling Protocol (SSTP))
| Site-to-site  Virtual Private Networks | Links your on-premises VPN device or gateway to the Azure VPN gateway in a virtual network (appear as being on local network) | Encrypted, IPsec/IKE (IKEv1 or IKEv2)
| ExpressRoute | Greater bandwidth and even higher levels of security, provides dedicated private connectivity | Private, no inet
|              | Azure ExpressRoute uses a combination of ExpressRoute circuits and routing domains to provide high-bandwidth connectivity to the Microsoft Cloud.|
|              | Connections into ExpressRoute can be through the following mechanisms: |
|              | IP VPN network (any-to-any) |
|              | Virtual cross-connection through an ethernet exchange |
|              | Point-to-point ethernet connection|

https://learn.microsoft.com/en-us/training/modules/configure-network-for-azure-virtual-machines/

* Plan a VPN gateway factors
* * Throughput, internet or private, public IP, vpn device compatibillity, many clients (points) or site, gateway type, SKU.

https://learn.microsoft.com/en-us/training/modules/configure-network-for-azure-virtual-machines/4-explore-azure-vpn-gateway



![VPN MS Learn](https://github.com/spawnmarvel/quickguides/blob/main/azure/vpn-ms-learn.jpg)

Configure VM availability options

#### Deploy and configure VM scale sets

* A proximity placement group is a logical grouping used to make sure that Azure compute resources are physically located close to each other. 
* Proximity placement groups are useful for workloads where low latency is a requirement. 
* When you assign your virtual machines to a proximity placement group, the virtual machines are placed in the same data center, 
* resulting in lower and deterministic latency for your applications.

* Orchestration:
* * Uniform: optimized for large scale statless workloads with identicial instances
* * Flexible: Achive high availability at scale with identicial or multiple virtual machine type

https://learn.microsoft.com/en-us/azure/virtual-machines/windows/proximity-placement-groups-portal

https://follow-e-lo.com/2023/03/18/az-lab-08-manage-virtual-machines/


* How do availability sets work?

| # | Description 
| ---     |--- 
|  VM             | Each virtual machine in your availability set is assigned an update domain and a fault domain by the underlying Azure platform.
|  3 and 20       | Each availability set can be configured with up to three fault domains and twenty update domains.
|  Update domains | Groups of virtual machines and underlying physical hardware that can be rebooted at the same time.
|  > 5 VM's?      | When more than five virtual machines are configured within a single availability set with five update domains:
|   6 VM          | Is placed into the same update domain as the first virtual machine
|   7 VM          | Same update domain as the second virtual machine, etc 8 VM in 3 update domain
| Update          | Only one update domain is rebooted at a time
| Fault domains   | Virtual machines that share a common power source and network switch. 
|                 | By default, the virtual machines configured within your availability set are separated across up to three fault domains. 


![Fault and update domain ](https://github.com/spawnmarvel/quickguides/blob/main/azure/fault-update-domain-1.jpg)

*  10 Update domains, 18 VM's how many will be booted at the same time?
*  2 VMS 

https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview

###  Create and configure containers

#### Configure sizing and scaling for Azure Container Instances

* Azure Container Apps manages automatic horizontal scaling through a set of declarative scaling rules. 
* As a container app revision scales out, new instances of the revision are created on-demand. These instances are known as replicas.

* Scale definition
* Scaling is defined by the combination of limits and rules.

| Scale limit | Default value | Min | Max 
| ------------| --------------| --- |----
| Min number of replicas per revision | 0 | 0 | 30
| Max number of replicas per revision | 10 | 1 | 30


* Scale rules
* Scaling is driven by three different categories of triggers:
* * HTTP: Based on the number of concurrent HTTP requests to your revision.
* * TCP: Based on the number of concurrent TCP connections to your revision.
* * Custom: Based on CPU, memory, or supported event-driven data sources such as:
* * * Azure Service Bus
* * * Azure Event Hubs
* * * Apache Kafka
* * * Redis

![Container instance ](https://github.com/spawnmarvel/quickguides/blob/main/azure/container-instance-scale.jpg)


#### Configure container groups for Azure Container Instances

* A container group is a collection of containers that get scheduled on the same host machine. 
* The containers in a container group share a lifecycle, resources, local network, and storage volumes. It's similar in concept to a pod in Kubernetes.
* The top-level resource in Azure Container Instances is the container group.

![Container Group ](https://github.com/spawnmarvel/quickguides/blob/main/azure/container-group.jpg)



https://learn.microsoft.com/en-us/azure/container-instances/container-instances-container-groups



#### Create and configure Azure Container Apps

* Deploy Docker
* Review functionality of container instance

![Container instance ](https://github.com/spawnmarvel/quickguides/blob/main/azure/container-instance.jpg)

Deploy

![Container instance ](https://github.com/spawnmarvel/quickguides/blob/main/azure/container-instance-deploy.jpg)

FQDN URL

![Container instance ](https://github.com/spawnmarvel/quickguides/blob/main/azure/container-instance-deploy-FQDN.jpg)

Logs

![Container instance ](https://github.com/spawnmarvel/quickguides/blob/main/azure/container-instance-deploy-FQDN-logs.jpg)


https://follow-e-lo.com/2023/04/01/az-lab-09b-implement-azure-container-instances/

https://github.com/MicrosoftLearning/AZ-104-MicrosoftAzureAdministrator/blob/master/Instructions/Labs/LAB_09b-Implement_Azure_Container_Instances.md

Configure storage for Azure Kubernetes Service (AKS)

* The app should be accessible via the pod's IP address.
* * With Azure Container Networking Interface (CNI), every pod gets an IP address from the subnet and can be accessed directly.

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
# From the Cloud Shell pane, run the following to deploy the nginx image from the Docker Hub:
kubectl create deployment nginx-deployment --image=nginx

# service/nginx-deployment exposed
kubectl expose deployment nginx-deployment --port=80 --type=LoadBalancer


```

https://learn.microsoft.com/en-us/azure/aks/concepts-network



#### Upgrade an AKS cluster

* Part of the AKS cluster lifecycle involves performing periodic upgrades to the latest Kubernetes version. 
* It’s important you apply the latest security releases, or upgrade to get the latest features.
* Performing upgrade operations requires the Microsoft.ContainerService/managedClusters/agentPools/write RBAC role.
* When you upgrade a supported AKS cluster, Kubernetes minor versions can't be skipped. All upgrades must be performed sequentially by major version number.



https://learn.microsoft.com/en-us/azure/aks/upgrade-cluster?tabs=azure-cli

#### ps1 / cli / aks 


```
# Check for available AKS cluster upgrades
az aks get-upgrades --resource-group myResourceGroup --name myAKSCluster --output table

# The following example output shows that the cluster can be upgraded to versions 1.19.1 and 1.19.3:

Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------
default  myResourceGroup  1.18.10          1.19.1, 1.19.3

# It takes a few minutes to upgrade the cluster, depending on how many nodes you have.
az aks upgrade \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --kubernetes-version KUBERNETES_VERSION

# To confirm that the upgrade was successful, use the az aks show command:
az aks show --resource-group myResourceGroup --name myAKSCluster --output table

Name          Location    ResourceGroup    KubernetesVersion    ProvisioningState    Fqdn
------------  ----------  ---------------  -------------------  -------------------  ----------------------------------------------
myAKSCluster  eastus      myResourceGroup  1.19.1               Succeeded            myakscluster-dns-379cbbb9.hcp.eastus.azmk8s.io


```

###  Create and configure an Azure App Service

##### Create an App Service plan

* 1 For Windows (so Windows is the only alternative if using ASP.NET)
* 1 For Linux (.Net core, Pyton, Ruby, PHP etc)

* Take note that you cannot change an App Service plan’s region. 
* Also, if you move a resource to a new resource group or subscription, the location of the resource would not change.


![Web app ](https://github.com/spawnmarvel/quickguides/blob/main/azure/web-app.jpg)

#### Configure scaling settings in an App Service plan

* Choose tier
* An app service always runs in an App Service plan. In addition, Azure Functions also has the option of running in an App Service plan. 
* An App Service plan defines a set of compute resources for a web app to run.

![Web app scaling ](https://github.com/spawnmarvel/quickguides/blob/main/azure/web-app-scaling.jpg)

Function

![Web app plan examples ](https://github.com/spawnmarvel/quickguides/blob/main/azure/web-app-plan.jpg)


https://learn.microsoft.com/en-us/azure/app-service/manage-scale-up

Create an App Service

#### Secure an App Service

* HTTPS and Certificates
* Client authentication and authorization
* *  including Azure Active Directory, Microsoft accounts, Facebook, Google, and Twitter
* Service-to-service authentication
* When authenticating against a back-end service, App Service provides two different mechanisms depending on your need:
* * Service identity - Sign in to the remote resource using the identity of the app itself, managed identity
* * On-behalf-of (OBO) - Make delegated access to remote resources on behalf of the user. With Azure Active Directory as the authentication provider, your App Service app can perform delegated sign-in to a remote service


https://learn.microsoft.com/en-us/azure/app-service/overview-security

#### Configure custom domain names

* Map an existing custom DNS name to Azure App Service
* You can use Azure DNS to manage DNS records for your domain and configure a custom DNS name for Azure App Service.
1. Configure a custom domain
2. The Hostname record type box defaults to the recommended DNS record to use
* * depending on whether the domain is a root domain (like contoso.com), 
* * a subdomain (like www.contoso.com, or a wildcard domain *.contoso.com).
2. Create the DNS records
* * Sign in to the website of your domain provider. (Domain Name, DNS, or Name Server Management.),create a record
* * You can use either a CNAME record or an A record to map a custom DNS name to App Service.
3. Validate and complete


https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain?tabs=root%2Cazurecli

https://follow-e-lo.com/2023/03/15/az-lab-add-your-custom-domain-name-to-azure-ad/


#### Configure backup for an App Service

* Automatic vs custom backups
* * Automatic backups made for your app regularly as long as it's in a supported pricing tier.

Backup

![Web app bck ](https://github.com/spawnmarvel/quickguides/blob/main/azure/web-app-bck.jpg)

Restore

![Web app bck restore ](https://github.com/spawnmarvel/quickguides/blob/main/azure/web-app-bck-restore.jpg)

* * Custom backups require initial configuration, and can be made on-demand or on a schedule.
* * In your app management page in the Azure portal, in the left menu, select Backups.
* * At the top of the Backups page, select Configure custom backups.
* * In Storage account, select an existing storage account (in the same subscription) or select Create new. Do the same with Container.
* * Link db and create a schedule

https://learn.microsoft.com/en-us/azure/app-service/manage-backup?tabs=portal


#### Configure networking settings

* Because App Service Environments are isolated to the individual customer, there are certain configuration settings that can be applied exclusively to App Service Environments.
* * Allow new private endpoint connections (For apps hosted on both ILB and External App Service Environment, you can allow creation of private endpoints.)
* * FTP access (This ftpEnabled setting allows you to allow or deny FTP connections are the App Service Environment level.)
* * Remote debugging access (Remote debugging is default disabled at the App Service Environment level. You can enable it)


https://learn.microsoft.com/en-us/azure/app-service/environment/configure-network-settings


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

* You have an on-premises device named Device1 that runs Windows and has a Point-to-Site (P2S) VPN client installed.
* You configure network peering between VNet1 and VNet2. What should you do?
* * Point-to-Site (P2S) VPN clients must be downloaded and reinstalled again after virtual network peering is successfully configured to ensure that the new routes are downloaded to the client.

You need to connect your on-premises network to Azure by using a site-to-site VPN.
* Which four actions should you perform in sequence?

| Steps | Description
| --- |------
| 1   | Deploy a gateway subnet
| 2   | Deploy a VPN gateway
| 3   | Deploy a local network gateway
| 4   | Deploy a VPN Connection

![VPN](https://github.com/spawnmarvel/quickguides/blob/main/azure/vpn.jpg)

https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal?toc=%2Fazure%2Fvirtual-network%2Ftoc.json


#### Create and configure virtual network peering

https://follow-e-lo.com/2023/03/11/azure-lab-05-implement-intersite-connectivity/

#### Configure private and public IP addresses

https://follow-e-lo.com/2023/03/07/azure-lab-04-implement-virtual-networking/

#### Configure user-defined network routes

https://follow-e-lo.com/2023/03/17/azure-lab-06-implement-traffic-management/

#### Configure Azure DNS

* Task 5: Configure Azure DNS for internal name resolution
* * Azure portal, search for and select Private DNS zones 
* * epok.org
* * on a vnet add VIRTUAL NETWORK LINK and enable auto registration
* * Verify that the DNS records for az104-04-vm0 and az104-04-vm1 appear in the list of record sets as Auto registered.

* Task 6: Configure Azure DNS for external name resolution (domain check with provider)
* * Azure portal, search for and select DNS zones
* * epicetus.com
* * Name server 1 to 4 is here.
* On the DNS zone blade, click + Record set.
* * Add record sets for vm


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


Source / Destination

* Any

* IP Addresses

* Service tags
* * A service tag represents a group of IP address prefixes from a given Azure service. It helps to minimize the complexity of frequent updates on network security rules.
* * Example App service or Azure Backup

* ASG
* * Application security groups allow you to group together the network interfaces from multiple virtual machines, 
* * and then use the group as the source or destination in an NSG rule. The network interfaces must be in the same virtual network.


Create security rules
* * Create a security rule that allows ports 80 and 443 to the web and 3389 to mgmt application security group s

![NSG](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg1.jpg)

* * ASG

![ASG](https://github.com/spawnmarvel/quickguides/blob/main/azure/asg1.jpg)

* Inbound ASG as destination
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


#### Evaluate effective security rules

* Network security groups can be associated at a subnet level or at a network interface level. 
* When associated at a subnet level, it applies to all virtual machines (VMs) in the virtual network subnet. 
* With effective security rules view in Network Watcher, you can see all inbound and outbound security rules that apply to a virtual machine’s network interface(s).

https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-security-group-view-overview

![NSG effective security rules](https://github.com/spawnmarvel/quickguides/blob/main/azure/nsg-evaluate-effective-security.jpg)

#### Implement Azure Bastion

* Azure Bastion is a service that lets you connect to a virtual machine by using a browser, without exposing RDP and SSH ports.
* To associate a vnet witha Bastion, it must contain a subnet with name AzureBastionSubnet and a prefix of at least /26

* There is a requirement that more than 90 users will concurrently use Bast01
* you need to upgrade the SKU of Bast01 from Basic to Standard
* After that, you can increase the instance count of Bast01 to whatever number of servers are required to accommodate the 90 users.

| Subnet | IPV4 |Available IPs
| ------- | -- | ---------
| AzureBastionSubnet | 10.0.3.0/26 | 59

![Bastion](https://github.com/spawnmarvel/quickguides/blob/main/azure/bastion.jpg)

https://learn.microsoft.com/en-us/azure/bastion/bastion-overview


#### Configure service endpoints on subnets

* Service endpoints are available for the following Azure services and regions. 

![Service end points](https://github.com/spawnmarvel/quickguides/blob/main/azure/vnet-service-endpoints.jpg)

Service endpoint example

![Service end points](https://github.com/spawnmarvel/quickguides/blob/main/azure/vnet-service-endpoints-example.jpg)


https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview

#### Configure private endpoints

* You must have a previously deployed Azure WebApp (or another AZ resource) to proceed with the steps in this article.
* In the search box at the top of the portal, enter Private endpoint. Select Private endpoints.
* In the Basics tab of Create a private endpoint, enter or select the following information.
* * myPrivateEndpoint, rg and more
* In the Resource pane, enter or select the following information.

| Field | Value
| ---- |------
| Resource type |  Microsoft.Web.Sites
| Resource      |  mywebapp41
| Target subresources | Site

![Private end points](https://github.com/spawnmarvel/quickguides/blob/main/azure/vnet-private-endpoints.jpg)

https://learn.microsoft.com/en-us/azure/private-link/create-private-endpoint-portal?tabs=dynamic-ip

### Configure load balancing

#### Configure Azure Application Gateway

* Azure Application Gateway is a web traffic load balancer that operates at Layer 7 of the OSI model. 
* Application Gateway can make routing decisions based on additional attributes of an HTTP request, such as the URI path or host headers.
* Azure Application Gateway supports end-to-end traffic encryption and TLS/SSL termination.
* Azure Load Balancer can be used to balance requests, but Azure Load Balancer will balance requests at Layer 4 (TCP and UDP) only.

* You need to associate a public IP address to a public Azure load balancer with an SKU of standard?
* * publicIpVm02, SKU(must match):STANDARD, Assigment: Static

https://follow-e-lo.com/2023/03/17/azure-lab-06-implement-traffic-management/

![Application GW vs LB ](https://github.com/spawnmarvel/quickguides/blob/main/azure/application-gw-vs-lb.jpg)

* Azure Traffic Manager: This service is mainly used for DNS-based traffic load balancing.
* Azure Load Balancer: You can use this service to create public and internal load balancers only.
* Azure Front Door and CDN:  Azure Front Door is a global, scalable entry-point that uses the Microsoft global edge network to create fast, secure, and widely scalable web applications.

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

Storage

![Monitor storage](https://github.com/spawnmarvel/quickguides/blob/main/azure/monitor-storage.jpg)

Activity

![Monitor Activity ](https://github.com/spawnmarvel/quickguides/blob/main/azure/monitor-activity.jpg)

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

* Vault support:
* Azure Backup uses Recovery Services vaults to orchestrate and manage backups for the following workload types:
* * Azure VMs, SQL in Azure VMs, SAP HANA in Azure VMs, Azure File shares and on-premises workloads using Azure Backup Agent, Azure Backup Server and System Center DPM.

https://learn.microsoft.com/en-us/azure/backup/backup-support-matrix#vault-support


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

| Steps | Description | Note
| ------| ---------- | ------
| 1  | Create a Recovery Services vault | Create a Recovery Services vault in any region, except in the source region from which you want to replicate VMs.
| 2  | Enable Site Recovery  | In the vault settings
| 3  | Enable replication   | Select the source settings and enable VM replication.
| 4  | Select the VMs |
| 5  | Review replication settings |
| 6  | Manage, Replication policy, Replication group

* You need to reprotect VM1 after the failover so that VM1 will replicate back to the primary region.
* * Before you begin, you must ensure that the virtual machine status is Failover committed. This will ensure replication back to the primary region.


![Disaster recovery ](https://github.com/spawnmarvel/quickguides/blob/main/azure/disaster-recovery.jpg)

https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-enable-replication

#### Run a disaster recovery drill for Azure VMs

| Steps | Description | Note
| ------| ---------- | ------
| 1 | Check VM settings before the drill | In the vault > Replicated items, select the VM. check that the VM is protected and healthy.
| 2 | Run a test failover | In Test Failover, choose a recovery point. The Azure VM in the target region is created using data from this recovery point.
| 3 | Clean up after the drill |

https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-dr-drill

#### Fail over Azure VMs to a secondary region

*  Fail over Azure VMs that are enabled for disaster recovery with Azure Site Recovery, to a secondary Azure region. After failover, you reprotect VMs in the target region so that they replicate back to the primary region.

| Steps | Description | Note
| ------| ---------- | ------
| 1 | Verify the VM settings | check that the VM is protected and healthy, before you run a failover.
| 2 | Run a failover | In Failover, choose a recovery point. The Azure VM in the target region is created using data from this recovery point.
| 3 | Reprotect the VM | After failover, you reprotect the VM in the secondary region, so that it replicates back to the primary region. 
|   | Make sure that VM Status is Failover committed

![Disaster recovery failover committed ](https://github.com/spawnmarvel/quickguides/blob/main/azure/disaster-recovery-failover-commited.jpg)

https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-failover-failback

#### Configure and review backup reports

* A common requirement for backup admins is to obtain insights on backups based on data that spans a long period of time. Use cases for such a solution include:
* * Allocating and forecasting of cloud storage consumed.
* * Auditing of backups and restores.
* * Identifying key trends at different levels of granularity.

1. Create a Log Analytics workspace or use an existing one
2. Configure diagnostics settings for your vaults

![Backup reports diagnostics ](https://github.com/spawnmarvel/quickguides/blob/main/azure/backup-reports.jpg)

3. View reports in the Azure portal

![Backup reports  ](https://github.com/spawnmarvel/quickguides/blob/main/azure/backup-reports-reports.jpg)

* Summary
* * high-level overview of your backup estate. 
* Backup Items
* * information and trends on cloud storage consumed at a Backup-item level. 
* Usage
* * view key billing parameters for your backups
* Jobs
* *  view long-running trends on jobs, such as the number of failed jobs per day and the top causes of job failure.
* Policies
* * view information on all of your active policies, such as the number of associated items and the total cloud storage consumed by items backed up under a given policy.
* Optimize
* * gain visibility into potential cost-optimization opportunities for your backups.
* Inactive resources
* *  identify those backup items that haven't had a successful backup for a significant duration of time. 
* Backup Items with a large retention duration
* * identify those items that have backups retained for a longer duration than required by your organization.
* Databases configured for daily full backup
* *  identify database workloads that have been configured for daily full backup.
* Policy adherence
* * identify whether all of your backup instances have had at least one successful backup every day.
* Email Azure Backup reports
* * create automated tasks to receive periodic reports via email.

https://learn.microsoft.com/en-us/azure/backup/configure-reports






