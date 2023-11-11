using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public partial class Korisnik  
    {
        public Korisnik()
        {
            KorisniciUloge = new HashSet<KorisniciUloge>();
        }
        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Email { get; set; }
        public string? Telefon { get; set; }
        public bool? Status { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string LozinkaHash { get; set; } = null!;
        public string LozinkaSalt { get; set; } = null!;
        public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; }
        //public virtual ICollection<Izlazi> Izlazis { get; set; }
        //public virtual ICollection<Ulazi> Ulazis { get; set; }
    }
}
