using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Prijava
    {
        public int PrijavaId { get; set; }
        public int KonkursId { get; set; }
        public string Ime{ get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string BrojTelefona { get; set; }
        public DateTime DatumPrijave { get; set; }
        public virtual Konkurs Konkurs { get; set; } = null!;
    }
}
