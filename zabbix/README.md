# Zabbix

## Visuals


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

Other than setting your web frontend URL within Zabbix to https://, ignore zabbix for this task.

Treat it as enabling SSL for apache.

Digital Ocean start

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-18-04

```bash

# from clean install with http
http://server_domain_or_IP
# to

# Step 1 — Creating the SSL Certificate
openssl version
OpenSSL 1.1.1f  31 Mar 2020

openssl req -new -newkey rsa:2048 -nodes -keyout server01.domain.net.key -out server01.domain.net.csr

# CN = server01.domain.net

# Step 2 — Configuring Apache to Use SSL
# Creating an Apache Configuration Snippet with Strong Encryption Settings
# sudo nano /etc/apache2/conf-available/ssl-params.conf
# HTTP Strict Transport Security, or HSTS, can do that in config

# Next, you’ll modify /etc/apache2/sites-available/default-ssl.conf
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak

sudo nano /etc/apache2/sites-available/default-ssl.conf

<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin your_email@example.com
                ServerName server01.domain.net

                DocumentRoot /var/www/html

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>

# Step 3 — Adjusting the Firewall
# If you have the ufw firewall enabled, as recommended by the prerequisite guides, you might need to adjust the settings to allow for SSL traffic.

# Step 4 — Enabling the Changes in Apache

# Enable mod_ssl, the Apache SSL module, and mod_headers, which is needed by some of the settings in the SSL snippet, with the a2enmod command
sudo a2enmod ssl
# sudo a2enmod headers

# Next, enable your SSL Virtual Host with the a2ensite command:
sudo a2ensite default-ssl

# You’ll also need to enable your ssl-params.conf file, to read in the values you set:
# sudo a2enconf ssl-params

# Check to make sure that there are no syntax errors in your files with a test:
sudo apache2ctl configtest

# If your output has Syntax OK in it
sudo systemctl restart apache2

# Step 5 — Testing Encryption
# https://server_domain_or_IP

# when https works

# To adjust the unencrypted Virtual Host file to redirect all traffic to be SSL encrypted, open the /etc/apache2/sites-available/000-default.conf file:
cd /etc/apache2/sites-available

sudo cp 000-default.conf 000-default.conf.bak

sudo nano /etc/apache2/sites-available/000-default.conf

<VirtualHost *:80>
        . . .

        Redirect "/" "https://your_domain_or_IP/"

        . . .
</VirtualHost>


# Check to make sure that there are no syntax errors in your files with a test:
sudo apache2ctl configtest

# If your output has Syntax OK in it
sudo systemctl restart apache2


# http://server_domain_or_IP should redirect to https://server_domain_or_IP

```

Digital Ocean end

Next

```bash

# I installed SSL on Zabbix 6 on Ubuntu 20.04.6 LTS by doing the following:
# 1- Backup Apache Configuration: Before making any changes, make sure to back up your current Apache configuration.

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak

# 2- Install SSL Module: Make sure you have the SSL module installed.

sudo a2enmod ssl

# 3- Copy Certificate and Key Files: Place your .crt and .key files in the appropriate directories (usually /etc/ssl/certs/ for the certificate and /etc/ssl/private/ for the key).

sudo cp /path/to/your_certificate.crt /etc/ssl/certs/

sudo cp /path/to/your_private.key /etc/ssl/private/

# 4- Update Apache Configuration: Edit your Apache configuration file 
# (/etc/apache2/sites-available/000-default.conf) to include the path to your SSL certificate and key. Your configuration should include something like this:

<VirtualHost *:443>

ServerName your-zabbix-server-name

SSLEngine on

SSLCertificateFile /etc/ssl/certs/your_certificate.crt

SSLCertificateKeyFile /etc/ssl/private/your_private.key

DocumentRoot /usr/share/zabbix

<Directory "/usr/share/zabbix">

Options FollowSymLinks

AllowOverride None

Require all granted

</Directory>

</VirtualHost>

# Make sure to replace your-zabbix-server-name, your_certificate.crt, and your_private.key with your actual server name and certificate files.

# 5- Restart Apache: Restart the Apache service for changes to take effect.

sudo systemctl restart apache2
```

