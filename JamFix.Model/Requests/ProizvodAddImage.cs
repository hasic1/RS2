using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Model.Requests
{
    public  class ProizvodAddImage
    {
        public IFormFile Slika { set; get; }
    }
}
