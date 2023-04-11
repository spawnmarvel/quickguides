# Azure Administrator

Azure Administrator

## Description

Azure Administrator Cheat Sheet

## Links

AZ-104 Microsoft Azure Administrator Sample Exam Questions

https://learn.microsoft.com/en-us/certifications/resources/az-104-sample-questions

## Questions

### Question # 1 (Multiple Choice)

Your company has a Microsoft 365 tenant and an Azure Active Directory (Azure AD) tenant named contoso.com. The company uses several Azure Files shares. Each share is assigned to a different department at the company. The department attribute in Azure AD is populated for all users.

You need to ensure that the users can access the departmental file shares. The solution must minimize administrative effort.

Which two types of groups should you use? Each correct presents a complete solution.

* A. a security group that uses the dynamic membership type
* B. a Microsoft 365 group that uses the dynamic membership type
* C. a distribution group
* D. a security group that uses the assigned membership type
* E. a Microsoft 365 group that uses the assigned membership type

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | A AND B
| Objective | 1.1 Manage Azure Active Directory (Azure AD) objects
| Rationale | Groups that use dynamic membership rules reduce the overhead of access management by providing attribute-based membership and access to resources. Based on membership rules the membership, and resulting access, can be granted and removed automatically.
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-dynamic-membership
</details>

### Question # 2 (Multiple Choice)

You have an Azure Active Directory (Azure AD) tenant named contoso.com.

You need to ensure that a user named User1 can review all the settings of the tenant. User1 must be prevented from changing any settings.

Which role should you assign to User1?

* A. Directory readers
* B. Security reader
* C. Reports reader
* D. Global reader

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 1.2 Manage access control
| Rationale | A user that is assigned the Global reader role is prevented from making any modifications. The role is a read-only version of Global Administrator that allows the user to read settings and administrative information across all services but can't take management actions.
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference#global-reader
</details>

### Question # 3 (Multiple Choice)

You have a production Azure Active Directory (Azure AD) tenant named contoso.com.

You deploy a development Azure Active Directory (AD) tenant, and then you create several custom administrative roles in the development tenant.

You need to copy the roles to the production tenant.

What should you do first?

* A. From the development tenant, export the custom roles to JSON.
* B. From the production tenant, create a new custom role.
* C. From the development tenant, perform a backup.
* D. From the production tenant, create an administrative unit.

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | A
| Objective | 1.2 Manage access control
| Rationale | Creating Custom roles in Azure can be complex due to thousands of permissions so custom roles can be exported as JSON and then imported into a new custom role. The first step is to export the role to a JSON format. A JSON file can then be imported into another tenant; containing all of the details in the custom role.
| URL:      | https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles
</details>

### Question # 4 (Multiple Choice)

You have an Azure subscription that contains several hundred virtual machines. You plan to create an Azure Monitor action rule that triggers when a virtual machine uses more than 80% of processor resources for five minutes.

You need to specify the recipient of the action rule notification.

What should you create?

* A. Action group
* B. Security group
* C. Distribution group
* D. Microsoft 365 group

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | A
| Objective | 5.1 Monitor resources by using Azure Monitor
| Rationale | An action group is a collection of notification preferences defined by the owner of an Azure subscription. Azure Monitor, Service Health and Azure Advisor alerts use action groups to notify users that an alert has been triggered.
| URL:      | https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups
</details>

### Question # 5 (Multiple Choice)

Your company has 10 different departments.

You have an Azure subscription that contains several hundred virtual machines. The users of each department use only their department’s virtual machines.

You plan to apply resource tags for each department to the virtual machines.

Which two solutions should you use? Each correct presents a complete solution.

* A. PowerShell
* B. Azure Resource Manager (ARM) templates
* C. app registrations
* D. Azure Advisor

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | A AND B
| Objective | 1.3 Manage Azure subscriptions and governance.
| Rationale | Assigning Tags to Virtual machines will allow you create reports and dashboards for Alerting, budget and performance management. Tags can be applied by using PowerShell, Azure CLI, and ARM templates.
| URL:      | https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/decision-guides/resource-tagging/

</details>

### Question # 6 (Multiple Choice)

You have an Azure subscription that contains the storage accounts shown in the following table.

![Storage accounts ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/storage-accounts-6.jpg)

You need to identify which storage accounts can be switched to geo-redundant storage (GRS).

