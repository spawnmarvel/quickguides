# Install on a single host

## Download and install Zabbix

https://www.zabbix.com/download?zabbix=6.0&os_distribution=ubuntu&os_version=22.04&components=server_frontend_agent&db=mysql&ws=apache

## Install Zabbix

```bash

sudo apt update
sudo apt upgrade -y

# 2 a  Install and configure Zabbix for your platform
sudo wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb

# view it
ls
zabbix-release_6.0-4+ubuntu22.04_all.deb

# unpack it
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb

# UPDATE IT
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


## Install Mysql


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

## Configure Zabbix

```bash
# c Create initial database
sudo mysql -uroot -p

# or, no pass
sudo mysql

# exit mysql
quit;

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

# mysql>
show databases;
# zabbix

# show users
# mysql> 
select user from mysql.user;

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

## Configure frontend

![Frontend](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/singlezabbix2.jpg)


## Upgrade minor from 6.0.26 to 6.0.27. Port 443 to repo.zabbix.com

Upgrade between minor versions
It is possible to upgrade minor versions of 6.0.x (for example, from 6.0.1 to 6.0.3). It is easy.

```bash
# To upgrade Zabbix minor version please run:
sudo apt install --only-upgrade 'zabbix.*'

# To upgrade Zabbix server minor version please run:
sudo apt install --only-upgrade 'zabbix-server.*'

# To upgrade Zabbix agent minor version please run:
sudo apt install --only-upgrade 'zabbix-agent.*'

# or, for Zabbix agent 2:
sudo apt install --only-upgrade 'zabbix-agent2.*'
```

Here we upgraded all packages on Linux, including all zabbix*

```bash
# what do we have?
ls -l
total 4
-rw-r--r-- 1 root root 3672 Sep 14  2022 zabbix-release_6.0-4+ubuntu20.04_all.deb

# 1 Stop Zabbix processes
sudo service zabbix-server stop
sudo service zabbix-agent stop

# 2 Back up the existing Zabbix database

# 3 Back up configuration files, PHP files and Zabbix binaries
# Configuration files:
sudo mkdir /opt/zabbix-backup/
sudo cp /etc/zabbix/zabbix_server.conf /opt/zabbix-backup/
sudo cp /etc/apache2/conf-enabled/zabbix.conf /opt/zabbix-backup/

#PHP files and Zabbix binaries:
sudo cp -R /usr/share/zabbix/ /opt/zabbix-backup/
sudo cp -R /usr/share/zabbix-* /opt/zabbix-backup/

sudo apt update -y

Hit:19 https://repo.zabbix.com/zabbix-agent2-plugins/1/ubuntu focal InRelease
Get:20 https://repo.zabbix.com/zabbix/6.0/ubuntu focal InRelease [4958 B]
Get:21 https://repo.zabbix.com/zabbix/6.0/ubuntu focal/main Sources [2263 B]
Get:22 https://repo.zabbix.com/zabbix/6.0/ubuntu focal/main amd64 Packages [5622 B]

sudo apt upgrade -y

Preparing to unpack .../19-zabbix-agent_1%3a6.0.27-1+ubuntu20.04_amd64.deb ...
Unpacking zabbix-agent (1:6.0.27-1+ubuntu20.04) over (1:6.0.26-1+ubuntu20.04) ...
Preparing to unpack .../20-zabbix-frontend-php_1%3a6.0.27-1+ubuntu20.04_all.deb ...
Unpacking zabbix-frontend-php (1:6.0.27-1+ubuntu20.04) over (1:6.0.26-1+ubuntu20.04) ...
Preparing to unpack .../21-zabbix-apache-conf_1%3a6.0.27-1+ubuntu20.04_all.deb ...
Unpacking zabbix-apache-conf (1:6.0.27-1+ubuntu20.04) over (1:6.0.26-1+ubuntu20.04) ...
Preparing to unpack .../22-zabbix-sender_1%3a6.0.27-1+ubuntu20.04_amd64.deb ...
Unpacking zabbix-sender (1:6.0.27-1+ubuntu20.04) over (1:6.0.26-1+ubuntu20.04) ...
Preparing to unpack .../23-zabbix-sql-scripts_1%3a6.0.27-1+ubuntu20.04_all.deb ...
Unpacking zabbix-sql-scripts (1:6.0.27-1+ubuntu20.04) over (1:6.0.26-1+ubuntu20.04) ...

Setting up zabbix-sql-scripts (1:6.0.27-1+ubuntu20.04) ...
Setting up libssl1.1:amd64 (1.1.1f-1ubuntu2.22) ...
Setting up less (551-1ubuntu0.2) ...
Setting up libuv1:amd64 (1.34.2-1ubuntu1.5) ...
Setting up zabbix-frontend-php (1:6.0.27-1+ubuntu20.04) ...
Setting up zabbix-agent (1:6.0.27-1+ubuntu20.04) ...
Setting up openssl (1.1.1f-1ubuntu2.22) ...
Setting up zabbix-apache-conf (1:6.0.27-1+ubuntu20.04) ...
Setting up zabbix-sender (1:6.0.27-1+ubuntu20.04) ...


# 7 Start Zabbix processes
service zabbix-server start
service zabbix-proxy start
service zabbix-agent start
service zabbix-agent2 start

# 8 tail log
cd /var/log/zabbix
tail -f zabbix_server.logs
tail -f zabbix_agent.logs

# 8 Clear web browser cookies and cache

zabbix_server --version
zabbix_server (Zabbix) 6.0.27
Revision c5fe8f4d2d2 26 February 2024, compilation time: Feb 26 2024 09:44:31

```
Before

