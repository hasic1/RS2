namespace JamFix.Model.Modeli
{
    public class Zahtjevi
    {
        public int ZahtjevId { get; set; }
        public string ImePrezime { get; set; }
        public string Adresa { get; set; }
        public string BrojTelefona { get; set; }
        public string Opis { get; set; }
        public DateTime DatumVrijeme { get; set; }
        public bool HitnaIntervencija { get; set; }
        public int StatusZahtjevaId { get; set; }
        public string StatusZahtjevaOpis { get; set; }
    }
}