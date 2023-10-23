using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    [Table("Radnik")]
    public class Radnik:KorisnickiNalog
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Spol { get; set; }
        public DateTime DatumRodjenja { get; set; }
        [ForeignKey(nameof(DrzavaId))]
        public Drzava Drzava { get; set; }
        public int DrzavaId { get; set; }
        public DateTime trajanjeUgovora { get; set; }
    }
}