https://www.reddit.com/r/zabbix/comments/10atj1t/how_to_configure_ssl_on_ubuntu/?rdt=62317


Extra linux vm public or private cert, since public CAs cannot issue certificates for .local domains. 

```bash
sudo apt update

sudo apt install openssl

openssl genrsa -out mysite.local.key 4096
# This will create a file named mysite.local.key which is your private key. Keep this file secure and private.

Country Name (2 letter code): The two-letter country code where your organization is legally located.
State or Province Name (full name): The state or province where your organization is located.
Locality Name (eg, city): The city where your organization is located.
Organization Name (eg, company): The legally registered name of your organization/company.
Organizational Unit Name (eg, section): The division of your organization handling the certificate.
Common Name (e.g. server FQDN or YOUR name): The fully qualified domain name (FQDN) for your server. In your case, you would enter mysite.local.
Email Address: An email address where you can be contacted.
A challenge password & optional company name: You can leave these blank for a CSR.
Review the CSR:

# Once you have generated the CSR, you may want to review it to ensure all information is correct.
openssl req -text -noout -verify -in mysite.local.csr
# This command will display the contents of the CSR in a human-readable format.

# Submit the CSR:
# For a private domain like mysite.local, you would typically use a self-signed certificate or a private Certificate Authority (CA) since public CAs cannot issue certificates for .local domains. 
# If you have a private CA, submit the CSR to your CA according to their process.

# Create a self-signed certificate (if not using a CA):
# If you're using the certificate for internal purposes and do not have a private CA, you can create a self-signed certificate with the following command:

openssl x509 -signkey mysite.local.key -in mysite.local.csr -req -days 365 -out mysite.local.crt
# This will create a certificate file named mysite.local.crt that is valid for 365 days.

# Remember to replace mysite.local with your actual private domain name, and make sure to store your private key and CSR in a secure location. The private key should never be shared or transmitted insecurely.
```

https://github.com/spawnmarvel/azure-automation/blob/main/azure-extra-linux-vm/ubuntu_csr.sh


Follow e-lo public cert and domain

```bash

openssl req -new -newkey rsa:2048 -nodes -keyout yourdomain.key -out yourdomain.csr

# Replace yourdomain with the domain name you’re securing. For example, if your domain name is coolexample.com, you would type coolexample.key and coolexample.csr.

# Open the CSR in a text editor and copy all of the text.

# Paste the full CSR into the SSL enrollment form in your account.

# backup files first

<VirtualHost 172.xx.x.xx:443>
    DocumentRoot /var/www/html2
    ServerName www.yourdomain.com
        SSLEngine on
        SSLCertificateFile /path/to/your_domain_name.crt
        SSLCertificateKeyFile /path/to/your_private.key
        SSLCertificateChainFile /path/to/DigiCertCA.crt
    </VirtualHost>

# Now test it

apachectl configtest

apachectl stop
apachectl start
```

https://follow-e-lo.com/2023/11/02/apache-generate-csr-certificate-signing-request/

Enabling Zabbix on root directory of URL

Enabling HTTP Strict Transport Security (HSTS) on the web server

https://www.zabbix.com/documentation/current/en/manual/installation/requirements/best_practices


Example with local domain on apache for wordpress:

mydomain.private.local

```bash

/etc/apache2/sites-enabled

wordpress.conf

sudo cp wordpress.conf wordpress.conf_bck

ls

wordpress.conf  wordpress.conf_bck

cd

sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/mydomain.private.local.key -out /etc/ssl/certs/mydomain.private.local.crt

# [...]
Common Name (e.g. server FQDN or YOUR name) []:mydomain.private.local

pwd
/etc/ssl/certs
openssl x509 -in mydomain.private.local.crt -text -noout

sudo nano  wordpress.conf
```
edit conf

