using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
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
        public virtual DbSet<Pozicija> Pozicija{ get; set; }
        public virtual DbSet<Proizvod> Proizvod { get; set; } 
        public virtual DbSet<RadniNalog> RadniNalog { get; set; } 
        public virtual DbSet<StatusZahtjeva> StatusZahtjeva { get; set; } 
        public virtual DbSet<Uloga> Uloga { get; set; } 
        public virtual DbSet<Usluge> Usluge { get; set; }
        public virtual DbSet<VrsteProizvoda> VrsteProizvoda { get; set; }
        public virtual DbSet<Zahtjev> Zahtjev { get; set; }
        public virtual DbSet<UslugaStavke> UslugaStavke { get; set; }


        //private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);

        //private void SeedData(ModelBuilder modelBuilder)
        //{
        //    SeedCountries(modelBuilder);
        //    SeedKindOfProduct(modelBuilder);
        //    SeedPosition(modelBuilder);
        //    SeedUslugaStavke(modelBuilder);
        //    SeedUsluge(modelBuilder);
        //    SeedStatusZahtjeva(modelBuilder);
        //    SeedZahtjev(modelBuilder);
        //    SeedUloga(modelBuilder);
        //    SeedNews(modelBuilder);
        //    SeedRadniNalog(modelBuilder);
        //    SeedProizvod(modelBuilder);
        //    SeedOcjene(modelBuilder);
        //}

        //private void SeedCountries(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Drzava>().HasData(
        //       new()
        //       {
        //           DrzavaId = 1,
        //           Naziv = "Bosnia and Herzegovina",
        //       },
        //       new()
        //       {
        //           DrzavaId = 2,
        //           Naziv = "Croatia",
        //       },
        //       new()
        //       {
        //           DrzavaId = 3,
        //           Naziv = "Serbia",
        //       },
        //       new()
        //       {
        //           DrzavaId = 4,
        //           Naziv = "Montenegro",
        //       },
        //       new()
        //       {
        //           DrzavaId = 5,
        //           Naziv = "Slovenia",
        //       },
        //       new()
        //       {
        //           DrzavaId = 6,
        //           Naziv = "Austria",
        //       });
        //}
        //private void SeedKindOfProduct(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<VrstaProizvoda>().HasData(
        //       new()
        //       {
        //           VrstaId = 1,
        //           Naziv = "Bosnia and Herzegovina",
        //       },
        //       new()
        //       {
        //           VrstaId = 2,
        //           Naziv = "Croatia",
        //       });
        //}
        //private void SeedPosition(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Pozicija>().HasData(
        //       new()
        //       {
        //           PozicijaId = 1,
        //           Naziv = "Bosnia and Herzegovina",
        //       },
        //       new()
        //       {
        //           PozicijaId = 2,
        //           Naziv = "Croatia",
        //       });
        //}
        //private void SeedNews(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Novosti>().HasData(
        //       new()
        //       {
        //           NovostId = 1,
        //           Naslov = "Bosnia and Herzegovina",
        //           Sadrzaj="NESTO NESTO"
        //       },
        //       new()
        //       {
        //           NovostId = 2,
        //           Naslov = "Croatia",
        //           Sadrzaj = "NESTO NESTO"

        //       });
        //}
        //private void SeedUloga(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Uloga>().HasData(
        //       new()
        //       {
        //           UlogaId = 1,
        //           Naziv = "Bosnia and Herzegovina",
        //           Opis = "NESTO NESTO"
        //       },
        //       new()
        //       {
        //           UlogaId = 2,
        //           Naziv = "Croatia",
        //           Opis = "NESTO NESTO"

        //       });
        //}
        //private void SeedZahtjev(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Zahtjev>().HasData(
        //       new()
        //       {
        //           ZahtjevId = 1,
        //           ImePrezime = "Bosnia and Herzegovina",
        //           Adresa = "NESTO NESTO",
        //           BrojTelefona="123",
        //           Opis="Veliki problem",
        //           DatumVrijeme=DateTime.Now,
        //           HitnaIntervencija=true,
        //           StatusZahtjevaId=1,
        //       },
        //       new()
        //       {
        //           ZahtjevId = 2,
        //           ImePrezime = "Bosnia and Herzegovina",
        //           Adresa = "NESTO NESTO",
        //           BrojTelefona = "123",
        //           Opis = "Veliki problem",
        //           DatumVrijeme = DateTime.Now,
        //           HitnaIntervencija = true,
        //           StatusZahtjevaId = 1,
        //       });
        //}
        //private void SeedStatusZahtjeva(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<StatusZahtjeva>().HasData(
        //       new()
        //       {
        //           StatusZahtjevaId = 1,
        //           Opis = "Bosnia and Herzegovina",
        //       },
        //       new()
        //       {
        //           StatusZahtjevaId = 2,
        //           Opis = "Croatia",

        //       });
        //}
        //private void SeedUsluge(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Usluge>().HasData(
        //       new()
        //       {
        //           UslugaId = 1,
        //           ImePrezime = "Bosnia and Herzegovina",
        //           Datum=DateTime.Now,
        //           BrojRacuna="123",
        //           Cijena="123",
        //           NazivPaketa="Neki naziv paketa",
        //           Placeno=true,
        //           ProizvodId=1,
        //       },
        //       new()
        //       {
        //           UslugaId = 2,
        //           ImePrezime = "Bosnia and Herzegovina",
        //           Datum = DateTime.Now,
        //           BrojRacuna = "123",
        //           Cijena = "123",
        //           NazivPaketa = "Neki naziv paketa",
        //           Placeno = true,
        //           ProizvodId = 1,
        //       });
        //}
        //private void SeedUslugaStavke(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<UslugaStavke>().HasData(
        //       new()
        //       {
        //           UslugaStavkeId = 1,
        //           ProizvodId = 1,
        //           UslugeId=1,
        //       },
        //       new()
        //       {
        //           UslugaStavkeId = 2,
        //           ProizvodId =2,
        //           UslugeId=1

        //       });
        //}
        //private void SeedRadniNalog(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<RadniNalog>().HasData(
        //       new()
        //       {
        //           NalogId = 1,
        //           NosilacPosla = "Bakir Hasic",
        //           OpisPrijavljenog = "Veliki problem",
        //           OpisUradjenog = "Veliko rijesenje",
        //           ImePrezime = "Bakir Hasic",
        //           Telefon = "061336026",
        //           Datum = DateTime.Now,
        //           Adresa = "Domanovici b.b",
        //           Mjesto = "Domanovici b.b",
        //           Naziv="Neki naziv",
        //           Kolicina=1
        //       },
        //       new()
        //       {
        //           NalogId = 2,
        //           NosilacPosla = "Bakir Hasic",
        //           OpisPrijavljenog = "Veliki problem",
        //           OpisUradjenog = "Veliko rijesenje",
        //           ImePrezime = "Bakir Hasic",
        //           Telefon = "061336026",
        //           Datum = DateTime.Now,
        //           Adresa = "Domanovici b.b",
        //           Mjesto = "Domanovici b.b",
        //           Naziv = "Neki naziv",
        //           Kolicina = 1
        //       });
        //}
        //private void SeedProizvod(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Proizvod>().HasData(
        //       new()
        //       {
        //           ProizvodId = 1,
        //           VrstaId = 1,
        //           NazivProizvoda = "Proizvod",
        //           Cijena = 111,
        //           Opis = "Bakir Hasic",
        //           Snizen = true,
        //           BrzinaInterneta = "Domanovici b.b",
        //           BrojMinuta = "Domanovici b.b",
        //           BrojKanala = "Domanovici b.b",
        //       },
        //       new()
        //       {
        //           ProizvodId = 2,
        //           VrstaId = 1,
        //           NazivProizvoda = "Proizvod",
        //           Cijena = 111,
        //           Opis = "Bakir Hasic",
        //           Snizen = true,
        //           BrzinaInterneta = "Domanovici b.b",
        //           BrojMinuta = "Domanovici b.b",
        //           BrojKanala = "Domanovici b.b",
        //       });
        //}
        //private void SeedOcjene(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Ocjene>().HasData(
        //       new()
        //       {
        //           OcjenaId = 1,
        //           ProizvodId = 1,
        //           Datum = DateTime.Now,
        //           Ocjena=3,
        //       },
        //       new()
        //       {
        //           OcjenaId = 2,
        //           ProizvodId = 1,
        //           Datum = DateTime.Now,
        //           Ocjena = 4,
        //       });
        //}
        //private void SeedKorisnik(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Korisnik>().HasData(
        //       new()
        //       {
        //           KorisnikId = 1,
        //           DrzavaId = 1,
        //           PozicijaId = 1,
        //           Ime = 3,
        //           Prezime
        //           Email
        //           Telefon
        //           KorisnickoIme



        //       },
        //       new()
        //       {
        //           OcjenaId = 2,
        //           ProizvodId = 1,
        //           Datum = DateTime.Now,
        //           Ocjena = 4,
        //       });
        //}
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
            //SeedData(modelBuilder);
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
