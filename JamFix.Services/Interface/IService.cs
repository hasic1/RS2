using JamFix.Model.Modeli;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Interface
{
    public interface IService<T,TSearch> where TSearch : class 
    {
        IEnumerable<T> Get(TSearch search = null);
        T GetById(int id);
        T DeleteById(int id);
    }
}
