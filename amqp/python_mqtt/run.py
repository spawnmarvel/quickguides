import paho.mqtt.client as mqtt
import time


mqtthost = "localhost"  
mqttuser = ""  
mqttpass = ""  
mqtttopic = "demo.key" 
# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, reason_code, properties):
    print(f"Connected with result code {reason_code}")
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe(mqtttopic)

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
     print(msg.topic+" "+str(msg.payload))

mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
print(mqttc.callback_api_version)
mqttc.on_connect = on_connect
mqttc.on_message = on_message

mqttc.username_pw_set(mqttuser, mqttpass)

mqttc.connect("localhost", 1883, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
# mqttc.loop_forever()

mqttc.loop_start()

while True:
    
    for x in range(100):
        message = "test data " + str(x)
        (rc, mid) = mqttc.publish(mqtttopic, str(message), qos=1)
        print("loop")
        time.sleep(10)


# Created a queue with name mqtt-demo-queue01, bindings amq.topic demo.key
# start and send data every 10 sec.
# view message header
# delivery_mode:	2, headers:	x-mqtt-publish-qos:	1
