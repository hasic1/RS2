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
        public DraftProductState(ILogger<DraftProductState> logger, IServiceProvider serviceProvider, Context context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
            _logger = logger;
        }

        public void Update(int id, ProizvodiUpdateRequest request)
        {
            var set = _context.Set<Proizvod>();

            _mapper.Map(request, CurrentEntity);
            CurrentEntity.StateMachine = "draft";

            _context.SaveChanges();
        }

        public override async Task<Proizvodi> Activate(int id)
        {
            _logger.LogInformation($"Aktivacija proizvoda: {id}");

            _logger.LogWarning($"W: Aktivacija proizvoda: {id}");

            _logger.LogError($"E: Aktivacija proizvoda: {id}");

            var set = _context.Set<Database.Proizvod>();

            var entity = await set.FindAsync(id);

            entity.StateMachine = "active";

            await _context.SaveChangesAsync();
            var mappedEntity = _mapper.Map<Proizvodi>(entity);

            using var bus = RabbitHutch.CreateBus("host=localhost");

            bus.PubSub.Publish(mappedEntity);

            return mappedEntity;
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Update");
            list.Add("Activate");

            return list;
        }
    }
}
