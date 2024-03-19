# 19 API

The Zabbix API allows you to programmatically retrieve and modify configuration of Zabbix and provides access to historical data. It is widely used to:

* Create new applications to work with Zabbix;
* Integrate Zabbix into a third-party software;
* Automate routine tasks.

The Zabbix API is an HTTP-based API, and it is shipped as a part of the web frontend. It uses the JSON-RPC 2.0 protocol, which means two things:

* The API consists of a set of separate methods.
* Requests and responses between the clients and the API are encoded using the JSON format.

## Visuals

https://follow-e-lo.com/2024/03/17/zabbix-api/

## Method reference

https://www.zabbix.com/documentation/current/en/manual/api/reference

## No dependencies: import urllib.request

## def connect_zabbix(self):

"method": "user.login"


## def get_all_hosts(self):

"method": "host.get"

## def update_host(self, hostname):






https://www.zabbix.com/documentation/current/en/manual/api