using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Usluge
    {
        public int UslugaId { get; set; }
        public string? ImePrezime { get; set; }
        public DateTime Datum { get; set; }
    }
}
