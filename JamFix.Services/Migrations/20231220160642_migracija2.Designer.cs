﻿// <auto-generated />
using System;
using JamFix.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace JamFix.Services.Migrations
{
    [DbContext(typeof(Context))]
    [Migration("20231220160642_migracija2")]
    partial class migracija2
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
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

                    b.ToTable("Korisnik", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.Kupci", b =>
                {
                    b.Property<int>("KupacId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("KupacID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KupacId"));

                    b.Property<DateTime>("DatumRegistracije")
                        .HasColumnType("datetime");

                    b.Property<string>("Email")
                        .IsRequired()
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

                    b.Property<bool>("Status")
                        .HasColumnType("bit");

                    b.HasKey("KupacId");

                    b.ToTable("Kupci", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.Novosti", b =>
                {
                    b.Property<int>("NovostId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("NovostId");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("NovostId"));

                    b.Property<string>("Sadrzaj")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("NovostId");

                    b.ToTable("Novosti", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.Ocjene", b =>
                {
                    b.Property<int>("OcjenaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("OcjenaID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("OcjenaId"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<int>("KupacId")
                        .HasColumnType("int")
                        .HasColumnName("KupacID");

                    b.Property<int>("Ocjena")
                        .HasColumnType("int");

                    b.Property<int>("ProizvodId")
                        .HasColumnType("int")
                        .HasColumnName("ProizvodID");

                    b.HasKey("OcjenaId");

                    b.HasIndex("KupacId");

                    b.HasIndex("ProizvodId");

                    b.ToTable("Ocjene", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.Proizvod", b =>
                {
                    b.Property<int>("ProizvodId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ProizvodID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ProizvodId"));

                    b.Property<decimal>("Cijena")
                        .HasColumnType("decimal(18, 2)");

                    b.Property<string>("NazivProizvoda")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Opis")
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<byte[]>("Slika")
                        .HasColumnType("varbinary(max)");

                    b.Property<byte[]>("SlikaThumb")
                        .HasColumnType("varbinary(max)");

                    b.Property<bool>("Snizen")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValueSql("((1))");

                    b.Property<string>("StateMachine")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("VrstaId")
                        .HasColumnType("int")
                        .HasColumnName("VrstaID");

                    b.HasKey("ProizvodId");

                    b.HasIndex("VrstaId");

                    b.ToTable("Proizvod", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.RadniNalog", b =>
                {
                    b.Property<int>("NalogId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("NalogId");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("NalogId"));

                    b.Property<string>("Adresa")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<string>("ImePrezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<int>("Kolicina")
                        .HasColumnType("int");

                    b.Property<string>("Mjesto")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("NosilacPosla")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OpisPrijavljenog")
                        .IsRequired()
                        .HasMaxLength(150)
                        .HasColumnType("nvarchar(150)");

                    b.Property<string>("OpisUradjenog")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Telefon")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("NalogId");

                    b.ToTable("RadniNalog", (string)null);
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

            modelBuilder.Entity("JamFix.Services.Database.Usluge", b =>
                {
                    b.Property<int>("UslugaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("UslugaId");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UslugaId"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<string>("ImePrezime")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("UslugaId");

                    b.ToTable("Usluge", (string)null);
                });

            modelBuilder.Entity("JamFix.Services.Database.VrsteProizvoda", b =>
                {
                    b.Property<int>("VrstaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("VrstaID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("VrstaId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("VrstaId");

                    b.ToTable("VrsteProizvoda", (string)null);
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

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("ZahtjevId");

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

            modelBuilder.Entity("JamFix.Services.Database.Ocjene", b =>
                {
                    b.HasOne("JamFix.Services.Database.Kupci", "Kupac")
                        .WithMany("Ocjene")
                        .HasForeignKey("KupacId")
                        .IsRequired()
                        .HasConstraintName("FK_Ocjene_Kupci");

                    b.HasOne("JamFix.Services.Database.Proizvod", "Proizvod")
                        .WithMany("Ocjene")
                        .HasForeignKey("ProizvodId")
                        .IsRequired()
                        .HasConstraintName("FK_Ocjene_Proizvodi");

                    b.Navigation("Kupac");

                    b.Navigation("Proizvod");
                });

            modelBuilder.Entity("JamFix.Services.Database.Proizvod", b =>
                {
                    b.HasOne("JamFix.Services.Database.VrsteProizvoda", "Vrsta")
                        .WithMany("Proizvod")
                        .HasForeignKey("VrstaId")
                        .IsRequired()
                        .HasConstraintName("FK_Proizvodi_VrsteProizvoda");

                    b.Navigation("Vrsta");
                });

            modelBuilder.Entity("JamFix.Services.Database.Korisnik", b =>
                {
                    b.Navigation("KorisniciUloge");
                });

            modelBuilder.Entity("JamFix.Services.Database.Kupci", b =>
                {
                    b.Navigation("Ocjene");
                });

            modelBuilder.Entity("JamFix.Services.Database.Proizvod", b =>
                {
                    b.Navigation("Ocjene");
                });

            modelBuilder.Entity("JamFix.Services.Database.Uloga", b =>
                {
                    b.Navigation("KorisniciUloges");
                });

            modelBuilder.Entity("JamFix.Services.Database.VrsteProizvoda", b =>
                {
                    b.Navigation("Proizvod");
                });
#pragma warning restore 612, 618
        }
    }
}
