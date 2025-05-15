
# Powershell my own quickguide

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