
# Powershell quickguide

## Browse all training tags powershell

https://learn.microsoft.com/en-us/training/browse/?terms=powershell


## The first quick quide

https://github.com/spawnmarvel/quickguides/blob/main/powershell/README.md

## Function logger

```ps1

# Function to append to the log file
function Write-Log {
    param(
        [string]$Message
    )
    try {
    
        $logFile = "c:\temp\ps1_log.txt"  #  <-- Add the log file path
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logEntry = "$timestamp - $Message"
        $logEntry | Out-File -FilePath $logFile -Append
        # For console also, ca be commented out
        Write-Host $logEntry
    }
    catch {
        Write-Host "ERROR: Failed to write to log file: $($_.Exception.Message)" -ForegroundColor Red
    }

}

# Example
# Define the target directory and log file path
$targetDirectory = "C:\Program Files\myapp\logs"
Write-Log "Directory '$targetDirectory' done."

```
## Manage variables in Windows PowerShell scripts

```ps1

# To review the variables contained in memory by reviewing the contents of the PowerShell drive named Variable, use the following command:

$MyCounter = 10
Get-ChildItem variable:

# You can also review the variables in memory by using the Get-Variable cmdlet:
Get-Variable

# Variable names aren't case sensitive. The variables $USER and $user are interchangeable. 

# All variables are assigned a type. The variable type determines the data that can be stored in it. In most cases, Windows PowerShell automatically determines the type of a variable during assignment of its value. 
# Automatic assignment of the variable type works well most of the time. 
[Int]$num2 = "5"
[DateTime]$date = "January 5, 2022 10:00AM"

# You can review a variable’s type by appending the GetType() method to the name of the variable.
$MyCounter = 10
$MyCounter.GetType()


# Just as objects in Windows PowerShell have properties and methods, so do variables. 

$MyCounter = 10
$MyCounter.GetType()
$MyCounter | Get-Member


```

Use string variables and methods in Windows PowerShell scripts

```ps1

$MyString = "This is my string"
# The string variable has only one property, Length. 
Write-Host $MyString.Length

# But many methods
$MyString | Get-Member

# example replace method
$MyString.Replace("my string", "a method")

```


https://learn.microsoft.com/en-us/training/modules/manage-variables-windows-powershell-scripts/

## What is the pipeline?

At its core, the pipeline is just the | (pipe) character. You simply put it in between PowerShell commands and it takes the output of one command and feeds it as the input to the next.

For each
```ps1
$dir = "C:\temp2" 
# get all files and folders
$files = $dir | Get-ChildItem

# Loop through each file
foreach ($file in $files) {
  # Check if the file is larger than 100MB
  if ($file.Length -lt 100MB) {
    # Display the file
    write-host $file
  }
}

```
A nested pip does the same

```ps1
$dir = "C:\temp2" 

$all = $dir | Get-ChildItem | Where-Object {$_.Length -lt 100MB}
write-host $all

```
Finding process using more than 300 MB of memory

```ps1
Get-Process | Where-Object {$_.WorkingSet -gt 300mb}
```

Get the service status of services starting with R
```ps1
Get-Service | Where-Object {$_.Name -like "R*"}
```


## Everything you wanted to know about

https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.5

### Use variables, arrays, arraylist and hash tables

```ps1
# You also can create an array by using the output from a command
$files = Get-ChildItem C:\temp\

# To identify what you can do with the content in an array, use the Get-Member cmdlet.
$files | Get-Member

# To review the properties and methods available for an array rather than the items within the array, use the following syntax:
Get-Member -InputObject $files

# To address the shortcomings of arrays, you can use an array list.
[System.Collections.ArrayList]$files = Get-ChildItem C:\temp\

$files | Get-Member
# FullName                  Property       string FullName {get;}
# [...]

# Iterate and use properties
foreach ($file in $files){ 
write-host $file.FullName
}


# To create an array list that's empty and ready to add items, use the following syntax:


$computers=New-Object System.Collections.ArrayList

$computers.Add("VM1")
$computers.Add("VM2")
Write-Host $computers

# If you want to remove an item from an array list based on the index number, you use the RemoveAt() method. For example:
$computers.RemoveAt(1)
Write-Host $computers

# By name
$computers.Remove("VM1")

# Call propertie count
Write-Host $computers.Count
Write-Host $computers

# Define hash tables in Windows PowerShell Scripts
# A hash table represents a similar concept to an array since it stores multiple items. However, unlike an array which uses an index number to identify each item, a hash table uses for this purpose a unique key. The key is a string that's a unique identifier for the item. Each key in a hash table is associated with a value.

$ComputersTable = @{}
# add
$ComputersTable["VM1"] = "10.0.0.11"
$ComputersTable["VM2"] = "10.0.0.12"
# access items
$ComputersTable["VM1"]

```

## Automate administrative tasks by using PowerShell MS Learn

### Discover commands in PowerShell

* Inspect commands to understand how to call them.
* Understand what a command returns and customize what it returns.

```ps1

Get-Help -Name Get-Help

Get-Help -Name Get-Service

Get-Help -Name Get-ChildItem

```

* NAME: Provides the name of the command.
* SYNTAX: Shows ways to call the command by using a combination of flags, and sometimes, allowed parameters.
* ALIASES: Lists any aliases for a command. An alias is a different name for a command, and it can be used to invoke the command.
* REMARKS: Provides information about what commands to run to get more help for this command.
* PARAMETERS: Provides details about the parameter. It lists its type, a longer description, and acceptable values, if applicable.

Filter the help response
If you don't want to display the full help page, narrow the response by adding flags to your Get-Help command. Here are some flags you can use:

* Full: Returns a detailed help page. It specifies information like parameters, inputs, and outputs that you don't get in the standard response.
* Detailed: Returns a response that looks like the standard response, but it includes a section for parameters.
* Examples: Returns only examples, if any exist.
Online: Opens a web page for your command.
* Parameter: Requires a parameter name as an argument. It lists a specific parameter's properties.


```ps1

Get-Help -Name Get-ChildItem -Examples

# Example pip the result for all examples to a file, is better to read that way.
Get-Help -Name Get-ChildItem -Examples | Out-File -FilePath .out.txt

# Example 1: Get child items from a file system directory
Get-ChildItem -Path C:\Test

# Example 2: Get child items in the current directory and subdirectories
Get-ChildItem -Path C:\Test\*.txt -Recurse -Force

# Example 3 When using the -Include parameter, if you don't include an asterisk in the path the command returns no output. Here it returns .txt files only
Get-ChildItem -Path C:\Test\ -Include *.txt
```
Next up https://learn.microsoft.com/en-us/training/modules/discover-commands/4-discover-objects


### Connect commands into a pipeline

### Write your first PowerShell code

### Introduction to scripting in PowerShell

### Automate Azure tasks with Azure PowerShell

https://learn.microsoft.com/en-us/training/paths/powershell/

Next up Browse all training

https://learn.microsoft.com/en-us/training/browse/?terms=powershell

