using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class OcjenaUpdateRequest
    {
        public int ProizvodId { get; set; }
        public DateTime Datum { get; set; }
        public int ocjena { get; set; }
    }
}
