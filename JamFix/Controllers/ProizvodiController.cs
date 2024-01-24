using JamFix.Handler;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : BaseCRUDController<Proizvodi, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        public IProizvodiService _proizvodiService { get; set; }

        public ProizvodiController(ILogger<BaseController<Proizvodi, ProizvodiSO>> loger, IProizvodiService service) : base(loger, service)
        {
            _proizvodiService = service;
        }

        [HttpPut("{id}/activate")]
        public virtual async Task<Proizvodi> Activate(int id)
        {
            return await (_service as IProizvodiService).Activate(id);
        }

        [HttpPut("{id}/hide")]
        public virtual async Task<Proizvodi> Hide(int id)
        {
            return await (_service as IProizvodiService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as IProizvodiService).AllowedActions(id);
        }
        [HttpGet("topRatedProducts/{numberOfTopProducts}")]
        public async Task<PagedResult<Proizvodi>> GetTopRatedProducts(int numberOfTopProducts)
        {
            var topRatedProducts = await _proizvodiService.GetTopRatedProducts(numberOfTopProducts);
            return topRatedProducts;
        }
        [AllowAnonymous]
        [HttpGet("{id}/recommend")]
        public List<Proizvodi> Recommend(int id)
        {
            return _proizvodiService.Recommend(id);
        }
    }
}
