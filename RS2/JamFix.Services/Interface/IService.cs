using JamFix.Model.Modeli;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Interface
{
    public interface IService<T, TSearch> where TSearch : class 
    {
        Task<PagedResult<T>> Get(TSearch search = null);
        Task<T> GetById(int id);
        //Task<T> DeleteById(int id);
    }
}
