using JamFix.Model.Modeli;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Ocjene
    {
        public int OcjenaId { get; set; }
        public int ProizvodId { get; set; }
        public int KupacId { get; set; }
        public DateTime Datum { get; set; }
        public int Ocjena { get; set; }
        public virtual Kupci Kupac { get; set; } = null!;
        public virtual Proizvod Proizvod { get; set; } = null!;
    }
}
