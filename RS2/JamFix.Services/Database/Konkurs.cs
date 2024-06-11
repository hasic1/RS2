using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Konkurs
    {
        public Konkurs()
        {
            Prijava = new HashSet<Prijava>();
        }
        public int KonkursId { get; set; }
        public DateTime DatumZavrsetka { get; set; }
        public string TrazenaPozicija { get; set; }
        public int BrojIzvrsitelja { get; set; }
        public virtual ICollection<Prijava> Prijava { get; set; }
    }
}
