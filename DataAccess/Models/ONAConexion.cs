using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Models
{
    public class ONAConexion : BaseEntity
    {
        [Key]
        public int IdONA { get; set; }
        public string? Host { get; set; } = "";
        public int Puerto { get; set; } = 0;
        public string? Usuario { get; set; } = "";
        public string? Contrasenia { get; set; } = "";
        public string? BaseDatos { get; set; } = "";
        public string? OrigenDatos { get; set; } = "";
        public string? Migrar { get; set; } = "";
        public string? Estado { get; set; } = "";
        public int? IdUserCreacion { get; set; } = 0;
        public int? IdUserModifica { get; set; } = 0;
        public DateTime? FechaCreacion { get; set; } = DateTime.Now;
        public DateTime? FechaModifica { get; set; } = DateTime.Now;
        public TimeSpan? HoraMigracion1 { get; set; }
        public TimeSpan? HoraMigracion2 { get; set; }
        public TimeSpan? HoraMigracion3 { get; set; }

        [ForeignKey("IdONA")]
        public virtual ONA? ONA { get; set; }
    }
}
