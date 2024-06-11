using AutoMapper;

namespace JamFixTestAPI2.Auth
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            //-------------------------------------------------------
            CreateMap<Korisnik, Korisnici>();

        }
    }
}
