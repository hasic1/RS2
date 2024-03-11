using AutoMapper;
using JamFix.Model.Modeli;
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
        public int Cijena { get; set; }
        public string? Opis { get; set; }
        public byte[]? Slika { get; set; }
        public byte[]? SlikaThumb { get; set; }
        public bool? Snizen { get; set; }
        public string? StateMachine { get; set; }
        public virtual ICollection<Ocjene> Ocjene { get; set; }
        public string BrzinaInterneta { get; set; }
        public string BrojMinuta { get; set; }
        public string BrojKanala { get; set; }
        public virtual VrsteProizvoda Vrsta { get; set; } = null!;
        public virtual ICollection<UslugaStavke> UslugaStavke { get; set; }
    }
}
