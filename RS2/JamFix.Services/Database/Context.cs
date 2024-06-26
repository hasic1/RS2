﻿using Microsoft.EntityFrameworkCore;

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
        public virtual DbSet<Konkurs> Konkurs { get; set; }
        public virtual DbSet<KorisniciUloge> KorisniciUloge { get; set; }
        public virtual DbSet<Korisnik> Korisnik { get; set; }
        public virtual DbSet<Novosti> Novosti{ get; set; } 
        public virtual DbSet<Ocjene> Ocjene { get; set; }
        public virtual DbSet<Pozicija> Pozicija{ get; set; }
        public virtual DbSet<Prijava> Prijava { get; set; }
        public virtual DbSet<Proizvod> Proizvod { get; set; } 
        public virtual DbSet<RadniNalog> RadniNalog { get; set; } 
        public virtual DbSet<StatusZahtjeva> StatusZahtjeva { get; set; } 
        public virtual DbSet<Uloga> Uloga { get; set; } 
        public virtual DbSet<UslugaStavke> UslugaStavke { get; set; }
        public virtual DbSet<Usluge> Usluge { get; set; }
        public virtual DbSet<VrsteProizvoda> VrsteProizvoda { get; set; }
        public virtual DbSet<Zahtjev> Zahtjev { get; set; }

        private readonly DateTime _dateTime = new(2024, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);



        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedCountries(modelBuilder);
            SeedIzvjestaj(modelBuilder);
            SeedKorisniciUloge(modelBuilder);
            SeedKorisnik(modelBuilder);
            SeedNovosti(modelBuilder);
            SeedOcjene(modelBuilder);
            SeedPozicija(modelBuilder);
            SeedProizvod(modelBuilder);
            SeedRadniNalog(modelBuilder);
            SeedStatusZahtjeva(modelBuilder);
            SeedUloga(modelBuilder);
            SeedUslugaStavke(modelBuilder);
            SeedUsluge(modelBuilder);
            SeedVrsteProizvoda(modelBuilder);
            SeedZahtjev(modelBuilder); 
            SeedKonkursi(modelBuilder);
            SeedPrijave(modelBuilder);

        }
        private void SeedPrijave(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Prijava>().HasData(
               new()
               {
                   PrijavaId = 1,
                   KonkursId = 1,
                   Ime = "Adin",
                   Prezime = "Zuhric",
                   Email = "adin@gmail.com",
                   BrojTelefona = "061-336-026",
                   DatumPrijave = DateTime.Now,
               },
               new()
               {
                   PrijavaId = 2,
                   KonkursId = 2,
                   Ime = "Almin",
                   Prezime = "Orucevic",
                   Email = "almin@gmail.com",
                   BrojTelefona = "061-234-123",
                   DatumPrijave = DateTime.Now,
               }, new()
               {
                   PrijavaId = 3,
                   KonkursId = 3,
                   Ime = "Belmin",
                   Prezime = "Nozic",
                   Email = "belmin@gmail.com",
                   BrojTelefona = "061-523-122",
                   DatumPrijave = DateTime.Now,
               });
        }
        private void SeedCountries(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Drzava>().HasData(
               new()
               {
                   DrzavaId = 1,
                   Naziv = "Bosnia and Herzegovina",
               },
               new()
               {
                   DrzavaId = 2,
                   Naziv = "Croatia",
               },
               new()
               {
                   DrzavaId = 3,
                   Naziv = "Serbia",
               },
               new()
               {
                   DrzavaId = 4,
                   Naziv = "Montenegro",
               },
               new()
               {
                   DrzavaId = 5,
                   Naziv = "Slovenia",
               },
               new()
               {
                   DrzavaId = 6,
                   Naziv = "Austria",
               });
        }
        private void SeedKonkursi(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Konkurs>().HasData(
               new()
               {
                   KonkursId = 1,
                   DatumZavrsetka = new DateTime(2024, 6, 30),
                   TrazenaPozicija = "Supervizor",
                   BrojIzvrsitelja = 1,
               },
               new()
               {
                   KonkursId = 2,
                   DatumZavrsetka = new DateTime(2024, 6, 30),
                   TrazenaPozicija = "Zaposlenik",
                   BrojIzvrsitelja = 1,
               },
               new()
               {
                   KonkursId = 3,
                   DatumZavrsetka = new DateTime(2024, 6, 30),
                   TrazenaPozicija = "Operater",
                   BrojIzvrsitelja = 1,
               });
        }
        private void SeedVrsteProizvoda(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<VrsteProizvoda>().HasData(
               new()
               {
                   VrstaId = 1,
                   Naziv = "Paket preplate",
               },
               new()
               {
                   VrstaId = 2,
                   Naziv = "Tarifa",
               });
        }
        private void SeedPozicija(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Pozicija>().HasData(
               new()
               {
                   PozicijaId = 1,
                   Naziv = "Direktor",
               },
               new()
               {
                   PozicijaId = 2,
                   Naziv = "Predsjednik",
               },
               new()
               {
                   PozicijaId = 3,
                   Naziv = "Direktor odjela",
               },
               new()
               {
                   PozicijaId = 4,
                   Naziv = "Menadzer",
               },
               new()
               {
                   PozicijaId = 5,
                   Naziv = "Supervizor",
               }, 
               new()
               {
                   PozicijaId = 6,
                   Naziv = "User",
               });
        }
        private void SeedNovosti(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Novosti>().HasData(
               new()
               {
                   NovostId = 1,
                   Naslov = "Reakcije na pad Fejsa: \"Zuckerberg nas sve izbacio\"",
                   Sadrzaj = "MNOŠTVO korisnika Facebooka javlja da su \"izbačeni\" sa svog računa. Točnije, ako pokušate ući na svoj Facebook profil, vrlo vjerojatno ćete vidjeti da ste s njega izlogirani i da se ne možete ulogirati natrag. Nedugo zatim sličan problem pojavio se i na Instagramu.\r\n\r\nReakcije na pad društvene mreže preplavile su X (bivši Twitter), mrežu Elona Muska.\r\n\r\n\"Jesu li svi ostali upravo izbačeni iz svojih Facebook računa i ne mogu nazad?\", \"Znači, sad smo svi na X-u da javimo da je pao Fejs?\", \"Ok, što se mene tiče, ne moraju me ni vraćati\", \"Zapravo bi bilo super da me nikad ne ulogira natrag\", \"Zuckerberg nas sve izbacio\", šale se korisnici X-a",
               },
               new()
               {
                   NovostId = 2,
                   Naslov = "Nova konkurencija ChatGPT-ju: Anthropic predstavio svoj najbrži i najmoćniji chatbot",
                   Sadrzaj = "U ponedjeljak su službeno predstavili svoju 'obitelj' modela Claude 3, koja uključuje tri najsuvremenija modela (prema uzlaznom redoslijedu mogućnosti): Claude 3 Haiku, Claude 3 Sonnet i Claude 3 Opus.\nAnthropic je tvrdio da je najsposobniji model, Opus, nadmašio OpenAI-jev GPT-4 i Googleov Gemini Ultra na testovima kao što su rasuđivanje, osnovna matematika te znanje na dodiplomskoj i diplomskoj razini. Opus i Sonnet su sada dostupni za korištenje u claude.ai, dok je Claude API dostupan u 159 zemalja.\r\n\r\nTvrtka je rekla da će kompaktniji modeli, Sonnet i Haiku, uskoro biti pušteni u prodaju. Novi chatbot može sažeti približno 200.000 riječi, dok ChatGPT može sažeti samo oko 3.000. Novi modeli također omogućuju učitavanje slika i dokumenata.",
               },
               new()
               {
                   NovostId = 3,
                   Naslov = "Amazonov oporavak poslovanja poguran otkazima",
                   Sadrzaj = "Nakon teške 2022. koja je rezultirala otpuštanjem tisuća zaposlenika u Amazonu i rezanjem troškova gdje je to bilo moguće, najveći svjetski online trgovac snažno se oporavio u 2023. U četvrtak je tvrtka izvijestila o najvišoj operativnoj dobiti u povijesti za proteklo blagdansko tromjesečje, kao prodaja značajno porastao u svakom od svojih operativnih segmenata. Ipak, što je još važnije, čini se da su prošlogodišnje agresivne mjere rezanja troškova urodile plodom jer je Amazonova operativna marža porasla s 1,8 posto u četvrtom tromjesečju 2022. na 7,8 posto u prošlom tromjesečju.\r\n\r\n\"Ovo četvrto tromjesečje bilo je rekordna sezona blagdanske kupnje i zatvorila je snažnu 2023. za Amazon\", rekao je izvršni direktor Amazona Andy Jassy u izjavi. \"Iako smo ostvarili značajne prihode, prihode od poslovanja i napredak u slobodnom novčanom tijeku, ono čime smo najviše zadovoljni je nastavak poboljšanja izuma i korisničkog iskustva u našim tvrtkama.\" Za cijelu godinu, neto prodaja porasla je 12 posto na 574,8 milijardi dolara, dok je neto prihod skočio natrag na 30,4 milijarde dolara s gubitka od 2,7 milijardi dolara u 2022.\r\n\r\nJedna stvar koja nas je izdvojila iz rezultata je rast Amazonovog oglašivačkog poslovanja. U prošlom tromjesečju, prodaja oglasa tvrtke iznosila je 14,7 milijardi dolara, čime je ukupni iznos za godinu blizu 50 milijardi dolara. S obzirom na to da je tvrtka upravo pokrenula oglase na svojoj usluzi streaminga Prime Video, možemo očekivati da će ta često zanemarena strana Amazonovog poslovanja dodatno rasti 2024. i kasnije.",
               },
               new()
               {
                   NovostId = 4,
                   Naslov = "Bivši direktori Twittera podnijeli milijunsku tužbu protiv Elona Muska",
                   Sadrzaj = "Tužbu su pokrenuli bivši izvršni direktor Parag Agrawal, Ned Segal, Twitterov bivši financijski direktor, Vijaya Gadde, bivša glavna pravna službenica i Sean Edgett, bivši glavni savjetnik\r\n\r\nČetiri bivša glavna rukovoditelja Twittera, uključujući bivšeg izvršnog direktora Paraga Agrawala, tuže Elona Muska za više od 128 milijuna dolara zbog neplaćenih otpremnina, navodi se u tužbi podnesenoj u ponedjeljak.\nTužba podnesena saveznom sudu u San Franciscu posljednja je u nizu pravnih izazova s ​​kojima se Musk suočava nakon što je u listopadu 2022. kupio društvenu mrežu za 44 milijarde dolara i kasnije je preimenovao u X.",
               }, new()
               {
                   NovostId = 5,
                   Naslov = "Apple odustaje od projekta EV",
                   Sadrzaj = "Apple je odustao od višegodišnjeg napora da napravi svoje električno vozilo. Prema medijskim izvješćima, barem neki zaposlenici iz tog odjela bit će premješteni u timove za umjetnu inteligenciju.\r\n\r\nApple je interno objavio da zatvara projekt električnih vozila koji ima gotovo 2000 zaposlenika. Objava je pripisana potpredsjedniku Kevinu Lynchu i COO-u Jeffu Williamsu. Lynch je nadgledao projekt električnih vozila, koji je poznat kao Grupa za posebne projekte.\r\n\r\nOdluka o zatvaranju projekta vrijednog više milijardi dolara donesena je tijekom proteklih nekoliko tjedana. Apple je zamislio da će cijena vozila biti oko 100.000 dolara. Pričalo se da je Apple zainteresiran za izradu električnog vozila još 2015. nakon što je tadašnji viši potpredsjednik operacija Williams na konferenciji izjavio da je automobil ultimativni mobilni uređaj.",
               });
        }
        private void SeedUloga(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Uloga>().HasData(
               new()
               {
                   UlogaId = 1,
                   Naziv = "Administrator",
                   Opis = "Administrator"
               },
               new()
               {
                   UlogaId = 2,
                   Naziv = "Korisnik",
                   Opis = "Korisnik"
               },
               new()
               {
                   UlogaId = 3,
                   Naziv = "Zaposlenik",
                   Opis = "Zaposlenik"
               },
               new()
               {
                   UlogaId = 4,
                   Naziv = "Operater",
                   Opis = "Operater"
               });
        }
        private void SeedZahtjev(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Zahtjev>().HasData(
               new()
               {
                   ZahtjevId = 1,
                   ImePrezime = "Bakir Hasic",
                   Adresa = "Domanovici",
                   BrojTelefona = "061-336-026",
                   Opis = "Moj ruter je u kvaru",
                   DatumVrijeme = DateTime.Now,
                   HitnaIntervencija = true,
                   StatusZahtjevaId = 1,
               },
               new()
               {
                   ZahtjevId = 2,
                   ImePrezime = "Arman Hodzic",
                   Adresa = "Mostar",
                   BrojTelefona = "062-223-322",
                   Opis = "Moj modem je u kvaru",
                   DatumVrijeme = DateTime.Now,
                   HitnaIntervencija = false,
                   StatusZahtjevaId = 1,
               }, 
               new()
               {
                   ZahtjevId = 3,
                   ImePrezime = "Amar Hodzic",
                   Adresa = "Mostar",
                   BrojTelefona = "062-123-321",
                   Opis = "Moj modem je u kvaru",
                   DatumVrijeme = DateTime.Now,
                   HitnaIntervencija = false,
                   StatusZahtjevaId = 1,
               });
        }
        private void SeedStatusZahtjeva(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<StatusZahtjeva>().HasData(
               new()
               {
                   StatusZahtjevaId = 1,
                   Opis = "Zaprimljen ",
               },
               new()
               {
                   StatusZahtjevaId = 2,
                   Opis = "U obradi",

               },
               new()
               {
                   StatusZahtjevaId = 3,
                   Opis = "Rijesen",
               });
        }
        private void SeedUsluge(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Usluge>().HasData(
               new()
               {
                   UslugaId = 1,
                   ImePrezime = "Bakir Hasic",
                   Datum = DateTime.Now,
                   BrojRacuna = "1234-1234-1234-1234",
                   Cijena = "123",
                   NazivPaketa = "Trio paket",
                   Placeno = true,
                   ProizvodId = 1,
               },
               new()
               {
                   UslugaId = 2,
                   ImePrezime = "Anel Hodzic",
                   Datum = DateTime.Now,
                   BrojRacuna = "1235-1235-1235-1235",
                   Cijena = "123",
                   NazivPaketa = "Trio paket",
                   Placeno = true,
                   ProizvodId = 1,
               },
               new()
               {
                   UslugaId = 3,
                   ImePrezime = "Hamza Dzeko",
                   Datum = DateTime.Now,
                   BrojRacuna = "1236-1236-1236-1236",
                   Cijena = "123",
                   NazivPaketa = "Trio paket",
                   Placeno = true,
                   ProizvodId = 1,
               });
        }
        private void SeedUslugaStavke(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UslugaStavke>().HasData(
               new()
               {
                   UslugaStavkeId = 1,
                   ProizvodId = 1,
                   UslugeId = 1,
               },
               new()
               {
                   UslugaStavkeId = 2,
                   ProizvodId = 3,
                   UslugeId = 1

               },
               new()
               {
                   UslugaStavkeId = 3,
                   ProizvodId = 6,
                   UslugeId = 1

               },
               new()
               {
                   UslugaStavkeId = 4,
                   ProizvodId = 2,
                   UslugeId = 2

               },
               new()
               {
                   UslugaStavkeId = 5,
                   ProizvodId = 4,
                   UslugeId = 2
               },
               new()
               {
                   UslugaStavkeId = 6,
                   ProizvodId = 3,
                   UslugeId = 3

               },
               new()
               {
                   UslugaStavkeId = 7,
                   ProizvodId = 5,
                   UslugeId = 3
               });
        }
        private void SeedRadniNalog(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<RadniNalog>().HasData(
               new()
               {
                   NalogId = 1,
                   NosilacPosla = "Bakir Hasic",
                   OpisPrijavljenog = "Modem u kvaru",
                   OpisUradjenog = "Zamjena modema",
                   ImePrezime = "Bakir Hasic",
                   Telefon = "061-330-326",
                   Datum = DateTime.Now,
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Neki naziv",
                   Kolicina = 1
               },
               new()
               {
                   NalogId = 2,
                   NosilacPosla = "Amar Hasic",
                   OpisPrijavljenog = "Ruter u kvaru",
                   OpisUradjenog = "Zamijena rutera",
                   ImePrezime = "Arman Hasic",
                   Telefon = "061-336-026",
                   Datum = DateTime.Now,
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Ruter",
                   Kolicina = 1
               },
               new()
               {
                   NalogId = 3,
                   NosilacPosla = "Ramiz Dizdar",
                   OpisPrijavljenog = "Problemi sa konekcijom",
                   OpisUradjenog = "Zamijena kablova",
                   ImePrezime = "Dzemal Causevic",
                   Telefon = "061-202-330",
                   Datum = DateTime.Now,
                   Adresa = "Mostar",
                   Mjesto = "Mostar",
                   Naziv = "Kablovi",
                   Kolicina = 2
               }, new()
               {
                   NalogId = 4,
                   NosilacPosla = "Neir Hasic",
                   OpisPrijavljenog = "Modem u kvaru",
                   OpisUradjenog = "Zamjena modema",
                   ImePrezime = "Bakir Hasic",
                   Telefon = "061-330-326",
                   Datum = _dateTime,
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Neki naziv",
                   Kolicina = 1
               },
               new()
               {
                   NalogId = 5,
                   NosilacPosla = "Armin Hasic",
                   OpisPrijavljenog = "Ruter u kvaru",
                   OpisUradjenog = "Zamijena rutera",
                   ImePrezime = "Arman Hasic",
                   Telefon = "061-336-026",
                   Datum = _dateTime,
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Ruter",
                   Kolicina = 3
               },
               new()
               {
                   NalogId = 6,
                   NosilacPosla = "Zejneb Dizdar",
                   OpisPrijavljenog = "Problemi sa konekcijom",
                   OpisUradjenog = "Zamijena kablova",
                   ImePrezime = "Dzemal Causevic",
                   Telefon = "061-202-330",
                   Datum = _dateTime,
                   Adresa = "Mostar",
                   Mjesto = "Mostar",
                   Naziv = "Kablovi",
                   Kolicina = 2
               }, new()
               {
                   NalogId = 7,
                   NosilacPosla = "Dajana Matic",
                   OpisPrijavljenog = "Modem u kvaru",
                   OpisUradjenog = "Zamjena modema",
                   ImePrezime = "Dajana Matic",
                   Telefon = "061-330-326",
                   Datum = new DateTime(2024, 3, 24, 16, 00, 0),
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Neki naziv",
                   Kolicina = 5
               },
               new()
               {
                   NalogId = 8,
                   NosilacPosla = "Faris Hadziomerovic",
                   OpisPrijavljenog = "Ruter u kvaru",
                   OpisUradjenog = "Zamijena rutera",
                   ImePrezime = "Faris Hadziomerovic",
                   Telefon = "061-336-026",
                   Datum = new DateTime(2024, 3, 24, 16, 00, 0),
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Ruter",
                   Kolicina = 2
               },
               new()
               {
                   NalogId = 9,
                   NosilacPosla = "Selma Causevic",
                   OpisPrijavljenog = "Problemi sa konekcijom",
                   OpisUradjenog = "Zamijena kablova",
                   ImePrezime = "Selma Causevic",
                   Telefon = "061-202-330",
                   Datum = new DateTime(2024, 3, 24, 16, 00, 0),
                   Adresa = "Mostar",
                   Mjesto = "Mostar",
                   Naziv = "Kablovi",
                   Kolicina = 4
               }, new()
               {
                   NalogId = 10,
                   NosilacPosla = "Dino Hasic",
                   OpisPrijavljenog = "Modem u kvaru",
                   OpisUradjenog = "Zamjena modema",
                   ImePrezime = "Dino Hasic",
                   Telefon = "061-330-326",
                   Datum = new DateTime(2024, 4, 24, 16, 00, 0),
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Neki naziv",
                   Kolicina = 2
               },
               new()
               {
                   NalogId = 11,
                   NosilacPosla = "Amel Hasic",
                   OpisPrijavljenog = "Ruter u kvaru",
                   OpisUradjenog = "Zamijena rutera",
                   ImePrezime = "Amel Hasic",
                   Telefon = "061-336-026",
                   Datum = new DateTime(2024, 4, 24, 16, 00, 0),
                   Adresa = "Domanovici b.b",
                   Mjesto = "Mostar",
                   Naziv = "Ruter",
                   Kolicina = 1
               },
               new()
               {
                   NalogId = 12,
                   NosilacPosla = "Dzemal Dizdar",
                   OpisPrijavljenog = "Problemi sa konekcijom",
                   OpisUradjenog = "Zamijena kablova",
                   ImePrezime = "Dzemal Dizdar",
                   Telefon = "061-202-330",
                   Datum = new DateTime(2024, 4, 24, 16, 00, 0),
                   Adresa = "Mostar",
                   Mjesto = "Mostar",
                   Naziv = "Kablovi",
                   Kolicina = 3
               });
        }
        private void SeedProizvod(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Proizvod>().HasData(
               new()
               {
                   ProizvodId = 1,
                   VrstaId = 1,
                   NazivProizvoda = "Trio start paket",
                   Cijena = 65,
                   Opis = "Za mala kucanstva",
                   Snizen = true,
                   BrzinaInterneta = "55",
                   BrojMinuta = "1000",
                   BrojKanala = "500",
               },
               new()
               {
                   ProizvodId = 2,
                   VrstaId = 1,
                   NazivProizvoda = "Trio paket",
                   Cijena = 75,
                   Opis = "Za kucanstva",
                   Snizen = true,
                   BrzinaInterneta = "75",
                   BrojMinuta = "1500",
                   BrojKanala = "750",
               },
               new()
               {
                   ProizvodId = 3,
                   VrstaId = 1,
                   NazivProizvoda = "Trio super paket",
                   Cijena = 90,
                   Opis = "Najbolje u ponudi",
                   Snizen = true,
                   BrzinaInterneta = "100",
                   BrojMinuta = "2000",
                   BrojKanala = "1000",
               },
               new()
               {
                   ProizvodId = 4,
                   VrstaId = 1,
                   NazivProizvoda = "Duo start paket",
                   Cijena = 40,
                   Opis = "Najbolje za mala kucanstva",
                   Snizen = true,
                   BrzinaInterneta = "25",
                   BrojMinuta = "0",
                   BrojKanala = "500",
               },
               new()
               {
                   ProizvodId = 5,
                   VrstaId = 1,
                   NazivProizvoda = "Duo paket",
                   Cijena = 50,
                   Opis = "Novo u ponudi",
                   Snizen = true,
                   BrzinaInterneta = "50",
                   BrojMinuta = "0",
                   BrojKanala = "600",
               },
               new()
               {
                   ProizvodId = 6,
                   VrstaId = 1,
                   NazivProizvoda = "Duo super paket",
                   Cijena = 65,
                   Opis = "Najbolje u ponudi",
                   Snizen = true,
                   BrzinaInterneta = "75",
                   BrojMinuta = "0",
                   BrojKanala = "1000",
               });
        }
        private void SeedOcjene(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Ocjene>().HasData(
               new()
               {
                   OcjenaId = 1,
                   ProizvodId = 1,
                   Datum = DateTime.Now,
                   Ocjena = 3,
               },
               new()
               {
                   OcjenaId = 2,
                   ProizvodId = 1,
                   Datum = DateTime.Now,
                   Ocjena = 5,
               }, new()
               {
                   OcjenaId = 3,
                   ProizvodId = 2,
                   Datum = DateTime.Now,
                   Ocjena = 3,
               },
               new()
               {
                   OcjenaId = 4,
                   ProizvodId = 2,
                   Datum = DateTime.Now,
                   Ocjena = 4,
               },
               new()
               {
                   OcjenaId = 5,
                   ProizvodId = 3,
                   Datum = DateTime.Now,
                   Ocjena = 5,
               },
               new()
               {
                   OcjenaId = 6,
                   ProizvodId = 3,
                   Datum = DateTime.Now,
                   Ocjena = 4,
               }, new()
               {
                   OcjenaId = 7,
                   ProizvodId = 4,
                   Datum = DateTime.Now,
                   Ocjena = 4,
               },
               new()
               {
                   OcjenaId = 8,
                   ProizvodId = 5,
                   Datum = DateTime.Now,
                   Ocjena = 4,
               });
        }
        private void SeedKorisnik(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Korisnik>().HasData(
               new()
               {
                   KorisnikId = 1,
                   DrzavaId = 1,
                   PozicijaId = 1,
                   Ime = "Admin",
                   Prezime = "Admin",
                   Email = "admin@gmail.com",
                   Telefon = "061-336-026",
                   Status = true,
                   KorisnickoIme = "admin",
                   LozinkaHash = Service.KorisniciService.GenerateHash("1wQEjdSFeZttx6dlvEDjOg==", "test"),
                   LozinkaSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                   DatumRodjenja = new DateTime(2000, 12,24),
                   Aktivnost = true,
                   TransakcijskiRacun= "4000 0000 0000 0002"
               },
               new()
               {
                   KorisnikId = 2,
                   DrzavaId = 1,
                   PozicijaId = 2,
                   Ime = "Korisnik",
                   Prezime = "Korisnik",
                   Email = "korisnik@gmail.com",
                   Telefon = "061-336-026",
                   Status = true,
                   KorisnickoIme = "korisnik",
                   LozinkaHash = Service.KorisniciService.GenerateHash("1wQEjdSFeZttx6dlvEDjOg==", "test"),
                   LozinkaSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                   DatumRodjenja = new DateTime(2000, 12,24),
                   Aktivnost = true,
                   TransakcijskiRacun = "5555 5555 5555 4444"

               },
               new()
               {
                   KorisnikId = 3,
                   DrzavaId = 1,
                   PozicijaId = 5,
                   Ime = "Zaposlenik",
                   Prezime = "Zaposlenik",
                   Email = "zaposlenik@gmail.com",
                   Telefon = "061-336-026",
                   Status = true,
                   KorisnickoIme = "zaposlenik",
                   LozinkaHash = Service.KorisniciService.GenerateHash("1wQEjdSFeZttx6dlvEDjOg==", "test"),
                   LozinkaSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                   DatumRodjenja = new DateTime(2000,12,24),
                   Aktivnost = true,
                   TransakcijskiRacun= "4242 4242 4242 4242"

               },
               new()
               {
                   KorisnikId = 4,
                   DrzavaId = 1,
                   PozicijaId = 6,
                   Ime = "Operater",
                   Prezime = "Operater",
                   Email = "operater@gmail.com",
                   Telefon = "061-336-026",
                   Status = true,
                   KorisnickoIme = "operater",
                   LozinkaHash = Service.KorisniciService.GenerateHash("1wQEjdSFeZttx6dlvEDjOg==", "test"),
                   LozinkaSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                   DatumRodjenja = new DateTime(2000,12,24),
                   Aktivnost = true,
                   TransakcijskiRacun= "6011 0000 0000 0004"
               }); 
        }
        private void SeedIzvjestaj(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Izvjestaj>().HasData(
               new()
               {
                   IzvjestajId = 1,
                   BrojIntervencija = 32,
                   NajPosMjesto = "Mostar",
                   CijenaUtrosAlata = 800,
                   NajOprema = "Ruter",
                   Datum = new DateTime(2024, 1, 31, 16, 00, 0),

               },
               new()
               {
                   IzvjestajId = 2,
                   BrojIntervencija = 29,
                   NajPosMjesto = "Mostar",
                   CijenaUtrosAlata = 870,
                   NajOprema = "Modem",
                   Datum = new DateTime(2024, 2, 29, 16, 00, 0),
               },
               new()
               {
                   IzvjestajId = 3,
                   BrojIntervencija = 26,
                   NajPosMjesto = "Mostar",
                   CijenaUtrosAlata = 780,
                   NajOprema = "Modem",
                   Datum = new DateTime(2024, 3, 31, 16, 00, 0),
               });
        }
        private void SeedKorisniciUloge(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<KorisniciUloge>().HasData(
               new()
               {
                   KorisnikUlogaId = 1,
                   KorisnikId = 1,
                   UlogaId = 1,
                   DatumIzmjene = DateTime.Now,

               },
               new()
               {
                   KorisnikUlogaId = 2,
                   KorisnikId = 2,
                   UlogaId =2,
                   DatumIzmjene = DateTime.Now,
               },
               new()
               {
                   KorisnikUlogaId = 3,
                   KorisnikId = 3,
                   UlogaId = 3,
                   DatumIzmjene = DateTime.Now,

               },
               new()
               {
                   KorisnikUlogaId = 4,
                   KorisnikId = 4,
                   UlogaId = 4,
                   DatumIzmjene = DateTime.Now,
               });
        }
        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    if (!optionsBuilder.IsConfigured)
        //    {
        //        //#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        //        optionsBuilder.UseSqlServer("Server=.; Database=p2089; Trusted_Connection=true; MultipleActiveResultSets=true");
        //    }
        //}
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
            modelBuilder.Entity<Prijava>(entity =>
            {
                entity.HasKey(e => e.PrijavaId);
                entity.ToTable("Prijava");
                entity.Property(e => e.PrijavaId).HasColumnName("PrijavaId");
                entity.Property(e => e.Ime).HasMaxLength(50);
                entity.Property(e => e.Prezime).HasMaxLength(50);
                entity.Property(e => e.Email).HasMaxLength(50);
                entity.Property(e => e.BrojTelefona).HasMaxLength(50);
                entity.Property(e => e.KonkursId).HasColumnName("KonkursId");


                entity.HasOne(d => d.Konkurs)
                    .WithMany(p => p.Prijava)
                    .HasForeignKey(d => d.KonkursId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Prijave_Konkursi");
            });
            modelBuilder.Entity<Konkurs>(entity =>
            {
                entity.HasKey(e => e.KonkursId);
                entity.ToTable("Konkurs");
                entity.Property(e => e.KonkursId).HasColumnName("KonkursId");
                entity.Property(e => e.BrojIzvrsitelja).HasColumnName("BrojIzvrsitelja");
                entity.Property(e => e.DatumZavrsetka).HasColumnType("datetime");
                entity.Property(e => e.TrazenaPozicija).HasMaxLength(55);
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
                entity.Property(e => e.Sadrzaj);
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



            //modelBuilder.UseCollation("Latin1_General_CI_AI");

            
            OnModelCreatingPartial(modelBuilder);
            SeedData(modelBuilder);
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
