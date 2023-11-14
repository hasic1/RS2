using AutoMapper;
using Azure.Core;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using Microsoft.Extensions.Logging;

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
