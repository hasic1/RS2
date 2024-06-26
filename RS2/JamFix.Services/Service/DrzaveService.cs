﻿using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Service
{
    public class DrzaveService : BaseCRUDService<Drzave, Drzava, DrzaveSO,DrzavaInsertRequest,DrzavaUpdateRequest>, IDrzaveService
    {
        public DrzaveService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
       
        public override IQueryable<Drzava> AddFilter(IQueryable<Drzava> querry, DrzaveSO? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search.Naziv))
            {
                querry = querry.Where(x => x.Naziv.StartsWith(search.Naziv));
            }
            if (!string.IsNullOrWhiteSpace(search.FTS))
            {
                querry = querry.Where(x => x.Naziv.Contains(search.FTS));
            }

            return base.AddFilter(querry, search);
        }

        public virtual async Task<PagedResult<Drzave>> GetDrzave()
        {
            var query = _context.Set<Drzava>().AsQueryable();
            PagedResult<Drzave> result = new PagedResult<Drzave>();

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<Drzave>>(list);
            result.Result = tmp;
            return result;
        }
    }
}
