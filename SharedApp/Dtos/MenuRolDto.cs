
using System.ComponentModel.DataAnnotations;


namespace SharedApp.Dtos
{
    public class MenuRolDto
    {
        
        public int IdMenuRol { get; set; } = 0;

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [Display(Name ="Rol")]
        public int? IdHRol { get; set; } = 0;
        public string? Rol { get; set; } = "";

        [Display(Name = "Menu")]
        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public int? IdHMenu { get; set; } = 0;

        public string? Menu { get; set; } = "";
        [Required]
        public string? Estado { get; set; } = Constantes.ESTADO_USUARIO_A;
        [Required]
        public DateTime? FechaCreacion { get; set; } = DateTime.Now;

    }
}
