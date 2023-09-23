# AMQP on-premsies vpn 2 Azure 

## Monitor ingress and more with AMQP Shovel on-premises to Azure

Gateway SKUs by tunnel, connection, and throughput (just the one we are testing)

![Throughput ](https://github.com/spawnmarvel/quickguides/blob/main/security-VPN/images/throughput.jpg)


https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways

* Install RabbitMQ on a VM
* Connect to shovel from on-premises to Azure VM running RabbitMQ
* Send a bunch of data
* NSG private ip, flow logs and traffic
* [...], best practice


## Highly Available cross-premises

To provide better availability for your cross premises connections, there are a few options available:

* Multiple on-premises VPN devices
* Active-active Azure VPN gateway
* Combination of both

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable

Connection resiliency

https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways