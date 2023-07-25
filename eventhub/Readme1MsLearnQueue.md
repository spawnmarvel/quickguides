# Discover Azure message queues

https://learn.microsoft.com/en-us/training/modules/discover-azure-message-queue/

## Introduction

Azure supports two types of queue mechanisms: Service Bus queues and Storage queues.

* Service Bus queues are part of a broader Azure messaging infrastructure that supports queuing, publish/subscribe, and more advanced integration patterns. 
* Storage queues are part of the Azure Storage infrastructure. They allow you to store large numbers of messages. You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. 


## Choose a message queue solution

### Consider using Service Bus queues

* Receive messages without having to poll the queue.
* Guaranteed first-in-first-out (FIFO) ordered delivery.
* Support automatic duplicate detection.
* Application to process messages as parallel long-running streams
* Requires transactional behavior and atomicity
* Messages that can exceed 64 KB but won't likely approach the 256-KB limit.


### Consider using Storage queues

* Must store over 80 gigabytes of messages in a queue.
* Track progress for processing a message in the queue. 
* Require server side logs of all of the transactions

## Explorer Azure Service Bus

## TODO