using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;

namespace JamFix.Services.Interface
{
    public interface IKorisniciService : ICRUDService<Korisnici, KorisniciSO, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public Task<Korisnici> Login(string username, string password); 
    }
}
