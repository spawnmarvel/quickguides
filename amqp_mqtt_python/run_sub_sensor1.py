from paho.mqtt import client as mqtt_client
import time
import json
import random
import logging

logging.basicConfig(filename="log_subscriber.log", filemode="a",format="%(asctime)s - %(thread)d - %(process)d - %(filename)s - %(lineno)d - %(funcName)20s() %(name)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.INFO)

# https://pypi.org/project/paho-mqtt/#client
# PUBLISHER EXAMPLE

class MqttPublisher():
    
    def __init__(self):
        self.mqtt_host = None 
        self.mqtt_user = None  
        self.mqtt_pass = None
        self.mqtt_topic = "myhome/livingroom/temperature/sensor1" 
        self.reconnect_delay = 5
        self.reconnect_try = 10
        # Generate a Client ID with the publish prefix.
        ran = random.randint(0, 10000)
        self.client_id = "subscribe-" + str(ran)
        self.exit_flag = False


    def read_vault(self):
            try:
                with open("keyvault.json") as fi:
                    data_tmp = json.load(fi)
                    data = data_tmp["keyvault"]
                    rv = data[0]
                    self.mqtt_host = rv["mqtthost"]
                    self.mqtt_user = rv["mqttuser"]
                    self.mqtt_pass = rv["mqttpass"]
                    rv = "Mqtt broker: " + self.mqtt_host + ". App user: " + self.mqtt_user + ". App ID: " + self.client_id
                    logging.info(rv)
            except FileNotFoundError as ex:
                logging.info(ex)


    def on_connect(self, client, userdata, flags, rc, duck_properties):
        logging.info("On connect " + str(client) + ". " + str(flags) + ". " + str(rc))
        if rc == 0 and client.is_connected():
            logging.info("Connected to Mqtt broker!")
            logging.info("Waiting for data.....")
            # https://pypi.org/project/paho-mqtt/#client
            # this is for subscriber
            # we should always subscribe from on_connect callback to be sure
            # our subscribed is persisted across reconnections.
            # client.subscribe("$SYS/#")
            client.subscribe(self.mqtt_topic)
        else:
            logging.info("Failed to connect, return code " + str(rc))


    def on_disconnect(self, client, userdata,flags, rc, duck_properties):
        logging.info("On disconnect " + str(client) + ". " + str(flags) + ". " + str(rc))
        count = 0
        con = False
        while count < self.reconnect_try:
            if rc != "Success":
                logging.info("On disconnect " + str(rc))
                logging.info("Sleep before reconnect")
                time.sleep(self.reconnect_delay)
                client.reconnect()
                count +=1
                if client.is_connected():
                    logging.info("Reconnected successfully!")
                    con = True
                else:
                    logging.info("Reconnct failed, attempt " + str(count))
        logging.info("Reconnct failed, and used max attempts " + str(self.reconnect_try))
        self.exit_flag = True

    
    # This is need for subscriber only
    def on_message(self,client, userdata, msg):
        logging.info("Received " + str(msg.payload.decode()) + " from " + str(msg.topic) + " . topic")


    def connect_mqtt(self):
        self.read_vault()
        con_status = False  
        client = None
        while not con_status:
            try:
                # https://stackoverflow.com/questions/77984857/paho-mqtt-unsupported-callback-api-version-error
                client = mqtt_client.Client(mqtt_client.CallbackAPIVersion.VERSION2,self.client_id)
                client.username_pw_set(self.mqtt_user, self.mqtt_pass)
                client.on_connect = self.on_connect
                client.connect("localhost", 1883, keepalive=120)
                client.on_disconnect = self.on_disconnect
                client.on_message = self.on_message
                con_status = True
                self.simulate_wait()
                return client
            except Exception as ex:
                logging.error(ex)
        return client


    def simulate_wait(self):
        logging.info("Sleep before next action")
        time.sleep(3)


    def run(self):
        client = self.connect_mqtt()
        logging.info(client)
        if not client:
            logging.error("Cound not establish a Mqtt connection")
            logging.error("Is the mqtt broker running?. " + str(self.mqtt_host))
            logging.info("Stopping app. " + str(self.client_id))
        else:
            client.loop_forever()
           


if __name__ == '__main__':
    logging.info("##### Start Subscriber ######")
    pub = MqttPublisher()
    pub.run()