using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;

namespace JamFix.Services.ProizvodiSM
{
    public class InitialProductState : BaseState
    {
        public InitialProductState(IServiceProvider serviceProvider,Context context, IMapper mapper) : base(serviceProvider,context, mapper)
        {

        }

        public override Proizvodi Insert(ProizvodiInsertRequest request)
        {
            var set = _context.Set<Proizvod>();
            var entity = _mapper.Map<Proizvod>(request);

            set.Add(entity);
            entity.StateMachine = "draft";
            _context.SaveChanges();
            return _mapper.Map<Proizvodi>(entity);
        }
        public override List<string> AllowedActions()
        {
            var list = base.AllowedActions();
            list.Add("Insert");
            return list;
        }
    }
}