```yml
<VirtualHost *:80>
ServerAdmin admin@example.com
DocumentRoot /var/www/html/wordpress
ServerName 172.xx.x.xx
ServerAlias mydomain.private.local
Redirect / https://172.xx.x.xx

  <Directory var/www/html/wordpress>
    Options FollowSymLinks
    AllowOverride All
    Require all granted
   </Directory>
   ErrorLog ${APACHE_LOG_DIR}/error.log
   CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:443>
   ServerName 172.xx.x.xx
   DocumentRoot /var/www/html/wordpress

   <Directory /var/www/html/wordpress/>
    Options FollowSymLinks
    AllowOverride All
    Require all granted
   </Directory>

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/mydomain.private.local.crt
   SSLCertificateKeyFile /etc/ssl/private/mydomain.private.local.key
</VirtualHost>
```
check it

```bash
sudo apache2ctl configtest

sudo service apache2 restart

sudo service apache2 status

# visit
https://mydomain.private.local

```
default-ssl.conf

```bash
# apache2

cd /etc/apache2/sites-enabled

000-default.conf  default-ssl.conf

cat default-ssl.conf

<IfModule mod_ssl.c>
  <VirtualHost *:8443>
   Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
   </VirtualHost>
    <VirtualHost _default_:443>
      ServerAdmin webmaster@localhost
                # FQDN
                ServerName vm01.domain.com
                ServerAlias alias.domain.com
                DocumentRoot /var/www/html
			SSLEngine on
        SSLCertificateFile      /etc/ssl/certs/alias.pem
        SSLCertificateKeyFile /etc/ssl/private/alias.pem.key
				<FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>
          <Directory /usr/lib/cgi-bin>
              SSLOptions +StdEnvVars
          </Directory>
	Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
 </VirtualHost>
</IfModule>
```

## Encryption

"PSK is an efficient way, and to be honest you get the same effect, [...] (like, cert management is a hustle compared to psk)."

https://www.reddit.com/r/zabbix/comments/srp2fx/setup_cert_encryption_on_zabbix_agent/?rdt=50737

First, generate a PSK

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-zabbix-to-securely-monitor-remote-servers-on-ubuntu-20-04


## Users and groups (7 Configuration, 12) Users and groups

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

User roles are configured in the Users -> User roles section by Super admin users.

Access to hosts
Access to any host and template data in Zabbix is granted to user groups on the host/template group level only.

That means that an individual user cannot be directly granted access to a host (or host group). It can only be granted access to a host by being part of a user group that is granted access to the host group that contains the host.

User groups
* User groups allow to group users both for organizational purposes and for assigning permissions to data. Permissions to viewing and configuring data of host groups and template groups are assigned to user groups, not individual users.


1. Put host's in a group (Interface monitoring)
2. Create a user group, Problem readers
3. Add Interface monitoring to Problem readers permission Read
4. Add a user, type user, add that user to the Problem readers group

https://www.zabbix.com/documentation/current/en/manual/config/users_and_usergroups/permissions


## Web interface, Users (18,2 Frontend section 8 Users)


https://www.zabbix.com/documentation/current/en/manual/web_interface


## History and trends

The general strong advice is to keep history for the smallest possible number of days and that way not to overload the database with lots of historical values.

Instead of keeping a long history, you can keep longer data of trends. For example, you could keep history for 14 days and trends for 5 years

Whereas history keeps each collected value, trends keep averaged information on hourly basis and therefore are less resource-hungry.

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

## Tuning, what to check.

