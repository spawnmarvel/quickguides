// See https://aka.ms/new-console-template for more information

using System;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NLog;
using NLog.Extensions.Logging;
using RabbitMQ.Client;
using RabbitMQ.Client.Impl; // For BasicProperties

// Ensure log directory exists
Directory.CreateDirectory("log");

// Create logger
var logger = LogManager.GetCurrentClassLogger();
logger.Info("Hi");

Console.WriteLine("Hello, World!");
Console.WriteLine("How many messages to send to amqp, enter a number");

// Get amount of messages from input
string? input = Console.ReadLine();
int number = 0;
if (int.TryParse(input, out number) && number > 0)
{
    Console.WriteLine("Number " + number);
}
else
{
    Console.WriteLine("Invalid number, using default value of 1.");
    number = 1;
}

// Publish to AMQP
Console.WriteLine("Publish to AMQP");
var publisher = new Sender(number);
await publisher.SendMessagesAsync(); // Pass user input as count

// Wait for user to exit
Console.WriteLine("Press Enter to exit...");
Console.ReadLine();