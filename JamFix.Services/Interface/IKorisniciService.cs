using JamFix.Model.Modeli;
using JamFix.Model.Requests;

namespace JamFix.Services.Interface
{
    public interface IKorisniciService
    {
        List<Korisnici> Get();
        Korisnici Insert(KorisniciInsertRequest request);
    }
}
