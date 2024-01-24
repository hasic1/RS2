using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JamFix.Services.Migrations
{
    /// <inheritdoc />
    public partial class migracija3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.CreateIndex(
                name: "IX_UslugaStavke_ProizvodID",
                table: "UslugaStavke",
                column: "ProizvodID");

            migrationBuilder.CreateIndex(
                name: "IX_UslugaStavke_UslugeID",
                table: "UslugaStavke",
                column: "UslugeID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UslugaStavke");
        }
    }
}
