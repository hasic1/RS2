using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class StatusZahtjevaController : BaseController<Model.Modeli.StatusiZahtjeva, StatusZahtjevaSO>
    {
        public StatusZahtjevaController(ILogger<BaseController<StatusiZahtjeva, StatusZahtjevaSO>> logger, IStatusZahtjevaService service) : base(logger, service)
        {
        }
    }
}
