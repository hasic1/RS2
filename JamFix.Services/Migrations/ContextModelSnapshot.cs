﻿// <auto-generated />
using System;
using JamFix.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace JamFix.Services.Migrations
{
    [DbContext(typeof(Context))]
    partial class ContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .UseCollation("Latin1_General_CI_AI")
                .HasAnnotation("ProductVersion", "7.0.11")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("JamFix.Services.Database.Drzava", b =>
                {
                    b.Property<int>("DrzavaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("DrzavaId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("DrzavaId");

                    b.ToTable("Drzava");
                });

            modelBuilder.Entity("JamFix.Services.Database.Izvjestaj", b =>
                {
                    b.Property<int>("IzvjestajId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("IzvjestajId"));

                    b.Property<int>("BrojIntervencija")
                        .HasColumnType("int");

                    b.Property<int>("CijenaUtrosAlata")
                        .HasColumnType("int");

                    b.Property<string>("NajOprema")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("NajPosMjesto")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("IzvjestajId");

                    b.ToTable("Izvjestaj");
                });

            modelBuilder.Entity("JamFix.Services.Database.KorisniciUloge", b =>
                {
                    b.Property<int>("KorisnikUlogaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("KorisnikUlogaID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KorisnikUlogaId"));

                    b.Property<DateTime>("DatumIzmjene")
                        .HasColumnType("datetime");

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    b.Property<int>("UlogaId")
                        .HasColumnType("int")
                        .HasColumnName("UlogaID");

                    b.HasKey("KorisnikUlogaId");

                    b.HasIndex("KorisnikId");

                    b.HasIndex("UlogaId");

                    b.ToTable("KorisniciUloge", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.Korisnik", b =>
                {
                    b.Property<int>("KorisnikId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KorisnikId"));

                    b.Property<string>("Email")
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("KorisnickoIme")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("LozinkaHash")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("LozinkaSalt")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<bool?>("Status")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValueSql("((1))");

                    b.Property<string>("Telefon")
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.HasKey("KorisnikId");

                    b.HasIndex(new[] { "Email" }, "CS_Email")
                        .IsUnique()
                        .HasFilter("[Email] IS NOT NULL");

                    b.HasIndex(new[] { "KorisnickoIme" }, "CS_KorisnickoIme")
                        .IsUnique();

                    b.ToTable("Korisnici", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.Proizvod", b =>
                {
                    b.Property<int>("ProizvodId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ProizvodId"));

                    b.Property<double>("Cijena")
                        .HasColumnType("float");

                    b.Property<string>("LokacijaSlike")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("NazivProizvoda")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Snizen")
                        .HasColumnType("bit");

                    b.Property<string>("StateMachine")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("ProizvodId");

                    b.ToTable("Proizvod");
                });

            modelBuilder.Entity("JamFix.Services.Database.RadniNalog", b =>
                {
                    b.Property<int>("NalogId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("NalogId"));

                    b.Property<string>("Adresa")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime2");

                    b.Property<string>("ImePreyime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("Kolicina")
                        .HasColumnType("int");

                    b.Property<string>("Mjesto")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OpisPrijavljenog")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OpisUradjenog")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("RadnikId")
                        .HasColumnType("int");

                    b.Property<string>("Telefon")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("NalogId");

                    b.HasIndex("RadnikId");

                    b.ToTable("RadniNalog");
                });

            modelBuilder.Entity("JamFix.Services.Database.Radnik", b =>
                {
                    b.Property<int>("RadnikId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RadnikId"));

                    b.Property<DateTime>("DatumRodjenja")
                        .HasColumnType("datetime2");

                    b.Property<int>("DrzavaId")
                        .HasColumnType("int");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Spol")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("trajanjeUgovora")
                        .HasColumnType("datetime2");

                    b.HasKey("RadnikId");

                    b.HasIndex("DrzavaId");

                    b.ToTable("Radnik");
                });

            modelBuilder.Entity("JamFix.Services.Database.StatusZahtjeva", b =>
                {
                    b.Property<int>("StatusZahtjevaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("StatusZahtjevaId"));

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("StatusZahtjevaId");

                    b.ToTable("StatusZahtjeva");
                });

            modelBuilder.Entity("JamFix.Services.Database.Uloga", b =>
                {
                    b.Property<int>("UlogaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UlogaId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UlogaId");

                    b.ToTable("Uloga");
                });

            modelBuilder.Entity("JamFix.Services.Database.Uredjaj", b =>
                {
                    b.Property<int>("UredjajId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UredjajId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UredjajId");

                    b.ToTable("Uredjaj");
                });

            modelBuilder.Entity("JamFix.Services.Database.Zahtjev", b =>
                {
                    b.Property<int>("ZahtjevId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ZahtjevId"));

                    b.Property<string>("Adresa")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("BrojTelefona")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("DatumVrijeme")
                        .HasColumnType("datetime2");

                    b.Property<bool>("HitnaIntervencija")
                        .HasColumnType("bit");

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int");

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("StatusId")
                        .HasColumnType("int");

                    b.Property<string>("StatusZahtjeva")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("UredjajId")
                        .HasColumnType("int");

                    b.HasKey("ZahtjevId");

                    b.HasIndex("UredjajId");

                    b.ToTable("Zahtjev");
                });

            modelBuilder.Entity("JamFix.Services.Database.KorisniciUloge", b =>
                {
                    b.HasOne("JamFix.Services.Database.Korisnik", "Korisnik")
                        .WithMany("KorisniciUloge")
                        .HasForeignKey("KorisnikId")
                        .IsRequired()
                        .HasConstraintName("FK_KorisniciUloge_Korisnici");

                    b.HasOne("JamFix.Services.Database.Uloga", "Uloga")
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("UlogaId")
                        .IsRequired()
                        .HasConstraintName("FK_KorisniciUloge_Uloge");

                    b.Navigation("Korisnik");

                    b.Navigation("Uloga");
                });

            modelBuilder.Entity("JamFix.Services.Database.RadniNalog", b =>
                {
                    b.HasOne("JamFix.Services.Database.Radnik", "Radnik")
                        .WithMany()
                        .HasForeignKey("RadnikId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Radnik");
                });

            modelBuilder.Entity("JamFix.Services.Database.Radnik", b =>
                {
                    b.HasOne("JamFix.Services.Database.Drzava", "Drzava")
                        .WithMany()
                        .HasForeignKey("DrzavaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Drzava");
                });

            modelBuilder.Entity("JamFix.Services.Database.Zahtjev", b =>
                {
                    b.HasOne("JamFix.Services.Database.Uredjaj", "Uredjaj")
                        .WithMany()
                        .HasForeignKey("UredjajId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Uredjaj");
                });

            modelBuilder.Entity("JamFix.Services.Database.Korisnik", b =>
                {
                    b.Navigation("KorisniciUloge");
                });

            modelBuilder.Entity("JamFix.Services.Database.Uloga", b =>
                {
                    b.Navigation("KorisniciUloges");
                });
#pragma warning restore 612, 618
        }
    }
}
