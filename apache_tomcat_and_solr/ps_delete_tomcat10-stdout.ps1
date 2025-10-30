# Task scheduler
# Ensure "Run with highest privileges" is checked.
# Ensure that the task is set to run even if the user is not logged on.
# Action is set to start a program.
# Program/script is set to "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
# Add arguments:
# -ExecutionPolicy Bypass -File "C:\OP\Jobs\ScheduleTasks\ps_delete_tomcat10-stdout.ps1"  <-- Update this path!

# Why?
# delete big files in C:\Program Files\Common Files\AspenTech Shared\Tomcat10.1.16\logs
# named tomcat10-stdout. 

# Define the target directory and log file path
$targetDirectory = "C:\Program Files\Common Files\App Shared\Tomcat10.1.16\logs"
# $logFile = "F:\LogsPS1\deletion_tomcat_stdout_log.txt"  # Log file for tracking deletions

# Function to append to the log file
function Write-Log {
    param(
        [string]$Message
    )
	$logFile = "F:\LogsPS1\deletion_tomcat_stdout_log.txt"  # Log file for tracking deletions
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $Message"
    $logEntry | Out-File -FilePath $logFile -Append
}

# Check if the directory exists
if (-Not (Test-Path -Path $targetDirectory)) {
    Write-Host "The directory '$targetDirectory' does not exist. Exiting script." -ForegroundColor Yellow
    Write-Log "Directory '$targetDirectory' does not exist. Script exited."
    exit
}

# --- Main Logic to Delete Files Starting with "tomcat10-stdout." ---

Write-Host "This script will delete files starting with 'tomcat10-stdout.' in: $targetDirectory" -ForegroundColor Cyan
Write-Log "Attempting to delete files starting with 'tomcat10-stdout.' in '$targetDirectory'."

try {
    # Get files starting with "tomcat10-stdout." using -Filter for efficiency
    $files = Get-ChildItem -Path $targetDirectory -Filter "tomcat10-stdout.*" -File -Force

    # Check if any matching files were found
    if ($files.Count -eq 0) {
        Write-Host "No files found matching 'tomcat10-stdout.*' in '$targetDirectory'. Nothing to delete." -ForegroundColor Yellow
        Write-Log "No files found matching 'tomcat10-stdout.*' in '$targetDirectory'. Nothing to delete."
        exit
    }

	# could add a stop service Goodtech.WMI and Apache tomcat, so we can delete all files.
	# if you stop, start apache, it creates a new log file with a new date.
	
    # Delete each matching file
    foreach ($file in $files) {
        Remove-Item -Path $file.FullName -Force -ErrorAction SilentlyContinue
        if ($?) {  # Check if Remove-Item was successful
            Write-Host "Deleted: $($file.FullName)" -ForegroundColor Green  # Changed to Green for successful deletion
            Write-Log "Deleted: $($file.FullName)"
        } else {
            Write-Host "Failed to delete: $($file.FullName)" -ForegroundColor Red
            Write-Log "Failed to delete: $($file.FullName). Error: $($Error[0])"
        }
    }

    Write-Host "Deletion process for 'tomcat10-stdout.*' files completed (or attempted)." -ForegroundColor Green
    Write-Log "Deletion process for 'tomcat10-stdout.*' files completed."
	
	# could add a start service Goodtech.WMI and Apache tomcat, so we can delete all files.

} catch {
    $errorMessage = $_
    Write-Host "An error occurred: $errorMessage" -ForegroundColor Red
    Write-Log "An error occurred: $errorMessage"
}