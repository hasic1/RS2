using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Modeli
{
    public class Zahtjevi
    {
        public int ZahtjevId { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }
        public string Opis { get; set; }
        public DateTime DatumVrijeme { get; set; }
        public int StatusZahtjevaId { get; set; }
        public bool HitnaIntervencija { get; set; }
    }
}
