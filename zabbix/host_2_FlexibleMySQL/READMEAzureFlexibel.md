# Azure Database for MySQL - Flexible Server

## Documentation

https://learn.microsoft.com/en-us/azure/mysql/

## Infrastructure

Ubuntu
* 
* 
* 

Azure for MySQL Flexibel Server
* 
* 
* 

## Install 

6.0 LTS, Ubuntu, 20.04 Focal, Server, Frontend, Agent, MySQL, Apache

https://www.zabbix.com/download?zabbix=6.0&os_distribution=ubuntu&os_version=20.04&components=server_frontend_agent&db=mysql&ws=apache

```bash
sudo apt update
sudo apt upgrade -y

# a. Install Zabbix repository
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo apt update

# b. Install Zabbix server, frontend, agent, Mysql localhost
# Localhost
# sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
# b. Install Zabbix server, frontend, agent, no recommends MySQL, since MySQL on a differnt host
sudp apt install --no-install-recommends zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# c. Create initial database
# Make sure you have database server up and running.
# Run the following on your database host.
mysql -uroot -p
# password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user 'zabbix'@'%' identified by 'A-PASSWORD';
mysql> grant all privileges on zabbix.* to 'zabbix'@'%';
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;

# Test user, you can also check all tables with HeidiSQL with the superuser for example
mysql -u zabbix@hostname -h hostname.mysql.database.azure.com -P 3309 --password=A-PASSWORD

# On Zabbix server host import initial schema and data to MySQL. You will be prompted to enter your newly created password.
# Local host
# zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
# Remote host
zcat server.sql.gz | mysql --default-character-set=utf8mb4 -u zabbix@hostname -h hostname.mysql.database.azure.com -P 3309 --password=A-PASSWORD zabbix

# Disable log_bin_trust_function_creators option after importing database schema.
mysql -uroot -p
password
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;

# d. Configure the database for Zabbix server
Edit file /etc/zabbix/zabbix_server.conf
# DBhost=hostname.mysql.database.azure.com
# DBName=zabbix
# DBUser=zabbix@hostname.mysql.database.azure.com
# DBPassword=A-PASSWORD
# DBHost=3309

# e. Start Zabbix server and agent processes
# Start Zabbix server and agent processes and make it start at system boot.
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

# f. Open Zabbix UI web page
The default URL for Zabbix UI when using Apache web server is http://host/zabbix

```
## Configure Web Interface

https://www.zabbix.com/documentation/6.0/en/manual/installation/frontend

## Secure Azure for MySQL Flexibel Server

Connect to Azure Database for MySQL - Flexible Server with encrypted connections

https://learn.microsoft.com/en-us/azure/mysql/flexible-server/how-to-connect-tls-ssl

Private Link for Azure Database for MySQL - Flexible Server (Preview)

https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-networking-private-link