## POWERSHELL

### Good to know

Using the PowerShell ISE is the preferred way to work with the scripting language, because it provides syntax highlighting, auto-filling of commands and other automation features that simplify script development and testing.

#### ISE
View modules use the ISE

![ISE ](https://github.com/spawnmarvel/quickguides/blob/main/powershell/x_images/power_ise.jpg)

#### Get-ExecutionPolicy

In addition, there is policy that restricts script execution. You can check this policy by running the Get-ExecutionPolicy command in PowerShell:
```ps1
Get-ExecutionPolicy
```

* Restricted— No scripts are allowed. This is the default setting, so you will see it the first time you run the command.
* AllSigned— You can run scripts signed by a trusted developer. With this setting in place, before executing, a script will ask you to confirm that you want to run it.
* RemoteSigned— You can run your own scripts or scripts signed by a trusted developer.
* Unrestricted— You can run any script you want.

#### Set-ExecutionPolicy RemoteSigned

To start working with ps1
```ps1 
Set-ExecutionPolicy RemoteSigned
```

## Powershell Tutorial (Tutorialspoint)

https://www.tutorialspoint.com/powershell/index.htm

View the Windows Powershell Language quick reference also

https://github.com/spawnmarvel/powershell-cmd/tree/master/x_quick_reference_pdf



### Cmdlets
A cmdlet is a PowerShell command with a predefined function, similar to an operator in a programming language, A cmdlet always consists of a verb (or a word that functions as a verb) and a noun, separated with a hyphen (the “verb-noun” rule). For example, some of the verbs include:

* Get — To get something
* Set — To define something
* Start — To run something
* Stop — To stop something that is running
* Out — To output something
* New — To create something (“new” is not a verb, of course, but it functions as one)


### The Three Core Cmdlets in PowerShell

* Get-Command
* Get-Help
* Get-Member

https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/02-help-system?view=powershell-7.3

Good news — you don’t need to memorize all cmdlets, use Get-Command

Get-Command:

```ps1
Get-Command
# CommandType     Name                                               Version    Source
# -----------     ----                                               -------    ------
# Alias           Add-AdlAnalyticsDataSource                         1.0.2      Az.DataLakeAnalytics
# [...]
```
Get-Help:

The Get-Help cmdlet displays information about PowerShell concepts and commands, including cmdlets, functions, Common Information Model (CIM) commands, workflows, providers, aliases, and scripts.

```ps1
# Get-Help cmdlet
Get-Help Get-Service
# NAME
#    Get-Service
# SYNTAX
#    Get-Service [[-Name] <string[]>] [-DependentServices] [-RequiredServices] [-Include <string[]>] [-Exclude <string[]
#    >] [<CommonParameters>]
# [...]
```
Get-Member:

If you forget a cmdlet’s parameters, use cmdlet | Get-Member, which will display the parameters for the Get-Process cmdlet:
```ps1
Get-Service | Get-Member
#    TypeName: System.Service.ServiceController#StartupType
# Name                      MemberType    Definition
# ----                      ----------    ----------
# Name                      AliasProperty Name = ServiceName

# We can then do the query
Get-Service -Name W*
# Status   Name               DisplayName
# ------   ----               -----------
# Running  W32Time            Windows Time
# Stopped  WaaSMedicSvc       Windows Update Medic Service
```

If you still don’t find the cmdlet you need, you can make sure that help is updated.
Then get examples for a cmdlet

```ps1
# To update the help data
Update-Help

# Get examples for a cmdlet
Get-Help Get-Process -Examples
# --------- Example 1: Get all services on the computer ---------
#    Get-Service
#    --- Example 2: Get services that begin with a search string ---
#    Get-Service "wmi*"

```
### Pipes
The pipe | A pipe passes data from one cmdlet to another
For example, if you execute the following script, you’ll get all services sorted by their status:
```ps1
# Get service info and sort by status
Get-Service | Sort-Object -property Status

# Output dir to text
"File-content" | Out-File out.txt

# Write-Output sends the output to the pipeline. From there it can be piped to another cmdlet or assigned to a variable. 
# Write-Output sends the data as an object through the pipeline. In the example it will just pass a string.
$a = 'Data to pipe'  | Write-Output
#  Write-Host sends it directly to the console.
$b = 'Data gone out' | Write-Host
# Data gone out
Get-Variable a,b
# Name                           Value
# ----                           -----
# a                              Data to pipe
# b

# Get all services where name starts with W store in var
$a = Get-Service -Name W* | Write-Output
# Get the type
Write-Host $a.GetType()
# Iterate over list
foreach($element in $a) {

 if($element.Name -eq "WinRM") {
   # do stuff with match
  Write-Host $element.Name
  }
  else {
  #
  }
  }

```

### about_Pipelines
A pipeline is a series of commands connected by pipeline operators (|) (ASCII 124). Each pipeline operator sends the results of the preceding command to the next command.

```ps1
# Command-1 | Command-2 | Command-3

# Here is a simple example. The following command gets the Notepad process and then stops it.
Get-Process notepad | Stop-Process

# This pipeline example gets the text files in the current directory, selects only the files that are more than 10,000 bytes long, sorts them by length, and displays the name and length of each file in a table.
Get-ChildItem -Path *.txt |
  Where-Object {$_.length -gt 10000} |
    Sort-Object -Property length |
      Format-Table -Property name, length
```

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pipelines?view=powershell-7.3

### Files and Folders

https://www.tutorialspoint.com/powershell/powershell_files_folders.htm

### Date and Time

https://www.tutorialspoint.com/powershell/powershell_dates_timers.htm

### Files/IO

```ps1
# Read XML
Get-Content test.xml 

```

Text, XML, CSV, HTML

https://www.tutorialspoint.com/powershell/powershell_files_io.htm

### Functions
Note: If you edit a function, clear the session or start a new terminal. Path is important also.

```ps1



# Function 1
function Get-Version {
    $PSVersionTable.PSVersion
}
# Call it
Get-Version

# Conflict with for example Get-Version, add prefix "PS".
function Get-PSVersion {
    $PSVersionTable.PSVersion
}

# There is still a good change you could end up with a naming conflict, choose a standard and stick with it.
function Get-CustPSVersion {
    $PSVersionTable.PSVersion
}
# Funtion example
Function Add-CustPSLogOut {
    param (
        [string]$ParameterText
    )
    Add-Content log.txt $ParameterText
}
# Call it
Add-CustPSLogOut("say something to log")

function Get-MrParameterCount {
    param (
        [string[]]$ParameterName
    )

    foreach ($Parameter in $ParameterName) {
        $Results = Get-Command -ParameterName $Parameter -ErrorAction SilentlyContinue

        [pscustomobject]@{
            ParameterName = $Parameter
            NumberOfCmdlets = $Results.Count
        }
    }
}
```
Naming
* Pascal case, name with an approved verb and a singular noun
* In PowerShell, there's a specific list of approved verbs that can be obtained by running Get-Verb.
* Get-Verb | Sort-Object -Property Verb

https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.3

### Advanced CMDlets

```ps1
# Get stopped services.
Get-Service | Where-Object {$_.Status -eq "Stopped"}

# Get the file details in a variable.
$A = Get-ChildItem D:\temp\test\*.txt

# In this example, we'll divide integer in an array. We'll refer to each object using $_.
1000,2000,3000 | ForEach-Object -Process {$_/1000}

# In this example, we'll create objects using Process properties.
Get-Process | Select-Object -Property ProcessName, Id, WS -Last 5

```

https://www.tutorialspoint.com/powershell/powershell_advanced_cmdlets.htm

### Scripting

* Cmdlets − Cmdlets perform common system administration tasks, for example managing the registry, services, processes, event logs, and using Windows Management Instrumentation (WMI).
* Object based − PowerShell possesses powerful object manipulation capabilities. Objects can be sent to other tools or databases directly.
* [...]

https://www.tutorialspoint.com/powershell/powershell_scripting.htm

# Special Variables

| Operator | Desc
| -------- | ---
|$$        | Represents the last token in the last line received by the session.
|$?        | Represents the execution status of the last operation. It contains TRUE if the last operation succeeded and FALSE if it failed.
|$_        | Same as $PSItem. Contains the current object in the pipeline object. You can use this variable in commands that perform an action on every object or on selected objects in a pipeline.
|$ARGS     | Represents an array of the undeclared parameters and/or parameter values that are passed to a function, script, or script block.
|$FALSE    | Represents FALSE. You can use this variable to represent FALSE in commands and scripts instead of using the string "false".
|[...]|
|$HOME     | C:\Users\jekl
|$PSITEM   | Same as $_. Contains the current object in the pipeline object.
|[...]|
|$NULL     | $null is an automatic variable that contains a NULL or empty value. You can use this variable to represent an absent or undefined value in commands and scripts. https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-null?view=powershell-7.3
|[...]|


https://www.tutorialspoint.com/powershell/powershell_special_variables.htm



### Operators

https://www.tutorialspoint.com/powershell/powershell_operators.htm

|Operator | Description | Example
| ------- | ----------- | -----
|eq (equals)| Compares two values to be equal or not.| A -eq B will give false
|ne (not equals) ||
|gt (greater than)||
|ge (greater than or equals to)||
|lt (less than)||
|le (less than or equals to)||

Matching

* -like, -ilike, -clike - string matches wildcard pattern
* -notlike, -inotlike, -cnotlike - string doesn't match wildcard pattern
* -match, -imatch, -cmatch - string matches regex pattern
* -notmatch, -inotmatch, -cnotmatch - string doesn't match regex pattern

Replacement
* -replace, -ireplace, -creplace - replaces strings matching a regex pattern

Containment
* -contains, -icontains, -ccontains - collection contains a value
* -notcontains, -inotcontains, -cnotcontains - collection doesn't contain a value
* -in - value is in a collection
* -notin - value isn't in a collection

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.3

### Looping

```ps1
#for loop
$array = @("item1", "item2", "item3")
 
for($i = 0; $i -lt $array.length; $i++){ $array[$i] }
item1
item2
item3

# forEach loop
$array = @("item1", "item2", "item3")
 
foreach ($element in $array) { $element }
item1
item2
item3

# while loop
$array = @("item1", "item2", "item3")
$counter = 0;

while($counter -lt $array.length){
   $array[$counter]
   $counter += 1
}
 
item1
item2
item3

# do.. while loop
$array = @("item1", "item2", "item3")
$counter = 0;

do {
   $array[$counter]
   $counter += 1
} while($counter -lt $array.length)
 
item1
item2
item3 
```

https://www.tutorialspoint.com/powershell/powershell_looping.htm

### Conditions

```ps1
# if
if(Boolean_expression) {
   // Statements will execute if the Boolean expression is true
}

# if else
if(Boolean_expression) {
   // Executes when the Boolean expression is true
}else {
   // Executes when the Boolean expression is false
}

# nested
if(Boolean_expression 1) {
   // Executes when the Boolean expression 1 is true
   if(Boolean_expression 2) {
      // Executes when the Boolean expression 2 is true
   }
}

# switch
switch(<test-value>) {
   <condition> {<action>} 
      break; // optional
   <condition> {<action>} 
      break; // optional
   <condition> {<action>} 
      break; // optional
}
```
https://www.tutorialspoint.com/powershell/powershell_conditions.htm

### Array

```ps1
$myList = 5.6, 4.5, 3.3, 13.2, 4.0, 34.33, 34.0, 45.45, 99.993, 11123

write-host("Print all the array elements")
$myList

write-host("Get the length of array")
$myList.Length

write-host("Get Second element of array")
$myList[1]

write-host("using for loop")
for ($i = 0; $i -le ($myList.length - 1); $i += 1) {
  $myList[$i]
}

write-host("using forEach Loop")
foreach ($element in $myList) {
  $element
}

write-host("using while Loop")
$i = 0
while($i -lt 4) {
  $myList[$i];
  $i++
}

write-host("Assign values")
$myList[1] = 10
$myList
```

https://www.tutorialspoint.com/powershell/powershell_array.htm

### Hashtables

```ps1
$hash = @{ ID = 1; Shape = "Square"; Color = "Blue"}

write-host("Print all hashtable keys")
$hash.keys

write-host("Print all hashtable values")
$hash.values

write-host("Get ID")
$hash["ID"]

write-host("Get Shape")
$hash.Number

write-host("print Size")
$hash.Count

write-host("Add key-value")
$hash["Updated"] = "Now"

write-host("Add key-value")
$hash.Add("Created","Now")

write-host("print Size")
$hash.Count

write-host("Remove key-value")
$hash.Remove("Updated")

write-host("print Size")
$hash.Count

write-host("sort by key")
$hash.GetEnumerator() | Sort-Object -Property key
```

https://www.tutorialspoint.com/powershell/powershell_hashtables.htm

### Regex

https://www.tutorialspoint.com/powershell/powershell_regex.htm

### Backtick
```ps1
Get-Service * | Sort-Object ServiceType `
| Format-Table Name, ServiceType, Status -AutoSize
```

https://www.tutorialspoint.com/powershell/powershell_backticks.htm

### Brackets

```ps1
# Parenthesis brackets. − ()
# Braces brackets. − {}
# Square brackets. − []
$array = @("item1", "item2", "item3")
 
for($i = 0; $i -lt $array.length; $i++){ $array[$i] }
item1
item2
item3

```

https://www.tutorialspoint.com/powershell/powershell_brackets.htm

### Creating Alias

```ps1
# Create alias
New-Alias -Name gs -Value Get-Service

# Use alias
gs
# Status   Name               DisplayName
# ------   ----               -----------
# Stopped  AarSvc_12a85c      Agent Activation Runtime_12a85c
```

https://www.tutorialspoint.com/powershell/powershell_alias.htm


### Custom module
```ps1

# https://thesysadminchannel.com/powershell-module/
# store all functions in (example file name )custom_module.psm1 file
Function Add-LogOut($txt) {
    Add-Content log.txt $txt
}

# Import and call the module functions
Import-Module .\do_make_mdoule\custom_module.psm1

Add-LogOut("Log1")

```

How do you create a script module?

https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/10-script-modules?view=powershell-7.3

## Powershell 101 Microsoft

https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/00-introduction?view=powershell-7.3

## Linux / BASH, Not a tutorial

View the BASH Language quick reference also

https://github.com/spawnmarvel/powershell-cmd/tree/master/x_quick_reference_pdf

## CMD, Not a tutorial, view postfix .cmd files

### Robocopy (just file structure)
``` CMD
robocopy C:\tmp C:\temp2 /e /xf *
```

### Robocopy copy all (run as admin to keep all properties)
``` CMD
REM /e copy subfolders including empty
REM /r:0  Number of retries (default:1000000)
REM /w:o wait time between retires
REM /sec copy files with SECurity
REM /secfix fix file SECurity on all files, even skipped files
REM /timfix fix file TIMes on all files, even skipped
REM /log the log file will come where your path is in cmd
REM /np Specifies that the progress of the copying operation (the number of files or directories copied so far) will not be displayed.
REM /np for faster copy, since it does not write % to log file
REM /mt:32 or 16, 8 is default, hm sometimes this is causing errors, must log all if this is used 
REM It is all about the bandwidth, the cloud can be quick or slow...mt could be danger and give errors!

REM NOTE: /sec /secfix could be problematic between Azure VM and Azure Storage Account File Share (but do you need them?), i.e access denied. 
REM NOTE: Check if you can edit in the container with your user, mainly the security on a folder

REM net use: connect, remove and configure connections to shared resources like mapped drives
net use z: \\WM01\f$
robocopy z:\datacatalog e:\datacatalog /e /r:1 /w:5 /sec /secfix /timfix /log:"F:\robo_log.log" /np
net use z: /del
pause

REM and not map it to z
robocopy \\WM01\f$\datacatalog e:\datacatalog /e /r:1 /w:5 /sec /secfix /timfix /log:"F:\robo_log.log" /np

REM "" path
Robocopy "c:\Program Files (x86)\folder\folder1" "c:\Program Files (x86)\folder\folder2" /e /r:1 /w:5 /sec /secfix /timfix /log:"c:\Program Files (x86)\folder\folder2\robo_log.log" /np
```

[Migrating Data to Microsoft Azure Files MT] [https://azure.microsoft.com/en-us/blog/migrating-data-to-microsoft-azure-files/]

#### MT
MT is the number of threads to use (see discussion below) When using robocopy, you should choose the “/mt” parameter to maximize throughput. This lets you control how many parallel threads do the copy, essentially controlling the queue depth of the IO requests to storage. A very low thread count does not queue enough requests on the server to let you take advantage of the inherent parallelism of our cloud architecture. A very high thread count risks server-side throttling, which end up reducing throughput. In our testing, we have found queue depths between 16 to 32 to be best for maximizing throughput. 

[robocopy-the-ultimate] [https://adamtheautomator.com/robocopy-the-ultimate/]

Note that if you do use /MT, you won’t be able to use /IPG or /EFSRAW. For better performance, don’t output the log to the console. Instead, use /LOG.

Robocopy does not copy open files. Any process may open files for exclusive read access by withholding the FILE_SHARE_READ flag during opening. Even Robocopy's Backup mode will not touch those files.

