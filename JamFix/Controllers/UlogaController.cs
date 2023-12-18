using JamFix.Model.Modeli;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UlogaController : ControllerBase
    {
        //protected readonly IUlogaService _ulogaService;

        //public UlogaController(IUlogaService ulogaService)
        //{
        //    _ulogaService = ulogaService;
        //}

        //[HttpGet("{id}")]
        //public async Task<Uloge> GetById(int id)
        //{
        //    return await _ulogaService.GetById(id);
        //}

        //[HttpGet]
        //public async Task<IActionResult> GetAllUloge()
        //{
        //    var uloge = await _ulogaService.GetAllUlogeAsync();
        //    return Ok(uloge);
        //}

        // Dodajte ostale akcije prema potrebi
    }
}
