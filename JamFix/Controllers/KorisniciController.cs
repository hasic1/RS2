using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisniciController : ControllerBase
    {
        private readonly IKorisniciService _service;
        private readonly Context _context;
        public KorisniciController( Context context,IKorisniciService service)
        {
            _context = context;
            _service = service;
        }
        [HttpGet]
        public IEnumerable<Korisnici> Get()
        {
            return _service.Get();
        }
        [HttpPost]
        public Korisnici Insert(KorisniciInsertRequest request)
        {
            return _service.Insert(request);
        }
    }
}
