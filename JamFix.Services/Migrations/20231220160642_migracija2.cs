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
                name: "FK_Zahtjev_StatusZahtjeva_StatusZahtjevaId",
                table: "Zahtjev");

            migrationBuilder.DropIndex(
                name: "IX_Zahtjev_StatusZahtjevaId",
                table: "Zahtjev");

            migrationBuilder.DropColumn(
                name: "StatusZahtjevaId",
                table: "Zahtjev");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "StatusZahtjevaId",
                table: "Zahtjev",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Zahtjev_StatusZahtjevaId",
                table: "Zahtjev",
                column: "StatusZahtjevaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Zahtjev_StatusZahtjeva_StatusZahtjevaId",
                table: "Zahtjev",
                column: "StatusZahtjevaId",
                principalTable: "StatusZahtjeva",
                principalColumn: "StatusZahtjevaId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
