using JamFix.Model.Modeli;
using JamFix.Model.Requests;

namespace JamFix.Services.Interface
{
    public interface IProizvodiService /*: ICRUDService<Proizvodi, ProizvodiSearchObject, ProizvodiInsertRequest, ProizvodiUpdateRequest>*/
    {
        List<Proizvodi> Get();
        Proizvodi Insert(ProizvodiInsertRequest request);
    }
}
