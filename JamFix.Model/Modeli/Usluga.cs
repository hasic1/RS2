using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Modeli
{
    public class Usluga
    {
        public int UslugaId { get; set; }
        public string? ImePrezime { get; set; }
        public DateTime Datum { get; set; }
        public string BrojRacuna { get; set; }
        public string NazivPaketa { get; set; }
        public string Cijena { get; set; }
        public bool Placeno { get; set; }

    }
}
