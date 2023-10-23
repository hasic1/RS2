using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Uredjaj
    {
        [Key]
        public int UredjajId { get; set; }
        public string Naziv { get; set; }
    }
}
