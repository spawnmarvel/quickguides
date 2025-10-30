# Task scheduler
# Ensure "Run with highest privileges" is checked.
# Ensure that the task is set to run even if the user is not logged on.
# Action is set to start a program.
# Program/script is set to "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
# Add arguments:
# -ExecutionPolicy Bypass -File "C:\OP\Jobs\ScheduleTasks\ps_delete_uploaded_files.ps1"

# Why?
# C:\Program Files\Common Files\App Shared\Tomcat10.1.16\bin
# Open tomcat10w.exe java options
# -Djava.io.tmpdir=F:\LogsTomcatTemp

# Define the target directory
$targetDirectory = "F:\LogsTomcatTemp"
# $logFile = "F:\LogsPS1\deletion_log.txt"  #  <-- Add the log file path


# Function to append to the log file
function Write-Log {
    param(
        [string]$Message
    )
	$logFile = "F:\LogsPS1\deletion_log.txt"  #  <-- Add the log file path
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $Message"
    $logEntry | Out-File -FilePath $logFile -Append
}


# Check if the directory exists
if (-Not (Test-Path -Path $targetDirectory)) {
    Write-Host "The directory '$targetDirectory' does not exist. Exiting script." -ForegroundColor Yellow
    Write-Log "Directory '$targetDirectory' does not exist. Script exited." # <-- Log entry
    exit
}

# Prompt the user for confirmation before proceeding (commented out in original, kept commented)
Write-Host "This script will delete ALL files in the directory: $targetDirectory" -ForegroundColor Cyan
Write-Log "Attempting to delete all files in '$targetDirectory'." # <-- Log entry

# debug start (kept commented)
# $userConfirmation = Read-Host "Are you sure you want to proceed? (Y/N)"
#if ($userConfirmation.ToUpper() -ne "Y") {
#    Write-Host "Operation canceled by the user. No files were deleted." -ForegroundColor Green
#    Write-Log "Operation canceled by the user. No files were deleted." # <-- Log entry
#    exit
#}
# debug end

# Get all files in the directory
try {
    $files = Get-ChildItem -Path $targetDirectory -File -Force
    # Check if there are any files to delete

    if ($files.Count -eq 0) {
        Write-Host "No files found in the directory '$targetDirectory'. Nothing to delete." -ForegroundColor Yellow
        Write-Log "No files found in '$targetDirectory'. Nothing to delete." # <-- Log entry
        exit
    }

    # Delete each file
    foreach ($file in $files) {
        Remove-Item -Path $file.FullName -Force -ErrorAction SilentlyContinue
        if ($?) { # Check if the last command (Remove-Item) was successful
            Write-Host "Deleted: $($file.FullName)" -ForegroundColor Red
            Write-Log "Deleted: $($file.FullName)" # <-- Log entry
        } else {
            Write-Host "Failed to delete: $($file.FullName)" -ForegroundColor Red
            Write-Log "Failed to delete: $($file.FullName).  Error: $($Error[0])" # <-- Log entry with error details
        }
    }

    Write-Host "All files in '$targetDirectory' have been successfully deleted (or attempted)." -ForegroundColor Green
    Write-Log "File deletion process completed in '$targetDirectory'." # <-- Log entry

} catch {
    $errorMessage = $_
    Write-Host "An error occurred while attempting to delete files: $errorMessage" -ForegroundColor Red
    Write-Log "An error occurred: $errorMessage" # <-- Log entry, including the error
}