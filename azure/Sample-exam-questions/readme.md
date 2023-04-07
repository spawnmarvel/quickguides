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

A. a security group that uses the dynamic membership type
B. a Microsoft 365 group that uses the dynamic membership type
C. a distribution group
D. a security group that uses the assigned membership type
E. a Microsoft 365 group that uses the assigned membership type



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

A. Directory readers
B. Security reader
C. Reports reader
D. Global reader


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

A. From the development tenant, export the custom roles to JSON.
B. From the production tenant, create a new custom role.
C. From the development tenant, perform a backup.
D. From the production tenant, create an administrative unit.


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

A. Action group
B. Security group
C. Distribution group
D. Microsoft 365 group


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

A. PowerShell
B. Azure Resource Manager (ARM) templates
C. app registrations
D. Azure Advisor


| Item      | Description
| -------   | -------------------------------
| Answer    | A AND B
| Objective | 1.3 Manage Azure subscriptions and governance.
| Rationale | Assigning Tags to Virtual machines will allow you create reports and dashboards for Alerting, budget and performance management. Tags can be applied by using PowerShell, Azure CLI, and ARM templates.
| URL:      | https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/decision-guides/resource-tagging/


### Question # 6 (Multiple Choice)

You have an Azure subscription that contains the storage accounts shown in the following table.

![Storage accounts ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Sample-exam-questions/storage-accounts-6.jpg)

| Item      | Description
| -------   | -------------------------------
| Answer    | 
| Objective | 
| Rationale |
| URL:      |


| Item      | Description
| -------   | -------------------------------
| Answer    | 
| Objective | 
| Rationale |
| URL:      |