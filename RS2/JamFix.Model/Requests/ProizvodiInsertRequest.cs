namespace JamFix.Model.Requests
{
    public class ProizvodiInsertRequest
    {
        public string? NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string? Opis { get; set; }
        public byte[]? Slika { get; set; }
        public bool Snizen { get; set; } = false;
        public int VrstaId { get; set; }
        public string? StateMachine { get; set; }
        public string? BrzinaInterneta { get; set; }
        public string? BrojMinuta { get; set; }
        public string? BrojKanala { get; set; }
    }
}
