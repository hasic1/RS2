﻿namespace JamFix.Model.Requests
{
    public class ProizvodiInsertRequest
    {
        public string? NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string? Opis { get; set; }
        public byte[]? Slika { get; set; }
        public byte[]? SlikaThumb { get; set; }
        public bool Snizen { get; set; } = false;
        public int VrstaId { get; set; }
        public string? StateMachine { get; set; }
    }
}
