using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikUlogeController : BaseCRUDController<KorisnikUloge, KorisnikUlogeSO, KorisnikUlogeInsertRequest, KorisnikUlogeUpdateRequest>
    {
        public KorisnikUlogeController(ILogger<BaseController<KorisnikUloge, KorisnikUlogeSO>> loger, IKorisnikUlogeService service) : base(loger, service)
        {
        }
    }
}
