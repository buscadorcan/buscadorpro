using Microsoft.Playwright;
using System.Text.RegularExpressions;

namespace BlazorE2ETests
{
    [TestClass]
    public class BuscadorPage : BaseImpl
    {
        [ClassInitialize]
        public static async Task Setup(TestContext context)
        {
            await MSTestSettings.InitializeAsync();
            await setUrl(Constantes.URL);
        }

        [ClassCleanup]
        public static async Task Teardown()
        {
            await MSTestSettings.CleanupAsync();
        }

        private async Task CloseModalInitLoadPage()
        {
            await TomarCapturaAsync();
            await page.WaitForSelectorAsync(Constantes.CLASS_BUTTON_CLOSE_MODAL_HOME_PAGE, new PageWaitForSelectorOptions
            {
                State = WaitForSelectorState.Visible
            });
            await TomarCapturaAsync();
            await page.ClickAsync(Constantes.CLASS_BUTTON_CLOSE_MODAL_HOME_PAGE);

            await TomarCapturaAsync(); var modal = await page.QuerySelectorAsync(Constantes.CLASS_BUTTON_CLOSE_MODAL_HOME_PAGE);
            if (modal != null)
            {
                var isVisible = await modal.IsVisibleAsync();
                Assert.IsFalse(isVisible, "El modal sigue visible después de hacer clic en cerrar.");
                return;
            }

            Assert.IsNull(modal, "El modal fue eliminado del DOM, lo cual también es válido.");
        }

        private async Task ClickButtonSearch()
        {
            await page.WaitForSelectorAsync(Constantes.CLASS_BUTTON_SEARCH_HOME_PAGE);
            await TomarCapturaAsync();
            await page.ClickAsync(Constantes.CLASS_BUTTON_SEARCH_HOME_PAGE);
            await TomarCapturaAsync();
        }

        private async Task ClickExportReport(string buttonSelector, string outputDirectory)
        {
            string fullDirectoryPath = Path.Combine(Directory.GetCurrentDirectory(), outputDirectory);
            Directory.CreateDirectory(fullDirectoryPath);
            await TomarCapturaAsync();
            Console.WriteLine("Carpeta de descarga: " + fullDirectoryPath);
            await TomarCapturaAsync();
            var download = await page.RunAndWaitForDownloadAsync(async () =>
            {
                Console.WriteLine("Haciendo clic en el botón de exportación...");
                await page.ClickAsync(buttonSelector);
            });

            string fileName = download.SuggestedFilename;

            await TomarCapturaAsync();
            var esFormatoCorrecto = Regex.IsMatch(fileName, @"^export_\d{4}-\d{2}-\d{2}_\d{6}\.(pdf|xlsx)$", RegexOptions.IgnoreCase);
            Assert.IsTrue(esFormatoCorrecto, $"Nombre del archivo no cumple con el formato esperado: {fileName}");
            await TomarCapturaAsync();
            string finalPath = Path.Combine(fullDirectoryPath, fileName);
            await download.SaveAsAsync(finalPath);

            await TomarCapturaAsync();

            Assert.IsTrue(File.Exists(finalPath), $"La descarga no se realizó correctamente. No se encontró el archivo: {fileName}");

            var fileInfo = new FileInfo(finalPath);
            Assert.IsTrue(fileInfo.Length > 0, "El archivo descargado está vacío.");
        }

        [TestMethod]
        public async Task BuscadorPage_Should_Have_Title()
        {
            await ConfigurationInit();
            var title = await page.TitleAsync();
            await TomarCapturaAsync();
            Assert.AreEqual("Buscador", title);
            await context.CloseAsync();
        }

        [TestMethod]
        public async Task BuscadorPage_Should_Close_Modal()
        {
            await ConfigurationInit();
            await CloseModalInitLoadPage();
            await page.CloseAsync();
        }

        [TestMethod]
        public async Task BuscadorPage_Should_Click_Button_Search_Show_Alert_Danger()
        {
            await ConfigurationInit();
            await TomarCapturaAsync();
            await CloseModalInitLoadPage();
            await TomarCapturaAsync();
            await ClickButtonSearch();
            await TomarCapturaAsync();
            await ValidateMessageResultToastHeader("Error de validación");

            await context.CloseAsync();
        }

        [TestMethod]
        public async Task BuscadorPage_Should_Fill_Input_Search_And_Click_Search()
        {
            await ConfigurationInit();
            await TomarCapturaAsync();
            await CloseModalInitLoadPage();
            await page.FillAsync("#inputBusqueda", "Agua");
            await ClickButtonSearch();
            await TomarCapturaAsync();
            await ValidateMessageResultToastHeader("Búsqueda completada");
            await TomarCapturaAsync();
            await ValidateTBodyContainsNumberRows(".bb-table");
            await context.CloseAsync();
        }


