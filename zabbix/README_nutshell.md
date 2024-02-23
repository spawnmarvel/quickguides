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

# zabbix_sender is used to send data to your Zabbix server and can be called from either the command line or from a scripting language capable of running shell commands.
# Example
zabbix_sender -z 127.0.0.1 -s "HOSTNAME" -k interface2 -o 10

# On Zabbix, you need to create a host and add a Zabbix Trapper item to receive and process the zabbix_sender message.

```

## Template Windows by Zabbix Agent

## Windows agent passive

## Windows agent active

## Tuning