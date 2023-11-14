using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;

namespace JamFix.Services.Interface
{
    public interface IProizvodiService : ICRUDService<Proizvodi, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        Proizvodi Activate(int id);
        List<string> AllowedActions(int id);

        List<Proizvodi> Recommend(int id);
        Proizvodi Hide(int id);
    }
}
