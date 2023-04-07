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



| Item      | Description
| -------   | -------------------------------
| Answer    | A AND B
| Objective | 1.1 Manage Azure Active Directory (Azure AD) objects
| Rationale | Groups that use dynamic membership rules reduce the overhead of access management by providing attribute-based membership and access to resources. Based on membership rules the membership, and resulting access, can be granted and removed automatically.
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-dynamic-membership


### Question # 2 (Multiple Choice)

You have an Azure Active Directory (Azure AD) tenant named contoso.com.

You need to ensure that a user named User1 can review all the settings of the tenant. User1 must be prevented from changing any settings.

Which role should you assign to User1?

* A. Directory readers
* B. Security reader
* C. Reports reader
* D. Global reader


| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 1.2 Manage access control
| Rationale | A user that is assigned the Global reader role is prevented from making any modifications. The role is a read-only version of Global Administrator that allows the user to read settings and administrative information across all services but can't take management actions.
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference#global-reader


### Question # 3 (Multiple Choice)

You have a production Azure Active Directory (Azure AD) tenant named contoso.com.

You deploy a development Azure Active Directory (AD) tenant, and then you create several custom administrative roles in the development tenant.

You need to copy the roles to the production tenant.

What should you do first?

* A. From the development tenant, export the custom roles to JSON.
* B. From the production tenant, create a new custom role.
* C. From the development tenant, perform a backup.
* D. From the production tenant, create an administrative unit.


| Item      | Description
| -------   | -------------------------------
| Answer    | A
| Objective | 1.2 Manage access control
| Rationale | Creating Custom roles in Azure can be complex due to thousands of permissions so custom roles can be exported as JSON and then imported into a new custom role. The first step is to export the role to a JSON format. A JSON file can then be imported into another tenant; containing all of the details in the custom role.
| URL:      | https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles


### Question # 4 (Multiple Choice)

You have an Azure subscription that contains several hundred virtual machines. You plan to create an Azure Monitor action rule that triggers when a virtual machine uses more than 80% of processor resources for five minutes.

You need to specify the recipient of the action rule notification.

What should you create?

* A. Action group
* B. Security group
* C. Distribution group
* D. Microsoft 365 group


| Item      | Description
| -------   | -------------------------------
| Answer    | A
| Objective | 5.1 Monitor resources by using Azure Monitor
| Rationale | An action group is a collection of notification preferences defined by the owner of an Azure subscription. Azure Monitor, Service Health and Azure Advisor alerts use action groups to notify users that an alert has been triggered.
| URL:      | https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups


### Question # 5 (Multiple Choice)

Your company has 10 different departments.

You have an Azure subscription that contains several hundred virtual machines. The users of each department use only their department’s virtual machines.

You plan to apply resource tags for each department to the virtual machines.

Which two solutions should you use? Each correct presents a complete solution.

* A. PowerShell
* B. Azure Resource Manager (ARM) templates
* C. app registrations
* D. Azure Advisor


| Item      | Description
| -------   | -------------------------------
| Answer    | A AND B
| Objective | 1.3 Manage Azure subscriptions and governance.
| Rationale | Assigning Tags to Virtual machines will allow you create reports and dashboards for Alerting, budget and performance management. Tags can be applied by using PowerShell, Azure CLI, and ARM templates.
| URL:      | https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/decision-guides/resource-tagging/


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

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 2.1 Configure access to storage
| Rationale | Geo-redundant storage (GRS) copies your data synchronously three times within a single physical location in the primary region using LRS. It then copies your data asynchronously to a single physical location in a secondary region that is hundreds of miles away from the primary region. Storage accounts configured with the Premium performance setting only support LRS. Any storage account already configured with ZRS cannot be changed or directly switched to another replication setting. In this scenario, the only storage account that is not set to LRS or Premium performance is storage2, which can be switched to use Geo-redundant storage.
| URL:      | https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy


### Question # 7 (Multiple Choice)

You have an Azure subscription.

You plan to deploy multiple Azure virtual machines by using an Azure Resource Manager (ARM) template.

You need to securely store the credentials that will be used for the deployment.

What should you use?

* A. Azure Active Directory (Azure AD) Identity Protection
* B. Azure Key Vault
* C. Azure storage account
* D. Azure Encryption scopes


| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 3.2 Automate deployment of resources by using templates
| Rationale | You can retrieve secrets from an Azure key vault and pass the secrets as parameters when you deploy an Azure Resource Manager template (ARM template). The parameter value is never exposed, because you can reference only the key vault ID and not the credentials directly.
| URL:      | https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-use-key-vault



### Question # 8 (Multiple Choice)

You have a resource group named RG1 that contains several unused resources.

You need to use the Azure CLI to remove RG1 and all its resources, without requiring a confirmation.

Which command should you use?

* A. az group delete --name rg1 --no-wait --yes
* B. az group deployment delete --name rg1 --no-wait
* C. az group update --name rg1 --remove
* D. az group wait –deleted –resource-group rg1

| Item      | Description
| -------   | -------------------------------
| Answer    | A
| Objective | 1.3 Manage Azure subscriptions and governance
| Rationale | To remove a resource group using Azure CLI you would use the az group delete command. The –no-wait switch specifies to not wait for long-running operations before you can continue using the open command prompt for additional commands, and the –yes switch specifies no prompt for confirmation.
| URL:      | https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az_group_delete&preserve-view=true


### Question # 9 (Multiple Choice)

You have an Azure virtual machine named VM1.

You need to create five additional virtual machines that have the same configurations as VM1. The solution must ensure that VM1 remains available.

From the Azure portal, you open the blade for VM1.

What should you do next?

