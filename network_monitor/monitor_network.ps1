# Network Monitor Script
param(
    [int]$checkInterval = 5,  # Seconds between checks
    [int]$discardThreshold = 100,  # Threshold for discarded packets
    [int]$errorThreshold = 50,     # Threshold for error packets
    [int]$queueThreshold = 20      # Threshold for queue length
)

function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

function Monitor-NetworkAdapter {
    $previousStats = @{}
    
    while ($true) {
        Clear-Host
        Write-Output "Network Adapter Statistics Monitor"
        Write-Output "--------------------------------"
        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Write-Output "Time: $date"
        Write-Output ""

        Get-NetAdapter | Where-Object Status -eq "Up" | ForEach-Object {
            $adapter = $_
            $stats = Get-NetAdapterStatistics -Name $adapter.Name
            
            Write-Output "Adapter: $($adapter.Name)"
            Write-Output "Status: $($adapter.Status)"
            Write-Output "Speed: $($adapter.LinkSpeed)"
            
            # Check for previous stats
            if ($previousStats.ContainsKey($adapter.Name)) {
                $prevStats = $previousStats[$adapter.Name]
                
                # Calculate differences
                $discardedDiff = $stats.PacketsReceivedDiscarded - $prevStats.PacketsReceivedDiscarded
                $errorsDiff = $stats.PacketsReceivedErrors - $prevStats.PacketsReceivedErrors
                
                # Alert conditions
                if ($discardedDiff -gt $discardThreshold) {
                    Write-ColorOutput Red "WARNING: High packet discard rate: $discardedDiff packets/interval"
                }
                if ($errorsDiff -gt $errorThreshold) {
                    Write-ColorOutput Red "WARNING: High error rate: $errorsDiff errors/interval"
                }
                if ($stats.OutputQueueLength -gt $queueThreshold) {
                    Write-ColorOutput Red "WARNING: High output queue length: $($stats.OutputQueueLength)"
                }
            }
            
            # Current statistics
            Write-Output "Packets Received Discarded: $($stats.PacketsReceivedDiscarded)"
            Write-Output "Packets Received Errors: $($stats.PacketsReceivedErrors)"
            Write-Output "Output Queue Length: $($stats.OutputQueueLength)"
            Write-Output "--------------------------------"
            
            # Store current stats for next comparison
            $previousStats[$adapter.Name] = $stats
        }
        
        Start-Sleep -Seconds $checkInterval
    }
}

# Run the monitor
try {
    Monitor-NetworkAdapter
}
catch {
    Write-Error "An error occurred: $_"
}
finally {
    Write-Output "Monitor stopped"
}