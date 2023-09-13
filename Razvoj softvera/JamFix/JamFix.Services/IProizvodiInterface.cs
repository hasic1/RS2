using JamFix.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services
{
    public interface IProizvodiInterface
    {
        IList<Proizvodi> Get();
    }
}
