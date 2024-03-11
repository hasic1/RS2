using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class StatusZahtjeva
    {
        public StatusZahtjeva()
        {
            Zahtjevi = new HashSet<Zahtjev>();
        }
        public int StatusZahtjevaId { get; set; }
        public string Opis { get; set; }

        public virtual ICollection<Zahtjev> Zahtjevi { get; set; }
    }
}
