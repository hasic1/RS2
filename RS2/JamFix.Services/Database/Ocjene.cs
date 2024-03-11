using System.ComponentModel.DataAnnotations;

namespace JamFix.Services.Database
{
    public class Ocjene
    {
        public int OcjenaId { get; set; }
        public int ProizvodId { get; set; }
        public DateTime Datum { get; set; }
        public int Ocjena { get; set; }
        public virtual Proizvod Proizvod { get; set; } = null!;
    }
}
