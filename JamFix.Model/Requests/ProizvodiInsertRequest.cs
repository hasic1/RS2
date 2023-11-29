namespace JamFix.Model.Requests
{
    public class ProizvodiInsertRequest
    {
        public int ProizvodId { get; set; }
        public string? NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string? Opis { get; set; }
        public string Slika { get; set; }
        public string SlikaThumb { get; set; }
        public bool Snizen { get; set; } = false;
        public int VrstaId { get; set; }
        public string StateMachine { get; set; }
    }
}
