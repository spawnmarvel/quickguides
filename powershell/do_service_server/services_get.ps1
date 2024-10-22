# get all automatic with name like
Get-Service | Select-Object -Property Name,DisplayName,Status,StartType | Where-Object { $_.StartType -eq "Automatic" -and ($_.Name -like "Aspen*" -or $_.Name -like "Afw*" -or $_.Name -like "Rabbit*" -or $_.Name -like "Goodtech*" -or $_.Name -like "W3SVC*" -or $_.Name -like "Tomcat*")}

# 4 It’s also helpful to know what services are installed on the system. 
Get-Service
Get-Service | Where-Object {$_.Status -eq "stopped"}
Get-Service | Where-Object {$_.Name -like "app*"}
