using System.ComponentModel.DataAnnotations.Schema;

namespace JamFix.Model.Requests
{
    public class KorisniciInsertRequest
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Spol { get; set; }
        public string? Email { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public string? Adresa { get; set; }
        public int DrzavaId { get; set; }
        public bool Pretplacen { get; set; }
        public string? LokacijaSlike { get; set; }
        public bool ConfirmedEmail { get; set; }
        public string? UserToken { get; set; }
        public string? korisnickoIme { get; set; }
        public string? lozinka { get; set; }
        public string? lozinkaPotvrda { get; set; }
    }
}
