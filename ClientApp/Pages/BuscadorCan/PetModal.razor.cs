using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para el modal de ONA.
    /// </summary>
    public partial class PetModal : ComponentBase
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
                var listaEsquemaOrganiza = await iCatalogoService.GetvwEsquemaOrganizaAsync();
                var esquemaOrganizaSeleccionado = listaEsquemaOrganiza.FirstOrDefault(esquema => esquema.IdEsquemaData == ResultData.IdEsquemaData);

                if (esquemaOrganizaSeleccionado != null)
                {
                    onaSeleccionado = new vwONADto
                    {
                        IdONA = esquemaOrganizaSeleccionado.ONAIdONA,
                        Pais = esquemaOrganizaSeleccionado.ONAPais,
                        Siglas = esquemaOrganizaSeleccionado.ONASiglas,
                        UrlIcono = esquemaOrganizaSeleccionado.ONAUrlIcono,
                        RazonSocial = esquemaOrganizaSeleccionado.PetNombrePersonalTecnico,
                        Correo = esquemaOrganizaSeleccionado.PetCorreo,
                        Telefono = esquemaOrganizaSeleccionado.PetTelefono
                    };

                    if (!string.IsNullOrEmpty(onaSeleccionado.UrlIcono) && onaSeleccionado.UrlIcono.Contains("filePath"))
                    {
                        var iconoJson = System.Text.Json.JsonDocument.Parse(onaSeleccionado.UrlIcono);
                        var filePath = iconoJson.RootElement.GetProperty("filePath").GetString()?.TrimStart('/');
                        if (!string.IsNullOrEmpty(filePath))
                        {
                            onaSeleccionado.UrlIcono = $"{UrlBasesOptions.UrlBaseBuscador.TrimEnd('/')}/{filePath}";
                        }
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
