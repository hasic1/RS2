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
        public override IQueryable<Izvjestaj> AddFilter(IQueryable<Izvjestaj> querry, IzvjestajiSO? search = null)
        {
            var fillteredQuery = base.AddFilter(querry, search);

            if (!string.IsNullOrWhiteSpace(search?.Datum)|| !string.IsNullOrWhiteSpace(search?.FTS))
            {
                fillteredQuery = fillteredQuery.Where(x => x.NajPosMjesto.Contains(search.FTS) || x.NajOprema.Contains(search.FTS) || x.Datum.Month.ToString()==search.Datum);
            }
            return fillteredQuery;
        }
    }
}
