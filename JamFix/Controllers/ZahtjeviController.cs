using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class ZahtjeviController : BaseCRUDController<Zahtjevi, ZahtjeviSO, ZahtjeviInsertRequest, ZahtjeviUpdateRequest>
    {
        public ZahtjeviController(ILogger<BaseController<Zahtjevi, ZahtjeviSO>> loger, IZahtjeviService service) : base(loger, service)
        {
        }
    }
}
