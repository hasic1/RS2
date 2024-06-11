using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace JamFixTestAPI2.Auth
{
    public partial class Context : DbContext
    {
        public Context()
        { }
        public Context(DbContextOptions<Context> options)
            : base(options) { }
        public virtual DbSet<Korisnik> Korisnici { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Korisnik>(entity =>
            {
                entity.HasKey(e => e.KorisnikId);
                entity.ToTable("Korisnik");
                entity.HasIndex(e => e.Email, "CS_Email")
                    .IsUnique();
                entity.HasIndex(e => e.KorisnickoIme, "CS_KorisnickoIme")
                    .IsUnique();
                entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
                entity.Property(e => e.Ime).HasMaxLength(50);
                entity.Property(e => e.Email).HasMaxLength(100);
                entity.Property(e => e.KorisnickoIme).HasMaxLength(50);
                entity.Property(e => e.LozinkaHash).HasMaxLength(50);
                entity.Property(e => e.LozinkaSalt).HasMaxLength(50);
            }); 
            OnModelCreatingPartial(modelBuilder);
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
