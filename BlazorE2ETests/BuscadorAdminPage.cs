using Microsoft.Playwright;
using System.Text.RegularExpressions;
using static System.Net.Mime.MediaTypeNames;

namespace BlazorE2ETests
{
    [TestClass]
    public class BuscadorAdminPage : BaseImpl
    {
        [ClassInitialize]
        public static async Task Setup(TestContext context)
        {
            await MSTestSettings.InitializeAsync();
            await setUrl(Constantes.URL_ADMIN);
        }

        [ClassCleanup]
        public static async Task Teardown()
        {
            await MSTestSettings.CleanupAsync();
        }

        private async Task FillCodeVerification()
        {
            await page.WaitForSelectorAsync("form.panel-edit-form >> text=Ingresa el código de verificación");
            await TomarCapturaAsync();
            string[] codigo = new string[] { "1", "2", "3", "4", "5", "6" };

            var inputs = await page.QuerySelectorAllAsync("div.input-component-code input");

            if (inputs.Count != 6)
            {
                throw new Exception("No se encontraron los 6 campos de código.");
            }

            for (int i = 0; i < 6; i++)
            {
                await inputs[i].FillAsync(codigo[i].ToString());
                await TomarCapturaAsync();
            }

            await page.ClickAsync("button:has-text('Verificar')");

            await page.WaitForSelectorAsync("ul.ds-menu >> text=ONA");
        }

        private async Task AuthUser()
        {
            await TomarCapturaAsync();
            await page.FillAsync("input.input-text:nth-of-type(1)", "admin@gmail.com");
            await TomarCapturaAsync();
            await page.FillAsync("input[type='password']", Constantes.PASS);
            await TomarCapturaAsync();
            await page.ClickAsync("button.input-button");
            await TomarCapturaAsync();
            await FillCodeVerification();
        }

        [TestMethod]
        public async Task BuscadorAdminPage_Should_Auth()
        {
            await ConfigurationInit();

            await AuthUser();

            await page.CloseAsync();
        }

        [TestMethod]
        public async Task BuscadorAdminPage_Should_Into_Migration_Excel()
        {
            await ConfigurationInit();

            await AuthUser();
            await page.WaitForSelectorAsync("ul.ds-menu >> text=Migración Excel");
            await TomarCapturaAsync();
            await page.ClickAsync("a.ds-menu-link:has-text(\"Migración Excel\")");
            await TomarCapturaAsync();
            await page.WaitForLoadStateAsync(LoadState.DOMContentLoaded);
            await TomarCapturaAsync();
            await page.WaitForSelectorAsync("a:has-text(\"Importar Excel\")");
            await TomarCapturaAsync();
            await page.ClickAsync("a:has-text(\"Importar Excel\")");
            await TomarCapturaAsync();
            await page.WaitForLoadStateAsync(LoadState.DOMContentLoaded);
            await TomarCapturaAsync();
            await SeleccionarOnaAsync("DTA-IBMETRO");
            await TomarCapturaAsync();
            await SubirArchivoExcelAsync(Constantes.ARCHIVO);
            await TomarCapturaAsync();
            await page.WaitForSelectorAsync("#btnGuardar");
            await page.ClickAsync("#btnGuardar");
            await TomarCapturaAsync();
            await page.WaitForSelectorAsync("div.modal-content");
            await TomarCapturaAsync();
            await page.WaitForSelectorAsync("div.modal-footer >> text=Confirmar");
            await TomarCapturaAsync();
            await page.ClickAsync("div.modal-footer >> text=Confirmar");
            await TomarCapturaAsync();
            await page.CloseAsync();
        }

        [TestMethod]
        public async Task BuscadorAdminPage_Should_Add_Sinonimo()
        {
            await ConfigurationInit();
            await AuthUser();

            // Ir al menú "Sinónimos"
            await page.WaitForSelectorAsync("ul.ds-menu >> text=Sinonimos");
            await TomarCapturaAsync();
            await page.ClickAsync("a.ds-menu-link:has-text(\"Sinonimos\")");

            // Esperar la carga
            await page.WaitForLoadStateAsync(LoadState.DOMContentLoaded);
            await page.WaitForSelectorAsync("h2.ds-title-h2 >> text=Administración Sinonimos");
            await TomarCapturaAsync();

            // Verificar que hay al menos una sección expandible
            var acordeonButtons = await page.QuerySelectorAllAsync(".accordion-button");
            if (!acordeonButtons.Any())
            {
                Assert.Fail("No se encontraron secciones para agregar sinónimos.");
            }

            // Expandir la primera sección
            await acordeonButtons.First().ClickAsync();
            await TomarCapturaAsync();

            // Abrir el modal "Agregar"
            var agregarButtons = await page.QuerySelectorAllAsync("button:has-text(\"Agregar\")");
            if (!agregarButtons.Any())
            {
                Assert.Fail("No se encontró botón para agregar sinónimos.");
            }

            await agregarButtons.First().ClickAsync();
            await page.WaitForSelectorAsync("h5.modal-title >> text=Agregar Sinonimo");
            await TomarCapturaAsync();

            // Escribir sinónimo nuevo
            string nuevoSinonimo = "ejemplo-sinonimo-" + Guid.NewGuid().ToString("N").Substring(0, 6);
            await page.FillAsync("input[placeholder=\"Ingrese el sinonimo\"]", nuevoSinonimo);
            await TomarCapturaAsync();

            // Guardar
            await page.ClickAsync("button:has-text(\"Guardar\")");
            await TomarCapturaAsync();

            // Esperar mensaje de éxito (si se muestra uno)
            var exito = await page.Locator(".mnjRegistroExitoso").IsVisibleAsync();
            Assert.IsTrue(exito, "No se mostró el mensaje de éxito al guardar el sinónimo.");

            // Confirmar que el nuevo sinónimo aparece en la lista
            var apareceEnLista = await page.Locator($"li:has-text(\"{nuevoSinonimo}\")").IsVisibleAsync();
            Assert.IsTrue(apareceEnLista, $"El sinónimo '{nuevoSinonimo}' no aparece en la lista después de guardarlo.");

            await TomarCapturaAsync();
            await page.CloseAsync();
        }

    }
}
