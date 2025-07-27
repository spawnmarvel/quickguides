namespace MyService;

using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

public class Worker : BackgroundService
{
    private readonly string _filePath = @"C:\temp\MyService\log.txt"; // Make sure this directory exists or create it in code

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(_filePath));
        while (!stoppingToken.IsCancellationRequested)
        {
            string message = $"Hello World at {DateTime.Now}";
            await File.AppendAllTextAsync(_filePath, message + Environment.NewLine);
            await Task.Delay(TimeSpan.FromSeconds(10), stoppingToken);
        }
    }
}