![Minor upgrade ](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/minor_upgrade-1.jpg)

After

![Minor upgrade ](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/minor_upgrade.jpg)

https://www.zabbix.com/documentation/6.0/en/manual/installation/upgrade/packages/debian_ubuntu


## Zabbix 6.0.27. © 2001–2024, Zabbix SIA

Current version installed, Direct upgrade to Zabbix 6.4.x is possible from Zabbix 6.2.x, 6.0.x [...]

## Upgrade major

```bash

# 1 Stop Zabbix processes
service zabbix-server stop

# 2 Back up the existing Zabbix database

# 3 Back up configuration files, PHP files and Zabbix binaries
# Configuration files:
mkdir /opt/zabbix-backup/
cp /etc/zabbix/zabbix_server.conf /opt/zabbix-backup/
cp /etc/apache2/conf-enabled/zabbix.conf /opt/zabbix-backup/

#PHP files and Zabbix binaries:
cp -R /usr/share/zabbix/ /opt/zabbix-backup/
cp -R /usr/share/zabbix-* /opt/zabbix-backup/

# 4 Update repository configuration package

# Then install the new repository configuration package.

# On Ubuntu 20.04 run:
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-1+ubuntu20.04_all.deb

# Update the repository information.
sudo apt-get update

# 5 Upgrade Zabbix components
sudo apt-get install --only-upgrade zabbix-server-mysql zabbix-frontend-php zabbix-agent

#!!!!!! Upgrading Zabbix agent 2 with the apt install zabbix-agent2 command could lead to an error. For more information, see
https://www.zabbix.com/documentation/6.0/en/manual/installation/known_issues#upgrading-zabbix-agent-2-6.0.5-or-older

# Then, to upgrade the web frontend with Apache correctly, also run:
apt-get install zabbix-apache-conf

# 6 Review component configuration parameters
# Make sure to review Upgrade notes to check if any changes in the configuration parameters are required.

# 7 Start Zabbix processes
service zabbix-server start
service zabbix-proxy start
service zabbix-agent start
service zabbix-agent2 start

# 8 Clear web browser cookies and cache
```
https://www.zabbix.com/documentation/current/en/manual/installation/upgrade

https://www.zabbix.com/documentation/6.0/en/manual/installation/upgrade/packages/debian_ubuntu

