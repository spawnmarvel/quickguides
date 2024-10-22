write-host "Cheking the last line in a file for the word error"
write-host "If error is present, we restart a service"
#
#
Get-Content "C:\temp\to\move.txt" | select -Last 1
$last = Get-Content "C:\temp\to\move.txt" | select -Last 1
write-host "Checking what the value of the last line " $last

if($last -like "*error*")
{
write-host "We found there error line, need to restart service"
}
else 
{
write-host "is ok..."
}
