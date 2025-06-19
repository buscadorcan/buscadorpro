using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedApp.Dtos
{
    public class FiltrosBusquedaDto
    {
        public bool ExactaBuscar { get; set; }
        public string TextoBuscar { get; set; } = "";
        public List<string> FiltroPais { get; set; } = new();
        public List<string> FiltroOna { get; set; } = new();
        public List<string> FiltroNorma { get; set; } = new();
        public List<string> FiltroEsquema { get; set; } = new();
        public List<string> FiltroEstado { get; set; } = new();
        public List<string> FiltroRecomocimiento { get; set; } = new();
    }
}
