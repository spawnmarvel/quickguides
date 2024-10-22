# Connect-AzAccount

Import-AzAutomationDscConfiguration `
    -Published `
    -ResourceGroupName testit2-rg `
    -SourcePath "MyFirstDsc.ps1" `
    -Force `
    -AutomationAccountName testitautomationacc