* When did it start (around new year or short time after? Wait a week)
* How long does it take, what was it before?
* How is general performance?
* Did the DB performance decline also?
* Did the DB grow?
* What is the DB size, should be flat after some time?
* What is the DB IO?
* tail -f zabbix_server.log and zabbix_agentd.log logs
* Check administration and queue?
* Check general and houskeeping settings?
* Has there been changes lately to templates or hosts?
* Num of users?
* What is num of Startpoller?
* Has new values per seconds increased?
* Can you reduce new values per second`?
* Use less min, avg, max more last and nodata.
* For history use smallets days possible, not default 90, 45, 14 or even 7.
* Better to keep trend for longer times, example, history 14 days, trends 1 year.
* Can we live with this?

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


## Troubleshoot

### Houskeeping is above in tuning

### Connection to Zabbix server "localhost" timed out: Possible reasons:

1. Incorrect server IP/DNS in the "zabbix.conf.php".
2. Firewall is blocking TCP connection.
- Connection timed out

Steps

```bash
sudo service zabbix-server status
sudo service zabbix-agent status
sudo service apache2 status

# conf
cd /etc/zabbix/
ls
zabbix_server.conf zabbix_agentd.conf apache.conf

ls -l
# not files are changed
-rw-r--r-- 1 root     root  1789 Jun 22  2022 apache.conf
drwxr-xr-x 2 www-data root  4096 Aug  7 18:12 web
-rw-r--r-- 1 root     root 18155 May 26  2023 zabbix_agentd.conf
-rw------- 1 root     root 17012 Jan 12  2023 zabbix_agentd.conf.old
drwxr-xr-x 2 root     root  4096 Sep 21  2022 zabbix_agentd.d
-rw------- 1 root     root 25989 Jun  7  2023 zabbix_server.conf
-rw------- 1 root     root 25931 Sep 23  2022 zabbix_server.conf.default

Cat zabbix_agentd.conf
# This is commnented out by default, we usually dont change it, it just works default.
# # ListenPort=10051
# logs
cd /var/log/zabbix

sudo tail -f zabbix_server.log

# 1357:20240130:133326.485 failed to accept an incoming connection: connection rejected, getpername() faild: [107] Transport endpoint is not connected.


# check telnet local host
telnet localhost 10050

telnet localhost 10051
# there should be an issue here

# tnc from remote host to zabbix 10051 works

sudo netstat -tulpn | grep ':10051'

sudo netstat -tulpn | grep ':10050'

# Restart vm did not fix it.

# Fix

sudo tail -f zabbix_server.log

# 1357:20240130:133326.485 failed to accept an incoming connection: connection rejected, getpername() faild: [107] Transport endpoint is not connected.

# it is the order of restart that fixes it for some time, but look further down for the root cause.

sudo service zabbix-server stop
sudo service zabbix-agent stop

sudo service zabbix-server start
sudo service zabbix-agent start

# or

sudo systemctl stop zabbix-server.service
sudo systemctl stop zabbix-agent.service

sudo systemctl start zabbix-server.service
sudo systemctl start zabbix-agent.service

# give it 2-3 min? Better.

# Check vm metrics Inbound Flows Max
# The server is flooded, high peaks when it fails.
# DDOS attack....

# many?
sudo ss -tulpn | grep :10051
# few?
sudo ss -tulpn | grep :10050


netstat

```
What is this?

failed to accept an incoming connection: connection rejected, getpeername() failed: [107] Transport endpoint is not connected

https://github.com/linkerd/linkerd2/issues/7266



I had the same problem.

The Zabbix just stopped to work, and I found the same log on the Zabbix.

"failed to accept an incoming connection: connection rejected, getpeername() failed: [107] Transport endpoint is not connected"

The utilization of the trapper data collector was in 100% also.

After I found this post, I have checked with my team, and they have confirmed that our DNS was down.

When they fixed the DNS, the utilization of the trapper data collector fell to 0%, and Zabbix resumed to work properly.

https://github.com/phothet/zabbix/issues/11


Zabbix server is not running: the information may not be current


```bash
netstat -tulpn

Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.1:12563         0.0.0.0:*               LISTEN      -
tcp      951      0 0.0.0.0:10051           0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:10050           0.0.0.0:*               LISTEN      -


