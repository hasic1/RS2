using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;
using JamFix.Services.Service.Helper;
using Microsoft.AspNetCore.Mvc;

namespace JamFix.Services.Service
{
    public class KorisniciService : BaseCRUDService<Korisnici,Korisnik,KorisniciSO, KorisniciInsertRequest, KorisniciUpdateRequest>, IKorisniciService
    {
        public KorisniciService(Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public List<UserRole> GetRolesForUser(int userId)
        {
            var userRoles = _context.KorisniciUloge
                .Where(ku => ku.KorisnikId == userId)
                .Select(ku => ku.Uloga.Naziv) 
                .ToList();

            var enumUserRoles = userRoles.Select(role => Enum.Parse<UserRole>(role)).ToList();
            return enumUserRoles;
        }
        public override async Task BeforeInsert(Korisnik entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Password);
        }
        public override async Task BeforeUpdate(Korisnik entity, KorisniciUpdateRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.NoviPassword);
        }
        public override IQueryable<Korisnik> AddFilter(IQueryable<Korisnik> querry, KorisniciSO? search = null)
        {
            var fillteredQuery = base.AddFilter(querry, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                fillteredQuery = fillteredQuery.Where(x => x.Ime.Contains(search.FTS) || x.Prezime.Contains(search.FTS));
            }
            return fillteredQuery;
        }

        public async override Task<Korisnici> Delete(int id)
        {

            var removeKorisniciUloga = await _context.KorisniciUloge.FirstOrDefaultAsync(u => u.KorisnikId == id);
            _context.Remove(removeKorisniciUloga);

            var korsisnik = await _context.Korisnik.FirstOrDefaultAsync(k => k.KorisnikId == id);
            _context.Korisnik.Remove(korsisnik);

            await _context.SaveChangesAsync();

            return _mapper.Map<Korisnici>(korsisnik);
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        
        public override IQueryable<Korisnik> AddInclude(IQueryable<Korisnik> query, KorisniciSO search = null)
        {
            if (search?.IsUlogeIncluded==true)
            {
                query = query.Include("KorisnikUloge.Uloga");
            }
            return base.AddInclude(query, search);
        }

        public async Task<Korisnici> Login(string username, string password)
        {
            var entity = await _context.Korisnik.Include("KorisniciUloge.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);
            if (entity==null)
            {
                return null;
            }
            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash !=entity.LozinkaHash)
            {
                return null;
            }
            return _mapper.Map<Korisnici>(entity);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public async Task<string> GetUlogaById(int korisnikId)
        {
            try
            {
                var uloga = await _context.KorisniciUloge
                    .Where(ku => ku.KorisnikId == korisnikId)
                    .Select(ku => ku.Uloga.Naziv)
                    .FirstOrDefaultAsync();
                if (uloga != null)
                {
                    return uloga;
                }
                else
                {
                    return "Nema pridružene uloge";
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Greška prilikom dobijanja uloge za korisnika sa ID {korisnikId}: {ex.Message}");
                throw;
            }
        }
    }
}
