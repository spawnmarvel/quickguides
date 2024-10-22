# https://stackoverflow.com/questions/44051241/how-to-catch-exceptions-on-powershell

$rgName = "Rg-iac-0080"
try {
    Get-AzResourceGroup -Name $rgName -Force
}
catch {
    Write-Host "rg does not exist $rgName"
}

# By adding -ErrorAction Stop to the end of the Statement inside the Try block (before or after the -Force), you can force it to become a terminating error, which will trigger the Catch statement.