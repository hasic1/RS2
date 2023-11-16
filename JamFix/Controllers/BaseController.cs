using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IService<T, TSearch> _service;
        protected readonly ILogger<BaseController<T, TSearch>> _logger;

        public BaseController(ILogger<BaseController<T,TSearch>> logger,IService<T, TSearch> service)
        {
            _service = service;
            _logger = logger;
        }

        [HttpGet]
        public virtual IEnumerable<T> Get([FromQuery] TSearch search = null)
        {
            return _service.Get(search);
        }

        [HttpGet("{id}")]
        public virtual T GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
