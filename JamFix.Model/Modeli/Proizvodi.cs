using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Modeli
{
    public class Proizvodi
    {
        public int ProizvodId { get; set; }
        public string? NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string? Opis { get; set; }
        public byte[] Slika { get; set; }
        public byte[] SlikaThumb { get; set; }
        public bool Snizen { get; set; } = false;
        public int VrstaId { get; set; }
        public string StateMachine { get; set; }
        public List<Ocjena> Ocjene { get; set; }
        public double ProsjecnaOcjena { get; set; }
        public string? BrzinaInterneta { get; set; }
        public string? BrojMinuta { get; set; }
        public string? BrojKanala { get; set; }
    }
}
