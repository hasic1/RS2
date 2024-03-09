using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Interface
{
    public interface IPozicijaService : ICRUDService<Pozicije,PozicijaSO,PozicijaInsertRequest,PozicijaUpdateRequest>
    {
    }
}
