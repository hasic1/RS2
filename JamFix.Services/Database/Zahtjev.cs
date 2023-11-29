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
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }
        public string Opis{ get; set; }
        public DateTime DatumVrijeme { get; set; }
        public string StatusZahtjeva { get; set; }
        public int KorisnikId { get; set; }
        public int StatusId { get; set; }
        public bool HitnaIntervencija { get; set; }
        public VrsteProizvoda VrsteProizvoda { get; set; }
        public int VrstaId { get; set; }
    }
}
