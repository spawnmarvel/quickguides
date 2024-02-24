# Zabbix in a nutshell

## Visuals

https://follow-e-lo.com/2024/02/23/zabbix-in-a-nutshell/

## Install (all on one host)

View visuals repos.

## Trigger dependency


https://www.zabbix.com/documentation/current/en/manual/config/triggers/dependencies

Test with bash

```bash

# since we downloaded the repos in install, we have it
# installed
# sudo wget wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb

# unzip'ed
# sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb

# update it
# sudo apt update

# we can just install it
sudo apt install zabbix-sender

# help
zabbix_sender -h

# zabbix_sender is used to send data to your Zabbix server and can be called from either the command line 
# or from a scripting language capable of running shell commands.
# Example
zabbix_sender -z 127.0.0.1 -s "HOSTNAME" -k interface2 -o 10

# On Zabbix, you need to create a host and add a Zabbix Trapper item to receive and process the zabbix_sender message.

```

## Template Windows by Zabbix Agent

## Windows agent passive

If you use the Zabbix agent in the passive mode, it means that the poller (internal server process) connects to the agent on port 10050/TCP and polls for a certain value (e.g., host CPU load). 

The poller waits until the agent on the host responds with the value. Then the server gets the value back, and the connection closes.

https://blog.zabbix.com/zabbix-agent-active-vs-passive/9207/

## Windows agent active

In the active mode, all data processing is performed on the agent, without the interference of pollers. 

However, the agent must know what metrics should be monitored, and that is why the agent connects to the trapper port 10051/TCP of the server once every two minutes (by default). 

The agent requests the information about the items, and then performs the monitoring on the host and pushes the data to the server via the same TCP port.

https://blog.zabbix.com/zabbix-agent-active-vs-passive/9207/

## Tuning