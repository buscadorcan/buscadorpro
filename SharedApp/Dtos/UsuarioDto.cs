﻿using System.ComponentModel.DataAnnotations;

namespace SharedApp.Dtos
{
    public class UsuarioDto
    {
        public int IdUsuario { get; set; }
        [Required]
        public int IdHomologacionRol { get; set; } = 0;
        [Required]
        public int IdONA { get; set; } = 0;
        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string? Nombre { get; set; } = "";
        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string? Apellido { get; set; } = "";

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [RegularExpression(@"^\+?\d{1,3}\s?\d{7,10}$", ErrorMessage = "El teléfono debe contener el código del país seguido del número (Ej: +1 1234567890).")]
        public string? Telefono { get; set; } = "";

        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        [EmailAddress(ErrorMessage = Constantes.MESAGGE_FORMAT_INVALI)]
        public string? Email { get; set; } = "";

        //[Required(ErrorMessage = "La clave es obligatoria.")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,11}$", ErrorMessage = "La clave debe tener entre 6 y 11 caracteres, con al menos una mayúscula, una minúscula y un número.")]
        public string? Clave { get; set; } = "";
        public string? Estado { get; set; } = "";
        public string Rol { get; set; } = "";
        public string RazonSocial { get; set; } = "";
        public string BaseDatos { get; set; } = "";
        public string OrigenDatos { get; set; } = "";
        public string Migrar { get; set; } = "";
        public DateTime FechaModifica { get; set; } = DateTime.Now;
        public int IdUserModifica { get; set; } = 0;
        public string EstadoMigracion { get; set; } = "";

    }
}
