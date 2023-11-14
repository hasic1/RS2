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
        public override Proizvodi Insert(ProizvodiInsertRequest insert)
        {
            //return base.Insert(insert);
            var state = _baseState.CreateState("initial");

            return state.Insert(insert);
        }

        public override Proizvodi Update(int id, ProizvodiUpdateRequest update)
        {
            var product = _context.Proizvod.Find(id);
            //return base.Update(id, update);
            var state = _baseState.CreateState(product.StateMachine);
            state.CurrentEntity = product;

            state.Update(id,update);

            return GetById(id);
        }

        public Proizvodi Activate(int id)
        {
            var product = _context.Proizvod.Find(id);
            //return base.Update(id, update);
            var state = _baseState.CreateState(product.StateMachine);
            state.CurrentEntity = product;

            state.Activate();

            return GetById(id);
        }
        
        public Proizvodi Hide(int id)
        {
            var product = _context.Proizvod.Find(id);
            //return base.Update(id, update);
            var state = _baseState.CreateState(product.StateMachine);
            state.CurrentEntity = product;

            state.Hide();

            return GetById(id);
        }
        public List<string> AllowedActions(int id)
        {
            var product = GetById(id);
            var state = _baseState.CreateState(product.StateMachine);

            return state.AllowedActions();
        }
        public List<Proizvodi> Recommend(int id)
        {
            throw new NotImplementedException();
        }

    }
}
