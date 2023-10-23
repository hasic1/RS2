using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class KorisniciInsertRequest
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? korisnickoIme { get; set; }
        public string lozinka { get; set; }
        public string? Spol { get; set; }
        public string? Email { get; set; }
        public string Password { get; set; }
        public string PasswordPotvrda { get; set; }
    }
}
