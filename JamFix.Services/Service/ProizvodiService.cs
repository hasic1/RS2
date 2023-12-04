using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.ProizvodiSM;

namespace JamFix.Services.Service
{
    public class ProizvodiService : BaseCRUDService<Proizvodi, Proizvod, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>, IProizvodiService
    {
        public BaseState _baseState { get; set; }

        public ProizvodiService(BaseState baseState, Context context, IMapper mapper) : base(context, mapper)
        {
            _baseState = baseState;
        }
        public override IQueryable<Proizvod> AddFilter(IQueryable<Proizvod> querry, ProizvodiSO? search = null)
        {
            var fillteredQuery = base.AddFilter(querry, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                fillteredQuery = fillteredQuery.Where(x => x.NazivProizvoda.Contains(search.FTS) || x.Cijena.ToString().Contains(search.FTS));
            }
            if (!string.IsNullOrWhiteSpace(search?.Cijena))
            {
                fillteredQuery = fillteredQuery.Where(x => x.Cijena.ToString()==search.Cijena.ToString());
            }
            return fillteredQuery;
        }
        public override Task<Proizvodi> Insert(ProizvodiInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");

            return state.Insert(insert);

        }

        public override async Task<Proizvodi> Update(int id, ProizvodiUpdateRequest update)
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

        public async Task<Proizvodi> Hide(int id)
        {
            var product = _context.Proizvod.Find(id);
            //return base.Update(id, update);
            var state = _baseState.CreateState(product.StateMachine);
            state.CurrentEntity = product;

            state.Hide();

            return await GetById(id);
        }
        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Proizvod.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "initial");
            return await state.AllowedActions();
        }
        public List<Proizvodi> Recommend(int id)
        {
            throw new NotImplementedException();
        }

    }
}
