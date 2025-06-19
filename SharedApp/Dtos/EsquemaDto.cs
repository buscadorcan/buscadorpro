using System.ComponentModel.DataAnnotations;

namespace SharedApp.Dtos
{
    public class EsquemaDto
    {
        public int IdEsquema { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public int MostrarWebOrden { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [StringLength(100, ErrorMessage = "El campo MostrarWeb no puede exceder los 100 caracteres.")]
        public string? MostrarWeb { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [StringLength(250, ErrorMessage = "El campo TooltipWeb no puede exceder los 250 caracteres.")]
        public string? TooltipWeb { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [StringLength(100, ErrorMessage = "El campo EsquemaVista no puede exceder los 100 caracteres.")]
        public string? EsquemaVista { get; set; }

        public string? EsquemaJson { get; set; }

        [StringLength(1, ErrorMessage = "El campo Estado debe tener un solo carácter (por ejemplo, 'A' para activo).")]
        public string? Estado { get; set; }
    }
}
