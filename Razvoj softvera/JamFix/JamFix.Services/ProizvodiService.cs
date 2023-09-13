using JamFix.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services
{
    public class ProizvodiService : IProizvodiInterface
    {
        List<Proizvodi> proizvodi = new List<Proizvodi>()
        {
            new Proizvodi()
            {
                ProizvodId=1,
                Naziv='a'
            }
        };
        public IList<Proizvodi> Get()
        {
            return proizvodi;
        }
    }
}
