// See https://aka.ms/new-console-template for more information

using System;
using System.Threading.Tasks;
using NLog;
using NLog.Extensions.Logging;

class Program
{
    static async Task Main(string[] args)
    {
        // ensure dir exists
        Directory.CreateDirectory("log");
        // create logger
        var logger = LogManager.GetCurrentClassLogger();
        //log
        logger.Info("Hi");

        Console.WriteLine("Hello, World!");
        Console.WriteLine("How many mesages to send to amqp, enter a number");

        // get amount of messages vfrom input
        string? input = Console.ReadLine();
        int number;
        if (int.TryParse(input, out number))
        {
             Console.WriteLine("Number " + number);

        }
        else
        {
            Console.WriteLine("Invalid number");
        }        // publish to amqp
        Console.WriteLine("Publish to AMQP");
        var publisher = new PublishSend();
        await publisher.SendMessagesAsync();
        // we wait
        Console.ReadLine();

    }

}

