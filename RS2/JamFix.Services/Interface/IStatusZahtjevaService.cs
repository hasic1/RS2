using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Interface
{
    public interface IStatusZahtjevaService: ICRUDService<Model.Modeli.StatusiZahtjeva, StatusZahtjevaSO,StatusZahtjevaInsertRequest,StatusZahtjevaUpdateRequest>
    {
    }
}
