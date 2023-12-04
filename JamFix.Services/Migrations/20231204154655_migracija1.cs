using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JamFix.Services.Migrations
{
    /// <inheritdoc />
    public partial class migracija1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "NosilacPosla",
                table: "RadniNalog",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NosilacPosla",
                table: "RadniNalog");
        }
    }
}
