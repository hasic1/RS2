using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class OcjeneController : BaseCRUDController<Ocjena, OcjeneSO, OcjenaInsertRequest, OcjenaUpdateRequest>
    {
        public OcjeneController(ILogger<BaseController<Ocjena, OcjeneSO>> loger, IOcjeneService service) : base(loger, service)
        {
        }
    }
}
