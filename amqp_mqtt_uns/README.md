# AMQP, RabbitMQ, MQTT as UNS, Unified Namespace

## What is UNS

A Unified Namespace (UNS) is a centralized, hierarchical, and standardized naming and organizational framework used to manage and integrate data across an enterprise or system. It acts as a single source of truth, providing a consistent way to identify, organize, and access data from various sources, such as devices, applications, databases, and processes, in real-time. The concept is particularly prominent in industrial automation, IoT (Internet of Things), and digital transformation initiatives, where seamless data integration and interoperability are critical.

***In a UNS, all data is structured in a logical, hierarchical tree-like format, often resembling a file system or directory structure. ***

For example, in a manufacturing environment, the hierarchy might include levels like 

* "Enterprise," "Site," "Area," "Line," and "Machine." 
* Each level contains relevant data points, such as sensor readings, production metrics, or equipment status, associated with that part of the operation. 

This structure ensures that data is contextually rich, easily discoverable, and universally understood across the organization.

The UNS is typically implemented using technologies like MQTT (Message Queuing Telemetry Transport) brokers, which enable real-time data communication between devices and systems. By leveraging a UNS, organizations can break down data silos, improve scalability, and enable better decision-making through a holistic view of operations. It also supports advanced analytics, machine learning, and automation by providing a standardized data foundation.

In essence, a Unified Namespace simplifies the complexity of managing diverse data sources, fosters interoperability, and aligns with modern architectures like Industry 4.0. 

***It is not a physical database but rather a logical framework that ensures all systems and stakeholders speak the same "data language," driving efficiency and innovation across the enterprise.***

## Selecting a broker for your Unified Namespace

Two protocols frontrunners

Currently, there are two protocols that are front runners for becoming the de facto data transfer choice in (industrial) IoT: MQTT or Kafka. They’ve been designed for different use cases and have different properties. At this time, MQTT is more often deployed as a broker in the unified namespace and is generally the best choice when starting to implement a unified namespace, it also features better support from hardware vendors.

The Cloud route

Cloud message queue brokers like AWS Kinesis and GCP Pub/Sub offer a high level of convenience. Scaling the infrastructure for real-time data processing and communication is their concern, the customer is mostly concerned about paying the bill. These brokers are fully managed, meaning they are maintained and updated by the cloud provider, reducing the burden on developers.

***Exotic options***

RabbitMQ is a widely used open-source message broker that’s mostly used as an event message bus for web applications. It can also function as a hub in a unified namespace. The broker primarily supports the AMQP (Advanced Message Queuing Protocol), considered the industry standard for high-performance messaging systems. It also supports STOMP (Streaming Text Oriented Messaging Protocol) and MQTT (MQ Telemetry Transport), catering to various messaging needs.


How Node-RED Helps


Node-RED provides a powerful and flexible way to integrate with various brokers, supporting protocols such as MQTT, Kafka, and AMQP. It allows you to build and manage workflows that interact with your chosen broker, seamlessly connecting different data sources and systems.

***Node-RED vs Telegraf***



https://flowfuse.com/blog/2024/01/unified-namespace-what-broker/


## UNS example with rabbitmq and telegraf as etl tool

Below is an example of implementing a Unified Namespace (UNS) using **RabbitMQ** as the message broker and **Telegraf** as the ETL (Extract, Transform, Load) tool to collect, process, and route data. This example focuses on a manufacturing environment where sensor data from machines is organized into a UNS and made accessible in real-time.

---

### Scenario
Imagine a factory with two production lines, each with multiple machines. The goal is to collect sensor data (e.g., temperature, vibration) from these machines, organize it into a UNS, and make it available for monitoring and analytics. The UNS will follow a hierarchical structure like:
- `Enterprise/Site/Area/Line/Machine/Sensor`

For example:
- `Factory1/PlantA/Assembly/Line1/Machine1/Temperature`
- `Factory1/PlantA/Assembly/Line2/Machine2/Vibration`

---

### Components
1. **RabbitMQ**: Acts as the message broker to handle the UNS. It uses topics or queues to route data based on the UNS hierarchy.
2. **Telegraf**: Collects data from machines (e.g., via MQTT, Modbus, or OPC UA), transforms it, and publishes it to RabbitMQ.
3. **Consumers**: Applications or systems (e.g., dashboards, databases) that subscribe to specific UNS topics in RabbitMQ to access the data.

