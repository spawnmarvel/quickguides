# cd C:\temp
# dir
$file_path = "c:\temp\a_file.json"
$content = Get-Content $file_path # -Raw
Write-Host "Before: " $content

# Replace 'oldText' with 'newText' in a string
$string_current = "Red"
$string_new = "Red123"
$content = $content -replace $string_current, $string_new

# Write the updated content back to the file
$content | Set-Content $file_path

# read the file and verify
$content = Get-Content $file_path # -Raw
Write-Host "After: " $content