* A. Select Capture.
* B. Select Availability and scaling.
* C. Select Redeploy + reapply.
* D. Select Export template.

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 3.1 Automate deployment of resources by using templates
| Rationale | If you need to create multiple Azure resources based upon an existing resource, you should export and use a JSON template. You can export a template from the resource itself, from a resource group, or from the deployment history. In this scenario, you would export the template from the VM1 blade. You would only use Capture if you wanted to create an image of the existing VM. However, this will make the source VM unusable. There are also several preparation tasks to complete before capturing the VM image. You would not select Redeploy + reapply as these two options are used to address failed connections or VM states. Availability and scaling is used to set up and manage VM high availability, not for creating additional VMs based upon a set configuration setting.
| URL:      | https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/export-template-portal


### Question # 10 (Multiple Choice)

You have an Azure subscription that contains an Azure App Service web app named webapp1. Webapp1 uses a domain name of webapp1.azurewebsites.net.

You need to add a custom domain named www.contoso.com to webapp1.

You verify the domain ownership.

Which DNS record should you use next?

* A. SRV
* B. CNAME
* C. TXT
* D. PTR

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 3.4 Create and configure an Azure App Service
| Rationale | When you add a custom domain to an App Service, you need to validate the domain to verify domain ownership. To verify domain ownership for contoso.com you will create a txt record that contains the Custom Domain Verification ID. The CNAME record is used to map www.contoso.com to webapp.azurewebsites.net.
| URL:      | https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain?tabs=cname


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


| Item      | Description
| -------   | -------------------------------
| Answer    | C
| Objective | 3.2 Create and configure VMs
| Rationale | To enable support for Azure Disk Encryption, you need to modify the Access policies for the key vault. This provides an option to enable access to Azure Disk Encryption for volume encryption.
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-machines/windows/disk-encryption-key-vault


### Question # 12 (Multiple Choice)

You have an Azure subscription that contains the resources shown in the following table.

![Backup ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/backup-12.jpg)

Which two resources can you back up to a Recovery Services vault? Each correct presents part of the solution.

* A. VM1
* B. blob1
* C. Disk1
* D. share1
* E. Database1


| Item      | Description
| -------   | -------------------------------
| Answer    | A AND D
| Objective | 5.2 Implement backup and recovery
| Rationale | Recovery Services vault supports Azure Virtual Machines, SQL in Azure VM, Azure Files, SAP HANA in Azure VM, Azure Backup Server, Azure Backup Agent, and DPM. Backup vault supports Azure Database for PostgreSQL servers, Azure Blobs, and Azure disks.
| URL:      | https://learn.microsoft.com/en-us/azure/backup/backup-support-matrix#vault-support , https://learn.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview , https://learn.microsoft.com/en-us/azure/backup/backup-vault-overview


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

| Item      | Description
| -------   | -------------------------------
| Answer    | B 
| Objective | Objective 1.1: Manage Azure Active Directory (Azure AD) objects
| Rationale | ![answer 13 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-13.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/users-bulk-add



### Question # 14 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to implement the planned changes for User1 and User2.

What should you do first?

* A. Create two new resource groups.
* B. Create two new management groups.
* C. Create two new named locations.
* D. Create two new administrative units.


| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | Objective 1.1: Manage Azure Active Directory (Azure AD) objects
| Rationale | ![answer 14 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-14.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/active-directory/roles/administrative-units

### Question # 15 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to implement the planned changes for Disk1.

What should you do first?

* A. Add ContosoSub1 and ContosoSub2 to a new management group.
* B. Remove Lock1 from ResourceGroup1.
* C. Modify the RG:1 tag.
* D. Remove Lock2 from ResourceGroup2.


| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 1.3 Manage Azure subscriptions and governance
| Rationale | ![answer 15 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-15.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources?tabs=json


### Question # 16 (Multiple Choice)
Answer the following question based on the information presented in the case study.

Which storage accounts meet the technical requirements?

* A. contosostorage1 and contosostorage4 only
* B. contosostorage2 and contosostorage3 only
* C. contosostorage1 and contosostorage3 only
* D. contosostorage2 and contosostorage4 only

| Item      | Description
| -------   | -------------------------------
| Answer    | C
| Objective | 2.3 Configure Azure files and Azure Blob Storage
| Rationale | ![answer 16 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-16.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview


### Question # 17 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to address the issue that relates to contosostorage2. The solution must meet the security requirements.

What should you do?

* A. Set a rotation reminder for the access keys.
* B. Configure a lifecycle management rule.
* C. Create a new access review.
* D. Generate a shared access signature (SAS).

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 2.1 Configure access to storage
| Rationale | ![answer 17 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-17.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview

### Question # 18 (Multiple Choice)
Answer the following question based on the information presented in the case study.

You need to implement the planned changes for Vnet1 and Vnet2.

What should you do first?

* A. Move Vnet1 to the East US Azure region.
* B. Move Vnet2 to the ContosoSub1 subscription.
* C. Modify the tag for Vnet2.
* D. Modify the address space for Vnet1.

| Item      | Description
| -------   | -------------------------------
| Answer    | D
| Objective | 4.1 Configure virtual networks
| Rationale | ![answer 18 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-18.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering

### Question # 19 (Multiple Choice)
Answer the following question based on the information presented in the case study.

Before you deploy DevVM1, you need to consider the technical and security requirements.

What should you do to ensure that access to DevVM1 is secure?

* A. Install the Remote Desktop client on all the devices that will connect to DevVM1.
* B. Deploy the Azure Bastion service.
* C. Configure Remote Desktop Gateway on all the devices that will connect to DevVM1.
* D. Configure the Azure Network Watcher service.

| Item      | Description
| -------   | -------------------------------
| Answer    | B
| Objective | 4.2 Configure secure access to virtual networks
| Rationale | ![answer 19 ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/case-answer-19.jpg)
| URL:      | https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering