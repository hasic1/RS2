using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public partial class Proizvod
    {
        public Proizvod()
        {
            Ocjene = new HashSet<Ocjene>();
        }
        public int ProizvodId { get; set; }
        public int VrstaId { get; set; }
        public string? NazivProizvoda { get; set; }
        public double Cijena { get; set; }
        public string? Opis { get; set; }
        public string? Slika { get; set; }
        public string? SlikaThumb { get; set; }
        public bool Snizen { get; set; } = false;
        public string? StateMachine { get; set; }
        public virtual ICollection<Ocjene> Ocjene { get; set; }
        public virtual VrsteProizvoda Vrsta { get; set; } = null!;

    }
}
