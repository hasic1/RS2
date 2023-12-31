﻿using JamFix.Handler;
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
                    new(JwtRegisteredClaimNames.Sub, request.username),
                    //new(JwtRegisteredClaimNames.Email, request.Email),
                    //new("userid", request.UserId.ToString()),
                    new(ClaimTypes.Role, string.Join(",", user.Uloge.Select(role => role.ToString()))),
                };

                // Dodavanje uloga u listu claim-ova
                claims.AddRange(roleClaims);

                //foreach (var claimPair in request.CustomClaims)
                //{
                //    var jsonElement = (JsonElement)claimPair.Value;
                //    var valueType = jsonElement.ValueKind switch
                //    {
                //        JsonValueKind.True => ClaimValueTypes.Boolean,
                //        JsonValueKind.False => ClaimValueTypes.Boolean,
                //        JsonValueKind.Number => ClaimValueTypes.Double,
                //        _ => ClaimValueTypes.String
                //    };
                //    var claim = new Claim(claimPair.Key, claimPair.Value.ToString()!, valueType);
                //    claims.Add(claim);
                //}
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(claims),
                    Expires = DateTime.UtcNow.Add(TokenLifetime),
                    Issuer = "https://id.nickchapsas.com",
                    Audience = "https://movies.nickchapsas.com",
                    SigningCredentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256)
                };
                var token = tokenHandler.CreateToken(tokenDescriptor);

                var jwt = tokenHandler.WriteToken(token);
                return Ok(jwt);
            }
        }
    }
}
