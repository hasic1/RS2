using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Novosti
    {
        [Key]
        public int NovostId { get; set; }
        public string Naslov { get; set; }
        [MaxLength(5000)]
        public string Sadrzaj { get; set; }
        public byte[]? Slika { get; set; }
    }
}
