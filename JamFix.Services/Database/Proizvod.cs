using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Proizvod
    {
        [Key]
        public int ProizvodId { get; set; }
        public string NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string Opis { get; set; }
        public string LokacijaSlike { get; set; }
        public bool Snizen { get; set; } = false;
    }
}
