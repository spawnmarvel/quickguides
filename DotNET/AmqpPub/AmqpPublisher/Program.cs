// See https://aka.ms/new-console-template for more information

using System;
using NLog;
using NLog.Extensions.Logging;

class Program
{
    static void Main(string[] args)
    {
        // ensure dir exists
        Directory.CreateDirectory("log");
        // create logger
        var logger = LogManager.GetCurrentClassLogger();
        //log
        logger.Info("Hi");

        Console.WriteLine("Hello, World!");


        for (int i = 0; i < 50; i++)
        {
            string rv = "Log num " + i;
            logger.Info(rv);

        }
        // we wait
        Console.ReadLine();

    }

}

