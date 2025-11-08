Import-Module WebAdministration
Get-IISAppPool -Name "SolrAppPool"
Restart-WebAppPool -Name "SolrAppPool"

