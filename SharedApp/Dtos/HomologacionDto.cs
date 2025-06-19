using System.ComponentModel.DataAnnotations;

namespace SharedApp.Dtos
{
    public class HomologacionDto
    {
        public int IdHomologacion { get; set; }
        public int? IdHomologacionGrupo { get; set; }
        public int? IdHomologacionFiltro { get; set; }

        [Range(0, int.MaxValue)]
        public int MostrarWebOrden { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string MostrarWeb { get; set; } = string.Empty;

        [Required(ErrorMessage = "Debe seleccionar si se muestra o no.")]
        public string Mostrar { get; set; }

        public string? TooltipWeb { get; set; }

        [Required(ErrorMessage = "Debe seleccionar un tipo de dato.")]
        public string MascaraDato { get; set; } = string.Empty;

        [MaxLength(10, ErrorMessage = "Máximo 10 caracteres permitidos.")]
        public string? SiNoHayDato { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string NombreHomologado { get; set; } = string.Empty;

        public string? InfoExtraJson { get; set; }

        [StringLength(20, ErrorMessage = "Código de homologación debe tener máximo 20 caracteres.")]
        public string? CodigoHomologacion { get; set; }

        [Range(1, 12, ErrorMessage = "Ancho de columna debe estar entre 1 y 12.")]
        public int AnchoColumna { get; set; }

        public string? CustomMostrarWeb { get; set; }
        public string? NombreFiltro { get; set; }

        [Required(ErrorMessage = "Debe indicar si se indexa o no.")]
        public string Indexar { get; set; }

        public string? Estado { get; set; }
    }
}
