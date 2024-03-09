using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using JamFix.Services.Service;

namespace JamFix.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            //-------------------------------------------------------
            CreateMap<Korisnik, Korisnici>();
            CreateMap<KorisniciInsertRequest, Korisnik>();
            CreateMap<KorisniciUpdateRequest, Korisnik>();
            //-------------------------------------------------------         
            CreateMap<ProizvodiInsertRequest, Proizvod>();
            CreateMap<ProizvodiUpdateRequest, Proizvod>();
            CreateMap<Proizvod, Proizvodi>();
            //-------------------------------------------------------
            CreateMap<VrsteProizvodaUpdateRequest, VrsteProizvoda>();
            CreateMap<VrsteProizvodaInsertRequest, VrsteProizvoda>();
            CreateMap<VrsteProizvoda,VrstaProizvoda>();
            //-------------------------------------------------------
            CreateMap<Drzava,Drzave>();
            CreateMap<DrzavaInsertRequest, Drzava>();
            CreateMap<DrzavaUpdateRequest, Drzava>();
            //-------------------------------------------------------
            CreateMap<Uloga, Uloge>();
            CreateMap<UlogeInsertRequest, Uloga>();
            CreateMap<UlogeUpdateRequest, Uloga>();

            //-------------------------------------------------------
            CreateMap<NovostUpdateRequest, Novosti>();
            CreateMap<NovostInsertRequest, Novosti>();
            CreateMap<Novosti, Novost>();
            //-------------------------------------------------------
            CreateMap<UslugaInsertRequest, Usluge>();
            CreateMap<UslugaUpdateRequest, Usluge>();
            CreateMap<Usluge, Usluga>();
            //-------------------------------------------------------
            CreateMap<ZahtjeviInsertRequest, Zahtjev>();
            CreateMap<ZahtjeviUpdateRequest, Zahtjev>();
            CreateMap<Zahtjev, Zahtjevi>();
            //-------------------------------------------------------
            CreateMap<IzvjestajiInsertRequest, Izvjestaj>();
            CreateMap<IzvjestajiUpdateRequest, Izvjestaj>();
            CreateMap<Izvjestaj, Izvjestaji>();
            //-------------------------------------------------------
            CreateMap<RadniNalogInsertRequest, RadniNalog>();
            CreateMap<RadniNalogUpdateRequest, RadniNalog>();
            CreateMap<RadniNalog, RadniNalozi>();
            //-------------------------------------------------------
            CreateMap<StatusZahtjeva, StatusiZahtjeva>();
            CreateMap<StatusZahtjevaInsertRequest, StatusZahtjeva>();
            CreateMap<StatusZahtjevaUpdateRequest, StatusZahtjeva>();
            //-------------------------------------------------------
            CreateMap<Pozicija,Pozicije>();
            CreateMap<PozicijaUpdateRequest, Pozicija>();
            CreateMap<PozicijaInsertRequest, Pozicija>();
            //-------------------------------------------------------
            CreateMap<Ocjene, Ocjena>();
            CreateMap<OcjenaInsertRequest, Ocjene>();
            CreateMap<OcjenaUpdateRequest, Ocjene>();
            //-------------------------------------------------------
            CreateMap<KorisniciUloge, KorisnikUloge>();
            CreateMap<KorisnikUlogeUpdateRequest, KorisniciUloge>();
            CreateMap<KorisnikUlogeInsertRequest, KorisniciUloge>();
            //-------------------------------------------------------
            CreateMap<UslugaStavke, UslugeStavke>();
            CreateMap<UslugeStavkeUpdateRequest, UslugaStavke>();
            CreateMap<UslugeStavkeInsertRequest, UslugaStavke>();
            //-------------------------------------------------------
        }
    }
}
