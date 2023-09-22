# Remote work using Azure VPN Gateway Point-to-site

A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer.

Azure supports three types of Point-to-site VPN options:

* Secure Socket Tunneling Protocol (SSTP). SSTP is a Microsoft proprietary SSL-based solution that can penetrate firewalls since most firewalls open the outbound TCP port that 443 SSL uses.
* OpenVPN. OpenVPN is a SSL-based solution that can penetrate firewalls since most firewalls open the outbound TCP port that 443 SSL uses.
* IKEv2 VPN. IKEv2 VPN is a standards-based IPsec VPN solution that uses outbound UDP ports 500 and 4500 and IP protocol no. 50. Firewalls don't always open these ports, so there's a possibility of IKEv2 VPN not being able to traverse proxies and firewalls.

* Auto-reconnect is a function of the client being used. Windows supports auto-reconnect by configuring the Always On VPN client feature.

![Vpn ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/vpn.jpg)

https://learn.microsoft.com/en-us/azure/vpn-gateway/work-remotely-support

## Step-By-Step: Creating an Azure Point-to-Site VPN

* Create resource group
* Create vnet
* Create subnets for servers
* Create subnets for gateway
* Create virtual network gateway
* Create self-sign root & client certificate
* Configure point-to-site Connection
* Testing VPN connection

## Steps

* Create resource group
* Create vnet
* Create subnets for servers, subnets 02 DMZ, 03 Vm's
* Create subnets for gateway, gateway subnet, edit to 1

We recommend that you use the following address ranges, which are enumerated in RFC 1918. The IETF has set aside these ranges for private, non-routable address spaces.

* 10.0.0.0 to 10.255.255.255 (10/8 prefix)
* 172.16.0.0 to 172.31.255.255 (172.16/12 prefix)
* 192.168.0.0 to 192.168.255.255 (192.168/16 prefix)

https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq

![Vnet ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/vnet.jpg)


Now we have all the things needed to create new VN gateway. 

Azure VPN Gateway connects your on-premises networks to Azure through Site-to-Site VPNs in a similar way that you set up and connect to a remote branch office. The connectivity is secure and uses the industry-standard protocols Internet Protocol Security (IPsec) and Internet Key Exchange (IKE).

* Create virtual network gateways

In here vpnuks01 is the is the gateway name, vnet-uks-central is the vnet, and a puplic ip is created.

![Gateway ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/gateway.jpg)

* Create self-sign root & client certificate

Now we need the root certificate from the computer and a client certificate, it can be found in "Manage Computer Certificates" or you must make one with powershell / openssl.

Now we have certs in place. But we need to export these so we can upload it to Azure.

To export root certificate,
* Right click on root cert inside certificate mmc.
* Click on Export
* In private key page, select not to export private key
* Select Base-64 encoded X.509 as export file format.
* Complete the wizard and save the cert in pc.

NOTE: Note – Only root cert will use in Azure VPN, client certificate can install on other computers which need P2S connections.

* Configure point-to-site Connection

Next step of this configuration is to configure the point-to-site connection. In here we will define client ip address pool as well. It is for VPN clients.
* Click on newly created VPN gateway connection.
* Then in new window click on Point-to-site configuration

![Point ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/point.jpg)

In new window type IP address range for VPN address pool. In this demo I will be using 172.16.25.0/24. 
* For tunnel type use both SSTP & IKEv2. Linux and other mobile clients by default use IKEv2 to connect. Windows also use IKEv2 first and then try SSTP. 
* For authentication type use Azure Certificates.

In same window there is place to define root certificate. Under root certificate name type the cert name and under public certificate data, paste the root certificate data ( you can open cert in notepad to get data).
* Then click on Save to complete the process.

Azure portal error: Failed to save the VPN gateway, and the data is invalid

Cause
* This problem might occur if the root certificate public key that you uploaded contains an invalid character, such as a space.

Solution
* Make sure that the data in the certificate does not contain invalid characters, such as line breaks (carriage returns). The entire value should be one long line. The following text is a sample of the certificate:
* You may need to modify your view in the text editor to 'Show Symbol/Show all characters' to see the carriage returns and line feeds.

![View all ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/viewall.jpg)

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-troubleshoot-vpn-point-to-site-connection-problems

Copy only the following section as one continuous line Example:

![Marked line ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/markedline.jpg)

Success on save

Note: The client certificate is already installed.


![Point-2-site ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/point2site2.jpg)


* Testing VPN connection

Now we have finished with configuration. As next step, we need to test the connection. To do that log in to the same pc where we generate certificates. If you going to use different PC, first you need to import root cert & client certificate we exported.

* Log in to Azure portal from machine and go to VPN gateway config page.
* In that page, click on Point-to-site configuration
* After that, click on Download VPN client
* Run VpnClientSetupAmd64.exe

![Install vpn ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/installvpn.jpg)

After that, we can see new connection under VPN page.

![Home ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/home.jpg)

Click on connect to VPN. Then it will open up this new window. Click on Connect in there.

![Azure vpn ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/azurevpn.jpg)

Ok....

![Error] ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/error.jpg)


https://learn.microsoft.com/en-us/answers/questions/1311355/a-certificate-could-not-be-found-that-can-be-used


Links

Step-By-Step: Creating an Azure Point-to-Site VPN

https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-creating-an-azure-point-to-site-vpn/ba-p/326264

Configure server settings for P2S VPN Gateway connections - certificate authentication - Azure portal

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal
