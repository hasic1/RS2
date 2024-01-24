using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class DrzavaController : BaseController<Drzave, DrzaveSO>
    {
        public DrzavaController(ILogger<BaseController<Drzave, DrzaveSO>> logger, IDrzaveService service) : base(logger, service)
        {
        }
    }
}
