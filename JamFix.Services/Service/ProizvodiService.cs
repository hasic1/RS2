using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using JamFix.Services.Interface;

namespace JamFix.Services.Service
{
    public class ProizvodiService : IProizvodiService
    {
        Context _context;
        public IMapper _mapper { get; set; }

        public ProizvodiService(Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public List<Proizvodi> Get()
        {
            var entityList = _context.Proizvod.ToList();

            return _mapper.Map<List<Proizvodi>>(entityList);
        }

        public Proizvodi Insert(ProizvodiInsertRequest request)
        {
            var proizvod = new Proizvod();
            _mapper.Map(request, proizvod);

            _context.Proizvod.Add(proizvod);
            _context.SaveChanges();

            return _mapper.Map<Proizvodi>(proizvod);
        }
    }
}
