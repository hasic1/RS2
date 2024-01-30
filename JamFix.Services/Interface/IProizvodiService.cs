using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using static JamFix.Services.Service.ProizvodiService;

namespace JamFix.Services.Interface
{
    public interface IProizvodiService : ICRUDService<Proizvodi, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        Task<Proizvodi> Activate(int id);
        Task<Proizvodi> Hide(int id);
        Task<List<string>> AllowedActions(int id);
        RecommendationResponse<Proizvodi> Recommend(int id);
        Task<PagedResult<Proizvodi>> GetTopRatedProducts(int numberOfTopProducts);
    }
}
