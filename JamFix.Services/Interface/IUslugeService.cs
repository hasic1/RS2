using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Service;

namespace JamFix.Services.Interface
{
    public interface IUslugeService : ICRUDService<Usluga, UslugeSO,UslugaInsertRequest,UslugaUpdateRequest>
    {
        public bool SetPaid(int id, bool paid, string chargeId);

    }
}
