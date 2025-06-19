using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedApp.Dtos
{
    public class EventTrackingDto
    {
        public int idUsuario { get; set; }
        public int CodigoEvento { get; set; }
        public string CodigoHomologacionRol { get; set; } = string.Empty;
        public string? NombreUsuario { get; set; } = string.Empty;
        public string CodigoHomologacionMenu { get; set; } = string.Empty;
        public string NombreControl { get; set; } = string.Empty;
        public string NombreAccion { get; set; } = string.Empty;
        public string UbicacionJson { get; set; } = string.Empty;
        public string ParametroJson { get; set; } = "{}";


    }
}
