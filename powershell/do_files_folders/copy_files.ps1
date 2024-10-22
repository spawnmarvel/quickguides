copy-item C:\Users\me\Desktop\bat\powershell\source_folder\move.txt C:\Users\me\Desktop\bat\powershell\destination_folder
$status = "The file was transferd and updated, successes."
$date = get-date
$log = $status + $date
$run = "---------------------------- Script last run: "
$lastrun = $run + $date
Add-content -Path C:\Users\me\Desktop\bat\powershell\log.txt -Value $log
Add-content -Path C:\Users\me\Desktop\bat\powershell\log.txt -Value $lastrun


#Bat = Powershell.exe -File C:\Users\jekl\Desktop\powershell\copy_command.ps1
