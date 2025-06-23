using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedApp.Dtos
{
    public class vwEsquemaOrganizaDto
    {
        public string PK { get; set; }
        public int IdEsquemaData { get; set; }
        public int IdEsquema { get; set; }
        public int ONAIdONA { get; set; }
        public string ONAPais { get; set; }
        public string ONAUrlIcono { get; set; }
        public string ONASiglas { get; set; }
        public string PetNombrePersonalTecnico { get; set; }
        public string PetCalificacion { get; set; }
        public string PetPais { get; set; }
        public string PetCiudad { get; set; }
        public string PetEsquemaAcreditacion { get; set; }
        public string PetNormaAcreditada { get; set; }
        public string PetCorreo { get; set; }
        public string PetTelefono { get; set; }
        public DateTime DataFecha { get; set; }
    }
}
