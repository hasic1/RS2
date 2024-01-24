using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class ZahtjeviUpdateRequest
    {
        public string ImePrezime { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }
        public string Opis { get; set; }
        public DateTime DatumVrijeme { get; set; }
        public bool HitnaIntervencija { get; set; }
        public int StatusZahtjevaId { get; set; }
    }
}
