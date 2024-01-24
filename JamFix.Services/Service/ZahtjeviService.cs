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
    public class ZahtjeviService : BaseCRUDService<Zahtjevi, Zahtjev, ZahtjeviSO, ZahtjeviInsertRequest, ZahtjeviUpdateRequest>, IZahtjeviService
    {
        public ZahtjeviService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Zahtjev> AddFilter(IQueryable<Zahtjev> querry, ZahtjeviSO? search = null)
        {
            var fillteredQuery = base.AddFilter(querry, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                fillteredQuery = fillteredQuery.Where(x => x.ImePrezime.Contains(search.FTS));
            }
            return fillteredQuery;
        }
    }
}
