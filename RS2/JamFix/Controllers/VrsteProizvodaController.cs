using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    public class VrsteProizvodaController : BaseCRUDController<VrstaProizvoda, VrsteProizvodaSO, VrsteProizvodaInsertRequest, VrsteProizvodaUpdateRequest>
    {
        public VrsteProizvodaController(ILogger<BaseController<VrstaProizvoda,VrsteProizvodaSO>>loger,IVrsteProizvodaService service)
            : base(loger,service)
        {
        }
    }

}
