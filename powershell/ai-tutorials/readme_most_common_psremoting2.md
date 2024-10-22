# Can you make a tutorial about Enable-PSRemoting and labs for practice it? Please also add what ports are used.

## **Enable-PSRemoting Tutorial**
==========================

**What is Enable-PSRemoting?**
-----------------------------

`Enable-PSRemoting` is a PowerShell cmdlet that enables PowerShell Remoting on a local computer. PowerShell Remoting allows you to run PowerShell commands on remote computers.

**Prerequisites**
-----------------

* Windows PowerShell 2.0 or later
* Windows operating system (Windows 7, Windows 8, Windows 10, Windows Server 2008 R2, Windows Server 2012, Windows Server 2016, Windows Server 2019)

**Ports Used by PowerShell Remoting**
--------------------------------------

PowerShell Remoting uses the following ports:

* **5985**: This is the default port used by PowerShell Remoting for HTTP connections.
* **5986**: This is the default port used by PowerShell Remoting for HTTPS connections.
* **80**: This port is used by PowerShell Remoting for HTTP connections when the `UseSSL` parameter is not specified.
* **443**: This port is used by PowerShell Remoting for HTTPS connections when the `UseSSL` parameter is specified.

**Enabling PSRemoting**
----------------------

To enable PSRemoting, follow these steps:

1. **Open PowerShell as Administrator**: Right-click on the PowerShell icon and select "Run as Administrator".
2. **Run the Enable-PSRemoting cmdlet**: Type the following command and press Enter:
```
Enable-PSRemoting -Force
```
The `-Force` parameter is optional, but it will automatically answer "yes" to any prompts that appear during the enabling process.

**Verifying PSRemoting**
----------------------

To verify that PSRemoting is enabled, follow these steps:

1. **Run the Get-PSSessionConfiguration cmdlet**: Type the following command and press Enter:
```
Get-PSSessionConfiguration
```
This cmdlet will display the current session configurations on the local computer.
2. **Check the Permission**: Make sure the permission is set to "NT AUTHORITY\NETWORK" or "Everyone" for the `Microsoft.PowerShell` session configuration.

**Configuring Windows Firewall**
-------------------------------

To allow PowerShell Remoting to work, you need to configure the Windows Firewall to allow incoming connections on the ports used by PowerShell Remoting. You can do this by running the following command:
```
netsh advfirewall firewall add rule name="PowerShell Remoting" dir=in action=allow protocol=TCP localport=5985
```
This will add a new rule to the Windows Firewall that allows incoming connections on port 5985.

**Lab Exercises**
-----------------

### Lab 1: Enabling PSRemoting on a Local Computer

* Open PowerShell as Administrator on your local computer.
* Run the `Enable-PSRemoting -Force` cmdlet to enable PSRemoting.
* Verify that PSRemoting is enabled by running the `Get-PSSessionConfiguration` cmdlet.

### Lab 2: Creating a Remote Session

* Open PowerShell on your local computer.
* Create a new remote session to a remote computer using the `New-PSSession` cmdlet:
```powershell
$session = New-PSSession -ComputerName <RemoteComputerName>
```
Replace `<RemoteComputerName>` with the name of the remote computer.
* Verify that the remote session is created by running the `Get-PSSession` cmdlet.

### Lab 3: Running Commands on a Remote Computer

* Open PowerShell on your local computer.
* Create a new remote session to a remote computer using the `New-PSSession` cmdlet.
* Run a command on the remote computer using the `Invoke-Command` cmdlet:
```powershell
Invoke-Command -Session $session -ScriptBlock { Get-Process }
```
This will run the `Get-Process` cmdlet on the remote computer and display the results on your local computer.

### Lab 4: Disabling PSRemoting

* Open PowerShell as Administrator on your local computer.
* Run the `Disable-PSRemoting -Force` cmdlet to disable PSRemoting.
* Verify that PSRemoting is disabled by running the `Get-PSSessionConfiguration` cmdlet.

### Lab 5: Configuring Windows Firewall

* Open PowerShell as Administrator on your local computer.
* Run the `netsh advfirewall firewall add rule` command to add a new rule to the Windows Firewall that allows incoming connections on port 5985.
* Verify that the new rule is added by running the `netsh advfirewall firewall show rule` command.

