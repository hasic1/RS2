using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
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
    public class KonkursService : BaseCRUDService<Konkursi, Konkurs, KonkursSO, KonkursInsertRequest, KonkursUpdateRequest>, IKonkursService
    {
        public KonkursService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public async override Task<Konkursi> Delete(int id)
        {
            var prijaveList = await _context.Prijava.Where(u => u.KonkursId == id).ToListAsync();
            _context.Prijava.RemoveRange(prijaveList);

            var konkurs = await _context.Konkurs.FirstOrDefaultAsync(k => k.KonkursId == id);
            if (konkurs != null)
            {
                _context.Konkurs.Remove(konkurs);
                await _context.SaveChangesAsync();
            }
            return _mapper.Map<Konkursi>(konkurs);
        }
    }
}
