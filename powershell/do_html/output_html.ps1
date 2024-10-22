# 5 If you need to extract data that you can use in a report or send to someone else, the ConvertTo-HTML is one simple way to do so.
ConverTo-HTML

Get-Service | Where-Object {$_.Name -like "app*"}  | ConvertTo-HTML > service.htm