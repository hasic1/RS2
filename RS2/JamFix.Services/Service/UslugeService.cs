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
    public class UslugeService : BaseCRUDService<Usluga, Usluge, UslugeSO, UslugaInsertRequest, UslugaUpdateRequest>, IUslugeService
    {
        public UslugeService(Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Usluge> AddFilter(IQueryable<Usluge> querry, UslugeSO? search = null)
        {
            var fillteredQuery = base.AddFilter(querry, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                fillteredQuery = fillteredQuery.Where(x => x.ImePrezime.Contains(search.FTS));
            }
            return fillteredQuery;
        }
        public bool SetPaid(int id, bool paid, string chargeId)
        {
            var entity = _context.Usluge.Find(id);
            entity.Placeno = paid;
            entity.UslugaId = int.Parse(chargeId);
            entity.Datum = DateTime.Now;
            _context.Entry(entity).Property(x => x.Placeno).IsModified = true;
            _context.Entry(entity).Property(x => x.UslugaId).IsModified = true;
            _context.Entry(entity).Property(x => x.Datum).IsModified = true;
            _context.SaveChanges();
            return true;
        }

        public async override Task<Usluga> Delete(int id)
        {
            var uslugaStavkeList = await _context.UslugaStavke.Where(u => u.UslugeId == id).ToListAsync();
            _context.UslugaStavke.RemoveRange(uslugaStavkeList);

            var usluga = await _context.Usluge.FirstOrDefaultAsync(k => k.UslugaId == id);
            if (usluga != null)
            {
                _context.Usluge.Remove(usluga);
                await _context.SaveChangesAsync();
            }
            return _mapper.Map<Usluga>(usluga);
        }
    }
}
