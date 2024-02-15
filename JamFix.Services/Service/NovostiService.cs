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
    public class NovostiService : BaseCRUDService<Novost, Novosti, NovostSO, NovostInsertRequest, KorisniciUpdateRequest>, INovostiService
    {
        public NovostiService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public async Task<Novost> Update(int id, NovostUpdateRequest update)
        {
            return await Update(id, update);
        }
    }
}
