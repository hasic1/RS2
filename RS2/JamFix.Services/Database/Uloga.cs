﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public partial class Uloga
    {
        public Uloga()
        {
            KorisniciUloges = new HashSet<KorisniciUloge>();
        }
        public int UlogaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string? Opis { get; set; }

        public virtual ICollection<KorisniciUloge> KorisniciUloges { get; set; }
    }
}

