using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : BaseCRUDController<Proizvodi, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        public ProizvodiController(ILogger<BaseController<Proizvodi, ProizvodiSO>> loger, IProizvodiService service) : base(loger, service)
        {
        }
        [HttpPut("{id}/activate")]
        public virtual async Task<Proizvodi> Activate(int id)
        {
            return await (_service as IProizvodiService).Activate(id);
        }
    }
}