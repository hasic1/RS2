using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class NovostiController : BaseCRUDController<Novost, NovostSO, NovostInsertRequest, NovostUpdateRequest>
    {
        public NovostiController(ILogger<BaseController<Novost, NovostSO>> loger, INovostiService service) : base(loger, service)
        {
        }
    }
}
