using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Service
{
    public class KorisniciService :IKorisniciService
    {
        Context _context;
        public IMapper _mapper{ get; set; }
        public KorisniciService(Context context,IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public List<Korisnici> Get()
        {
            var entityList = _context.Korisnik.ToList();
           
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
    }
}
