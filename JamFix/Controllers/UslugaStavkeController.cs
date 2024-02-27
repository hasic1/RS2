using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UslugaStavkeController : BaseCRUDController<UslugeStavke, UslugaStavkeSO, UslugeStavkeInsertRequest, UslugeStavkeUpdateRequest>
    {
        public UslugaStavkeController(ILogger<BaseController<UslugeStavke, UslugaStavkeSO>> loger, IUslugeStavkeService service) : base(loger, service)
        {
        }
    }   
}
