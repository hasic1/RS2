﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public class RadniNalog
    {
        [Key]
        public int NalogId { get; set; }
        public DateTime Datum { get; set; }
        public string Mjesto { get; set; }
        public string ImePreyime { get; set; }
        public string Adresa { get; set; }
        public string Telefon { get; set; }
        public string OpisPrijavljenog { get; set; }
        public string OpisUradjenog { get; set; }
        public string Naziv { get; set; }
        public int Kolicina { get; set; }
        [ForeignKey(nameof(RadnikId))]
        public Radnik Radnik { get; set; }
        public int RadnikId { get; set; }
    }
}