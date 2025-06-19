using System.ComponentModel.DataAnnotations;

namespace SharedApp.Dtos
{
    public class OnaDto
    {
        public int IdONA { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [Display(Name ="pais")]
        public int? IdHomologacionPais { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string? RazonSocial { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string? Siglas { get; set; }
        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string? Ciudad { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [EmailAddress(ErrorMessage = Constantes.MESAGGE_FORMAT_INVALI)]
        public string? Correo { get; set; }
        public string? Direccion { get; set; }

        [Url(ErrorMessage = Constantes.MESAGGE_FORMAT_INVALI)]
        public string? PaginaWeb { get; set; }

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [Phone(ErrorMessage = Constantes.MESAGGE_FORMAT_INVALI)]
        public string? Telefono { get; set; }
        public string? UrlIcono { get; set; }
        public string? UrlLogo { get; set; }
        public string? InfoExtraJson { get; set; }
        public string? Estado { get; set; }
        public int? IdUserCreacion { get; set; }
        public int? IdUserModifica { get; set; }

    }
}
