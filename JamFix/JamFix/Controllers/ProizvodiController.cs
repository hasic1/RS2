using JamFix.Model;
using JamFix.Model.ViewModels;
using JamFix.Services;
using JamFix.Services.Database;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : ControllerBase
    {
        private readonly Context _context;
        private readonly IProizvodiInterface _proizvodiInterface;

        public ProizvodiController(Context context,IProizvodiInterface proizvodiInterface)
        {
            _proizvodiInterface = proizvodiInterface;
            _context = context;
        }
        [HttpGet]
        public List<ProizvodVM> GetAll()
        {

            var data = _context.Proizvod.OrderBy(p => p.ProizvodId)
                .Select(p => new ProizvodVM()
                {
                    ProizvodId = p.ProizvodId,
                    NazivProizvoda = p.NazivProizvoda,
                    Cijena = p.Cijena,
                    LokacijaSlike = p.LokacijaSlike,
                    Opis = p.Opis,
                    Snizen = p.Snizen,
                }).AsQueryable();
            return data.Take(100).ToList();
        }
        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            return Ok(_context.Proizvod.FirstOrDefault(p => p.ProizvodId == id));
        }
        [HttpPost]
        public ActionResult Add([FromBody] ProizvodAddVM x)
        {

            var newProizvod = new Proizvod
            {
                Cijena = x.Cijena,
                LokacijaSlike = x.LokacijaSlike,
                NazivProizvoda = x.NazivProizvoda,
                Opis = x.Opis,
                Snizen = x.Snizen
            };
            _context.Add(newProizvod);
            _context.SaveChanges();

            return Get(newProizvod.ProizvodId);

        }

        [HttpPost("{id}")]
        public ActionResult Delete(int id)
        {
            Proizvod proizvod = _context.Proizvod.Find(id);

            if (proizvod == null)
                return BadRequest("pogresan ID");

            _context.Remove(proizvod);

            _context.SaveChanges();
            return Ok(proizvod);
        }
    }
}