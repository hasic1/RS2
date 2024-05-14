using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DrzavaController : BaseCRUDController<Drzave, DrzaveSO,DrzavaInsertRequest,DrzavaUpdateRequest>
    {
        private readonly IDrzaveService _drzaveService;

        public DrzavaController(ILogger<BaseController<Drzave, DrzaveSO>> logger, IDrzaveService service) : base(logger, service)
        {
            _drzaveService= service;
        }
        [AllowAnonymous]
        [HttpGet("GetDrzave")]
        public async Task<PagedResult<Drzave>> GetDrzave()
        {
            return await _drzaveService.GetDrzave();
        }
    }
}
