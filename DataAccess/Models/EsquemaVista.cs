using SharedApp;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Models
{
    public class EsquemaVista : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IdEsquemaVista { get; set; }
        public int IdONA { get; set; }
        public int IdEsquema { get; set; }
        [Required]
        public string VistaOrigen { get; set; } = "";
        [Required]
        public string Estado { get; set; } = Constantes.ESTADO_USUARIO_A;

        [ForeignKey("IdONA")]
        public ONA? ONA { get; set; }
        [ForeignKey("IdEsquema")]
        public Esquema? Esquema { get; set; }
    }
}
