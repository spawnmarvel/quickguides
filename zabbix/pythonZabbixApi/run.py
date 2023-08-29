import requests
import json
import logging

UNAME = "Admin"
PWORD = "zabbix"
AUTHTOKEN = None
TEMPLATEID = None
TEMPLATENAMETOUPDATE = None
# this must be set on run and you must create it in zabbix first
TEMPLATENAMECHECK = "Goodtech IP21 SHA"
#

def connect_zabbix(url_zabbix):
    logging.info("Connection to IMS OC, get token")
    
    global UNAME
    global PWORD
    global AUTHTOKEN
    r = requests.post(url_zabbix,
                  json={
                      "jsonrpc": "2.0",
                      "method": "user.login",
                      "params": {
                          "user": UNAME,
                          "password": PWORD},
                      "id": 1
                  })

    # print(json.dumps(r.json(), indent=4, sort_keys=True))
    AUTHTOKEN = r.json()["result"]
    logging.info(AUTHTOKEN)
    return AUTHTOKEN