Import-Module WebAdministration
Get-IISAppPool -Name "SolrAppPool"
Restart-WebAppPool -Name "SolrAppPool"

# Swap space goes down after 1 min to normal 15gb
# Run saturday, 64 bit, not 32 bit ps1
