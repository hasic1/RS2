using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
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
    public class IzvjestajiService : BaseCRUDService<Izvjestaji, Izvjestaj, IzvjestajiSO, IzvjestajiInsertRequest, IzvjestajiUpdateRequest>, IIzvjestajiService
    {
        public IzvjestajiService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
