using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;

namespace JamFix.Controllers
{
    public class PrijavaController : BaseCRUDController<Model.Modeli.Prijava, PrijavaSO, PrijavaInsertRequest, PrijavaUpdateRequest>
    {
        public PrijavaController(ILogger<BaseController<Prijava, PrijavaSO>> loger, IPrijavaService service) : base(loger, service)
        {
        }
    }
}
