using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using JamFix.Services.Service;

namespace JamFix.Controllers
{
    public class UlogeController : BaseCRUDController<Uloge, UlogeSO, UlogeInsertRequest, UlogeUpdateRequest>
    {
        public UlogeController(ILogger<BaseController<Uloge, UlogeSO>> loger, IUlogaService service) : base(loger, service)
        {
        }
    }
}