Which storage accounts should you identify?

* A. storage1 only
* B. storage2 only
* C. storage3 only
* D. storage4 only
* E. storage1 and storage4 only
* F. storage2 and storage3 only

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 2.1 Configure access to storage
| Rationale | Geo-redundant storage (GRS) copies your data synchronously three times within a single physical location in the primary region using LRS. It then copies your data asynchronously to a single physical location in a secondary region that is hundreds of miles away from the primary region. Storage accounts configured with the Premium performance setting only support LRS. Any storage account already configured with ZRS cannot be changed or directly switched to another replication setting. In this scenario, the only storage account that is not set to LRS or Premium performance is storage2, which can be switched to use Geo-redundant storage.
| URL:      | https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy
</details>

### Question # 7 (Multiple Choice)

You have an Azure subscription.

You plan to deploy multiple Azure virtual machines by using an Azure Resource Manager (ARM) template.

You need to securely store the credentials that will be used for the deployment.

What should you use?

* A. Azure Active Directory (Azure AD) Identity Protection
* B. Azure Key Vault
* C. Azure storage account
* D. Azure Encryption scopes

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 3.2 Automate deployment of resources by using templates
| Rationale | You can retrieve secrets from an Azure key vault and pass the secrets as parameters when you deploy an Azure Resource Manager template (ARM template). The parameter value is never exposed, because you can reference only the key vault ID and not the credentials directly.
| URL:      | https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-use-key-vault

</details>


### Question # 8 (Multiple Choice)

You have a resource group named RG1 that contains several unused resources.

You need to use the Azure CLI to remove RG1 and all its resources, without requiring a confirmation.

Which command should you use?

* A. az group delete --name rg1 --no-wait --yes
* B. az group deployment delete --name rg1 --no-wait
* C. az group update --name rg1 --remove
* D. az group wait –deleted –resource-group rg1

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | A
| Objective | 1.3 Manage Azure subscriptions and governance
| Rationale | To remove a resource group using Azure CLI you would use the az group delete command. The –no-wait switch specifies to not wait for long-running operations before you can continue using the open command prompt for additional commands, and the –yes switch specifies no prompt for confirmation.
| URL:      | https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az_group_delete&preserve-view=true

</details>

### Question # 9 (Multiple Choice)

You have an Azure virtual machine named VM1.

You need to create five additional virtual machines that have the same configurations as VM1. The solution must ensure that VM1 remains available.

From the Azure portal, you open the blade for VM1.

What should you do next?

* A. Select Capture.
* B. Select Availability and scaling.
* C. Select Redeploy + reapply.
* D. Select Export template.

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 3.1 Automate deployment of resources by using templates
| Rationale | If you need to create multiple Azure resources based upon an existing resource, you should export and use a JSON template. You can export a template from the resource itself, from a resource group, or from the deployment history. In this scenario, you would export the template from the VM1 blade. You would only use Capture if you wanted to create an image of the existing VM. However, this will make the source VM unusable. There are also several preparation tasks to complete before capturing the VM image. You would not select Redeploy + reapply as these two options are used to address failed connections or VM states. Availability and scaling is used to set up and manage VM high availability, not for creating additional VMs based upon a set configuration setting.
| URL:      | https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/export-template-portal

</details>

### Question # 10 (Multiple Choice)

You have an Azure subscription that contains an Azure App Service web app named webapp1. Webapp1 uses a domain name of webapp1.azurewebsites.net.

You need to add a custom domain named www.contoso.com to webapp1.

You verify the domain ownership.

Which DNS record should you use next?

* A. SRV
* B. CNAME
* C. TXT
* D. PTR

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 3.4 Create and configure an Azure App Service
| Rationale | When you add a custom domain to an App Service, you need to validate the domain to verify domain ownership. To verify domain ownership for contoso.com you will create a txt record that contains the Custom Domain Verification ID. The CNAME record is used to map www.contoso.com to webapp.azurewebsites.net.
| URL:      | https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain?tabs=cname
</details>

### Question # 11 (Multiple Choice)

You have an Azure subscription that contains a virtual machine named VM1.

VM1 requires volume encryption for its operating system and data disks.

You create an Azure key vault named vault1.

You need to configure vault1 to support Azure Disk Encryption for volume encryption.

Which setting should you modify for vault1?

