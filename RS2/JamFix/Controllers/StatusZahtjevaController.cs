using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class StatusZahtjevaController : BaseCRUDController<Model.Modeli.StatusiZahtjeva, StatusZahtjevaSO,StatusZahtjevaInsertRequest,StatusZahtjevaUpdateRequest>
    {
        public StatusZahtjevaController(ILogger<BaseController<StatusiZahtjeva, StatusZahtjevaSO>> logger, IStatusZahtjevaService service) : base(logger, service)
        {
        }
    }
}
