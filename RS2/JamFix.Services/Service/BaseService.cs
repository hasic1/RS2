using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.EntityFrameworkCore;

namespace JamFix.Services.Service
{
    public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where TDb : class where T : class where TSearch : BaseSO
    {
        protected Context _context;
        protected IMapper _mapper{ get; set; }
        public BaseService(Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            query = AddFilter(query, search);

            query = AddInclude(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }
            if (typeof(T) == typeof(Proizvodi))
            {
                query = query.Include(p => (p as Proizvod).Ocjene);
            }
            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<T>>(list);
            if (tmp.Any() && tmp.First() is Proizvodi)
            {
                var proizvodi = tmp.Cast<Proizvodi>().ToList();

                foreach (var proizvod in proizvodi)
                {
                    proizvod.ProsjecnaOcjena = proizvod.Ocjene.Count > 0 ? proizvod.Ocjene.Average(o => o.ocjena) : 0;
                }
            }
            result.Result = tmp;
            return result;
        }
        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            return _mapper.Map<T>(entity);
        }       
        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> querry,TSearch? search = null)
        {
            return querry;
        }
        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }
    }
}
