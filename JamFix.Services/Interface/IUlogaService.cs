using JamFix.Model.Modeli;
using JamFix.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Interface
{
    public interface IUlogaservice
    {
        Task<string> GetUlogaById(int korisnikId);

    }
}
