using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Pozicija
    {
        public Pozicija()
        {
            Korisnik = new HashSet<Korisnik>();
        }
        public int PozicijaId { get; set; }
        public string Naziv { get; set; }
        public virtual ICollection<Korisnik> Korisnik { get; set; }
    }
}
