using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;

namespace JamFix.Services.Interface
{
    public interface IKorisniciService
    {
        Task<List<Korisnici>> Get();
        Korisnici Insert(KorisniciInsertRequest request);
        Korisnici Update(int id,KorisniciUpdateRequest request);
        List<Korisnik> Delete(int id);
    }
}
