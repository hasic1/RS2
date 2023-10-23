using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : ControllerBase
    {
        private readonly IProizvodiService _service;
        private readonly Context _context;
        public ProizvodiController(Context context,IProizvodiService service)
        {
            _context = context;
            _service = service;
        }
        [HttpGet]
        public IEnumerable<Proizvod> Get()
        {
            return _service.Get();
        }
    }
}