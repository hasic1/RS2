using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.SearchObjects
{
    public class ProizvodiSO : BaseSO
    {//Full text search-FTS
        public string? FTS { get; set; }
        public string? Cijena { get; set; }
    }
}