        [TestMethod]
        public async Task Home_Page_Should_Export_Pdf()
        {
            await ConfigurationInit();

            await CloseModalInitLoadPage();
            await page.FillAsync("#inputBusqueda", "Agua");
            await ClickButtonSearch();

            await ClickExportReport(Constantes.CLASS_BUTTON_EXPORT_PDF_HOME_PAGE, "Descargas");

            await context.CloseAsync();
        }

        [TestMethod]
        public async Task Home_Page_Should_Export_Excel()
        {
            await ConfigurationInit();

            await CloseModalInitLoadPage();
            await TomarCapturaAsync();
            await page.FillAsync("#inputBusqueda", "Agua");
            await TomarCapturaAsync();
            await ClickButtonSearch();
            await TomarCapturaAsync();
            await ClickExportReport(Constantes.CLASS_BUTTON_EXPORT_EXCEL_HOME_PAGE, "Descargas");
            await TomarCapturaAsync();
            await context.CloseAsync();
        }

        [TestMethod]
        public async Task Home_Page_Should_Search_Validate_Synonimous()
        {
            await ConfigurationInit();
            await TomarCapturaAsync();
            await CloseModalInitLoadPage();
            await page.FillAsync("#inputBusqueda", "Agua");
            await ClickButtonSearch();
            await TomarCapturaAsync();
            await ValidateMessageResultToastHeader("Búsqueda completada");
            await TomarCapturaAsync();
            
            var organismos = await ObtenerOrganismosAsync(".bb-table");

            foreach (var organismo in organismos)
            {
                //await organismo.EsquemaAcreditacionLink.ClickAsync();
                await organismo.EsquemaAcreditacionLink.ScrollIntoViewIfNeededAsync();
                await organismo.EsquemaAcreditacionLink.ClickAsync(new() { Force = true });

                var modal = page.Locator(".modal.fade.show");
                await TomarCapturaAsync();
                await modal.WaitForAsync(new() { State = WaitForSelectorState.Visible });
                await TomarCapturaAsync();
                var certificados = await GetCertificacionProducto(".modal .bb-table");
                await page.WaitForTimeoutAsync(1000);
                await page.Keyboard.PressAsync("Escape");
                await TomarCapturaAsync();
                await modal.WaitForAsync(new() { State = WaitForSelectorState.Hidden });
                await TomarCapturaAsync();
            }

            await context.CloseAsync();
        }

        [TestMethod] 
        public async Task Home_Page_Should_Search_Advanced()
        {
            await ConfigurationInit();
            
            await TomarCapturaAsync();
            await CloseModalInitLoadPage();
            await TomarCapturaAsync();
            
            await page.ClickAsync("label[for='filtros-avanzados']");
            await TomarCapturaAsync();

            await page.WaitForTimeoutAsync(5000);
            await TomarCapturaAsync();

            var dropdownIds = new[] {
                "dropdownMenuButton-0", // Por País
                "dropdownMenuButton-1", // ONA
                "dropdownMenuButton-2", // Esquemas
                "dropdownMenuButton-3", // Norma
                "dropdownMenuButton-4", // Estado
                "dropdownMenuButton-5"  // Reconocimiento
            };

            foreach (var id in dropdownIds)
            {
                var dropdownButton = page.Locator($"#{id}").Last;
                await dropdownButton.WaitForAsync(new()
                {
                    State = WaitForSelectorState.Visible,
                    Timeout = 5000
                });

                await TomarCapturaAsync();
                await dropdownButton.ClickAsync();
                await TomarCapturaAsync();

                var dropdownMenu = page.Locator($"#{id} + ul.dropdown-menu");
                await dropdownMenu.WaitForAsync(new()
                {
                    Timeout = 3000,
                    State = WaitForSelectorState.Visible
                });

                await TomarCapturaAsync();
                var primerCheckbox = dropdownMenu.Locator("input[type=checkbox]").First;
                if (await primerCheckbox.IsVisibleAsync())
                {
                    await primerCheckbox.CheckAsync();
                    await TomarCapturaAsync();
                }

                await TomarCapturaAsync();
                await dropdownButton.ClickAsync();
                await TomarCapturaAsync();
            }

            await TomarCapturaAsync();
            await page.FillAsync("#inputBusqueda", "Agua");
            await TomarCapturaAsync();
            await ClickButtonSearch();
            await TomarCapturaAsync();
            await ValidateMessageResultToastHeader("Búsqueda completada");
            await TomarCapturaAsync();
            await ValidateTBodyContainsNumberRows(".bb-table");
            await TomarCapturaAsync();
            await context.CloseAsync();
        }
    }
}
