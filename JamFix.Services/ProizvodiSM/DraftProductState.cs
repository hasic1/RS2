using AutoMapper;
using Azure.Core;
using EasyNetQ;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using Microsoft.Extensions.Logging;
using RabbitMQ.Client;
using System.Text;

namespace JamFix.Services.ProizvodiSM
{
    public class DraftProductState : BaseState
    {
        protected ILogger _logger;
        public DraftProductState(ILogger<DraftProductState> logger,IServiceProvider serviceProvider, Context context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _logger = logger;   
        }

        public void Update(int id,ProizvodiUpdateRequest request)
        {
            var set = _context.Set<Proizvod>();

            _mapper.Map(request, CurrentEntity);
            CurrentEntity.StateMachine = "draft";

            _context.SaveChanges();
        }

        public override void Activate()
        {
            _logger.LogInformation($"Aktivacija proizvoda");
            _logger.LogWarning($"W: Aktivacija proizvoda");
            _logger.LogError($"E: Aktivacija proizvoda");

            //var factory = new ConnectionFactory { HostName = "localhost" };
            //using var connection = factory.CreateConnection();
            //using var channel = connection.CreateModel();

            //channel.QueueDeclare(queue: "product_added",
            //                     durable: false,
            //                     exclusive: false,
            //                     autoDelete: false,
            //                     arguments: null);

            //const string message = "Hello World!";
            //var body = Encoding.UTF8.GetBytes(message);

            //channel.BasicPublish(exchange: string.Empty,
            //                     routingKey: "product_added",
            //                     basicProperties: null,
            //                     body: body);

            using var bus = RabbitHutch.CreateBus("host=localhost");

            bus.PubSub.Publish(CurrentEntity);

            CurrentEntity.StateMachine = "active";
            _context.SaveChanges();
        }
        public override List<string> AllowedActions()
        {
            var list = base.AllowedActions();

            list.Add("Update");
            list.Add("Activate");

            return list;
        }
    }
}
