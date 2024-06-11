using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Modeli
{
    public class Konkursi
    {
        public int KonkursId { get; set; }
        public DateTime DatumZavrsetka { get; set; }
        public string? TrazenaPozicija { get; set; }
        public int BrojIzvrsitelja { get; set; }
    }
}
