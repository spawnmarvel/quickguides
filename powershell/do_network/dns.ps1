# 5. Perform DNS lookups
Resolve-DnsName -Name "Hostname"
# Arguably, the backbone of a network is the DNS service. Without it, users would be forced to know the IP addresses for all websites and services. 
# And yet when connectivity issues arise, DNS is often the culprit after ruling out IP-related errors. 
# By appending the "-server" switch, followed by a DNS server's IP address, 
# IT can perform a DNS resolve request against a specific server to verify resolution is working properly.

# or cmd
nslookup

# 7. View & Set DNS information
Get-DnsClient
Set-DnsClientServer Address
# This cmdlet lets you check the DNS client information for a device. 
# It will indicate what DNS server(s) are being used by the device to perform address resolutions as configured on multiple adapters. 
# The Set-DnsClientServerAddress cmdlet allows for specified DNS servers to be added to the network configuration

# 8. Flush DNS cache
Clear-DnsClientCache
# The DNS cache helps keep often used DNS resolution records stored locally on a device, 
# allowing it to read that record instead of performing a lookup every time a record is requested. 
# This helps speed up the already fast resolution process. If stale records--or those that haven't been updated--are present, 
# this could lead to poor network performance, denial of service, or security issues that seek to exploit incorrect records that point user 
# requests to the wrong server/service.