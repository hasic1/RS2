using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class RadniNalogController : BaseCRUDController<RadniNalozi, RadniNaloziSO, RadniNalogInsertRequest, RadniNalogUpdateRequest>
    {
        public RadniNalogController(ILogger<BaseController<RadniNalozi, RadniNaloziSO>> loger,IRadniNalogService service) : base(loger, service)
        {
        }
    }
}
