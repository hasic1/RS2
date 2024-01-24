using AutoMapper;
using JamFix.Model.Modeli;
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
    public class StatusZahtjevaService : BaseService<Model.Modeli.StatusiZahtjeva, Database.StatusZahtjeva, StatusZahtjevaSO>,IStatusZahtjevaService
    {
        public StatusZahtjevaService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
