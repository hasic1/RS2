using JamFix.Model.Modeli;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public partial class KorisniciUloge
    {
        public int KorisnikUlogaId { get; set; }
        public int KorisnikId { get; set; }
        public int UlogaId { get; set; }
        public DateTime DatumIzmjene { get; set; }
        public virtual Korisnik Korisnik { get; set; } = null!;
        public virtual Uloga Uloga { get; set; } = null!;
    }
}