---

### Implementation Steps

#### 1. **Set Up RabbitMQ**
- Install RabbitMQ and enable the MQTT plugin (if using MQTT as the protocol for Telegraf).
- Create an exchange (e.g., `uns_exchange`) of type `topic` to route messages based on the UNS hierarchy.
- Define routing keys that match the UNS structure, such as `Factory1.PlantA.Assembly.Line1.Machine1.Temperature`.

#### 2. **Configure Telegraf**
Telegraf will collect data from machines, transform it, and publish it to RabbitMQ. Below is an example configuration (`telegraf.conf`):

```toml
# Input plugin to collect data from machines (e.g., via MQTT or Modbus)
[[inputs.mqtt_consumer]]
  servers = ["tcp://localhost:1883"]
  topics = ["sensors/#"]
  data_format = "json"

# Processor plugin to add UNS context (optional transformation)
[[processors.override]]
  [processors.override.tags]
    enterprise = "Factory1"
    site = "PlantA"
    area = "Assembly"
    line = "Line1"
    machine = "Machine1"

# Output plugin to publish to RabbitMQ
[[outputs.amqp]]
  url = "amqp://guest:guest@localhost:5672/"
  exchange = "uns_exchange"
  exchange_type = "topic"
  routing_key = "{{ .tags.enterprise }}.{{ .tags.site }}.{{ .tags.area }}.{{ .tags.line }}.{{ .tags.machine }}.{{ .name }}"
  format = "json"
```

In this configuration:
- Telegraf subscribes to an MQTT broker to collect raw sensor data.
- The `processors.override` plugin adds UNS context (e.g., enterprise, site) as tags.
- The `outputs.amqp` plugin publishes the data to RabbitMQ, using the UNS hierarchy as the routing key.

#### 3. **Publish Data to RabbitMQ**
When Telegraf collects data from a machine (e.g., temperature = 75°C from Machine1), it transforms the data and publishes it to RabbitMQ with a routing key like:
- `Factory1.PlantA.Assembly.Line1.Machine1.Temperature`

The message payload might look like:
```json
{
  "enterprise": "Factory1",
  "site": "PlantA",
  "area": "Assembly",
  "line": "Line1",
  "machine": "Machine1",
  "sensor": "Temperature",
  "value": 75,
  "timestamp": "2023-10-10T10:00:00Z"
}
```

#### 4. **Consume Data from RabbitMQ**
Applications or systems can subscribe to specific UNS topics in RabbitMQ to access the data. For example:
- A dashboard might subscribe to `Factory1.PlantA.Assembly.Line1.*` to monitor all sensors on Line1.
- A time-series database (e.g., InfluxDB) might subscribe to `Factory1.PlantA.Assembly.#` to store all data from the Assembly area.

To subscribe, use a RabbitMQ client (e.g., in Python with `pika`):
```python
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

channel.exchange_declare(exchange='uns_exchange', exchange_type='topic')

queue_name = channel.queue_declare(queue='', exclusive=True).method.queue
channel.queue_bind(exchange='uns_exchange', queue=queue_name, routing_key='Factory1.PlantA.Assembly.Line1.*')

def callback(ch, method, properties, body):
    print(f"Received: {body} with routing key: {method.routing_key}")

channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)
channel.start_consuming()
```

---

### Benefits of This Setup
1. **Centralized Data Access**: All data is organized in a UNS and accessible through RabbitMQ, acting as the single source of truth.
2. **Scalability**: RabbitMQ's topic-based routing allows for flexible and scalable data distribution.
3. **Real-Time Processing**: Telegraf ensures data is collected, transformed, and published in real-time.
4. **Interoperability**: Systems can subscribe to specific parts of the UNS, enabling seamless integration.

---

### Example UNS Hierarchy in RabbitMQ
- `Factory1.PlantA.Assembly.Line1.Machine1.Temperature`
- `Factory1.PlantA.Assembly.Line1.Machine1.Vibration`
- `Factory1.PlantA.Assembly.Line2.Machine2.Temperature`

This structure ensures that data is contextually rich and easily discoverable, aligning with the principles of a Unified Namespace.