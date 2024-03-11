using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace JamFix.Services.Migrations
{
    /// <inheritdoc />
    public partial class initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Drzava",
                columns: table => new
                {
                    DrzavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Drzava", x => x.DrzavaId);
                });

            migrationBuilder.CreateTable(
                name: "Izvjestaj",
                columns: table => new
                {
                    IzvjestajId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BrojIntervencija = table.Column<int>(type: "int", nullable: false),
                    NajPosMjesto = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CijenaUtrosAlata = table.Column<int>(type: "int", nullable: false),
                    NajOprema = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Izvjestaj", x => x.IzvjestajId);
                });

            migrationBuilder.CreateTable(
                name: "Novosti",
                columns: table => new
                {
                    NovostId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", maxLength: 5000, nullable: false),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Novosti", x => x.NovostId);
                });

            migrationBuilder.CreateTable(
                name: "Pozicija",
                columns: table => new
                {
                    PozicijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Pozicija", x => x.PozicijaId);
                });

            migrationBuilder.CreateTable(
                name: "RadniNalog",
                columns: table => new
                {
                    NalogId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NosilacPosla = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OpisPrijavljenog = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    OpisUradjenog = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    ImePrezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Mjesto = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Kolicina = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RadniNalog", x => x.NalogId);
                });

            migrationBuilder.CreateTable(
                name: "StatusZahtjeva",
                columns: table => new
                {
                    StatusZahtjevaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StatusZahtjeva", x => x.StatusZahtjevaId);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "Usluge",
                columns: table => new
                {
                    UslugaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ImePrezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    BrojRacuna = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    NazivPaketa = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Placeno = table.Column<bool>(type: "bit", nullable: false),
                    ProizvodId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usluge", x => x.UslugaId);
                });

            migrationBuilder.CreateTable(
                name: "VrsteProizvoda",
                columns: table => new
                {
                    VrstaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VrsteProizvoda", x => x.VrstaID);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DrzavaId = table.Column<int>(type: "int", nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: false, defaultValueSql: "((1))"),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DatumZaposlenja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PozicijaId = table.Column<int>(type: "int", nullable: false),
                    Aktivnost = table.Column<bool>(type: "bit", nullable: false),
                    TransakcijskiRacun = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikID);
                    table.ForeignKey(
                        name: "FK_Korisnik_Drzava",
                        column: x => x.DrzavaId,
                        principalTable: "Drzava",
                        principalColumn: "DrzavaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Korisnik_Pozicija_PozicijaId",
                        column: x => x.PozicijaId,
                        principalTable: "Pozicija",
                        principalColumn: "PozicijaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Zahtjev",
                columns: table => new
                {
                    ZahtjevId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ImePrezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BrojTelefona = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumVrijeme = table.Column<DateTime>(type: "datetime2", nullable: false),
                    HitnaIntervencija = table.Column<bool>(type: "bit", nullable: false),
                    StatusZahtjevaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zahtjev", x => x.ZahtjevId);
                    table.ForeignKey(
                        name: "FK_Zahtjev_StatusZahtjeva",
                        column: x => x.StatusZahtjevaId,
                        principalTable: "StatusZahtjeva",
                        principalColumn: "StatusZahtjevaId");
                });

            migrationBuilder.CreateTable(
                name: "Proizvod",
                columns: table => new
                {
                    ProizvodID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    VrstaID = table.Column<int>(type: "int", nullable: false),
                    NazivProizvoda = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    SlikaThumb = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    Snizen = table.Column<bool>(type: "bit", nullable: false, defaultValueSql: "((1))"),
                    StateMachine = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BrzinaInterneta = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BrojMinuta = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BrojKanala = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Proizvod", x => x.ProizvodID);
                    table.ForeignKey(
                        name: "FK_Proizvodi_VrsteProizvoda",
                        column: x => x.VrstaID,
                        principalTable: "VrsteProizvoda",
                        principalColumn: "VrstaID");
                });

            migrationBuilder.CreateTable(
                name: "KorisniciUloge",
                columns: table => new
                {
                    KorisnikUlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    UlogaID = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisniciUloge", x => x.KorisnikUlogaID);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Korisnici",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Uloge",
                        column: x => x.UlogaID,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                });

            migrationBuilder.CreateTable(
                name: "Ocjene",
                columns: table => new
                {
                    OcjenaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProizvodID = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Ocjena = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocjene", x => x.OcjenaID);
                    table.ForeignKey(
                        name: "FK_Ocjene_Proizvodi",
                        column: x => x.ProizvodID,
                        principalTable: "Proizvod",
                        principalColumn: "ProizvodID");
                });

            migrationBuilder.CreateTable(
                name: "UslugaStavke",
                columns: table => new
                {
                    UslugaStavkeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProizvodID = table.Column<int>(type: "int", nullable: false),
                    UslugeID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UslugaStavke", x => x.UslugaStavkeID);
                    table.ForeignKey(
                        name: "FK_UslugaStavke_Proizvod",
                        column: x => x.ProizvodID,
                        principalTable: "Proizvod",
                        principalColumn: "ProizvodID");
                    table.ForeignKey(
                        name: "FK_UslugaStavke_Usluge",
                        column: x => x.UslugeID,
                        principalTable: "Usluge",
                        principalColumn: "UslugaId");
                });

            migrationBuilder.InsertData(
                table: "Drzava",
                columns: new[] { "DrzavaId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Bosnia and Herzegovina" },
                    { 2, "Croatia" },
                    { 3, "Serbia" },
                    { 4, "Montenegro" },
                    { 5, "Slovenia" },
                    { 6, "Austria" }
                });

            migrationBuilder.InsertData(
                table: "Izvjestaj",
                columns: new[] { "IzvjestajId", "BrojIntervencija", "CijenaUtrosAlata", "Datum", "NajOprema", "NajPosMjesto" },
                values: new object[,]
                {
                    { 1, 32, 800, new DateTime(2024, 1, 31, 16, 0, 0, 0, DateTimeKind.Unspecified), "Ruter", "Mostar" },
                    { 2, 29, 870, new DateTime(2024, 2, 29, 16, 0, 0, 0, DateTimeKind.Unspecified), "Modem", "Mostar" },
                    { 3, 26, 780, new DateTime(2024, 3, 31, 16, 0, 0, 0, DateTimeKind.Unspecified), "Modem", "Mostar" }
                });

            migrationBuilder.InsertData(
                table: "Novosti",
                columns: new[] { "NovostId", "Naslov", "Sadrzaj", "Slika" },
                values: new object[,]
                {
                    { 1, "Reakcije na pad Fejsa: \"Zuckerberg nas sve izbacio\"", "MNOŠTVO korisnika Facebooka javlja da su \"izbačeni\" sa svog računa. Točnije, ako pokušate ući na svoj Facebook profil, vrlo vjerojatno ćete vidjeti da ste s njega izlogirani i da se ne možete ulogirati natrag. Nedugo zatim sličan problem pojavio se i na Instagramu.\r\n\r\nReakcije na pad društvene mreže preplavile su X (bivši Twitter), mrežu Elona Muska.\r\n\r\n\"Jesu li svi ostali upravo izbačeni iz svojih Facebook računa i ne mogu nazad?\", \"Znači, sad smo svi na X-u da javimo da je pao Fejs?\", \"Ok, što se mene tiče, ne moraju me ni vraćati\", \"Zapravo bi bilo super da me nikad ne ulogira natrag\", \"Zuckerberg nas sve izbacio\", šale se korisnici X-a", null },
                    { 2, "Nova konkurencija ChatGPT-ju: Anthropic predstavio svoj najbrži i najmoćniji chatbot", "U ponedjeljak su službeno predstavili svoju 'obitelj' modela Claude 3, koja uključuje tri najsuvremenija modela (prema uzlaznom redoslijedu mogućnosti): Claude 3 Haiku, Claude 3 Sonnet i Claude 3 Opus.\nAnthropic je tvrdio da je najsposobniji model, Opus, nadmašio OpenAI-jev GPT-4 i Googleov Gemini Ultra na testovima kao što su rasuđivanje, osnovna matematika te znanje na dodiplomskoj i diplomskoj razini. Opus i Sonnet su sada dostupni za korištenje u claude.ai, dok je Claude API dostupan u 159 zemalja.\r\n\r\nTvrtka je rekla da će kompaktniji modeli, Sonnet i Haiku, uskoro biti pušteni u prodaju. Novi chatbot može sažeti približno 200.000 riječi, dok ChatGPT može sažeti samo oko 3.000. Novi modeli također omogućuju učitavanje slika i dokumenata.", null },
                    { 3, "Amazonov oporavak poslovanja poguran otkazima", "Nakon teške 2022. koja je rezultirala otpuštanjem tisuća zaposlenika u Amazonu i rezanjem troškova gdje je to bilo moguće, najveći svjetski online trgovac snažno se oporavio u 2023. U četvrtak je tvrtka izvijestila o najvišoj operativnoj dobiti u povijesti za proteklo blagdansko tromjesečje, kao prodaja značajno porastao u svakom od svojih operativnih segmenata. Ipak, što je još važnije, čini se da su prošlogodišnje agresivne mjere rezanja troškova urodile plodom jer je Amazonova operativna marža porasla s 1,8 posto u četvrtom tromjesečju 2022. na 7,8 posto u prošlom tromjesečju.\r\n\r\n\"Ovo četvrto tromjesečje bilo je rekordna sezona blagdanske kupnje i zatvorila je snažnu 2023. za Amazon\", rekao je izvršni direktor Amazona Andy Jassy u izjavi. \"Iako smo ostvarili značajne prihode, prihode od poslovanja i napredak u slobodnom novčanom tijeku, ono čime smo najviše zadovoljni je nastavak poboljšanja izuma i korisničkog iskustva u našim tvrtkama.\" Za cijelu godinu, neto prodaja porasla je 12 posto na 574,8 milijardi dolara, dok je neto prihod skočio natrag na 30,4 milijarde dolara s gubitka od 2,7 milijardi dolara u 2022.\r\n\r\nJedna stvar koja nas je izdvojila iz rezultata je rast Amazonovog oglašivačkog poslovanja. U prošlom tromjesečju, prodaja oglasa tvrtke iznosila je 14,7 milijardi dolara, čime je ukupni iznos za godinu blizu 50 milijardi dolara. S obzirom na to da je tvrtka upravo pokrenula oglase na svojoj usluzi streaminga Prime Video, možemo očekivati da će ta često zanemarena strana Amazonovog poslovanja dodatno rasti 2024. i kasnije.", null },
                    { 4, "Bivši direktori Twittera podnijeli milijunsku tužbu protiv Elona Muska", "Tužbu su pokrenuli bivši izvršni direktor Parag Agrawal, Ned Segal, Twitterov bivši financijski direktor, Vijaya Gadde, bivša glavna pravna službenica i Sean Edgett, bivši glavni savjetnik\r\n\r\nČetiri bivša glavna rukovoditelja Twittera, uključujući bivšeg izvršnog direktora Paraga Agrawala, tuže Elona Muska za više od 128 milijuna dolara zbog neplaćenih otpremnina, navodi se u tužbi podnesenoj u ponedjeljak.\nTužba podnesena saveznom sudu u San Franciscu posljednja je u nizu pravnih izazova s ​​kojima se Musk suočava nakon što je u listopadu 2022. kupio društvenu mrežu za 44 milijarde dolara i kasnije je preimenovao u X.", null },
                    { 5, "Apple odustaje od projekta EV", "Apple je odustao od višegodišnjeg napora da napravi svoje električno vozilo. Prema medijskim izvješćima, barem neki zaposlenici iz tog odjela bit će premješteni u timove za umjetnu inteligenciju.\r\n\r\nApple je interno objavio da zatvara projekt električnih vozila koji ima gotovo 2000 zaposlenika. Objava je pripisana potpredsjedniku Kevinu Lynchu i COO-u Jeffu Williamsu. Lynch je nadgledao projekt električnih vozila, koji je poznat kao Grupa za posebne projekte.\r\n\r\nOdluka o zatvaranju projekta vrijednog više milijardi dolara donesena je tijekom proteklih nekoliko tjedana. Apple je zamislio da će cijena vozila biti oko 100.000 dolara. Pričalo se da je Apple zainteresiran za izradu električnog vozila još 2015. nakon što je tadašnji viši potpredsjednik operacija Williams na konferenciji izjavio da je automobil ultimativni mobilni uređaj.", null }
                });

            migrationBuilder.InsertData(
                table: "Pozicija",
                columns: new[] { "PozicijaId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Direktor" },
                    { 2, "Predsjednik" },
                    { 3, "Direktor odjela" },
                    { 4, "Menadzer" },
                    { 5, "Supervizor" },
                    { 6, "User" }
                });

            migrationBuilder.InsertData(
                table: "RadniNalog",
                columns: new[] { "NalogId", "Adresa", "Datum", "ImePrezime", "Kolicina", "Mjesto", "Naziv", "NosilacPosla", "OpisPrijavljenog", "OpisUradjenog", "Telefon" },
                values: new object[,]
                {
                    { 1, "Domanovici b.b", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1000), "Bakir Hasic", 1, "Mostar", "Neki naziv", "Bakir Hasic", "Modem u kvaru", "Zamjena modema", "061-330-326" },
                    { 2, "Domanovici b.b", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1004), "Arman Hasic", 1, "Mostar", "Ruter", "Amar Hasic", "Ruter u kvaru", "Zamijena rutera", "061-336-026" },
                    { 3, "Mostar", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1006), "Dzemal Causevic", 2, "Mostar", "Kablovi", "Ramiz Dizdar", "Problemi sa konekcijom", "Zamijena kablova", "061-202-330" }
                });

            migrationBuilder.InsertData(
                table: "StatusZahtjeva",
                columns: new[] { "StatusZahtjevaId", "Opis" },
                values: new object[,]
                {
                    { 1, "Zaprimljen " },
                    { 2, "U obradi" },
                    { 3, "Rijesen" }
                });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "UlogaId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Administrator", "Administrator" },
                    { 2, "Korisnik", "Korisnik" },
                    { 3, "Zaposlenik", "Zaposlenik" },
                    { 4, "Operater", "Operater" }
                });

            migrationBuilder.InsertData(
                table: "Usluge",
                columns: new[] { "UslugaId", "BrojRacuna", "Cijena", "Datum", "ImePrezime", "NazivPaketa", "Placeno", "ProizvodId" },
                values: new object[,]
                {
                    { 1, "1234-1234-1234-1234", "123", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1058), "Bakir Hasic", "Trio paket", true, 1 },
                    { 2, "1235-1235-1235-1235", "123", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1061), "Anel Hodzic", "Trio paket", true, 1 },
                    { 3, "1236-1236-1236-1236", "123", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1063), "Hamza Dzeko", "Trio paket", true, 1 }
                });

            migrationBuilder.InsertData(
                table: "VrsteProizvoda",
                columns: new[] { "VrstaID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Paket preplate" },
                    { 2, "Tarifa" }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikID", "Aktivnost", "DatumRodjenja", "DatumZaposlenja", "DrzavaId", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "PozicijaId", "Prezime", "Status", "Telefon", "TransakcijskiRacun" },
                values: new object[,]
                {
                    { 1, true, new DateTime(2024, 12, 24, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "admin@gmail.com", "Admin", "admin", "PEPuXC0FRTDz8Ep3LtkrCzwN0Kw=", "1wQEjdSFeZttx6dlvEDjOg==", 1, "Admin", true, "061-336-026", "4000 0000 0000 0002" },
                    { 2, true, new DateTime(2024, 12, 24, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "korisnik@gmail.com", "Korisnik", "korisnik", "PEPuXC0FRTDz8Ep3LtkrCzwN0Kw=", "1wQEjdSFeZttx6dlvEDjOg==", 2, "Korisnik", true, "061-336-026", "5555 5555 5555 4444" },
                    { 3, true, new DateTime(2024, 12, 24, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "zaposlenik@gmail.com", "Zaposlenik", "zaposlenik", "PEPuXC0FRTDz8Ep3LtkrCzwN0Kw=", "1wQEjdSFeZttx6dlvEDjOg==", 5, "Zaposlenik", true, "061-336-026", "4242 4242 4242 4242" },
                    { 4, true, new DateTime(2024, 12, 24, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "operater@gmail.com", "Operater", "operater", "PEPuXC0FRTDz8Ep3LtkrCzwN0Kw=", "1wQEjdSFeZttx6dlvEDjOg==", 6, "Operater", true, "061-336-026", "6011 0000 0000 0004" }
                });

            migrationBuilder.InsertData(
                table: "Proizvod",
                columns: new[] { "ProizvodID", "BrojKanala", "BrojMinuta", "BrzinaInterneta", "Cijena", "NazivProizvoda", "Opis", "Slika", "SlikaThumb", "Snizen", "StateMachine", "VrstaID" },
                values: new object[,]
                {
                    { 1, "500", "1000", "55", 65m, "Trio start paket", "Za mala kucanstva", null, null, true, null, 1 },
                    { 2, "750", "1500", "75", 75m, "Trio paket", "Za kucanstva", null, null, true, null, 1 },
                    { 3, "1000", "2000", "100", 90m, "Trio super paket", "Najbolje u ponudi", null, null, true, null, 1 },
                    { 4, "500", "0", "25", 40m, "Duo start paket", "Najbolje za mala kucanstva", null, null, true, null, 1 },
                    { 5, "600", "0", "50", 50m, "Duo paket", "Novo u ponudi", null, null, true, null, 1 },
                    { 6, "1000", "0", "75", 65m, "Duo super paket", "Najbolje u ponudi", null, null, true, null, 1 }
                });

            migrationBuilder.InsertData(
                table: "Zahtjev",
                columns: new[] { "ZahtjevId", "Adresa", "BrojTelefona", "DatumVrijeme", "HitnaIntervencija", "ImePrezime", "Opis", "StatusZahtjevaId" },
                values: new object[,]
                {
                    { 1, "Domanovici", "061-336-026", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1104), true, "Bakir Hasic", "Moj ruter je u kvaru", 1 },
                    { 2, "Mostar", "062-223-322", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1106), false, "Arman Hodzic", "Moj modem je u kvaru", 1 },
                    { 3, "Mostar", "062-123-321", new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(1108), false, "Amar Hodzic", "Moj modem je u kvaru", 1 }
                });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "KorisnikUlogaID", "DatumIzmjene", "KorisnikID", "UlogaID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(592), 1, 1 },
                    { 2, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(623), 2, 2 },
                    { 3, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(626), 3, 3 },
                    { 4, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(627), 4, 4 }
                });

            migrationBuilder.InsertData(
                table: "Ocjene",
                columns: new[] { "OcjenaID", "Datum", "Ocjena", "ProizvodID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(942), 3, 1 },
                    { 2, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(945), 5, 1 },
                    { 3, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(946), 3, 2 },
                    { 4, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(948), 4, 2 },
                    { 5, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(949), 5, 3 },
                    { 6, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(951), 4, 3 },
                    { 7, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(952), 4, 4 },
                    { 8, new DateTime(2024, 3, 11, 15, 34, 58, 107, DateTimeKind.Local).AddTicks(954), 4, 5 }
                });

            migrationBuilder.InsertData(
                table: "UslugaStavke",
                columns: new[] { "UslugaStavkeID", "ProizvodID", "UslugeID" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 3, 1 },
                    { 3, 6, 1 },
                    { 4, 2, 2 },
                    { 5, 4, 2 },
                    { 6, 3, 3 },
                    { 7, 5, 3 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_KorisnikID",
                table: "KorisniciUloge",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_UlogaID",
                table: "KorisniciUloge",
                column: "UlogaID");

            migrationBuilder.CreateIndex(
                name: "CS_Email",
                table: "Korisnik",
                column: "Email",
                unique: true,
                filter: "[Email] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "CS_KorisnickoIme",
                table: "Korisnik",
                column: "KorisnickoIme",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_DrzavaId",
                table: "Korisnik",
                column: "DrzavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_PozicijaId",
                table: "Korisnik",
                column: "PozicijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_ProizvodID",
                table: "Ocjene",
                column: "ProizvodID");

            migrationBuilder.CreateIndex(
                name: "IX_Proizvod_VrstaID",
                table: "Proizvod",
                column: "VrstaID");

            migrationBuilder.CreateIndex(
                name: "IX_UslugaStavke_ProizvodID",
                table: "UslugaStavke",
                column: "ProizvodID");

            migrationBuilder.CreateIndex(
                name: "IX_UslugaStavke_UslugeID",
                table: "UslugaStavke",
                column: "UslugeID");

            migrationBuilder.CreateIndex(
                name: "IX_Zahtjev_StatusZahtjevaId",
                table: "Zahtjev",
                column: "StatusZahtjevaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Izvjestaj");

            migrationBuilder.DropTable(
                name: "KorisniciUloge");

            migrationBuilder.DropTable(
                name: "Novosti");

            migrationBuilder.DropTable(
                name: "Ocjene");

            migrationBuilder.DropTable(
                name: "RadniNalog");

            migrationBuilder.DropTable(
                name: "UslugaStavke");

            migrationBuilder.DropTable(
                name: "Zahtjev");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Proizvod");

            migrationBuilder.DropTable(
                name: "Usluge");

            migrationBuilder.DropTable(
                name: "StatusZahtjeva");

            migrationBuilder.DropTable(
                name: "Drzava");

            migrationBuilder.DropTable(
                name: "Pozicija");

            migrationBuilder.DropTable(
                name: "VrsteProizvoda");
        }
    }
}
