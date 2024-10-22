# https://gist.github.com/chgeuer/8342314

Write-Host "#### V1.0 Install Erlang and set path or verify it, .exe must be in same folder as the script. RUN AS ADMIN"

$erlangkey = Get-ChildItem HKLM:\SOFTWARE\Wow6432Node\Ericsson\Erlang -ErrorAction SilentlyContinue
if ($erlangkey -eq $newpath ) { 
    Write-Host "Erlang not found, need to install it"
    Start-Process -Wait C:\install\otp_win64_25.1.exe /S
     Write-Host "Erlang is now installed" # 20.11.2022 success
}
else {
    Write-Host "Erlang is installed" # 20.11.2022 success
}

Write-Host "Check erlang path"
# Check erlang path
$system_erl_home = [System.Environment]::GetEnvironmentVariable("ERLANG_HOME", "Machine")
Write-Host "Erlang home = " $system_erl_home

# Add Erlang to the path if needed (does not work, just give \\bin?)
#
$system_path_elems = [System.Environment]::GetEnvironmentVariable("PATH", "Machine").Split(";")
if (!$system_path_elems.Contains("%ERLANG_HOME%\bin") -and !$system_path_elems.Contains("$ERLANG_HOME\bin")) 
{
    Write-Host "Adding erlang to path"
    $newpath = [System.String]::Join(";", $system_path_elems + "$ERLANG_HOME\bin")
    Write-Host $newpath
    [System.Environment]::SetEnvironmentVariable("PATH", $newpath, "Machine")
}

# 
# https://adamtheautomator.com/powershell-environment-variables/
# The .NET class [System.Environment] offers methods for getting and setting environment variables also. This is only method to access various environment scopes directly and set environment variables that survive across PowerShell sessions.

# [System.Environment]::GetEnvironmentVariables('Machine')
# [System.Environment]::SetEnvironmentVariable('gotest','C:\temp\bin2',[System.EnvironmentVariableTarget]::Machine)
# [System.Environment]::SetEnvironmentVariable('TestVariable','Alpha','Machine')