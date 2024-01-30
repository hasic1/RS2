using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class KorisnikUlogeUpdateRequest
    {
        public int UlogaId { get; set; }
        public DateTime DatumIzmjene { get; set; }

    }
}
