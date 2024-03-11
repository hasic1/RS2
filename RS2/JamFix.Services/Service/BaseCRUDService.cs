using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Collections.Generic;

namespace JamFix.Services.Service
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch> where TDb : class where T : class where TSearch : BaseSO
    {
        public BaseCRUDService(Context context, IMapper mapper) : base(context, mapper) { }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }
        public virtual async Task BeforeUpdate(TDb entity, TUpdate insert)
        {

        }
        public virtual async Task<bool> IsUsernameTaken(string korisnickoIme)
        {
            var existingUser = await _context.Korisnik.FirstOrDefaultAsync(u => u.KorisnickoIme == korisnickoIme);

            if (existingUser != null)
            {
                return true;
            }
            else { return false; }
        }
        private async Task SetDefaultUserRole(Korisnik korisnikEntity)
        {
            if (korisnikEntity != null)
            {
                var defaultUloga = await _context.Uloga.SingleOrDefaultAsync(u => u.Naziv == "Korisnik");

                if (defaultUloga != null)
                {
                    korisnikEntity.KorisniciUloge.Add(new KorisniciUloge
                    {
                        KorisnikId = korisnikEntity.KorisnikId,
                        UlogaId = defaultUloga.UlogaId,
                        DatumIzmjene = DateTime.Now,
                    });
                }
            }
        }
        private async Task SetUslugeStavke(Usluge uslugeEntity)
        {
            if (uslugeEntity != null)
            {
                int uslugaid;
                bool exists = await _context.Usluge.AnyAsync(u => u.BrojRacuna == uslugeEntity.BrojRacuna);

                if (exists)
                {
                    uslugaid = await _context.Usluge
                        .Where(u => u.BrojRacuna == uslugeEntity.BrojRacuna)
                        .Select(u => u.UslugaId)
                        .FirstOrDefaultAsync();
                }
                else
                {
                    uslugaid = await _context.Usluge
                        .Select(u => u.UslugaId)
                        .DefaultIfEmpty()
                        .MaxAsync();
                    uslugaid++;
                }
                await _context.UslugaStavke.AddAsync(new UslugaStavke
                {
                    ProizvodId = uslugeEntity.ProizvodId,
                    UslugeId = uslugaid
                });
            }
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            if (insert is KorisniciInsertRequest korisnikInsert && await IsUsernameTaken(korisnikInsert.KorisnickoIme))
            {
                throw new Exception("Korisničko ime već zauzeto.");
            }

            var set = _context.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);
            if (entity is Korisnik korisnikEntity)
            {
                await SetDefaultUserRole(korisnikEntity);
                korisnikEntity.PozicijaId = 1;
            }
            if (entity is Zahtjev zahtjevEntity)
            {
                zahtjevEntity.StatusZahtjevaId = 1;
            }

            await BeforeInsert(entity, insert);

            set.Add(entity);
            await _context.SaveChangesAsync();
            if (entity is Usluge uslugeEntity)
            {
                await SetUslugeStavke(uslugeEntity);
                await _context.SaveChangesAsync();
            }
            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Delete(int id)
        {
            var set = _context.Set<TDb>();
            var entity = await set.FindAsync(id);
            if (entity != null)
            {
                //if (entity is Korisnik korisnikEntity)
                //{
                //    var removeKorisniciUloga = await _context.KorisniciUloge.FirstOrDefaultAsync(u => u.KorisnikId == korisnikEntity.KorisnikId);
                //    if (removeKorisniciUloga != null)
                //    {
                //        _context.Remove(removeKorisniciUloga);
                //    }
                //}
                //if (entity is Usluge uslugaEntity)
                //{
                //    var removeUslugaEntity = await _context.UslugaStavke.FirstOrDefaultAsync(u => u.UslugeId == uslugaEntity.UslugaId);
                //    if (removeUslugaEntity != null)
                //    {
                //        _context.Remove(removeUslugaEntity);
                //    }
                //}
                set.Remove(entity);
                await _context.SaveChangesAsync();
            }
            return entity != null ? _mapper.Map<T>(entity) : null;
        }
        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();
            var entity = await set.FindAsync(id);
            _mapper.Map(update, entity);

            if (update is KorisniciUpdateRequest korisniciUpdateRequest && korisniciUpdateRequest.NoviPassword != null)
            {
                await BeforeUpdate(entity, update);
            }

            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }
    }
}
