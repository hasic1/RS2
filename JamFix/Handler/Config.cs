namespace JamFix.Handler
{
    public class Config
    {
        public static string AplikacijURL = "https://localhost:7097/";
        public static string Slike => "profile_images/";
        public static string SlikeURL => AplikacijURL + Slike;
        public static string SlikeFolder => "wwwroot/" + Slike;
    }
}
