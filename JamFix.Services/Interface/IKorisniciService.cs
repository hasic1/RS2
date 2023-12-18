using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Service.Helper;

namespace JamFix.Services.Interface
{
    public interface IKorisniciService : ICRUDService<Korisnici, KorisniciSO, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        Task<Korisnici> Login(string username, string password);
        Task<string> GetUlogaById(int korisnikId);
        List<UserRole> GetRolesForUser(int userId);
    }
}
