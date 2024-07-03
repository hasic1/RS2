using System;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using EasyNetQ;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Interface;
using JamFix.Services.Service;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        // Registrirajte vaše servise ovdje
        services.AddSingleton<IDrzaveService, DrzaveService>();
        // Dodajte druge servise ovdje
    })
    .Build();

using var scope = host.Services.CreateScope();
var services = scope.ServiceProvider;

var drzaveService = services.GetRequiredService<IDrzaveService>();

string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "";
string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

var factory = new ConnectionFactory
{
    HostName = hostname,
    UserName = username,
    Password = password,
    VirtualHost = virtualHost,
};

using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();

channel.QueueDeclare(queue: "drzava",
                     durable: false,
                     exclusive: false,
                     autoDelete: true,
                     arguments: null);
Console.WriteLine(" [*] Waiting for messages.");
var consumer = new EventingBasicConsumer(channel);

consumer.Received += async (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    Console.WriteLine(message.ToString());
    var notification =System.Text.Json.JsonSerializer.Deserialize<DrzavaInsertRequest>(message);

    using (var requestScope = services.CreateScope())
    {
        var notificationsService = requestScope.ServiceProvider.GetRequiredService<IDrzaveService>();
        if (notification != null)
        {
            try
            {
                await notificationsService.Insert(notification);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
    Console.WriteLine(Environment.GetEnvironmentVariable("Some"));
};

channel.BasicConsume(queue: "drzava",
                     autoAck: true,
                     consumer: consumer);

using (var bus = RabbitHutch.CreateBus("host=localhost"))
{
    bus.PubSub.Subscribe<Proizvodi>("test", HandleTextMessage);
    Console.WriteLine("Listening for messages. Hit <return> to quit.");
    Console.ReadLine();
}

void HandleTextMessage(Proizvodi entity)
{
    Console.WriteLine($"Recived: {entity?.ProizvodId}, {entity?.NazivProizvoda}");
}

Console.WriteLine("Hello, World!");
