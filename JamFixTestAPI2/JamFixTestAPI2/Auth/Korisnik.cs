namespace JamFixTestAPI2.Auth
{
    public class Korisnik
    {
        public int KorisnikId { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string? Email { get; set; }
        public string LozinkaHash { get; set; } = null!;
        public string Ime { get; set; } = null!;
        public string LozinkaSalt { get; set; } = null!;
    }
}