* A. Keys
* B. Secrets
* C. Access policies
* D. Security

<details>
  <summary>Click me</summary>


| Item      | Description
| -------   | -------------------------------
| Answer    | C
| Objective | 3.2 Create and configure VMs
| Rationale | To enable support for Azure Disk Encryption, you need to modify the Access policies for the key vault. This provides an option to enable access to Azure Disk Encryption for volume encryption.
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-machines/windows/disk-encryption-key-vault

</details>

### Question # 12 (Multiple Choice)

You have an Azure subscription that contains the resources shown in the following table.

![Backup ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/backup-12.jpg)

Which two resources can you back up to a Recovery Services vault? Each correct presents part of the solution.

* A. VM1
* B. blob1
* C. Disk1
* D. share1
* E. Database1

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | A AND D
| Objective | 5.2 Implement backup and recovery
| Rationale | Recovery Services vault supports Azure Virtual Machines, SQL in Azure VM, Azure Files, SAP HANA in Azure VM, Azure Backup Server, Azure Backup Agent, and DPM. Backup vault supports Azure Database for PostgreSQL servers, Azure Blobs, and Azure disks.
| URL:      | https://learn.microsoft.com/en-us/azure/backup/backup-support-matrix#vault-support , https://learn.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview , https://learn.microsoft.com/en-us/azure/backup/backup-vault-overview
</details>


### Case Study

#### Overview
Contoso, Ltd. is a consulting company. The company has a main office in Vancouver and branch offices in Seattle and New York.

##### Existing Environment
Azure Environment
Contoso has two Azure subscriptions named ContosoSub1 and ContosoSub2.

ContosoSub1 has the resource group shown in the following table.

![Contoso sub 1 resources ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-resources1.jpg)

ResourceGroup1 contains the resources shown in the following table.

![Contoso resources rg1 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-resources-rg1.jpg)

ContosoSub2 has the resource group shown in the following table.

![Contoso sub 2 resources ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-resources2.jpg)

ResourceGroup2 contains the resources shown in the following table.

![Contoso resources rg2 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-resources-rg2.jpg)

Contoso has an Azure Active Directory (Azure AD) tenant named contoso.com that contains the user accounts shown in the following table.

![Contoso ad ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-ad.jpg)

Azure Storage Environment

ContosoSub1 contains the storage accounts shown in the following table.

![Contoso sub1 storage accounts ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-storage.jpg)

Contoso has the Recovery Service vaults shown in the following table.

![Contoso recovery service vault ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-contoso-recvault.jpg)


##### Problem Statement
Administrators share the contosostorage2 access key with external users.
Replication costs for backups are over budget.

##### Requirements

##### Planned Changes

Contoso plans to implement the following changes:

* Configure backups to use locally-redundant storage (LRS) replication whenever possible.
* Hire 125 new employees, each of whom will require an account created in the tenant.
* Delegate User1 to manage all the user and group accounts in the New York office.
* Delegate User2 to manage all the user and group accounts in the Seattle office.
* Deploy a new Azure virtual machine named DevVM1 that will run Windows 10.
* Create peering between Vnet1 and Vnet2.
* Move Disk1 to ResourceGroup2.

##### Technical Requirements

Contoso must meet the following technical requirements:

* For supported storage accounts, data not accessed for 60 days must be moved automatically to cool storage. Data not accessed for 120 days must be moved automatically to archive storage.
* DevVM1 must be accessible from the Azure portal over TLS and provide seamless RDP/SSH connectivity.
* Delegated administrative permissions must be scoped to specific locations.
* Administrative effort and costs must be minimized whenever possible.
* The principle of least privilege must be used.

##### Security Requirements

Contoso must meet the following security requirements:

* User access to storage account data must be granted for a specified start and expiration date and time.
* DevVM1 must be protected from port scanning from outside the virtual network.
* Storage account access keys must not be shared directly with users.

### Question # 13 (Multiple Choice)
Answer the following question based on the information presented in the case study.

Which administrator can implement the planned changes for the new employees?

