using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisniciController : BaseCRUDController<Korisnici,KorisniciSO,KorisniciInsertRequest,KorisniciUpdateRequest>
    {
        public KorisniciController( ILogger<BaseController<Korisnici,KorisniciSO>> loger,IKorisniciService service) : base(loger, service)
        {
        }
      
    }
}
