﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.SearchObjects
{
    public class KorisniciSO : BaseSO
    {
        public string? FTS { get; set; }

        public bool? IsUlogeIncluded { get; set; }
    }
}
