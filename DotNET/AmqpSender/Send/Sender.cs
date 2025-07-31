using System;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NLog;
using NLog.Extensions.Logging;
using RabbitMQ.Client;
using RabbitMQ.Client.Impl; // For BasicProperties

public class Sender
{
    private readonly string _hostName;
    private readonly string _exchangeName;
    private readonly string _queueName;
    private readonly string _routingKey;
    private readonly string _user;
    private readonly string _pass;
    private readonly int _count;
    private static readonly Logger _logger = LogManager.GetCurrentClassLogger();

    public Sender(int count, string hostName = "localhost", string queueName = "queue_dotnet", string routingKey = "dotnet")
    {
        _count = count;
        _hostName = hostName;
        _exchangeName = "dotnet_exchange";
        _queueName = queueName;
        _routingKey = routingKey;
        _user = "admin1";
        _pass = "dockeruser789";
       
    }

    public async Task SendMessagesAsync(string message = "Hello queue")
    {
        var factory = new ConnectionFactory
        {
            HostName = _hostName,
            UserName = _user,
            Password = _pass
        };
        using var connection = await factory.CreateConnectionAsync();
        using var channel = await connection.CreateChannelAsync();

        // 1. Declare a direct exchange
        await channel.ExchangeDeclareAsync(
            exchange: _exchangeName,
            type: "direct",
            durable: true,
            autoDelete: false,
            arguments: null);

        // 2. Declare a queue
        await channel.QueueDeclareAsync(
            queue: _queueName,
            durable: true,
            exclusive: false,
            autoDelete: false,
            arguments: null);

        // 3. Bind the queue to the exchange with the routing key
        await channel.QueueBindAsync(
            queue: _queueName,
            exchange: _exchangeName,
            routingKey: _routingKey);

        var body = Encoding.UTF8.GetBytes(message);
        var properties = new BasicProperties
        {
            DeliveryMode = RabbitMQ.Client.DeliveryModes.Persistent
        };
        Console.WriteLine("Send " + _count + " messages");
        for (int i = 0; i < _count; i++)
        {
            await channel.BasicPublishAsync(
                exchange: _exchangeName,
                routingKey: _routingKey,
                mandatory: false,
                basicProperties: properties,
                body: body);

            Console.WriteLine($"Sent {i} {message}");
            _logger.Info($"Sent {i} {message}");
            await Task.Delay(600);
        }
    }
}