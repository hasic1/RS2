using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    [Table("KorisnickiNalog")]
    public class KorisnickiNalog
    {
        [Key]
        public int Id { get; set; }
        public string? korisnickoIme { get; set; }
        [JsonIgnore]
        public string ?lozinka { get; set; }

        [JsonIgnore]
        public Korisnik? korisnik => this as Korisnik;

        [JsonIgnore]
        public Administrator? administrator => this as Administrator;

        [JsonIgnore]
        public Radnik? radnik => this as Radnik;

        public bool isKupac => korisnik != null;
        public bool isAdmin => administrator != null;
    }
}
