using JamFix.Model;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Interface
{
    public interface IProizvodiService /*: ICRUDService<Proizvodi, ProizvodiSearchObject, ProizvodiInsertRequest, ProizvodiUpdateRequest>*/
    {
       List<Proizvod> Get();
    }
}
