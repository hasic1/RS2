using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [Route("[controller]")]
    public class BaseCRUDController<T, TSearch,TInsert,TUpdate> : BaseController<T,TSearch> where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        protected new readonly ICRUDService<T, TSearch, TInsert, TUpdate> _service;
        protected readonly ILogger<BaseController<T,TSearch>> _logger;

        public BaseCRUDController(ILogger<BaseController<T,TSearch>> loger, ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(loger, service)
        {
            _service = service;
            _logger = loger;
        }

        [HttpPost]
        [Authorize(Roles ="Administrator")]
        public virtual T Insert([FromBody]TInsert insert)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this._service).Insert(insert);

            return result;
        }
        [HttpPut("{id}")]
        public virtual T Update(int id,[FromBody]TUpdate update)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this._service).Update(id, update);

            return result;
        }        
    }
}
