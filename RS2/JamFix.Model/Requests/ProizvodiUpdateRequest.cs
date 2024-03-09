using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class ProizvodiUpdateRequest
    {
        public string? NazivProizvoda { get; set; }
        public double? Cijena { get; set; }
        public string? Opis { get; set; }
        public byte[]? Slika { get; set; }
        public bool? Snizen { get; set; } = false; 
        public string? BrzinaInterneta { get; set; }
        public string? BrojMinuta { get; set; }
        public int? VrstaId { get; set; }
        public string? BrojKanala { get; set; }
    }
}
