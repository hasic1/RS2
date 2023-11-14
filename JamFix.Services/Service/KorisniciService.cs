using AutoMapper;
using Azure.Core;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace JamFix.Services.Service
{
    public class KorisniciService : BaseCRUDService<Korisnici,Korisnik,KorisniciSO, KorisniciInsertRequest, KorisniciUpdateRequest>, IKorisniciService
    {
        public KorisniciService(Context context, IMapper mapper) : base(context, mapper)
        {
        }

        public override async Task BeforeInsert(Korisnik entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.lozinka);

        }

       

        public List<Korisnik> Delete(int id)
        {
            throw new NotImplementedException();
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
                query = query.Include("KorisniciUloge.Uloga");
            }
            return base.AddInclude(query, search);
        }

        public async Task<Korisnici> Login(string username, string password)
        {
            var entity = await _context.Korisnik.FirstOrDefaultAsync(x => x.KorisnickoIme == username);
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
    }
}
