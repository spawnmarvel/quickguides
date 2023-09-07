# Zabbix

## Documenation always LTS

https://www.zabbix.com/manuals

## Environment requirements

* The more physical memory you have, the faster the database (and therefore Zabbix) works.
* CPU, Zabbix and especially Zabbix database may require significant CPU resources depending on number of monitored parameters and chosen database engine.

Examples of hardware configuration
The table provides examples of hardware configuration, assuming a Linux/BSD/Unix platform.

These are size and hardware configuration examples to start with. Each Zabbix installation is unique. Make sure to benchmark the performance of your Zabbix system in a staging or development environment, so that you can fully understand your requirements before deploying the Zabbix installation to its production environment.

![Requirements matrix ](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/requirements.jpg)

1 1 metric = 1 item + 1 trigger + 1 graph
2 Example with Amazon general purpose EC2 instances, using ARM64 or x86_64 architecture, a proper instance type like Compute/Memory/Storage optimised should be selected during Zabbix installation evaluation and testing before installing in its production environment.

https://www.zabbix.com/documentation/current/en/manual/installation/requirements


## Security

Setting up SSL for Zabbix frontend Apache

Enabling Zabbix on root directory of URL

Enabling HTTP Strict Transport Security (HSTS) on the web server

https://www.zabbix.com/documentation/current/en/manual/installation/requirements/best_practices

## Encryption

"PSK is an efficient way, and to be honest you get the same effect, [...] (like, cert management is a hustle compared to psk)."

https://www.reddit.com/r/zabbix/comments/srp2fx/setup_cert_encryption_on_zabbix_agent/?rdt=50737

First, generate a PSK

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-zabbix-to-securely-monitor-remote-servers-on-ubuntu-20-04


## Users and groups (12)

Configuring a user

Permissions
* User - has limited access rights to menu sections (see below) and no access to any resources by default. Any permissions to host or template groups must be explicitly assigned;
* Admin - has incomplete access rights to menu sections (see below). The user has no access to any host groups by default. Any permissions to host or template groups must be explicitly given;
* Super admin - has access to all menu sections. The user has a read-write access to all host and template groups. Permissions cannot be revoked by denying access to specific groups.

| Menu section | User | Admin | Super Admin
| ------------ | ---- | ----- | ----------
| Dashboards   | +    | +     | +
| Problems     | +    | +     | + 
| Hosts        | +    | +     | + 
[...]

https://www.zabbix.com/documentation/current/en/manual/config/users_and_usergroups/permissions


## Web interface, Users (18, 8)


1. User Groups


https://www.zabbix.com/documentation/current/en/manual/web_interface/frontend_sections/users/user_groups

2. User roles

Super admin role
* 
Admin role
* 
User role
* 
Guest role
* 

https://www.zabbix.com/documentation/current/en/manual/web_interface/frontend_sections/users/user_roles

Users and user groups

https://www.zabbix.com/documentation/current/en/manual/config/users_and_usergroups

Configurering a user
* 

Permissions
* 

User groups
*


## History and trends

The general strong advice is to keep history for the smallest possible number of days and that way not to overload the database with lots of historical values.

Instead of keeping a long history, you can keep longer data of trends. For example, you could keep history for 14 days and trends for 5 years

https://www.zabbix.com/documentation/4.0/en/manual/config/items/history_and_trends

## Tuning

[...]

How to measure performance

Number of values processed per second (NVPS)
* Update frequency greatly affects NVPS.

Zabbix is able to deliver 2 million of values per minute or around 30.000 of values per second

What affects performance?
* Type of items, value types, SNMPv3, number of triggers and complexity of triggers.
* Housekeeper settings and thus size of the database
* Number of users working with the WEB interface
* Choose update frequency and duration of storage carefully

History analysis affects performance of Zabbix. But not so much!
|                                 | Slow    | Fast
|---------------------------------| ------- |------
| DB Size                         | Large   | Fits into memory
| Low level detection             | Update freq, 30s, 15m, 30m | Update freq, 1h, 1d, 7d
| Trigger expressions             | min(), max(), avg() | last(), nodata()
| Data collection                 | Polling (SNMP, agent-less, passive agent) | Trapping (active agents)
| Data types                      | Text, string | Numeric

