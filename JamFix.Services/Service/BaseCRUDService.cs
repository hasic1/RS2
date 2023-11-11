using AutoMapper;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Service
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>,ICRUDService<T,TSearch,TInsert,TUpdate>
        where T : class where TDb : class where TSearch : BaseSO where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(Context context, IMapper mapper) : base(context, mapper){   }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _context.Set<TDb>(); 
            TDb entity= _mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);
            await _context.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }
        public virtual async Task<T> Update(int id,TUpdate update)
        {
            var set = _context.Set<TDb>();
            var entity = await set.FindAsync(id);

            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }
    }
}
