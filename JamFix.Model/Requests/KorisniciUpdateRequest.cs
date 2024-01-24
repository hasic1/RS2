namespace JamFix.Model.Requests
{
    public class KorisniciUpdateRequest
    {
        public int DrzavaId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Telefon { get; set; }
        public string NoviPassword { get; set; }
        public string PasswordPotvrda { get; set; }
        public string Email { get; set; }
        public int? PozicijaId { get; set; }
        public bool? Aktivnost { get; set; }
    }
}