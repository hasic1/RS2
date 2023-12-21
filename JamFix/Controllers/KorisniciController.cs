using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisniciController : BaseCRUDController<Korisnici, KorisniciSO, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        private readonly IKorisniciService _korisnikService;
        public KorisniciController(ILogger<BaseController<Korisnici, KorisniciSO>> loger, IKorisniciService service) : base(loger, service)
        {
            _korisnikService = service;
        }
        public override Task<Korisnici> Insert([FromBody] KorisniciInsertRequest insert)
        {
            return base.Insert(insert);
        }
        [HttpPost("logout")]
        public IActionResult Logout()
        {
            // Implementirajte logiku za odjavu korisnika
            // Na primer, uklonite token iz sesije ili izbrišite kolačić sa tokenom
            HttpContext.Session.Remove("AccessToken");

            return Ok(new { message = "Successfully logged out." });
        }
        [HttpGet("uloga/{id}")]
        public async Task<IActionResult> GetUlogaById(int id)
        {
            try
            {
                var uloga = await _korisnikService.GetUlogaById(id);
                return Ok(uloga);
            }
            catch (Exception ex)
            {
                // Logovanje greške
                Console.WriteLine($"Greška prilikom dobijanja uloge za korisnika sa ID {id}: {ex.Message}");
                return StatusCode(500, "Internal Server Error");
            }
        }
    }
}

