﻿using JamFix.Model.Modeli;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Controllers
{
    [Authorize]
    [Route("[controller]")]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IService<T, TSearch> _service;
        protected readonly ILogger<BaseController<T, TSearch>> _logger;

        public BaseController(ILogger<BaseController<T,TSearch>> logger,IService<T, TSearch> service)
        {
            _service = service;
            _logger = logger;
        }
        [HttpGet()]
        public async Task<PagedResult<T>> Get([FromQuery] TSearch? search = null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
