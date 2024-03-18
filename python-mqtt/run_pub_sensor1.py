import paho.mqtt.client as mqtt
import time
import json

import logging

logging.basicConfig(filename="log.log", filemode="a",format="%(asctime)s - %(thread)d - %(process)d - %(filename)s - %(lineno)d - %(funcName)20s() %(name)s - %(levelname)s - %(message)s", datefmt="%Y-%m-%d %H:%M:%S",level=logging.INFO)


MQTTHOST = None 
MQTTUSER = None  
MQTTPASS = None
MQTTTOPIC = "myhome.livingroom.temperature.sensor1.status" 



def read_vault():
        global MQTTHOST 
        global MQTTUSER
        global MQTTPASS
        try:
            with open("keyvault.json") as fi:
                data_tmp = json.load(fi)
                data = data_tmp["keyvault"]
                rv = data[0]
                MQTTHOST = rv["mqtthost"]
                MQTTUSER = rv["mqttuser"]
                MQTTPASS = rv["mqttpass"]
                rv = MQTTHOST + " ; " + MQTTUSER
                logging.info(rv)
        except FileNotFoundError as ex:
            logging.info(ex)

read_vault()

# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, reason_code, properties):
    global MQTTTOPIC
    print(f"Connected with result code {reason_code}")
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe(MQTTTOPIC)

mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
mqttc.on_connect = on_connect

logging.info(MQTTHOST)

mqttc.username_pw_set(str(MQTTUSER), str(MQTTPASS))

mqttc.connect("localhost", 1883, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
# mqttc.loop_forever()


mqttc.loop_start()
logging.info("## start ##")
while True:
    
    for x in range(100):
        logging.info(MQTTTOPIC)
        message = "test data " + str(x)
        (rc, mid) = mqttc.publish(MQTTTOPIC, str(message), qos=1)
        logging.info("loop " + str(x))
        time.sleep(10)


# Created a queue with name mqtt-demo-queue01, bindings amq.topic myhome/livingroom/temperature/sensor1/status
# start and send data every 10 sec.
# view message header
# delivery_mode:	2, headers:	x-mqtt-publish-qos:	1


# https://www.rabbitmq.com/docs/mqtt
# rabbitmq-plugins enable rabbitmq_mqtt

# rabbitmq.conf
# mqtt.listeners.tcp.default = 1883
# mqtt.listeners.ssl.default = 8883
# mqtt.ssl_cert_login = true
# mqtt.allow_anonymous = true