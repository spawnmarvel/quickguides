# https://thesysadminchannel.com/powershell-module/


# store all functions in .psm1 file

Function Add-CustPSLogInfoOut {
    param (
        [string]$ParameterText
    )
    $dt = Get-Date
    $rv= -join("Info: ", $dt, ":", $ParameterText)
    Add-Content log.txt $rv
}

Function Add-CustPSLogErrorOut {
    param (
        [string]$ParameterText
    )
    $dt = Get-Date
    $rv= -join("Error: ",$dt, ":", $ParameterText)
    Add-Content log.txt $rv
}

function Get-CustPSProcess {
    param (
        [string]$ParameterText
    )
    
        $ParameterTextTemp = -join($ParameterText, "*")
        $TempData =  Get-Process | where-Object {$_.ProcessName -like "$ParameterTextTemp"}
        $rv = ""
        foreach ($item in $TempData) {
            $rv = -join($item.ProcessName,":", $item.Id)
        }
        Add-Content log_process.txt $rv
        
}

