# Remote work using Azure VPN Gateway Point-to-site

A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer.

Azure supports three types of Point-to-site VPN options:

* Secure Socket Tunneling Protocol (SSTP). SSTP is a Microsoft proprietary SSL-based solution that can penetrate firewalls since most firewalls open the outbound TCP port that 443 SSL uses.
* OpenVPN. OpenVPN is a SSL-based solution that can penetrate firewalls since most firewalls open the outbound TCP port that 443 SSL uses.
* IKEv2 VPN. IKEv2 VPN is a standards-based IPsec VPN solution that uses outbound UDP ports 500 and 4500 and IP protocol no. 50. Firewalls don't always open these ports, so there's a possibility of IKEv2 VPN not being able to traverse proxies and firewalls.

* Auto-reconnect is a function of the client being used. Windows supports auto-reconnect by configuring the Always On VPN client feature.

![Vpn ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/vpn.jpg)

https://learn.microsoft.com/en-us/azure/vpn-gateway/work-remotely-support

## Step-By-Step: Creating an Azure Point-to-Site VPN

Step-By-Step: Creating an Azure Point-to-Site VPN

https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-creating-an-azure-point-to-site-vpn/ba-p/326264

Configure server settings for P2S VPN Gateway connections - certificate authentication - Azure portal

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal

* Create resource group
* Create vnet
* Create subnets for servers
* Create subnets for gateway
* Create virtual network gateway
* Create self-sign root & client certificate
* Configure point-to-site Connection
* Testing VPN connection


## 1 Create resources

* Create resource group
* Create vnet
* Create subnets for servers, Vms03, Dmzs02
* Create subnets for gateway, GatewaySubnet

We recommend that you use the following address ranges, which are enumerated in RFC 1918. The IETF has set aside these ranges for private, non-routable address spaces.

* 10.0.0.0 to 10.255.255.255 (10/8 prefix)
* 172.16.0.0 to 172.31.255.255 (172.16/12 prefix)
* 192.168.0.0 to 192.168.255.255 (192.168/16 prefix)

https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq

![Vnet ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/vnet2.jpg)

Now we have all the things needed to create new VN gateway. 

Azure VPN Gateway connects your on-premises networks to Azure through Site-to-Site VPNs in a similar way that you set up and connect to a remote branch office. 

The connectivity is secure and uses the industry-standard protocols Internet Protocol Security (IPsec) and Internet Key Exchange (IKE).

## 2 Create virtual network gateways

Vpn-uks-2-onprem01 is the is the gateway name, vnet-uks-central is the vnet, and a puplic ip is created.

This can take sometime, 0-20 min.

![Gateway ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/gateway.jpg)

## 3 Create self-sign root & client certificate

If your organization using internal CA, you always can use it to generate relevant certificates for this exercise. 

* Each client computer that you connect to a VNet with a point-to-site connection must have a client certificate installed. 
* You generate it from the root certificate and install it on each client computer. 
* If you don't install a valid client certificate, authentication will fail when the client tries to connect to the VNet.
* You can either generate a unique certificate for each client, or you can use the same certificate for multiple clients. 
* The advantage to generating unique client certificates is the ability to revoke a single certificate.

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal


If you do not have internal CA, we still can use self-sign certs to do the job (make one with powershell / openssl).

Root and client certificate

```ps1
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=Your-name-root-01" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

New-SelfSignedCertificate -Type Custom -DnsName Your-name-client -KeySpec Signature -Subject "CN=Your-name-client" -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" -Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
```

To export root certificate,

* Right click on root cert inside certificate mmc.
* Click on Export
* In private key page, select not to export private key
* Base-64 encode X.509 (.cer)

To export client certificate,

* Use same method to export as root cert
* But this time under private key page, select option to export private key.
* Define password for the pfx file and complete the wizard.

The certificates are stored or inserted by ps1 to location Manage user certificates (copy them also to Manage computer certifcates, personal and trusted root)

![Certificates ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/certificates.jpg)

Install pfx

![Pfx ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/pfx.jpg)


Note – Only root cert will use in Azure VPN, client certificate can install on other computers which need P2S connections.

## 4 Configure point-to-site Connection

Next step of this configuration is to configure the point-to-site connection. In here we will define client ip address pool as well. It is for VPN clients.

* Click on newly created VPN gateway connection.
* Then in new window click on Point-to-site configuration

* In new window type IP address range for VPN address pool. 
* In this demo I will be using 172.16.25.0/24. 
* For tunnel type use both SSTP & IKEv2. 
* Linux and other mobile clients by default use IKEv2 to connect. 
* Windows also use IKEv2 first and then try SSTP. 
* For authentication type use Azure Certificates.

In same window there is place to define root certificate. Under root certificate name type the cert name and under public certificate data, paste the root certificate data ( you can open cert in notepad to get data).

Note : when you paste certificate data, do not copy -----BEGIN CERTIFICATE----- & -----END CERTIFICATE----- text.

* Upload the root certificate on format mentioned below.


```log
Open the certificate with a text editor, such as Notepad. 
When copying the certificate data, make sure that you copy the text as one continuous
line without carriage returns or line feeds. 
You may need to modify your view in the text editor 
to 'Show Symbol/Show all characters' to see the carriage returns and line feeds. 
Copy only the following section as one continuous line:

```
![Copy ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/copy.jpg)

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal


Troubleshooting: Azure point-to-site connection problems

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-troubleshoot-vpn-point-to-site-connection-problems

The Point-to-site configuration

![Point2site ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/point2site.jpg)

## 5 Testing VPN connection

Now we have finished with configuration. As next step, we need to test the connection. To do that log in to the same pc where we generate certificates. If you going to use different PC, first you need to import root cert & client certificate we exported.

* Log in to Azure portal from machine and go to VPN gateway config page.
* In that page, click on Point-to-site configuration
* After that, click on Download VPN client

Note: If you have some issues, view troubleshoot links above and:
* Delete or rename: C:\Users\jekl\AppData\Roaming\Microsoft\Network\Connections\Cm folder
* Go to VPN and remove the VPN
* Trying again with correct certificate and download the VPN client again

![Connected ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/connected.jpg)

Then run ip config to verify ip allocation from VPN address pool, used for gateway.

![Ipconfig ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/ipconfig.jpg)

This can also be verified on the Virtual network gateway.

![Azure Ip ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/azureip.jpg)

Now go to monitoring->metrics on the vpn and view PS2 Connection count.

![Metrics ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/metrics.jpg)

## Connect to a VM in Azure

* Create a windows vm
* Public inbound ports, None (It will just be given a private IP from the subnet)
* Vnet, vnet-uks-central
* Subnet, Vms03 (192.168.3.0/24)
* Nic, Basic

NSG is default
* in, 65000 AllowVnetInBound
* in, 65001 AllowAzureLoadBalancerInBound
* in, 65500 DenyAllInBound
* out, 65000 AllowVnetOutBound
* out, 65001 AllowInternetOutBound
* out, 65500 DenyAllOutBound

Test rdp with VPN and without VPN.

![Success ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/success.jpg)

Now go to monitoring->metrics on the vpn and view bandwith (added type and cost also)

![Metric2 ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images2/metric2.jpg)



















