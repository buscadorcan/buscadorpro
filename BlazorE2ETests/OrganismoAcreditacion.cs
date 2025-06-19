using Microsoft.Playwright;

namespace BlazorE2ETests
{
    public class OrganismoAcreditacion
    {
        public ILocator VerDetalleButton { get; set; } = null!;
        public string Reconocimiento { get; set; } = null!;
        public string RazonSocial { get; set; } = null!;
        public string NombreOEC { get; set; } = null!;
        public string Pais { get; set; } = null!;
        public string EsquemaAcreditacion { get; set; } = null!;
        public string NormaAcreditada { get; set; } = null!;
        public string Identificacion { get; set; } = null!;
        public string Estado { get; set; } = null!;
        public ILocator DetalleButton { get; set; } = null!;
        public ILocator PdfButton { get; set; } = null!;
        public ILocator EsquemaAcreditacionLink { get; set; } = null!;
    }
}
