# Operations


## General security

https://github.com/spawnmarvel/quickguides/blob/main/security/README.md

Setting up SSL for Zabbix frontend

Enabling Zabbix on root directory of URL

Enabling HTTP Strict Transport Security (HSTS) on the web server


## Zabbix security

2 Best practices for secure Zabbix setup

https://www.zabbix.com/documentation/6.0/en/manual/installation/requirements/best_practices

## Tunning

## Zabbix agents

Templates

* Windows by Zabbix Agent (clone and add 2 or gt to modify)
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