Common problems of initial setup
* Default database settings
* * Tune database for the best performance (https://github.com/hermanekt/Zabbix_MYSQL_tunned_for_40k)
* Not optimal configuration of Zabbix Server
* * Tune Zabbix Server configuration (Monitoring > Dashboard > Zabbix server health)
* Housekeeper settings do not match hardware spec
* * (Use partitions in DB) 
* Use of default templates
* * Make your own smarter templates
* Use of older releases
* * Always use the latest one!

[...]

Zabbix server configuration file, zabbix_server.conf:

```log
StartPollers=80
StartPingers=10
StartPollersUnreachable=80
StartIPMIPollers=10
StartTrappers=20
StartDBSyncers=6
```
Should be done before, but How to know when it is time to apply partitioning?
* Trigger “Zabbix housekeeper processes more than 75% busy” is in problem state for hours or days
* The performance of housekeeper is dropping

https://www.initmax.cz/wp-content/uploads/2022/06/zabbix_performance_tuning_6.0.pdf

SO

"If it's up to 10 minutes, you can probably ignore that and tune the trigger to be less sensitive. If it's more, it is a general Zabbix DB performance issue."

https://stackoverflow.com/questions/40040509/zabbix-housekeeper-processes-more-than-75-busy

## Zabbix Agent: Active vs. Passive

* Passive, it means that the poller (internal server process) connects to the agent on port 10050/TCP and polls for a certain value (e.g., host CPU load).
* In the active mode, all data processing is performed on the agent, without the interference of pollers, trapper port  10051/TCP.

Topology benefits
* It could be that customer does not want incoming connections, but incoming connections, have to use active checks.
*  Then ca not use remote commands, but that is better to do on the trapper host anyway and just have an alert in managament.

Now, onto the most important part, namely configuring the agent in the active or the passive modes. 
The default setting is passive, meaning that even the default Zabbix server host has all of the Zabbix agent item types configured as passive.

Passive checks
* Parameter Server, It is a comma-separated list of IP addresses and DNS names from which the agent will accept incoming connections. The Zabbix server connects to this agent and polls the data.

Active checks
* ServerActive variable, This is the list of IP addresses and DNS names of your Zabbix servers or proxies to which the agent will connect once every two minutes to request the configuration. After it receives the configuration, it starts the requested monitoring and pushes the collected data.

https://blog.zabbix.com/zabbix-agent-active-vs-passive/9207/

## Zabbix agents

Templates

* Windows by Zabbix Agent (clone and add 2 or gt to modify)
* zabbix_agent2-6.0.0-windows-amd64-openssl.msi
* * Items 32
* * Discovery rules
* * * Mounted filesystem discovery, interval 1h
* * * Physical disks discovery, interval 1h
* * * Windows services discovery, interval 1h

* Website certificate by Zabbix Agent (clone and add 2 or gt to modify)
* IIS by Zabbix agent

### Check Zabbix agent version on Zabbix host
```bash
# Status
sudo service zabbix-agent status
cd /var/log/zabbix
tail -f zabbix_agentd.log

# Configuration
cd /etc/zabbix
# Version
zabbix.agentd -V


```

## Zabbix sender

zabbix_sender -z zabbix -s "Linux DB3" -k db.connections -o 43
where:
* z - Zabbix server host (IP address can be used as well)
* s - technical name of monitored host (as registered in Zabbix frontend)
* k - item key
* o - value to send

https://www.zabbix.com/documentation/current/en/manual/concepts/sender

Select it and download it.

Example 

https://www.zabbix.com/download_agents?version=6.0+LTS&release=6.0.21&os=Windows&os_version=Any&hardware=amd64&encryption=OpenSSL&packaging=Archive&show_legacy=0

zabbix_agent-6.0.21-windows-amd64-openssl.zip

![Sender ](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/sender.jpg)


## Script agent

## Python Agent

## Trigger action

IP must be whitelisted

Administration->Media types-> Email
* SMTP server, mailhost.company.com
* SMTP server port, 25
* SMTP helo, company.com
* SMTP email, HEADER ALERT <alert-message@company.com>

## Linux VM

How to Linux

https://github.com/spawnmarvel/azure-automation/blob/main/azure-extra-linux-vm/README.md

Price example (could have 1 VM with App and one with Database)


![Linux](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/linux.jpg)

## Database Mysql (Azure Flexible Server MySql)

https://learn.microsoft.com/en-us/azure/mysql/

Price example

![Paas](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/paas.jpg)

## Container

https://learn.microsoft.com/en-us/azure/container-instances/


A container group is a collection of containers that get scheduled on the same host machine. 
The containers in a container group share a lifecycle, resources, local network, and storage volumes. It's similar in concept to a pod in Kubernetes

For example, in a group with two container instances each requesting 1 CPU, one of your containers might run a workload that requires more CPUs to run than the other.

In this scenario, you could set a resource limit of up to 2 CPUs for the container instance. This configuration allows the container instance to use up to 2 CPUs if available.

https://learn.microsoft.com/en-us/azure/container-instances/container-instances-container-groups

Price example

![Container](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/container.jpg)

## App Service for Overview

Simple topology

![Topology](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/topology2.jpg)

