using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class ProizvodiInsertRequest
    {
        public string? NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string? Opis { get; set; }
        public string Slika { get; set; }
        public string SlikaThumb { get; set; }
        public bool Snizen { get; set; } = false;
    }
}
