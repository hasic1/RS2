using AutoMapper;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.EntityFrameworkCore;

namespace JamFix.Services.Service
{
    public class BaseService<T,TDb, TSearch> : IService<T,TSearch> where TDb : class where T : class where TSearch : BaseSO
    {
        protected Context _context;
        protected IMapper _mapper{ get; set; }
        public BaseService(Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<List<T>> Get(TSearch? search=null) 
        {
            var querry= _context.Set<TDb>().AsQueryable();

            querry = AddFilter(querry, search);

            if (search?.Page.HasValue==true&& search?.PageSize.HasValue == true)
            {
                querry = querry.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list= await querry.ToListAsync();

            return _mapper.Map<List<T>>(list);
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
        public virtual async Task<T> DeleteById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);
            
            _context.Remove(entity);
            _context.SaveChanges();

            return _mapper.Map<T>(entity);
        }
    }
}
