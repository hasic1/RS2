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
                .Select(ku => ku.Uloga.Naziv) // Pretpostavljamo da 'Naziv' sadrži vrednost enum-a
                .ToList();

            var enumUserRoles = userRoles.Select(role => Enum.Parse<UserRole>(role)).ToList();
            return enumUserRoles;
        }
        public override async Task BeforeInsert(Korisnik entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Password);
        }
        
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
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
        public async Task<string> GetUlogaById(int korisnikId)
        {
            try
            {
                var uloga = await _context.KorisniciUloge
                    .Where(ku => ku.KorisnikId == korisnikId)
                    .Select(ku => ku.Uloga.Naziv) // Prilagodite prema stvarnom nazivu svoje klase za uloge
                    .FirstOrDefaultAsync();

                if (uloga != null)
                {
                    return uloga;
                }
                else
                {
                    // Ako korisnik nema pridruženu ulogu
                    return "Nema pridružene uloge";
                }
            }
            catch (Exception ex)
            {
                // Logovanje greške
                Console.WriteLine($"Greška prilikom dobijanja uloge za korisnika sa ID {korisnikId}: {ex.Message}");
                throw;
            }
        }
    }
}
