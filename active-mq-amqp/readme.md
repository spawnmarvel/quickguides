#

## Table of content

- [](#)
  - [Table of content](#table-of-content)
  - [RabbitMQ limitations with mtls on windows server](#rabbitmq-limitations-with-mtls-on-windows-server)
  - [Switch to Apache ActiveMQ (or Apache ActiveMQ Artemis),](#switch-to-apache-activemq-or-apache-activemq-artemis)
  - [Apache Active MQ 1, 2 and 3](#apache-active-mq-1-2-and-3)
  - [RabbitMQ vs ActiveMQ 30 to 50 one-to-one connections](#rabbitmq-vs-activemq-30-to-50-one-to-one-connections)

## RabbitMQ limitations with mtls on windows server


Because RabbitMQ relies entirely on the underlying Erlang/OTP TLS implementation (ssl application), it inherently expects file-system paths pointing to flat files (typically PEM-encoded format) for the Root CA, the certificate chain/node certificate, and the private key.

Static shovels are configured using Erlang terms inside the advanced.config file (or via environment options depending on how the shovel connects).


* cacertfile: Path to the file containing the trusted Root CA certificate(s).   
* certfile: Path to the client's public certificate file.   
* keyfile: Path to the client's private key file.

Here are the best practices for securing private key flat files in a RabbitMQ environment:

1. File System Permissions and Ownership, Strict Ownership

Yes, on Windows, securing flat-file private keys relies heavily on NTFS file permissions, Access Control Lists (ACLs), and Windows service accounts.

## Switch to Apache ActiveMQ (or Apache ActiveMQ Artemis),

1. Java Keystores and Truststores Instead of Flat PEM Files
Instead of needing separate, unencrypted flat files (certfile, keyfile, cacertfile) sitting loose on the disk, Java-based message brokers use Keystores and Truststores (typically .jks or .p12 / PKCS12 format).

* Single Container File: Your private key and certificate chain are bundled together into a single keystore file, which is protected by a keystore password.

* Truststore: The trusted Root CAs are placed into a separate truststore file.

* Security Benefit: While the keystore file is still technically on disk, the private key inside it is encrypted with a password, adding an extra layer of protection beyond standard file permissions

2. Native Network Bridges ("Network of Brokers")
ActiveMQ is famous for its powerful Network of Brokers feature, which allows you to set up store-and-forward bridges between different brokers very easily.

* SSL/TLS Transport: You can configure these network connectors to use SSL/TLS with client authentication (mTLS) by pointing the broker configuration (activemq.xml) directly to your Java keystore and truststore paths and providing the keystore password.

* AMQP Support: Modern ActiveMQ (especially Artemis) has first-class, high-performance support for AMQP 1.0, allowing you to run standard AMQP traffic end-to-end across your bridged network securely.


## Apache Active MQ 1, 2 and 3

1. Install OpenJDK

* Version Requirement
* Environment Variable:

2. Download and Extract ActiveMQ

* Download the Windows-compatible binary zip distribution from the official Apache ActiveMQ website
* Extract it to a clean directory path (e.g., C:\ActiveMQ\apache-activemq). Avoid spaces in the folder path to prevent script execution issues with Windows batch files.
  
3. Running as a Windows Service

* ActiveMQ includes a built-in wrapper utility (bin\win64\wrapper.exe or similar depending on the exact version/flavor) to install itself into the Windows Service Control Manager (services.msc)
* You can configure the service to run automatically on system startup under a dedicated Windows service account.

4. Managing Keystores After Installation

Once OpenJDK and ActiveMQ are running, you can handle your mTLS certificates using Java's key management tools rather than flat files:

* Use Java's built-in keytool utility (which comes with OpenJDK) to import your certificates into a .p12 (PKCS12) or .jks keystore.
*  Point your ActiveMQ transport connector configuration inside activemq.xml to that keystore file and provide the password, keeping your private keys safely encrypted inside the keystore container.
*  

## RabbitMQ vs ActiveMQ 30 to 50 one-to-one connections

With a maximum of 30 to 50 connections and a one-to-one, direct messaging pattern, your workload is extremely light for any modern message broker.

Both RabbitMQ and ActiveMQ (Artemis or Classic) will handle this load effortlessly without breaking a sweat. Neither option will run into performance bottlenecks or resource limits at this scale.

Which one should you pick based on your needs?

* Choose ActiveMQ if you prefer managing certificates inside a password-protected Java keystore/truststore rather than handling unencrypted flat files and Windows ACL permissions (icacls) on disk.
* Choose RabbitMQ if you prefer a smaller footprint, native Erlang/AMQP tooling, and are comfortable securing the flat .pem keys using Windows service permissions.

At 30–50 connections, performance won't be the deciding factor—ease of management and how your team prefers handling security/certificates should drive your choice!
