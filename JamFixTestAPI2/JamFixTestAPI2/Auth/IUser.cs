namespace JamFixTestAPI2.Auth
{
    public interface IUser
    {
        Task<Korisnici> Login(string username, string password);
    }
}
