using Microsoft.Playwright;
using static System.Net.Mime.MediaTypeNames;

namespace BlazorE2ETests
{
    public abstract class BaseImpl
    {
        public IBrowserContext context = null!;
        public IPage page = null!;
        private static string url = string.Empty;

        public static async Task setUrl(string value)
        {
            url = value;
        }

        public async Task ConfigurationInit()
        {
            context = await MSTestSettings.Browser.NewContextAsync();
            page = await context.NewPageAsync();
            await page.GotoAsync(url);
        }
        public async Task ValidateMessageResultToastHeader(string textToSearch)
        {
            var toastHeader = await page.WaitForSelectorAsync(".toast-header");
            var texto = await toastHeader.InnerTextAsync();
            Assert.IsTrue(texto.Contains(textToSearch), "No se encontró el mensaje de error esperado.");
        }

        public async Task SeleccionarOnaAsync(string nombreOna)
        {
            await page.ClickAsync("button.custom-dropdown-button");
            await page.WaitForSelectorAsync($"a.custom-dropdown-item:has-text(\"{nombreOna}\")");
            await page.ClickAsync($"a.custom-dropdown-item:has-text(\"{nombreOna}\")");
        }

        public async Task SubirArchivoExcelAsync(string rutaArchivo)
        {
            if (!File.Exists(rutaArchivo))
            {
                throw new FileNotFoundException("Archivo no encontrado: " + rutaArchivo);
            }

            await page.WaitForSelectorAsync("input[type='file']");
            await page.SetInputFilesAsync("input[type='file']", rutaArchivo);
        }

        public async Task TomarCapturaAsync(string nombreArchivo = null, bool fullPage = true)
        {
            string carpeta = "screenshots";
            if (!Directory.Exists(carpeta))
            {
                Directory.CreateDirectory(carpeta);
            }

            if (string.IsNullOrWhiteSpace(nombreArchivo))
            {
                nombreArchivo = $"captura_{DateTime.Now:yyyyMMdd_HHmmss}.png";
            }

            string rutaCompleta = Path.Combine(carpeta, nombreArchivo);

            await page.ScreenshotAsync(new PageScreenshotOptions
            {
                Path = rutaCompleta,
                FullPage = fullPage
            });
        }

        public async Task<List<CertificacionProducto>> GetCertificacionProducto(string selector)
        {
            List<CertificacionProducto> certificaciones = new();
            var tabla = page.Locator($"{selector} > tbody > tr");
            int rowCount = await tabla.CountAsync();

            for (int i = 0; i < rowCount; i++)
            {
                var fila = tabla.Nth(i);
                var celdas = fila.Locator("td");

                var certificacion = new CertificacionProducto
                {
                    TipoCertificacion = await celdas.Nth(0).InnerTextAsync(),
                    ProductoProcesoServicio = await celdas.Nth(1).InnerTextAsync(),
                    DocumentoNormativo = await celdas.Nth(2).InnerTextAsync(),
                    EsquemaCertificacion = await celdas.Nth(3).InnerTextAsync(),
                    DivisionNace = await celdas.Nth(4).InnerTextAsync(),
                    CodigoCPA = await celdas.Nth(5).InnerTextAsync(),
                    Vigente = await celdas.Nth(6).InnerTextAsync()
                };

                certificaciones.Add(certificacion);
            }

            return certificaciones;
        }

        public async Task<List<OrganismoAcreditacion>> ObtenerOrganismosAsync(string selector)
        {
            var organismos = new List<OrganismoAcreditacion>();
            var filas = page.Locator($"{selector} > tbody > tr");
            int rowCount = await filas.CountAsync();

            for (int i = 0; i < rowCount; i++)
            {
                var fila = filas.Nth(i);
                var celdas = fila.Locator("td");

                organismos.Add(new OrganismoAcreditacion
                {
                    VerDetalleButton = celdas.Nth(0).Locator("button"),
                    Reconocimiento = await celdas.Nth(1).InnerTextAsync(),
                    RazonSocial = await celdas.Nth(2).InnerTextAsync(),
                    NombreOEC = await celdas.Nth(3).InnerTextAsync(),
                    Pais = await celdas.Nth(4).InnerTextAsync(),
                    EsquemaAcreditacion = await celdas.Nth(5).InnerTextAsync(),
                    EsquemaAcreditacionLink = celdas.Nth(5).Locator("a"),
                    NormaAcreditada = await celdas.Nth(6).InnerTextAsync(),
                    Identificacion = await celdas.Nth(7).InnerTextAsync(),
                    Estado = await celdas.Nth(8).InnerTextAsync(),
                    DetalleButton = celdas.Nth(9).Locator("button"),
                    PdfButton = celdas.Nth(10).Locator("button")
                });
            }

            return organismos;
        }

        public async Task ValidateTBodyContainsNumberRows(string tableId)
        {
            var filas = await GetTableContent(tableId);
            await TomarCapturaAsync();
            Assert.IsTrue(filas.Count > 0, "La tabla no tiene datos.");
        }

        public async Task<IReadOnlyList<IElementHandle>> GetTableContent(string tableId)
        {
            await page.WaitForSelectorAsync(tableId);
            await TomarCapturaAsync();
            return await page.QuerySelectorAllAsync($"{tableId} tbody tr");
        }
    }
}
