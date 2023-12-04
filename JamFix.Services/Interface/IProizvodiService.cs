using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;

namespace JamFix.Services.Interface
{
    public interface IProizvodiService : ICRUDService<Proizvodi, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        Task<Proizvodi> Activate(int id);
        Task<Proizvodi> Hide(int id);
        Task<List<string>> AllowedActions(int id);
        //List<Proizvodi> Recommend(int id);
    }
}
