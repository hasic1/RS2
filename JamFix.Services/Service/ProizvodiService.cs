using JamFix.Services.Database;
using JamFix.Services.Interface;

namespace JamFix.Services.Service
{
    public class ProizvodiService : IProizvodiService
    {
        Context _context=null;

        List<Proizvod> proizvodi = new List<Proizvod>()
        {
            new Proizvod()
            {
                ProizvodId=1,
                NazivProizvoda="asd"
            }
        };
        public IList<Proizvod> Get()
        {
            var list = _context.Proizvod.ToList();
            return proizvodi;
        }

        List<Proizvod> IProizvodiService.Get()
        {
            throw new NotImplementedException();
        }
    }
}
