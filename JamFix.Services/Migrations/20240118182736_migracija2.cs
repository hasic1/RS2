using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JamFix.Services.Migrations
{
    /// <inheritdoc />
    public partial class migracija2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Kupci",
                table: "Ocjene");

            migrationBuilder.DropTable(
                name: "Kupci");

            migrationBuilder.DropIndex(
                name: "IX_Ocjene_KupacID",
                table: "Ocjene");

            migrationBuilder.RenameColumn(
                name: "KupacID",
                table: "Ocjene",
                newName: "KupacId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "KupacId",
                table: "Ocjene",
                newName: "KupacID");

            migrationBuilder.CreateTable(
                name: "Kupci",
                columns: table => new
                {
                    KupacID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumRegistracije = table.Column<DateTime>(type: "datetime", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kupci", x => x.KupacID);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_KupacID",
                table: "Ocjene",
                column: "KupacID");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Kupci",
                table: "Ocjene",
                column: "KupacID",
                principalTable: "Kupci",
                principalColumn: "KupacID");
        }
    }
}
