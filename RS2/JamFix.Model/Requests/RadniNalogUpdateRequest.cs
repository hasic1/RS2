using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class RadniNalogUpdateRequest
    {
        public string NosilacPosla { get; set; }
        public string OpisPrijavljenog { get; set; }
        public string OpisUradjenog { get; set; }
        public string ImePrezime { get; set; }
        public string Telefon { get; set; }
        public DateTime Datum { get; set; }
        public string Adresa { get; set; }
        public string Mjesto { get; set; }
        public string Naziv { get; set; }
        public int Kolicina { get; set; }
    }
}
