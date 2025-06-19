using BlazorBootstrap;
using Microsoft.AspNetCore.Components;
using Infractruture.Interfaces;
using Microsoft.JSInterop;
using Newtonsoft.Json;
using SharedApp.Helpers;
using System.Text;
using SharedApp.Dtos;
using System.Net.Http.Json;

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para la página de búsqueda de CAN.
    /// </summary>
    public partial class IndexGrilla : ComponentBase
    {

        /// <summary>
        /// Servicio de homologación.
        /// </summary>
        [Inject] 
        public IBusquedaService BusquedaService { get; set; } = default!;

        /// <summary>
        /// Servicio de homologación.
        /// </summary>
        [Inject]
        private IJSRuntime JS { get; set; } = default!;// 🔹 Inyección de JavaScript

        /// <summary>
        /// Servicio de homologación.
        /// </summary>
        [Inject]
        public NavigationManager Navigation { get; set; } = default!;

        /// <summary>
        /// Servicio de homologación.
        /// </summary>
        [Inject]
        public HttpClient Http { get; set; } = default!;

        /// <summary>
        /// Servicio de homologación.
        /// </summary>
        [Inject] public IHomologacionService? iHomologacionService { get; set; }

        /// <summary>
        /// Servicio de JavaScript.
        /// </summary>
        [Inject] public IJSRuntime? iJSRuntime { get; set; }

        /// <summary>
        /// Gets or sets the list data dto.
        /// </summary>
        [Parameter] public List<BuscadorResultadoDataDto>? ListDataDto { get; set; }

        /// <summary>
        /// Gets or sets the list url data dto.
        /// </summary>
        [Parameter] public Dictionary<int, string>? iconUrls { get; set; }

        /// <summary>
        /// Listado de etiquetas de la grilla.
        /// </summary>
        [Parameter] public List<VwGrillaDto>? listaEtiquetasGrilla { get; set; }
        
        /// <summary>
        /// COmponente modal.
        /// </summary>
        private Modal modal = default!;

        /// <summary>
        /// open or close dialog
        /// </summary>
        private bool isDialogOpen = false;

        /// <summary>
        /// url pdf
        /// </summary>
        private string? PdfUrl;

        private bool isModalOpen = false;

        [Parameter]
        public bool IsSearchingExport { get; set; } = false;

        [Inject]
        public Blazored.LocalStorage.ILocalStorageService localStorage { get; set; } = default!;

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        /// <param name="resultData"></param>
        private async void showModal(BuscadorResultadoDataDto resultData)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Style = "font-size: 10px !important;";
            modal.Size = ModalSize.ExtraLarge;
            await modal.ShowAsync<EsquemaModal>(title: "Información Detallada", parameters: parameters);
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async void showModalOna(BuscadorResultadoDataDto resultData)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Style = "font-size: 10px !important;";
            modal.Size = ModalSize.Regular;
            await modal.ShowAsync<OnaModal>(title: "Información Organizacion", parameters: parameters);
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async void showModalOEC(BuscadorResultadoDataDto resultData)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Style = "font-size: 10px !important;";
            modal.Size = ModalSize.Regular;
            await modal.ShowAsync<OECModal>(title: "Información del OEC", parameters: parameters);
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async void showModalESQ(BuscadorResultadoDataDto resultData)
        {
         
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Style = "font-size: 10px !important;";
            modal.Size = ModalSize.ExtraLarge;
            await modal.ShowAsync<IndvEsquemaModal>(title: "Información Esquema", parameters: parameters);
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async Task ShowPdfDialog(BuscadorResultadoDataDto resultData)
        {
            // Obtener la URL del certificado
            var base64 = await GetPdfUrlFromEsquema(resultData);

            if (string.IsNullOrWhiteSpace(base64))
            {
                Console.WriteLine("Archivo no encontrado.");
            }

            var parameters = new Dictionary<string, object>();
            parameters.Add("PdfUrl", base64);
            await modal.ShowAsync<PdfModal>(title: "Información", parameters: parameters);
        }

        /// <summary>
        /// Método para obtener la URL del certificado.
        /// </summary>
        private async Task<string?> GetPdfUrlFromEsquema(BuscadorResultadoDataDto resultData)
        {
            try
            {
                if (resultData.DataEsquemaJson == null || !resultData.DataEsquemaJson.Any())
                    return null;

                var homologaciones = await iHomologacionService.GetHomologacionsAsync();
                var idHomologacion = homologaciones.FirstOrDefault(x => x.CodigoHomologacion == "KEY_ESQ_CERT")?.IdHomologacion;
               
                if (idHomologacion == null)
                    return null;

                var urlPdf = resultData.DataEsquemaJson?.FirstOrDefault(f => f.IdHomologacion == idHomologacion)?.Data;

        
                return await BusquedaService.DescargarPDF(urlPdf);

            }
            catch (Exception ex)
            {
                throw new Exception("Archivo no encontrado", ex);
            }
        }

        private async Task HandleModalClose()
        {
            Console.WriteLine("🔹 Modal cerrado automáticamente al hacer clic fuera.");
            isModalOpen = false;
            StateHasChanged(); // 🔄 Forzar actualización de la UI
        }

        private async Task ExportarExcel()
        {
            try
            {

                IsSearchingExport = true;
                StateHasChanged();

                // 1️⃣ Recupera los filtros que guardaste en localStorage
                var filtros = await localStorage.GetItemAsync<FiltrosBusquedaDto>("FiltrosBusqueda");
                if (filtros == null)
                {
                    Console.WriteLine("❌ No hay filtros almacenados.");
                    return;
                }

                // 2️⃣ Serializa el DTO de filtros a JSON
                var filtrosJson = JsonConvert.SerializeObject(filtros);

                // 3️⃣ Llama al servicio; ahora devuelve directamente la URL del .xlsx
                string base64 = await BusquedaService.ExportarExcelBuscAsync(filtrosJson);

                // 4️⃣ Abre esa URL en el navegador para forzar la descarga
                //    forceLoad: true hace que salga del router de Blazor y cargue la URL directamente
                //Navigation.NavigateTo(urlExcel, forceLoad: true);

                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.xlsx";

                await iJSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error al exportar: {ex.Message}");
            }
            finally
            {
                // 6️⃣ Desactivar el overlay (aunque la navegación ya esté en marcha)
                IsSearchingExport = false;
                StateHasChanged();
            }
        }

        private async Task ExportarPDF()
        {
            try
            {
                IsSearchingExport = true;
                StateHasChanged();
                // 1️⃣ Recupera los filtros que guardaste en localStorage
                var filtros = await localStorage.GetItemAsync<FiltrosBusquedaDto>("FiltrosBusqueda");
                if (filtros == null)
                {
                    Console.WriteLine("❌ No hay filtros almacenados.");
                    return;
                }

                // 2️⃣ Serializa el DTO de filtros a JSON
                var filtrosJson = JsonConvert.SerializeObject(filtros);

                // 3️⃣ Llama al servicio; ahora devuelve directamente la URL del .xlsx
                string base64 = await BusquedaService.ExportarPdfBuscAsync(filtrosJson);

                // 4️⃣ Abre esa URL en el navegador para forzar la descarga
                //    forceLoad: true hace que salga del router de Blazor y cargue la URL directamente
                //Navigation.NavigateTo(urlPdf, forceLoad: true);

                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.pdf";

                await iJSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error al exportar: {ex.Message}");
            }
            finally
            {
                // 6️⃣ Desactivar el overlay
                IsSearchingExport = false;
                StateHasChanged();
            }
        }

    }
}