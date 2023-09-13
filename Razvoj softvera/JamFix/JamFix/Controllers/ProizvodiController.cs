using JamFix.Model;
using JamFix.Services;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : ControllerBase
    {
        private readonly IProizvodiInterface _proizvodiInterface;

        public ProizvodiController(IProizvodiInterface proizvodiInterface)
        {
            _proizvodiInterface = proizvodiInterface;
        }

        [HttpGet]
        public IEnumerable<Proizvodi> Get()
        {
            return _proizvodiInterface.Get();
        }
    }
}