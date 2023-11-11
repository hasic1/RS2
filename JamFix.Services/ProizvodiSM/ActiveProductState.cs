using AutoMapper;
using JamFix.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.ProizvodiSM
{
    public class ActiveProductState : BaseState
    {
        public ActiveProductState(IServiceProvider serviceProvider, Context context, IMapper mapper) : base(serviceProvider,context, mapper)
        {
        }
    }
}
