
# Powershell my own quickguide


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

### Arrays

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

```

### hashtables

### PSCustomobject

### String substitution

### if/then/else

### switch

### exceptions

### $null

### ShouldProcess

### Visualize parameter binding