from paho.mqtt import client as mqtt_client
import time
import json
import random
import logging

logging.basicConfig(filename="log.log", filemode="a",format="%(asctime)s - %(thread)d - %(process)d - %(filename)s - %(lineno)d - %(funcName)20s() %(name)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.INFO)


class MqttPublisher():
    
    def __init__(self):
        self.mqtt_host = None 
        self.mqtt_user = None  
        self.mqtt_pass = None
        self.mqtt_topic = "myhome/livingroom/temperature/sensor1" 
        self.reconnect_delay = 5
        # Generate a Client ID with the publish prefix.
        ran = random.randint(0, 10000)
        self.client_id = "publish-" + str(ran)
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
                    rv = "Mqtt host " + self.mqtt_host + ". User " + self.mqtt_user + ". ID " + self.client_id
                    logging.info(rv)
            except FileNotFoundError as ex:
                logging.info(ex)


    def on_connect(self, client, userdata, flags, rc, duck_properties):
        logging.info("On connect " + str(client) + ". " + str(flags) + ". " + str(rc))
        if rc == 0 and client.is_connected():
            logging.info("Connected to MQTT Broker!")
            client.subscribe(self.mqtt_topic)
        else:
            logging.info("Failed to connect, return code " + str(rc))


    def on_disconnect(self, client, userdata,flags, rc, duck_properties):
        logging.info("Disconnected with result code: %s", rc)
        count = 0
        # reconnect_try = 3
        # con = False
        # while count < reconnect_try:
        logging.info("Sleep before reconnect")
        time.sleep(self.reconnect_delay)
        client.reconnect()
        if client.is_connected():
            logging.info("Reconnected successfully!")
            con = True
        else:
            logging.info("Reconnct failed")
                
        self.exit_flag = True

    

    # This is ned for subscriber only
    #def on_message(self,client, userdata, msg):
    #    logging.info(f'Received `{msg.payload.decode()}` from `{msg.topic}` topic')


    def connect_mqtt(self):
        self.read_vault()
        client = mqtt_client.Client(mqtt_client.CallbackAPIVersion.VERSION2,self.client_id)
        client.username_pw_set(self.mqtt_user, self.mqtt_pass)
        client.on_connect = self.on_connect
        # for subscriber only
        # client.on_message = self.on_message
        client.connect("localhost", 1883, keepalive=120)
        client.on_disconnect = self.on_disconnect
        return client


    def publish(self,client):
        msg_count = 0
        while not self.exit_flag:
            msg_dict = {
                'msg': msg_count
            }
            msg = json.dumps(msg_dict)
            if not client.is_connected():
                logging.error("publish: MQTT client is not connected!")
                time.sleep(1)
                continue
            result = client.publish(self.mqtt_topic, msg)
            # result: [0, 1]
            status = result[0]
            if status == 0:
                logging.info(f'Send `{msg}` to topic `{self.mqtt_topic}`')
            else:
                logging.info(f'Failed to send message to topic {self.mqtt_topic}')
            msg_count += 1
            time.sleep(1)


    def run(self):
        client = self.connect_mqtt()
        client.loop_start()
        time.sleep(1)
        if client.is_connected():
            self.publish(client)
        else:
            client.loop_stop()


if __name__ == '__main__':
    logging.info("## Start ##")
    pub = MqttPublisher()
    pub.run()