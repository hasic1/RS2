using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Radnik
    {
        public int RadnikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Spol { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public Drzava Drzava { get; set; }
        public int DrzavaId { get; set; }
        public DateTime trajanjeUgovora { get; set; }
        public virtual ICollection<RadniNalog> RadniNalog { get; set; }

    }
}
