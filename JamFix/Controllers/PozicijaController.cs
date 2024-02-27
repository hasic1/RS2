using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class PozicijaController : BaseCRUDController<Pozicije, PozicijaSO,PozicijaInsertRequest,PozicijaUpdateRequest>
    {
        public PozicijaController(ILogger<BaseController<Pozicije, PozicijaSO>> logger, IPozicijaService service) : base(logger, service)
        {
        }
    }
}
