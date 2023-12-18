using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Service
{
    public class UlogaService : IUlogaService
    {
        protected readonly Context _context;
        protected IMapper _mapper { get; set; }

        public UlogaService(Context context,IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
        }

        public async Task<Uloge> GetById(int ulogaId)
        {
            var entity = await _context.Set<Korisnik>().FindAsync(ulogaId);

            return _mapper.Map<Uloge>(entity);
        }

        public async Task<IEnumerable<Uloga>> GetAllUlogeAsync()
        {
            return await _context.Uloga.ToListAsync();
        }

        // Implementirajte ostale metode prema potrebi
    }
}