* A. Admin1 only
* B. Admin2 only
* C. Admin3 only
* D. Admin1 and Admin2 only
* E. Admin1 and Admin3 only

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | B 
| Objective | Objective 1.1: Manage Azure Active Directory (Azure AD) objects
| Rationale | ![answer 13 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-13.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/users-bulk-add
</details>


### Question # 14 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to implement the planned changes for User1 and User2.

What should you do first?

* A. Create two new resource groups.
* B. Create two new management groups.
* C. Create two new named locations.
* D. Create two new administrative units.

<details>
  <summary>Click me</summary>


| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | Objective 1.1: Manage Azure Active Directory (Azure AD) objects
| Rationale | ![answer 14 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-14.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/roles/administrative-units
</details>

### Question # 15 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to implement the planned changes for Disk1.

What should you do first?

* A. Add ContosoSub1 and ContosoSub2 to a new management group.
* B. Remove Lock1 from ResourceGroup1.
* C. Modify the RG:1 tag.
* D. Remove Lock2 from ResourceGroup2.

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 1.3 Manage Azure subscriptions and governance
| Rationale | ![answer 15 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-15.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json
</details>

### Question # 16 (Multiple Choice)
Answer the following question based on the information presented in the case study.

Which storage accounts meet the technical requirements?

* A. contosostorage1 and contosostorage4 only
* B. contosostorage2 and contosostorage3 only
* C. contosostorage1 and contosostorage3 only
* D. contosostorage2 and contosostorage4 only

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | C
| Objective | 2.3 Configure Azure files and Azure Blob Storage
| Rationale | ![answer 16 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-16.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview
</details>

### Question # 17 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to address the issue that relates to contosostorage2. The solution must meet the security requirements.

What should you do?

* A. Set a rotation reminder for the access keys.
* B. Configure a lifecycle management rule.
* C. Create a new access review.
* D. Generate a shared access signature (SAS).

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 2.1 Configure access to storage
| Rationale | ![answer 17 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-17.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview
</details>

### Question # 18 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to implement the planned changes for Vnet1 and Vnet2.

What should you do first?

* A. Move Vnet1 to the East US Azure region.
* B. Move Vnet2 to the ContosoSub1 subscription.
* C. Modify the tag for Vnet2.
* D. Modify the address space for Vnet1.

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 4.1 Configure virtual networks
| Rationale | ![answer 18 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-18.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering
</details>

### Question # 19 (Multiple Choice)
Answer the following question based on the information presented in the case study.

Before you deploy DevVM1, you need to consider the technical and security requirements.

What should you do to ensure that access to DevVM1 is secure?

* A. Install the Remote Desktop client on all the devices that will connect to DevVM1.
* B. Deploy the Azure Bastion service.
* C. Configure Remote Desktop Gateway on all the devices that will connect to DevVM1.
* D. Configure the Azure Network Watcher service.

<details>
  <summary>Click me</summary>

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 4.2 Configure secure access to virtual networks
| Rationale | ![answer 19 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-19.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering
</details>

#### Question # 20 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to resolve the issue that relates to the replication costs for backups.

Which Recovery Services vault can be configured to use locally-redundant storage (LRS) replication?

* A. Rsv1 only
* B. Rsv2 only
* C. Rsv3 only
* D. Rsv1 and Rsv2 only
* E. Rsv1, Rsv2, and Rsv3

<details>
  <summary>Click me</summary>
  
| Item      | Description
| -------   | -------------------------------
| Answer    | C
| Objective | 5.2 Implement backup and recovery
| Rationale | ![answer 20 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-20.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering
</details>






## Practice Assessments for Microsoft Certifications

Links

Practice Assessments for Microsoft Certifications

https://learn.microsoft.com/en-us/certifications/practice-assessments-for-microsoft-certifications


## Questions

### Question # 21


You have an Azure subscription that contains the following StorageV2 (general purpose v2) storage accounts:

* store1 is a Premium account that uses geo-redundant storage (GRS) redundancy.
* store2 is a Standard account that uses locally-redundant storage (LRS) redundancy.
* store3 is a Premium account that uses read-access geo-redundant storage (RA-GRS) redundancy.
* store4 is a Premium account that uses RA-GRS redundancy.

You need to identify which storage account can be converted to zone-redundant replication (ZRS) for live migration.

Which storage account should you identify?

* store1
* store2
* store3
* store4

<details>
  <summary>Click me</summary>


store2

Only zone-redundant replication (ZRS) supports StorageV2, FileStorage, and BlockBlobStorage accounts. 
Live migration is not supported for read-access geo-redundant storage (RA-GRS) and only standard storage accounts can be used.

</details>


### Question # 22


You plan to configure object replication between two Azure Storage accounts.

* Change feed
* Blob soft delete
* Hierarchical namespace
* Versioning

<details>
  <summary>Click me</summary>

Versioning

Versioning must be enabled for both the source and destination accounts. 

</details>


### Question # 23


You plan to create an alert in Azure Monitor that will have an action group to send SMS messages.

What is the maximum number of SMS messages that will be sent every hour if the alert gets triggered every minute?

* 4
* 6
* 12
* 60

<details>
  <summary>Click me</summary>

12

A maximum of one SMS message can be sent every five minutes. Therefore, a maximum of 12 messages will be sent per hour.

</details>

### Question # 24


You have an Azure virtual network that contains two subnets named Subnet1 and Subnet2. You have a virtual machine named VM1 that is connected to Subnet1. VM1 runs Windows Server.

You need to ensure that VM1 is connected directly to both subnets.

What should you do first?


* From the Azure portal, create an IP group.
* From the Azure portal, add a network interface.
* Sign in to Windows Server and create a network bridge.
* From the Azure portal, modify the IP configurations of an existing network interface.

<details>
  <summary>Click me</summary>

From the Azure portal, add a network interface.

From the Azure portal, add a network interface.
A network interface is used to connect a virtual machine to a subnet. Since VM1 is connected to Subnet1, VM1 already has a network interface attached that is connected to Subnet1. 
To connect VM1 directly to Subnet2, you must create a new network interface that is connected to Subnet2. Next, you must attach the new network interface to VM1.

</details>


### Question # 25


You have an Azure virtual network named VNet1.

You deploy an Azure App Service web app named WebApp1.

You need to ensure that you can access WebApp1 by using an IP address from VNet1.

What should you do?

* Add a peering to VNet1.
* Deploy Azure Bastion to VNet1.
* Add VNet integration to WebApp1.
* Add a private endpoint connection to WebApp1.

<details>
  <summary>Click me</summary>

Add a private endpoint connection to WebApp1.

A private endpoint connection will expose a web app on a virtual network and provide the web app with an IP address on the virtual network. 
The web app can then be accessed through the virtual network instead of using the public endpoint.

https://learn.microsoft.com/azure/app-service/networking/private-endpoint

</details>

### Question # 26


You have an Azure subscription that contains a resource group named RG1. RG1 contains a virtual machine named VM1 connected to a virtual network named Network1.

A user named Admin1 must be able to change the settings of Network1.

You need to use PowerShell to assign Admin1 the appropriate role and permissions.

Which two PowerShell statements should you use to complete the task? Each correct answer presents part of the solution.

* $User = Get-AzADServicePrinciple -DisplayName admin1
* New-AzRoleAssignment -ObjectId $User.id ` -RoleDefinitionName "Network Contributor" ` -ResourceName Network1 ` -ResourceType Microsoft.Network/virtualNetworks ` -ResourceGroupName RG1
* New-AzRoleAssignment -ObjectId $User.id ` -RoleDefinitionName "Virtual Machine Contributor" ` -ResourceGroupName RG1
* $User = Get-AzADUser -DisplayName admin1

<details>
  <summary>Click me</summary>

* New-AzRoleAssignment -ObjectId $User.id ` -RoleDefinitionName "Network Contributor" ` -ResourceName Network1 ` -ResourceType Microsoft.Network/virtualNetworks ` -ResourceGroupName RG1
* $User = Get-AzADUser -DisplayName admin1


Before assigning an RBAC role to a user, you must use the Get-AzADUser cmdlet to obtain the ID of the user. 
The New-AzRoleAssignment cmdlet can be used to assign an RBAC role to any resource. 
If you assign the Virtual Machine Contributor role to RG1, it will only allow changes to the virtual machine, it will not allow Admin1 to manage the virtual network. 
To modify network settings, you must assign the Network Contributor role.


</details>


### Question # 27


You need to create a custom RBAC role from the Reader role

* Get-AzRoleDefinition Reader | ConvertTo-Json 
* Get-AzRoleAssignment | ConvertTo-Json 
* Get-AzRoleAssignment | ConvertFrom-Json 
* Get-AzRoleDefinition Reader | ConvertFrom-Json 

Which PowerShell statements should you use to complete the task?

<details>
  <summary>Click me</summary>


Get-AzRoleDefinition Reader | ConvertTo-Json 

Get-AzRoleDefinition Reader | ConvertTo-Json  is correct

https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles-powershell

Lists Azure RBAC role assignments at the specified scope. By default it lists all role assignments in the selected Azure subscription.

Example

Get-AzRoleAssignment -SignInName user@someaccount.onmicrosoft.com

https://learn.microsoft.com/en-us/powershell/module/az.resources/get-azroleassignment?view=azps-9.6.0



</details>


### Question # 28

Note: This question is part of a series of questions that present the same scenario. Each question in the series contains a unique solution that might meet the stated goals. Some question sets might have more than one correct solution, while others might not have a correct solution.
After you answer a question in this section, you will NOT be able to return to it. As a result, these questions will not appear in the review screen.


You have an Azure Active Directory (Azure AD) tenant named contoso.com.
You have a CSV file that contains the names and email addresses of 500 external users.
You need to create a guest user account in contoso.com for each of the 500 external users.
Solution: You create a PowerShell script that runs the New-AzureADMSInvitation cmdlet for each external user.
Does this meet the goal?

* A:Yes
* B:No

<details>
  <summary>Click me</summary>

A:Yes

This cmdlet is used to invite a new external user to your directory.

https://learn.microsoft.com/en-us/powershell/module/azuread/new-azureadmsinvitation?view=azureadps-2.0

Use the New-AzureADMSInvitation cmdlet which is used to invite a new external user to your directory.
Reference:
https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureadmsinvitation


</details>


### Question # 29

Your company has three virtual machines (VMs) that are included in an availability set.
You try to resize one of the VMs, which returns an allocation failure message.
It is imperative that the VM is resized.
Which of the following actions should you take?

* A. You should only stop one of the VMs.
* B. You should stop two of the VMs.
* C. You should stop all three VMs. Most Voted
* D. You should remove the necessary VM from the availability set.

<details>
  <summary>Click me</summary>

* C. You should stop all three VMs. Most Voted

If the VM you wish to resize is part of an availability set, then you must stop all VMs in the availability set before changing the size of any VM in the availability set.
The reason all VMs in the availability set must be stopped before performing the resize operation to a size that requires different hardware is that all running VMs in the availability set must be using the same physical hardware cluster. Therefore, if a change of physical hardware cluster is required to change the VM size then all VMs must be first stopped and then restarted one-by-one to a different physical hardware clusters.

https://github.com/MicrosoftDocs/SupportArticles-docs/blob/main/support/azure/virtual-machines/restart-resize-error-troubleshooting.md


</details>

### Question # 30

Note: The question is included in a number of questions that depicts the identical set-up. However, every question has a distinctive result. Establish if the solution satisfies the requirements.

Your company's Azure subscription includes two Azure networks named VirtualNetworkA and VirtualNetworkB.
VirtualNetworkA includes a VPN gateway that is configured to make use of static routing. Also, a site-to-site VPN connection exists between your company's on- premises network and VirtualNetworkA.
You have configured a point-to-site VPN connection to VirtualNetworkA from a workstation running Windows 10. After configuring virtual network peering between
VirtualNetworkA and VirtualNetworkB, you confirm that you are able to access VirtualNetworkB from the company's on-premises network. However, you find that you cannot establish a connection to VirtualNetworkB from the Windows 10 workstation.
You have to make sure that a connection to VirtualNetworkB can be established from the Windows 10 workstation.
Solution: You download and re-install the VPN client configuration package on the Windows 10 workstation.
Does the solution meet the goal?

A. Yes
B. No

<details>
  <summary>Click me</summary>

A. Yes

https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-point-to-site-routing

</details>


### Question # 31

Your company has virtual machines (VMs) hosted in Microsoft Azure. The VMs are located in a single Azure virtual network named VNet1.
The company has users that work remotely. The remote workers require access to the VMs on VNet1.
You need to provide access for the remote workers.

What should you do?

* A. Configure a Site-to-Site (S2S) VPN.
* B. Configure a VNet-toVNet VPN.
* C. Configure a Point-to-Site (P2S) VPN.
* D. Configure DirectAccess on a Windows Server 2012 server VM.
* E. Configure a Multi-Site VPN

<details>
  <summary>Click me</summary>

C. Configure a Point-to-Site (P2S) VPN.

A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer.


https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways

</details>