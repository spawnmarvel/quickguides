# Install on a single host

## Download and install Zabbix

https://www.zabbix.com/download?zabbix=6.0&os_distribution=ubuntu&os_version=22.04&components=server_frontend_agent&db=mysql&ws=apache

## Install

```bash

sudo apt update
sudo apt upgrade -y

# 2 a  Install and configure Zabbix for your platform
sudo wget wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb

# view it
ls

# unpack it
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb

# update it
sudo apt update

# b Install Zabbix server, frontend, agent 
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent


# chekc packages
sudo dpkg --list

# remove it, if needed
sudo apt --purge remove zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

```
![MySQL](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/mysql_support.jpg)
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-zabbix-to-securely-monitor-remote-servers-on-ubuntu-20-04


Install DB, MariaDB in this case on.

```bash

# some mysql things is installed with zabbix.

# mysql server is not
dpkg --get-selections | grep mysql

libmysqlclient21:amd64                          install
mysql-client                                    install
mysql-client-8.0                                install
mysql-client-core-8.0                           install
mysql-common                                    install
php-mysql                                       install
php7.4-mysql                                    install
zabbix-server-mysql                             install

# install it

sudo apt install mysql-server
# sudo apt install mysql-client

# now it is
dpkg --get-selections | grep mysql

libmysqlclient21:amd64                          install
mysql-client                                    install
mysql-client-8.0                                install
mysql-client-core-8.0                           install
mysql-common                                    install
mysql-server                                    install
mysql-server-8.0                                install
mysql-server-core-8.0                           install
php-mysql                                       install
php7.4-mysql                                    install
zabbix-server-mysql                             install

# Make it start at system boot.
sudo systemctl enable --now mysql

sudo mysql_secure_installation

n, y,y,y,y,y

```
https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-20-04

```bash
# c Create initial database
sudo mysql -uroot -p

# or, no pass
sudo mysql

create database zabbix character set utf8mb4 collate utf8mb4_bin;
# create user zabbix@localhost identified by 'A-PASSWORD';
# grant all privileges on zabbix.* to zabbix@localhost;
create user 'zabbix'@'%' identified by 'A-PASSWORD';
grant all privileges on zabbix.* to 'zabbix'@'%';
FLUSH PRIVILEGES;
set global log_bin_trust_function_creators = 1;
quit;

# On Zabbix server host import initial schema and data. You will be prompted to enter your newly created password.
# This will take 1-3 minuttes.
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

# Disable log_bin_trust_function_creators option after importing database schema.
mysql -uroot -p

# or, no pass
sudo mysql

set global log_bin_trust_function_creators = 0;
quit;


# show databases
sudo mysql
mysql> show databases;
# zabbix

# show users
mysql> select user from mysql.user;

# connect with user
mysql -u zabbix -p zabbix -h localhost

# d. Configure the database for Zabbix server
# Edit file /etc/zabbix/zabbix_server.conf, DBPassword=A-PASSWORD
cd /etc/zabbix
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
# Status: inactive

sudo ufw app list
sudo ufw allow Apache
```
NSG for HTTP
![NSG](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/NSG.jpg)

Configure frontend

![Frontend](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/singlezabbix2.jpg)