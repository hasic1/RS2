using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;

namespace JamFix.Controllers
{
    public class KonkursController : BaseCRUDController<Konkursi, KonkursSO, KonkursInsertRequest, KonkursUpdateRequest>
    {
        public KonkursController(ILogger<BaseController<Konkursi, KonkursSO>> loger,IKonkursService service) : base(loger, service)
        {
        }
    }
}
