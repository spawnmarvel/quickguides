## Wordpress

How to Programmatically Create Dozens of Wordpress Pages to Catalogue Thousands of Documents

https://python.plainenglish.io/how-to-programmatically-create-dozens-of-wordpress-pages-to-catalogue-thousands-of-documents-f3f531fdff84

## Install Ubuntu

## WordPress Python Integration, no plugin

https://blog.finxter.com/how-to-publish-a-wordpress-post-using-python/

https://follow-e-lo.com/

* The application password feature requires HTTPS
* New user
* Role author
* Application Passwords
Application passwords allow authentication via non-interactive systems, such as XML-RPC or the REST API, without providing your actual password. Application passwords can be easily revoked. They cannot be used for traditional logins to your website. 
* Add string: XXXXXXXXXXXXXXXX


![Wp pass create](https://github.com/spawnmarvel/quickguides/blob/main/wordpress/images/apppass.jpg)

* You get a new password back

Run the code for create page

![Python page](https://github.com/spawnmarvel/quickguides/blob/main/wordpress/images/resultpage.jpg)

Run the code for create post with sub html template, no body or html tag

![With HTML template](https://github.com/spawnmarvel/quickguides/blob/main/wordpress/images/withtemplate.jpg)

## REST API Handbook


Create post
* POST /wp/v2/posts
https://developer.wordpress.org/rest-api/reference/posts/#create-a-post

Create page
* POST /wp/v2/pages
https://developer.wordpress.org/rest-api/reference/pages/#create-a-page



https://developer.wordpress.org/rest-api/

## Create a tag database with MySql

* Userbase : 250
* Make a tag db and set restriction on tags
* Used for make an organized chaos with tags

Example tags for customer and product:

| Entity              | Tag 1:Segment |  Tag 2: Supplier |
| -------------       | ------------- | -------------    |
| Customer Oil Inc    | oil           |                  |
| Customer Gas Inc    | gas           |                  |
| Customer Food Inc   | food          |                  |
| Product MonitorLane |               | softlane         | 
| Product GasMonitor  |               | limasolutions    |
| Product WasherSink  |               | limasolutions    |

Misc tags:

* Install
* Configure
* Troubleshoot
* OPC
* OPCAE
* MEC
* License
* MQTT

MySQL row:

| Id       |  Tag           | Description  |
| -------- | -------------  | ------------ |
| AutoInc  | oil            | All customers that produces oil  |
| AutoInc  | gas            | All customers that produces gas  |
| AutoInc  | food           | All customers that produces food |
| AutoInc  | softlane       | Supplier  |
| AutoInc  | limasolutions  | Supplier  |
| AutoInc  | Install        | Install   |
| AutoInc  | configure      | Configure |
| AutoInc  | troubleshoot   | How to troubleshoot and support   |
| AutoInc  | opc            | Open platform communication       |
| AutoInc  | opcae          | Open platform communication Alarm  and events |
| AutoInc  | mec            | Mechanical engineering   |
| AutoInc  | license        | License description   |
| AutoInc  | mqtt           | Message Queuing Telemetry Transport   |






*** MySql: Chapter 5 Connector/Python Coding Examples***

https://dev.mysql.com/doc/connector-python/en/connector-python-examples.html


*** Deploying a Flask Application via the Apache Server ***

https://www.opensourceforu.com/2023/03/deploying-a-flask-application-via-the-apache-server/


