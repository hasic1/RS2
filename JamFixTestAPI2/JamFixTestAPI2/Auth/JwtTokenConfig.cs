﻿namespace JamFixTestAPI2.Auth
{
    public class JwtTokenConfig
    {
        public string Issuer { get; set; } = null!;
        public string Audience { get; set; } = null!;
        public string SecretKey { get; set; } = null!;
        public int Duration { get; set; }
    }
}
