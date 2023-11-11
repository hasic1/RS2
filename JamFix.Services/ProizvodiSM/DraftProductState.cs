using AutoMapper;
using Azure.Core;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;

namespace JamFix.Services.ProizvodiSM
{
    public class DraftProductState : BaseState
    {
        public DraftProductState(IServiceProvider serviceProvider, Context context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override async Task<Proizvodi> Update(int id,ProizvodiUpdateRequest request)
        {
            var set = _context.Set<Proizvod>();
            var entity = await set.FindAsync(id);

            _mapper.Map(request, entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<Proizvodi>(entity);
        }

        public override async Task<Proizvodi> Activate(int id)
        {
            var set = _context.Set<Proizvod>();
            var entity = await set.FindAsync(id);
            entity.StateMachine = "active";

            await _context.SaveChangesAsync();

            return _mapper.Map<Proizvodi>(entity);
        }
    }
}
