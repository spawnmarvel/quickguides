import urllib.request
import json
import logging

logging.basicConfig(filename="log.log", filemode="a",format="%(asctime)s - %(thread)d - %(process)d - %(filename)s - %(lineno)d - %(funcName)20s() %(name)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.INFO)

# https://www.zabbix.com/documentation/current/en/manual/api
# The Zabbix API is an HTTP-based API, and it is shipped as a part of the web frontend. It uses the JSON-RPC 2.0 protocol, which means two things:
# The API consists of a set of separate methods.
# Requests and responses between the clients and the API are encoded using the JSON format.

class ApiWorker():

    def __init__(self):
        self.url = None
        self.user = None
        self.cred = None
        self.port = None
        self.authtoken = None
        self.read_vault()
        self.connect_zabbix()
        self.host_list = self.get_all_hosts()

    def read_vault(self):
        try:
            with open("keyvault.json") as fi:
                data_tmp = json.load(fi)
                data = data_tmp["keyvault"]
                rv = data[0]
                self.url = rv["url"]
                self.user = rv["user"]
                self.cred = rv["cred"]
        except FileNotFoundError as ex:
            logging.info(ex)

    def connect_zabbix(self):
        logging.info("Connecting to zabbix, trying to get token")
        try:
            logging.debug(self.url)
           
            # headers
            headers = {'Content-type': 'application/json'}
            logging.info(headers)
            # post data
            post_data = {"jsonrpc": "2.0", "method": "user.login","params": {
                                      "user": self.user,
                                      "password": self.cred},
                                  "id": 1
            }
            post_json = json.dumps(post_data).encode("utf-8")
            req = urllib.request.Request(self.url, post_json, headers)
            with urllib.request.urlopen(req) as f:
                result = f.read()
                rv = result.decode()
                logging.debug(rv)
                json_object = json.loads(rv)
                # {"jsonrpc":"2.0","result":"TOKEN-TOKEN-TOKEN","id":1}
                self.authtoken = json_object["result"]
                logging.info("Authtoken acquired")

        except Exception as ex:
            logging.error(ex)
        return self.authtoken
    

    def new_get_hosts(self):
        # https://www.zabbix.com/documentation/current/en/manual/api
        # auth is the old way, but always returns
        # 2024-03-17 20:33:22,576 root DEBUG {"jsonrpc":"2.0","error":{"code":-32602,"message":"Invalid params.","data":"Not authorized."},"id":1}
        # fix
        # https://www.zabbix.com/forum/zabbix-troubleshooting-and-problems/465800-python-api-modules-not-working-with-6-4
        # SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
        # to the apache config solved the problem.
        # It seems Apache by default does not pass the Authorization header.
        logging.info("Trying to get host")
        try:
            # post data
            post_data = {"jsonrpc": "2.0", "method": "host.get","params": {
                                      "output": [
                                          "hostid",
                                          "host"
                                          ],
                                          "selectIntrefaces": [
                                              "interfaceid",
                                              "ip"
                                          ]
            },
            "id":1
            }
            post_json = json.dumps(post_data).encode("utf-8")
            req = urllib.request.Request(self.url, post_json)
            req.add_header('Content-type','application/json')
            logging.debug(self.authtoken)
            req.add_header('Authorization', str(self.authtoken))
            with urllib.request.urlopen(req) as f:
                result = f.read()
                rv = result.decode()
                logging.debug(rv)
                json_object = json.loads(rv)

        except Exception as ex:
            logging.error(ex)

    def get_all_hosts(self):
        # https://www.zabbix.com/documentation/current/en/manual/api/reference/host/get
        logging.info("Trying to get hosts")
        host_list = []
        try:
            # post data
            post_data = {"jsonrpc": "2.0", "method": "host.get","params": {
                                      "output": [
                                          "hostid",
                                          "host"
                                          ]},
                                          "auth":self.authtoken,
            "id":2
            }
            post_json = json.dumps(post_data).encode("utf-8")
            req = urllib.request.Request(self.url, post_json)
            req.add_header('Content-type','application/json')
            logging.debug(self.authtoken)
            req.add_header('Authorization', str(self.authtoken))
            with urllib.request.urlopen(req) as f:
                result = f.read()
                rv = result.decode()
                logging.debug(rv)
                json_dict = json.loads(rv)
                logging.debug(type(json_dict))

                all_keys = "All keys; "
                for k, v in json_dict.items():
                    all_keys = all_keys + "; " + str(k)
                    if k == "result":
                        logging.debug(v)
                        logging.debug(type(v))
                        for l in v:
                            logging.debug(l)
                            logging.debug(type(l))
                            host_list.append(l)
                logging.info(all_keys)
            logging.info(host_list)
            logging.info("Hosts list populated")
            return host_list
        except Exception as ex:
            logging.error(ex)

    def update_host(self, hostname):
        # init list
        li = self.host_list
        logging.info("Case sensitive, VM28 is not vm28 or Vm28")
        logging.info("Searching for " + str(hostname))
        found = False
        try:
            for l in li:
                if l["host"] == str(hostname):
                    logging.info(str(hostname) + ". Found, can be updated")
                    found = True
                    break
            if not found:
                logging.info(str(hostname) + ". Not found.")
                    
        
        except Exception as ex:
            logging.error(ex)




    def get_host_groups(self):
        # https://www.zabbix.com/documentation/current/en/manual/api/reference/hostgroup/get
        logging.info("Trying to get host groups")
        try:
            # post data
            post_data = {"jsonrpc": "2.0", "method": "hostgroup.get","params": {
                                      "output": 
                                          "extend"
                                          },
                                          "auth":self.authtoken,
            "id":2
            }
            post_json = json.dumps(post_data).encode("utf-8")
            req = urllib.request.Request(self.url, post_json)
            req.add_header('Content-type','application/json')
            logging.debug(self.authtoken)
            req.add_header('Authorization', str(self.authtoken))
            with urllib.request.urlopen(req) as f:
                result = f.read()
                rv = result.decode()
                logging.info(rv)
                # json_dict = json.loads(rv)
                
           
                

        except Exception as ex:
            logging.error(ex)


if __name__ == "__main__":
    logging.info("#### Started ####")
    logging.info("#### No third party dependencies, default Python ####")
    worker = ApiWorker()
    # worker.get_all_hosts()
    worker.update_host("vm89")
    worker.update_host("VM28")
    # worker.get_host_groups()