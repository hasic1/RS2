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
using static JamFix.Services.Service.ProizvodiService;

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

        [HttpGet("topRatedProducts/{numberOfTopProducts}")]
        public async Task<PagedResult<Proizvodi>> GetTopRatedProducts(int numberOfTopProducts)
        {
            var topRatedProducts = await _proizvodiService.GetTopRatedProducts(numberOfTopProducts);
            return topRatedProducts;
        }
        [HttpGet("recommend/{id}")]
        public RecommendationResponse<Proizvodi> Recommend(int id)
        {
            return _proizvodiService.Recommend(id);
        }
    }
}
