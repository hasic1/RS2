using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class IzvjestajiController : BaseCRUDController<Izvjestaji, IzvjestajiSO, IzvjestajiInsertRequest, IzvjestajiUpdateRequest>
    {
        public IzvjestajiController(ILogger<BaseController<Izvjestaji, IzvjestajiSO>> loger, IIzvjestajiService service) : base(loger, service)
        {
        }
    }
}
