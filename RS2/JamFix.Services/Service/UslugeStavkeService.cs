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
    public class UslugeStavkeService : BaseCRUDService<UslugeStavke, UslugaStavke, UslugaStavkeSO, UslugeStavkeInsertRequest, UslugeStavkeUpdateRequest>, IUslugeStavkeService
    {
        public UslugeStavkeService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
