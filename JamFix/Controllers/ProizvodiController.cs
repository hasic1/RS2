using JamFix.Handler;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : BaseCRUDController<Proizvodi, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        Context _context;
        public IProizvodiService _proizvodiService { get; set; }

        public ProizvodiController(ILogger<BaseController<Proizvodi, ProizvodiSO>> loger, IProizvodiService service) : base(loger, service)
        {
            _proizvodiService = service;
        }
        [HttpPut("{id}/activate")]
        public virtual Proizvodi Activate(int id)
        {
            var result = _proizvodiService.Activate(id);

            return result;
        }
        [HttpPost("{id}")]
        public ActionResult AddProfileImage(int id, [FromForm] ProizvodAddImage x)
        {
            try
            {
                Proizvod proizvod = _context.Proizvod.FirstOrDefault(s => s.ProizvodId == id);

                if (x.Slika != null && proizvod != null)
                {
                    string ekstenzija = Path.GetExtension(x.Slika.FileName);

                    var filename = $"{Guid.NewGuid()}{ekstenzija}";

                    x.Slika.CopyTo(new FileStream(Config.SlikeFolder + filename, FileMode.Create));
                    proizvod.Slika = Config.SlikeURL + filename;
                    _context.SaveChanges();
                }

                return Ok(proizvod);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message + ex.InnerException);
            }
        }
        [HttpPut("{id}/hide")]
        public virtual Proizvodi Hide(int id)
        {
            var result = _proizvodiService.Hide(id);

            return result;
        }
        [HttpGet("{id}/allowedActions")]
        public virtual List<string> AllowedActions(int id)
        {
            return _proizvodiService.AllowedActions(id);
        }
    }
}