﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class Drzava
    {
        public int DrzavaId { get; set; }
        public string Naziv { get; set; }
        public virtual ICollection<Korisnik> Korisnik { get; set; }

    }
}
