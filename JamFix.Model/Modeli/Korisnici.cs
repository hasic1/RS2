using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Modeli
{
    public class Korisnici
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Spol { get; set; }
        public string? Email { get; set; }
        public string? Adresa { get; set; }
        public bool Pretplacen { get; set; }
        public string LokacijaSlike { get; set; }
        public bool ConfirmedEmail { get; set; }
    }
}
