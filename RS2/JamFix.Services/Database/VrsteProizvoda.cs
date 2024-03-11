using JamFix.Model.Modeli;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class VrsteProizvoda
    {
        public VrsteProizvoda()
        {
            Proizvod = new HashSet<Proizvod>();
        }
        public int VrstaId { get; set; }
        public string Naziv { get; set; } = null!;

        public virtual ICollection<Proizvod> Proizvod{ get; set; }
    }
}
