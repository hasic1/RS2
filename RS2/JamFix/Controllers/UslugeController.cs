using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UslugeController : BaseCRUDController<Usluga,UslugeSO, UslugaInsertRequest, UslugaUpdateRequest>
    {
        public UslugeController(ILogger<BaseController<Usluga, UslugeSO>> loger, IUslugeService service) : base(loger, service)
        {
        }
    }
}
