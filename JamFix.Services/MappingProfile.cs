using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;

namespace JamFix.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Korisnik, Korisnici>();
            CreateMap<KorisniciInsertRequest, Korisnik>();
            CreateMap<KorisniciUpdateRequest, Korisnik>();

            CreateMap<ProizvodiInsertRequest, Proizvod>();
            CreateMap<ProizvodiUpdateRequest, Proizvod>();
            CreateMap<Proizvod, Proizvodi>();
            
            CreateMap<Uredjaj,Uredjaji>();  

            CreateMap<Drzava,Drzave>();

            CreateMap<KorisniciUloge, KorisnikUloge>();
            CreateMap<Uloga, Uloge>();

        }
    }
}
