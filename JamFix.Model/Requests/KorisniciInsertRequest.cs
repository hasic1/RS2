﻿using JamFix.Model.Modeli;
using System.ComponentModel.DataAnnotations;

namespace JamFix.Model.Requests
{
    public class KorisniciInsertRequest
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Email { get; set; }
        public string? Telefon { get; set; }
        public bool? Status { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string Password { get; set; }
        public string PasswordPotvrda { get; set; }
        public List<int> UlogeIdList { get; set; } = new List<int> { };
    }
}
