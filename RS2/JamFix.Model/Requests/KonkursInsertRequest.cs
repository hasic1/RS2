using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class KonkursInsertRequest
    {
        public DateTime DatumZavrsetka { get; set; }
        public string? TrazenaPozicija { get; set; }
        public int BrojIzvrsitelja { get; set; }
    }
}
