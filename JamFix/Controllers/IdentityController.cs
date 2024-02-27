using JamFix.Handler;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Text.Json;

namespace JamFix.Controllers
{
    public class IdentityController : ControllerBase
    {
        IKorisniciService _korisniciService;
        private const string TokenSecret = "kljuc";
        private static readonly TimeSpan TokenLifetime = TimeSpan.FromMinutes(15);

        public IdentityController(IKorisniciService korisniciService)
        {
            _korisniciService = korisniciService;
        }

        [HttpPost("token")]
        public async Task<IActionResult> GenerateTokenAsync([FromBody]TokenGenerationRequest request)
        {

            var user = await _korisniciService.Login(request.username, request.password);

            if (user == null)
            {
                return BadRequest("Incorrect username or password");
            }
            else
            {
                user.Uloge = _korisniciService.GetRolesForUser(user.KorisnikId);

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(TokenSecret.PadRight(32)));
                var userRoles = user.KorisniciUloge.Select(ku => ku.Uloga.ToString());
                var roleClaims = userRoles.Select(role => new Claim("role", role)).ToList();
                var claims = new List<Claim>
                {
                   new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                   new(JwtRegisteredClaimNames.Sub, user.KorisnickoIme),
                   new(ClaimTypes.MobilePhone, user.Telefon),
                   new(ClaimTypes.NameIdentifier, user.KorisnikId.ToString()),
                   new(ClaimTypes.Name, user.Ime), 
                   new(ClaimTypes.Surname, user.Prezime), 
                   new(ClaimTypes.Email, user.Email),
                   new(ClaimTypes.Rsa, user.Telefon), 
                   new(ClaimTypes.Actor, user.KorisnickoIme),
                   new(ClaimTypes.Upn, user.PozicijaId.ToString()),
                   new(ClaimTypes.SerialNumber, user.DrzavaId.ToString()),

                   new(ClaimTypes.Role, string.Join(",", user.Uloge.Select(role => role.ToString()))),

                };

                claims.AddRange(roleClaims);

                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(claims),
                    Expires = DateTime.UtcNow.Add(TokenLifetime),
                    SigningCredentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256)
                };
                var token = tokenHandler.CreateToken(tokenDescriptor);

                var jwt = tokenHandler.WriteToken(token);
                return Ok(jwt);
            }
        }
    }
}
