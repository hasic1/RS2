﻿using JamFix.Handler;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [Route("[controller]")]
    public class BaseCRUDController<T, TSearch,TInsert,TUpdate> : BaseController<T,TSearch> where T : class where TSearch : class 
    { 
        protected new readonly ICRUDService<T, TSearch, TInsert, TUpdate> _service;
        protected readonly ILogger<BaseController<T,TSearch>> _logger;

        public BaseCRUDController(ILogger<BaseController<T,TSearch>> loger, ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(loger, service)
        {
            _service = service;
            _logger = loger;
        }

        [HttpPost]
        public virtual async Task<T> Insert([FromBody]TInsert insert)
        {
            var result = _service.Insert(insert);

            return await result;
        }
        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id,[FromBody]TUpdate update)
        {
            var result = _service.Update(id, update);

            return await result;
        }
        [Authorize(Policy =Identity.AdminUserPolicyName)]
        [HttpPost("{id}")]
        public virtual async Task<T> Delete(int id)
        {
            var result = _service.Delete(id);

            return await  result;
        }
    }
}
