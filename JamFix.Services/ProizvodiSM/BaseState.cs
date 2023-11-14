using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.ProizvodiSM
{
    public class BaseState
    {
        public Context _context { get; set; } = null;
        public Proizvod CurrentEntity { get; set; }
        public string CurrentState { get; set; }
        public IMapper _mapper { get; set; }
        public IServiceProvider _serviceProvider { get; set; }

        public BaseState(IServiceProvider serviceProvider, Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Proizvodi Insert(ProizvodiInsertRequest request)
        {
            throw new UserException("Not allowed");
        }
        public virtual Proizvodi Update(int id, ProizvodiUpdateRequest request)
        {
            throw new UserException("Not allowed");
        }
        public virtual void Activate()
        {
            throw new UserException("Not allowed");
        }
        public virtual void Hide()
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Proizvodi> Delete(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual List<string> AllowedActions()
        {
            return new List<string>();
        }
        public BaseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return _serviceProvider.GetService<InitialProductState>();
                    break;
                case "draft":
                    return _serviceProvider.GetService<DraftProductState>();
                case "active":
                    return _serviceProvider.GetService<ActiveProductState>();
                default:
                    throw new UserException("Ne radi");
            }
        }
    }
}
