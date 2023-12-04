using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Service
{
    public class UslugaUpdateRequest
    {
        public string? ImePrezime { get; set; } = null!;
        public DateTime Datum { get; set; }
    }
}
