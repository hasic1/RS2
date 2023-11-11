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
        public Context _context;
        public IMapper _mapper { get; set; }
        public IServiceProvider _serviceProvider { get; set; }
        public BaseState(IServiceProvider serviceProvider, Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Task<Proizvodi> Insert(ProizvodiInsertRequest request)
        {
            throw new Exception("Not allowed");
        }
        public virtual Task<Proizvodi> Update(int id,ProizvodiUpdateRequest request)
        {
            throw new Exception("Not allowed");
        }
        public virtual Task<Proizvodi> Activate(int id)
        {
            throw new Exception("Not allowed");
        }
        public virtual Task<Proizvodi> Hide(int id)
        {
            throw new Exception("Not allowed");
        }
        public virtual Task<Proizvodi> Delete(int id)
        {
            throw new Exception("Not allowed");
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
                    throw new Exception("Ne radi");
            }
        }
    }
}
