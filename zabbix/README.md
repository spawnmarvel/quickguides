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

## Tuning


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

