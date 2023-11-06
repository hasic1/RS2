using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace JamFix.Services.Service
{
    public class KorisniciService : IKorisniciService
    {
        Context _context;
        public IMapper _mapper{ get; set; }
        public KorisniciService(Context context,IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<Korisnici>>Get()
        {
            var entityList =await _context.Korisnik.ToListAsync();
           
            return _mapper.Map<List<Korisnici>>(entityList);
        }

        public Korisnici Insert(KorisniciInsertRequest request)
        {
            var korisnik = new Korisnik();
            _mapper.Map(request, korisnik);

            
            _context.Korisnik.Add(korisnik);
            _context.SaveChanges();

            return _mapper.Map<Korisnici>(korisnik);
        }
        public Korisnici Update(int id, KorisniciUpdateRequest request)
        {
            var entity = _context.Korisnik.Find(id);
            _mapper.Map(request,entity);

            _context.SaveChanges();
            return _mapper.Map<Korisnici>(entity);
        }

        public List<Korisnik> Delete(int id)
        {
            throw new NotImplementedException();
        }

        //public ActionResult Delete(int id)
        //{
        //    Korisnik korisnik = _context.Korisnik.Find(id);
        //    if (korisnik == null)
        //        return null;
        //    _context.Remove(korisnik);
        //    _context.SaveChanges();

        //    return Ok(korisnik);
        //}
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

    }
}
