using JamFix.Services.Service.Helper;

namespace JamFix.Model.Modeli
{
    public partial class Korisnici
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Email { get; set; }
        public string? Telefon { get; set; }
        public bool? Status { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string LozinkaHash { get; set; } = null!;
        public string LozinkaSalt { get; set; } = null!;
        public virtual ICollection<KorisnikUloge> KorisniciUloge { get; set; }
        public List<UserRole> Uloge { get; set; }

        //public string RoleNames => string.Join(", ", KorisnikUloge?.Select(x => x.Uloga?.Naziv)?.ToList());

    }
}
