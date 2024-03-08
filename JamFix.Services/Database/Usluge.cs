using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Usluge
    {
        [Key]
        public int UslugaId { get; set; }
        public string? ImePrezime { get; set; }
        public DateTime Datum { get; set; }
        public string BrojRacuna { get; set; }
        public string Cijena { get; set; }
        public string NazivPaketa { get; set; }
        public bool Placeno { get; set; }
        public int ProizvodId { get; set; }

        public virtual ICollection<UslugaStavke> UslugaStavke { get; set; }
    }
}
