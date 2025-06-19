using System.ComponentModel.DataAnnotations;

namespace SharedApp.Dtos
{
    public class ONAConexionDto
    {
        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public int IdONA { get; set; }
        [Required(ErrorMessage = Constantes.MESAGGE_GENERY)]
        public string? Host { get; set; }
        [Required(ErrorMessage =Constantes.MESAGGE_GENERY)]
        public int Puerto { get; set; }
        [Required(ErrorMessage =Constantes.MESAGGE_GENERY)]
        public string? Usuario { get; set; }
        [Required(ErrorMessage =Constantes.MESAGGE_GENERY)]
        public string? Contrasenia { get; set; }
        [Required(ErrorMessage =Constantes.MESAGGE_GENERY)]
        public string? BaseDatos { get; set; }
        [Required(ErrorMessage =Constantes.MESAGGE_GENERY)]
        public string? OrigenDatos { get; set; }
        [Required(ErrorMessage =Constantes.MESAGGE_GENERY)]
        public string? Migrar { get; set; }
        public string? Estado { get; set; }
        public TimeSpan ? HoraMigracion1 { get; set; }
        public TimeSpan? HoraMigracion2 { get; set; }
        public TimeSpan? HoraMigracion3 { get; set; }
        public string? Siglas { get; set; }
    }
}