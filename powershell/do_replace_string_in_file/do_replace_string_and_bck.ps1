
$stringOld = "jippi_alarm; Password = 1234596edweveb;"
$stringReplace = "jippi_alarm; Password = swwbebb456123456;"


# paths
$fileName = "File.Consume.Service.exe.config"
$configFile = "C:\Users\File.Consume.Service.exe.config"
$destination =  "C:\Users\"

Write-Host "Searcing for " $stringOld " in " $configFile
$content = Get-Content $configFile # -Raw


# Current string, when searching for this, the return array sould be 1
$searchStr = Select-String -Path $configFile -Pattern $stringOld
# OracleConnectionString
# write-host $searchStr[0]
# EventTaskConnectionString
# write-host $searchStr[1]
# there are only two in each file
# Write-Host $searchStr.Length
# Write-Host $searchStr

if($searchStr) {

    # stop the service


    # Take a Backup only of we find the string
    $date = Get-Date -Format "yyyy-MM-dd-hh-mm-ss"
    $newFileName = $fileName + "_" + $date + ($configFile | Split-Path -Leaf).Extension
    Write-Host "Try to create a backupfile "$newFileName
    Copy-Item -Path $configFile -Destination ($destination + $newFileName)
    # check that we have a backup
    $backupExists = Test-Path -path ($destination + $newFileName)
    if($backupExists) {
        Write-Host "A backup exist:" $backupExists  ": " $newFileName

        # start the update work
        $content = $content -replace $stringOld, $stringReplace
        # Write the updated content back to the file
        $content | Set-Content $configFile
        # end the update work

        # Read the file and verfy new string exists
        $searchStrNew = Select-String -Path $configFile -Pattern $stringReplace
        if($searchStrNew) {
        # Write-Host $searchStrNew.Length
        Write-Host "New string "$searchStrNew

        # start the service
   
   }
    }
    else {
        Write-Host "A backup does not exist " $backupExists
        }
}
else {
    Write-Host "String not found " $searchStr
}