cd /etc/zabbix
sudo cat zabbix_server.conf


############ ADVANCED PARAMETERS ################

### Option: StartPollers
#       Number of pre-forked instances of pollers.
#
# Mandatory: no
# Range: 0-1000
# Default:
# StartPollers=20
StartPollers=30

cd /etc/zabbix
sudo cp zabbix_server.conf zabbix_server.conf_bck

sudo nano zabbiz_server.conf

sudo systemctl stop zabbix-server.service
sudo systemctl start zabbix-server.service

### Option: CacheSize
#       Size of configuration cache, in bytes.
#       Shared memory size for storing host, item and trigger data.
#
# Mandatory: no
# Range: 128K-64G
# Default:
CacheSize=64M

### Option: Timeout
#       Specifies how long we wait for agent, SNMP device or external check (in seconds).
#
# Mandatory: no
# Range: 1-30
# Default:
# Timeout=3
# Timeout=15
Timeout=20


# turns out...... it was a host that was sending much data.

# Host logs, is is pilling up and doing to much.
2024/01/11 00:49:27.024498 Detected performance counter with negative denominator the second time after retry, giving up...
2024/01/11 00:49:28.024616 Detected performance counter with negative denominator the second time after retry, giving up...
2024/01/11 00:49:29.025564 Detected performance counter with negative denominator the second time after retry, giving up...
2024/01/11 00:49:30.026362 Detected performance counter with negative denominator the second time after retry, giving up...
2024/01/11 00:49:27.024499 [101] cannot receive data from [ZABBIX-IP:10051]: Cannot read message: 'read tcp HOST-IP21:64868->ZABBIX-IP21:10051: i/o timeout'
2024/01/11 00:49:27.024500 [101] active check configuration update from host [HOST-IP-FQDN] started to fail

# Checked:
# Network Watcher | Traffic Analytics
# Traffic distrubution IP21:Checked Top 20 IPs with respect to network traffic flow count
# NSG hits: Checked: view analytics for NSG and NSG rules across your envornment units in Flows
# Total traffic

# Stopped Zabbix agent2 on the host..
# Better for 1.5 hours
# turns out...... it was also one more host that was sending much data.
# Stopped Zabbix agent2 on the other host..
# better for 2 hours an counting.....se after the night.
# It looks good in the morning (+ 7h) the last stopped agent was even started up again, and it seems stabil.
# Maybe just agent hang and in need of a restart, looks ok after starting it again.
# Os was upgraded some days before, kernel but that did not influence it.
# The agent was crazy, maybe update the agent version.

```
## Zabbix forum

https://www.zabbix.com/forum/zabbix-help/479547-sudden-peaks-in-inbound-flows-to-zabbix-from-agents-halting-zabbix

###  Value cache effectiveness


If any of the cache usages go above 80% then consider adjusting the Zabbix servers CacheSize setting.

The CacheSize setting is in the zabbix_server.conf file. The default is 8M. You can change this from 128K to 64GB. 

You will need to adjust this as you manage more hosts, especially if they have many triggers, calculated items, dependent items and other host related statistics and properties stored in the cache.


Value cache effectiveness (dashboard Zabbix Server Health)


The two important values shown in this graph are related to hits and misses. 

A Hit is when a value was retrieved from memory. A miss happens when the data is not currently in memory, but needs to be retrieved from the database first. 

Aim to have as few misses as possible by increasing the CacheSize setting if necessary, or by reducing the amount of items and triggers you are processing for a host.


But the miss after 45 min after agent log: cannot receive data from cannot read message 'read tcp i/o timeout'

![Connection lost ](https://github.com/spawnmarvel/quickguides/blob/main/zabbix/images/connection_lost.jpg)

https://sbcode.net/zabbix/zabbix-server-health/


Fix?

Workarround:
"Downgrade" to the classic zabbix agent. Perfomance counters works right.

https://support.zabbix.com/browse/ZBX-21661

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

