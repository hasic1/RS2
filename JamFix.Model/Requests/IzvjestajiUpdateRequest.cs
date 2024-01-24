using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class IzvjestajiUpdateRequest
    {
        public int BrojIntervencija { get; set; }
        public string NajPosMjesto { get; set; }
        public int CijenaUtrosAlata { get; set; }
        public string NajOprema { get; set; }
        public DateTime Datum { get; set; }

    }
}
