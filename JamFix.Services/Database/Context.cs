using JamFix.Model.Modeli;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Database
{
    public partial class Context : DbContext
    {
        public Context()
        { }

        public Context(DbContextOptions<Context> options)
            : base(options) { }
        public virtual DbSet<Drzava> Drzava { get; set; }
        public virtual DbSet<Izvjestaj> Izvjestaj { get; set; } 
        public virtual DbSet<KorisniciUloge> KorisniciUloge { get; set; }
        public virtual DbSet<Korisnik> Korisnik { get; set; }
        public virtual DbSet<Novosti> Novosti{ get; set; } 
        public virtual DbSet<Ocjene> Ocjene { get; set; }  
        public virtual DbSet<Proizvod> Proizvod { get; set; } 
        public virtual DbSet<RadniNalog> RadniNalog { get; set; } 
        public virtual DbSet<StatusZahtjeva> StatusZahtjeva { get; set; } 
        public virtual DbSet<Uloga> Uloga { get; set; } 
        public virtual DbSet<Usluge> Usluge { get; set; }
        public virtual DbSet<VrsteProizvoda> VrsteProizvoda { get; set; }
        public virtual DbSet<Zahtjev> Zahtjev { get; set; } 




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
                entity.Property(e => e.Prezime).HasMaxLength(50);
                entity.Property(e => e.Email).HasMaxLength(100);
                entity.Property(e => e.Telefon).HasMaxLength(20);
                entity.Property(e => e.KorisnickoIme).HasMaxLength(50);
                entity.Property(e => e.LozinkaHash).HasMaxLength(50);
                entity.Property(e => e.LozinkaSalt).HasMaxLength(50);
                entity.Property(e => e.DrzavaId).HasColumnName("DrzavaId");

                entity.HasOne(d => d.Drzava)
                    .WithMany(p => p.Korisnik)
                    .HasForeignKey(d => d.DrzavaId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_Korisnik_Drzava");

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");
            });
            modelBuilder.Entity<Drzava>(entity =>
            {
                entity.HasKey(e => e.DrzavaId);
                entity.ToTable("Drzava");
                entity.Property(e => e.DrzavaId).HasColumnName("DrzavaId");
                entity.Property(e => e.Naziv).HasMaxLength(50);
            });

            modelBuilder.Entity<KorisniciUloge>(entity =>
            {
                entity.HasKey(e => e.KorisnikUlogaId);
                entity.ToTable("KorisniciUloge");
                entity.Property(e => e.KorisnikUlogaId).HasColumnName("KorisnikUlogaID");
                entity.Property(e => e.DatumIzmjene).HasColumnType("datetime");
                entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
                entity.Property(e => e.UlogaId).HasColumnName("UlogaID");
                
                entity.HasOne(d => d.Korisnik)
                    .WithMany(p => p.KorisniciUloge)
                    .HasForeignKey(d => d.KorisnikId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_KorisniciUloge_Korisnici");

                entity.HasOne(d => d.Uloga)
                    .WithMany(p => p.KorisniciUloges)
                    .HasForeignKey(d => d.UlogaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_KorisniciUloge_Uloge");
            });
            modelBuilder.Entity<UslugaStavke>(entity =>
            {
                entity.HasKey(e => e.UslugaStavkeId);
                entity.ToTable("UslugaStavke");
                entity.Property(e => e.UslugaStavkeId).HasColumnName("UslugaStavkeID");
                entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");
                entity.Property(e => e.UslugeId).HasColumnName("UslugeID");

                entity.HasOne(d => d.Proizvod)
                    .WithMany(p => p.UslugaStavke)
                    .HasForeignKey(d => d.ProizvodId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UslugaStavke_Proizvod");

                entity.HasOne(d => d.Usluge)
                    .WithMany(p => p.UslugaStavke)
                    .HasForeignKey(d => d.UslugeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_UslugaStavke_Usluge");
            });
            modelBuilder.Entity<Ocjene>(entity =>
            {
                entity.HasKey(e => e.OcjenaId);
                entity.ToTable("Ocjene");
                entity.Property(e => e.OcjenaId).HasColumnName("OcjenaID");
                entity.Property(e => e.Datum).HasColumnType("datetime");
                entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");
                
             
                entity.HasOne(d => d.Proizvod)
                    .WithMany(p => p.Ocjene)
                    .HasForeignKey(d => d.ProizvodId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Ocjene_Proizvodi");
            });
            modelBuilder.Entity<Proizvod>(entity =>
            {
                entity.HasKey(e => e.ProizvodId);
                entity.ToTable("Proizvod");
                entity.Property(e => e.ProizvodId).HasColumnName("ProizvodID");
                entity.Property(e => e.VrstaId).HasColumnName("VrstaID");
                entity.Property(e => e.NazivProizvoda).HasMaxLength(50);
                entity.Property(e => e.Cijena).HasColumnType("decimal(18, 2)");
                entity.Property(e => e.Opis).HasMaxLength(100);
                
                entity.Property(e => e.Snizen)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Vrsta)
                    .WithMany(p => p.Proizvod)
                    .HasForeignKey(d => d.VrstaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Proizvodi_VrsteProizvoda");
            });
            modelBuilder.Entity<RadniNalog>(entity =>
            {
                entity.HasKey(e => e.NalogId);
                entity.ToTable("RadniNalog");
                entity.Property(e => e.NalogId).HasColumnName("NalogId");
                entity.Property(e => e.Datum).HasColumnType("datetime");
                entity.Property(e => e.Mjesto).HasMaxLength(50);
                entity.Property(e => e.ImePrezime).HasMaxLength(50);
                entity.Property(e => e.Adresa).HasMaxLength(50);
                entity.Property(e => e.Telefon).HasMaxLength(50);
                entity.Property(e => e.OpisPrijavljenog).HasMaxLength(150);
                entity.Property(e => e.OpisUradjenog).HasMaxLength(50);
                entity.Property(e => e.Naziv).HasMaxLength(50);
               
                //entity.Property(e => e.Cijena).HasColumnType("decimal(18, 2)");
            });
            modelBuilder.Entity<VrsteProizvoda>(entity =>
            {
                entity.HasKey(e => e.VrstaId);
                entity.ToTable("VrsteProizvoda");
                entity.Property(e => e.VrstaId).HasColumnName("VrstaID");
                entity.Property(e => e.Naziv).HasMaxLength(50);
            });
            modelBuilder.Entity<Novosti>(entity =>
            {
                entity.HasKey(e => e.NovostId);
                entity.ToTable("Novosti");
                entity.Property(e => e.NovostId).HasColumnName("NovostId");
                entity.Property(e => e.Sadrzaj).HasMaxLength(50);
            });
            modelBuilder.Entity<Usluge>(entity =>
            {
                entity.HasKey(e => e.UslugaId);
                entity.ToTable("Usluge");
                entity.Property(e => e.UslugaId).HasColumnName("UslugaId");
                entity.Property(e => e.Datum).HasColumnType("datetime");
                entity.Property(e => e.ImePrezime).HasMaxLength(50);
            });
            modelBuilder.Entity<Zahtjev>(entity =>
            {
                entity.HasKey(e => e.ZahtjevId);
                entity.Property(e => e.StatusZahtjevaId).HasColumnName("StatusZahtjevaId");
                entity.HasOne(d => d.StatusZahtjeva)
                    .WithMany(p => p.Zahtjevi)
                    .HasForeignKey(d => d.StatusZahtjevaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Zahtjev_StatusZahtjeva");
            });
            modelBuilder.UseCollation("Latin1_General_CI_AI");

            //modelBuilder.Entity<Radnik>(entity =>
            //{
            //    entity.HasKey(e => e.);

            //    entity.ToTable("Dobavljaci");

            //    entity.Property(e => e.DobavljacId).HasColumnName("DobavljacID");

            //    entity.Property(e => e.Adresa).HasMaxLength(100);

            //    entity.Property(e => e.Email).HasMaxLength(100);

            //    entity.Property(e => e.Fax).HasMaxLength(25);

            //    entity.Property(e => e.KontaktOsoba).HasMaxLength(100);

            //    entity.Property(e => e.Napomena).HasMaxLength(500);

            //    entity.Property(e => e.Naziv).HasMaxLength(100);

            //    entity.Property(e => e.Telefon).HasMaxLength(25);

            //    entity.Property(e => e.Web).HasMaxLength(100);

            //    entity.Property(e => e.ZiroRacuni).HasMaxLength(255);
            //});
            OnModelCreatingPartial(modelBuilder);

            //modelBuilder.Entity<Student>().ToTable("Student");
            //modelBuilder.Entity<Nastavnik>().ToTable("Nastavnik");
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
