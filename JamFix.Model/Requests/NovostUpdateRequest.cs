﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public class NovostUpdateRequest
    {
        public string? Naslov { get; set; }
        public string? Sadrzaj { get; set; }
        public byte[]? Slika { get; set; }

    }
}
