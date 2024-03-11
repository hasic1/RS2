using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class UslugaStavke
    {
        public int UslugaStavkeId { get; set; }
        public int ProizvodId { get; set; }
        public int UslugeId { get; set; }
        public virtual Proizvod Proizvod { get; set; } = null!;
        public virtual Usluge Usluge { get; set; } = null!;
    }
}
