using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Zahtjev
    {
        public int ZahtjevId { get; set; }
        public string ImePrezime { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }
        public string Opis{ get; set; }
        public DateTime DatumVrijeme { get; set; }
        public bool HitnaIntervencija { get; set; }
        public int StatusZahtjevaId { get; set; }
        public virtual StatusZahtjeva StatusZahtjeva{ get; set; }

    }
}
