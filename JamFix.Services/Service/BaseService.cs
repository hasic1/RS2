using AutoMapper;
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

        public virtual IEnumerable<T> Get(TSearch? search=null) 
        {
            var querry= _context.Set<TDb>().AsQueryable();

            querry = AddFilter(querry, search);

            if (search?.Page.HasValue==true&& search?.PageSize.HasValue == true)
            {
                querry = querry.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list= querry.ToList();

            return _mapper.Map<IList<T>>(list);
        }
        public T GetById(int id)
        {
            var set = _context.Set<TDb>();

            var entity = set.Find(id);

            return _mapper.Map<T>(entity);
        }
        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> querry,TSearch? search = null)
        {
            return querry;
        }
        public T DeleteById(int id)
        {
            var set = _context.Set<TDb>();

            var entity = set.Find(id);
            _context.Remove(entity);
            _context.SaveChanges();

            return _mapper.Map<T>(entity);
        }
        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }
    }
}
