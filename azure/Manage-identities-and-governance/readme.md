# Azure Administrator

Manage Azure identities and governance (15–20%)

## Description

Azure Administrator Cheat Sheet

## Links

Learn

https://learn.microsoft.com/en-us/training/paths/az-104-manage-identities-governance/

Study Guide

https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104

## Manage Azure identities and governance (15–20%)

## MS learn AZ-104: Manage identities and governance in Azure

## Configure Azure Active Directory

## Configure user and group accounts

The module concepts are covered in: Manage identities and governance in Azure (15-20%)

Manage Azure Active Directory objects

* Create users and groups
* Manage user and group properties
* Manage device settings
* Perform bulk user updates
* Manage guest accounts

#### Create user accounts

Things to know about user accounts

* Cloud identity
* * A user account with a cloud identity is defined only in Azure AD. 

* Directory-synchronized identity
* * User accounts that have a directory-synchronized identity are defined in an on-premises Active Directory. A synchronization activity occurs via Azure AD Connect to bring these user accounts in to Azure. The source for these accounts is Windows Server Active Directory.

* Guest user
* * Guest user accounts are defined outside Azure.

#### Manage user accounts



#### Create bulk user accounts

Bulk operations, including bulk create and delete for user accounts.

* Azure portal common approach
* Azure Powershell can be used for bulk upload

Only Global administrators or User administrators have privileges to create and delete user accounts in the Azure portal.


![Bulk operations ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Manage-identities-and-governance/bulk_operations.jpg)

##### Bulk create users in Azure Active Directory

Bulk create users in Azure Active Directory

https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/users-bulk-add


Use PowerShell to bulk invite Azure AD B2B collaboration users

* If you use Azure Active Directory (Azure AD) B2B collaboration to work with external partners, you can invite multiple guest users to your organization at the same time via the portal or via PowerShell.
* In this tutorial, you learn how to use PowerShell to send bulk invitations to external users. 

1. Install the latest AzureADPreview module
2. Make sure that you install the latest version of the Azure AD PowerShell for Graph module
3. Get test email accounts
4. You need two or more test email accounts that you can send the invitations to. (NEED 2 OR MORE USERS)
5. Prepare the CSV file
6. Sign in to your tenant
7. Send bulk invitations


In Microsoft Excel, create a CSV file with the list of invitee user names and email addresses. 
Make sure to include the Name and InvitedUserEmailAddress column headings.

For example, create a worksheet in the following format:

![Bulk csv ](https://github.com/spawnmarvel/quickguides/blob/main/azure/Manage-identities-and-governance/bulk_csv.jpg)

```
$invitations = import-csv c:\bulkinvite\invitations.csv

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello. You are invited to the Contoso organization."

foreach ($email in $invitations)
   {New-AzureADMSInvitation `
      -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
      -InvitedUserDisplayName $email.Name `
      -InviteRedirectUrl https://myapps.microsoft.com `
      -InvitedUserMessageInfo $messageInfo `
      -SendInvitationMessage $true
   }

```



https://learn.microsoft.com/en-us/azure/active-directory/external-identities/bulk-invite-powershell

Bulk invite Azure AD B2B collaboration users

https://learn.microsoft.com/en-us/azure/active-directory/external-identities/tutorial-bulk-invite

Enforce multi-factor authentication for B2B guest users

https://learn.microsoft.com/en-us/azure/active-directory/external-identities/b2b-tutorial-require-mfa


## Configure subscriptions

## Configure Azure Policy

## Configure role-based access control


Note

| Built-in role | Description
| ------------- | -----------
| Virtual Machine Contributor | Lets you manage classic virtual machines, but not access to them, and not the virtual network or storage account they're connected to.
|               | 

https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles


#### Create an Azure custom role using Azure PowerShell

https://learn.microsoft.com/en-us/azure/role-based-access-control/tutorial-custom-role-powershell


