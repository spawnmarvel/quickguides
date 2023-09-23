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
* Create subnets for servers, subnetvm 02
* Create subnets for gateway, gateway subnet, subnetgatew 01

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

vpn-uks-2-onprem01 is the is the gateway name, vnet-uks-central is the vnet, and a puplic ip is created.

## Links

Step-By-Step: Creating an Azure Point-to-Site VPN

https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-creating-an-azure-point-to-site-vpn/ba-p/326264

Configure server settings for P2S VPN Gateway connections - certificate authentication - Azure portal

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal
