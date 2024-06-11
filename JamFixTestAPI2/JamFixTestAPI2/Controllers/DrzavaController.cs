using JamFixTestAPI2.Request;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RabbitMQ.Client;
using System.Text;

namespace JamFixTestAPI2.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class DrzavaController: ControllerBase
    {
        private readonly string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ";
        private readonly string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        [HttpPost("SendDrzava")]
        public async Task<IActionResult> SendDrzava(DrzavaInsert drzava)
        {
            if (drzava == null)
                return BadRequest("Cann't send null object");
           
            if (drzava.Naziv == null || drzava.Naziv.Length == 0)
                return BadRequest("Title is mandatory");

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


            var json = JsonConvert.SerializeObject(drzava);

            var body = Encoding.UTF8.GetBytes(json);

            channel.BasicPublish(exchange: string.Empty,
                                 routingKey: "drzava",

                                 body: body);

            return Ok(drzava);
        }
    }
}
