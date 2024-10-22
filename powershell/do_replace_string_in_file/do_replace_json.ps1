# Load the JSON content from a file
$jsonPath = "C:\temp\json\config.json"
# make a backup
Copy-Item -Path $jsonPath -Destination "C:\temp\json\config_bck.json"
Write-Host "Backup JSON has been saved to 'C:\temp\json\config_bck.json'."

# Read the JSON file
$jsonData = Get-Content -Path $jsonPath -Raw | ConvertFrom-Json

# Access the 'main' object
$main = $jsonData.main

# Display main.id and main.value
Write-Host "Main ID: $($main.id)"
Write-Host "Main Value: $($main.value)"

# Access the 'taglist' array
$tags = $main.tags.taglist

# Iterate through each tag
foreach ($tag in $tags) {
    Write-Host "Tag Value: $($tag.value)"
    Write-Host "Tag Info: $($tag.info)"
    Write-Host "---------------------------"
}
# Find and update tag3's info
foreach ($tag in $main.tags.taglist) {
    if ($tag.value -eq "tag3") {
        $tag.info = "3333333"
        Write-Host "Updated tag3's info to $($tag.info)"
    }
}

# Display the updated taglist
$main.tags.taglist | ForEach-Object {
    Write-Host "Tag Value: $($_.value), Tag Info: $($_.info)"
}
# Convert the PowerShell object back to JSON, just set max depth, we do not have 100 in depth
$updatedJson = $jsonData | ConvertTo-Json -Depth 100

# Save the updated JSON to a new file
$updatedJson | Out-File -FilePath "C:\temp\json\config_updated.json" -Encoding utf8

# Save the updated JSON file with the same name
$updatedJson | Out-File -FilePath "C:\temp\json\config.json" -Encoding utf8

Write-Host "Updated JSON has been saved to 'C:\temp\json\config_updated.json'."
Write-Host "Updated JSON with new parameters has been saved to 'C:\temp\json\config.json'."