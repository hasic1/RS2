using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public partial class Context:DbContext
    {
        
        public Context() { }
        public virtual DbSet<Administrator> Administrator { get; set; } = null!;
        public virtual DbSet<Korisnik> Korisnik { get; set; } = null!;
        public virtual DbSet<Drzava> Drzava { get; set; } = null!;
        public virtual DbSet<Izvjestaj> Izvjestaj { get; set; } = null!;
        public virtual DbSet<KorisnickiNalog> KorisnickiNalog { get; set; } = null!;
        public virtual DbSet<Proizvod> Proizvod { get; set; } = null!;
        public virtual DbSet<Radnik> Radnik { get; set; } = null!;
        public virtual DbSet<RadniNalog> RadniNalog { get; set; } = null!;
        public virtual DbSet<StatusZahtjeva> StatusZahtjeva { get; set; } = null!;
        public virtual DbSet<Uredjaj> Uredjaj { get; set; } = null!;
        public virtual DbSet<Zahtjev> Zahtjev { get; set; } = null!;
        
        public Context(
           DbContextOptions options) : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=.; Database=p2089; Trusted_Connection=true; MultipleActiveResultSets=true");
            }
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            //ovdje pise FluentAPI konfiguraciju

            //modelBuilder.Entity<Student>().ToTable("Student");
            //modelBuilder.Entity<Nastavnik>().ToTable("Nastavnik");
        }
    }
}
