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
            migrationBuilder.DropColumn(
                name: "LokacijaSlike",
                table: "Proizvod");

            migrationBuilder.AddColumn<byte[]>(
                name: "Slika",
                table: "Proizvod",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.AddColumn<byte[]>(
                name: "SlikaThumb",
                table: "Proizvod",
                type: "varbinary(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Slika",
                table: "Proizvod");

            migrationBuilder.DropColumn(
                name: "SlikaThumb",
                table: "Proizvod");

            migrationBuilder.AddColumn<string>(
                name: "LokacijaSlike",
                table: "Proizvod",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
