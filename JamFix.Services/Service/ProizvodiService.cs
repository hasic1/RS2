using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.ProizvodiSM;
using System.Collections.Generic;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace JamFix.Services.Service
{
    public class ProizvodiService : BaseCRUDService<Proizvodi, Proizvod, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>, IProizvodiService
    {
        public BaseState _baseState { get; set; }

        public ProizvodiService(BaseState baseState, Context context, IMapper mapper) : base(context, mapper)
        {
            _baseState = baseState;
        }
        public override Task<Proizvodi> Insert(ProizvodiInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");
            return state.Insert(insert);
        }
        public override async Task<Proizvodi>Update(int id, ProizvodiUpdateRequest update)
        {
            var entity = await _context.Proizvod.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Update(id, update);
        }
        public async Task<Proizvodi> Activate(int id)
        {
            var entity = await _context.Proizvod.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Activate(id);
        }
    }
}
