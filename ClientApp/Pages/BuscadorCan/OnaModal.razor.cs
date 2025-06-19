using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para el modal de ONA.
    /// </summary>
    public partial class OnaModal : ComponentBase
    {
        /// <summary>
        /// Servicio de catálogos.
        /// </summary>
        [Inject] private ICatalogosService iCatalogoService { get; set; } = default!;

        /// <summary>
        /// Resultado de datos de búsqueda.
        /// </summary>
        [Parameter] public BuscadorResultadoDataDto ResultData { get; set; } = default!;

        /// <summary>
        /// ONA seleccionado.
        /// </summary>
        private vwONADto? onaSeleccionado;

        /// <summary>
        /// Indicador de carga.
        /// </summary>
        private bool loading = true;

        /// <summary>
        /// Método de inicialización de datos.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            try
            {
                var listaOnas = await iCatalogoService.GetvwOnaAsync();
                onaSeleccionado = listaOnas.FirstOrDefault(ona => ona.IdONA == ResultData.IdONA);
                if (!string.IsNullOrEmpty(onaSeleccionado?.UrlIcono) && onaSeleccionado.UrlIcono.Contains("filePath"))
                {
                    var iconoJson = System.Text.Json.JsonDocument.Parse(onaSeleccionado.UrlIcono);
                    // Extraer el filePath y quitar barra inicial
                    var filePath = iconoJson.RootElement.GetProperty("filePath").GetString()?.TrimStart('/');
                    if (!string.IsNullOrEmpty(filePath))
                    {
                        // Concatenar UrlBaseAdmin con el filePath
                        onaSeleccionado.UrlIcono = $"{UrlBasesOptions.UrlBaseBuscador.TrimEnd('/')}/{filePath}";
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al cargar el ONA: {ex.Message}");
            }
            finally
            {
                loading = false;
            }
        }
    }
}
