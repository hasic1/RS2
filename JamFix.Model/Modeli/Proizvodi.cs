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
        public string? LokacijaSlike { get; set; }
        public bool Snizen { get; set; } = false;
        public string StateMachine { get; set; }
    }
}
