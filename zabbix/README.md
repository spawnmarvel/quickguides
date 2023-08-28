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

![Topology](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/topology1.jpg)