**Troubleshooting Tips**
-------------------------

* Make sure that the Windows Firewall is enabled and configured to allow PowerShell Remoting.
* Make sure that the remote computer is configured to allow PowerShell Remoting.
* Check the event logs for any errors related to PowerShell Remoting.

**Conclusion**
----------

In this tutorial, you learned how to enable PSRemoting on a local computer and create a remote session to a remote computer. You also learned how to run commands on a remote computer using the `Invoke-Command` cmdlet. Finally, you learned how to disable PSRemoting on a local computer and configure the Windows Firewall to allow PowerShell Remoting.

# Can PSRemoting be used the same way as ansible, please make a tutorial about it with examples.

## **Using PSRemoting as a Configuration Management Tool**
=====================================================

While PSRemoting is not a full-fledged configuration management tool like Ansible, it can be used to manage and configure multiple Windows systems remotely. In this tutorial, we will explore how to use PSRemoting to manage and configure multiple Windows systems.

**Prerequisites**
-----------------

* Windows PowerShell 2.0 or later
* Windows operating system (Windows 7, Windows 8, Windows 10, Windows Server 2008 R2, Windows Server 2012, Windows Server 2016, Windows Server 2019)
* PSRemoting enabled on all target systems

**PSRemoting vs Ansible**
-------------------------

Here's a comparison of PSRemoting and Ansible:

| Feature | PSRemoting | Ansible |
| --- | --- | --- |
| Platform Support | Windows only | Multi-platform |
| Configuration Management | Limited | Advanced |
| Automation | Limited | Advanced |
| Inventory Management | No | Yes |
| Playbook/Script Support | No | Yes |

**Using PSRemoting for Configuration Management**
----------------------------------------------

While PSRemoting is not a full-fledged configuration management tool, it can be used to manage and configure multiple Windows systems remotely. Here are some examples:

### Example 1: Running a Command on Multiple Systems

To run a command on multiple systems, you can use the `Invoke-Command` cmdlet:
```powershell
$servers = @("server1", "server2", "server3")
Invoke-Command -ComputerName $servers -ScriptBlock { Get-Process }
```
This will run the `Get-Process` cmdlet on each of the specified servers and display the results.

### Example 2: Installing Software on Multiple Systems

To install software on multiple systems, you can use the `Invoke-Command` cmdlet:
```powershell
$servers = @("server1", "server2", "server3")
Invoke-Command -ComputerName $servers -ScriptBlock { Install-Package -Name "SoftwarePackage" }
```
This will install the specified software package on each of the specified servers.

### Example 3: Configuring Firewall Rules on Multiple Systems

To configure firewall rules on multiple systems, you can use the `Invoke-Command` cmdlet:
```powershell
$servers = @("server1", "server2", "server3")
Invoke-Command -ComputerName $servers -ScriptBlock { New-NetFirewallRule -DisplayName "Allow Incoming Traffic" -Direction Inbound -Protocol TCP -LocalPort 80 }
```
This will create a new firewall rule on each of the specified servers to allow incoming traffic on port 80.

**Using PSRemoting with PowerShell Scripts**
------------------------------------------

You can use PSRemoting with PowerShell scripts to automate tasks on multiple systems. Here's an example:
```powershell
# script.ps1
param (
    [string[]]$servers
)

Invoke-Command -ComputerName $servers -ScriptBlock {
    # Install software
    Install-Package -Name "SoftwarePackage"

    # Configure firewall rules
    New-NetFirewallRule -DisplayName "Allow Incoming Traffic" -Direction Inbound -Protocol TCP -LocalPort 80

    # Restart the system
    Restart-Computer -Force
}

# Run the script
.\script.ps1 -servers @("server1", "server2", "server3")
```
This script will install software, configure firewall rules, and restart each of the specified servers.

**Conclusion**
----------

In this tutorial, we explored how to use PSRemoting as a configuration management tool to manage and configure multiple Windows systems remotely. While PSRemoting is not a full-fledged configuration management tool like Ansible, it can be used to automate tasks on multiple systems. By using PSRemoting with PowerShell scripts, you can automate complex tasks and simplify your system administration tasks.