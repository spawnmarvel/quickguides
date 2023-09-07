# Install on a single host

## Download and install Zabbix

https://www.zabbix.com/download?zabbix=6.0&os_distribution=ubuntu&os_version=22.04&components=server_frontend_agent&db=mysql&ws=apache

## Install

```bash

sudo apt update
sudo apt upgrade -y

# 2 a  Install and configure Zabbix for your platform
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo apt update

# b Install Zabbix server, frontend, agent 
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent


```
![MySQL](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/mysql_support.jpg)
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-zabbix-to-securely-monitor-remote-servers-on-ubuntu-20-04


Install DB, MariaDB in this case

```bash
sudo apt install mariadb-server mariadb-client

# To uninstall sudo apt purge mariadb-server

# Make it start at system boot.
sudo systemctl enable --now mariadb

sudo mysql_secure_installation

```
https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-20-04

```bash
# c Create initial database
mysql -uroot -p
# or sudo mysql

create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'A-PASSWORD';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
quit;

# On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

# Disable log_bin_trust_function_creators option after importing database schema.
mysql -uroot -p
# or sudo mysql
set global log_bin_trust_function_creators = 0;
quit;

# d. Configure the database for Zabbix server
# Edit file /etc/zabbix/zabbix_server.conf, DBPassword=A-PASSWORD
sudo cp zabbix_server.conf zabbix_server.conf.bck
sudo nano zabbix_server.conf

# e. Start Zabbix server and agent processes
# Start Zabbix server and agent processes and make it start at system boot.
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

# f. Open Zabbix UI web page
The default URL for Zabbix UI when using Apache web server is http://host/zabbix

# Allow inbound NSG, HTTP
sudo ufw status
sudo ufw app list
sudo ufw allow Apache
```
NSG for HTTP
![NSG](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/NSG.jpg)

Configure frontend

![Frontend](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/singlezabbix2.jpg)