#----- define parameters -----#
#----- get current date ----#
$Now = Get-Date;
#----- define amount of days ----#
$Days = 40;
#----- define folder where files are located ----#
$TargetFolder = "C:\Backup\myBck";
#----- define extension ----#"*.log, *.txt, or all *"
$Extension = "*";
#----- define LastWriteTime parameter based on $Days ---#
$LastWrite = $Now.AddDays(-$Days);
write-host "Check if there is folders/files before:" $LastWrite ", if so delete them!"
#----- get files based on lastwrite filter and specified folder ---#
$Files = Get-Childitem $TargetFolder -Include $Extension -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}
if ($Files -eq $NULL)
{
write-host "No folders older then " $Days " days, exit script."
}
else {
$count = 0;
foreach ($File in $Files)
{
        if ($File -ne $NULL)
            {
             #write-output "Deleting File $File"
             Remove-Item -Recurse -Force $File.FullName
             $count = $count + 1
            }
        }
         write-host "Deleted " $count " files"
        }
