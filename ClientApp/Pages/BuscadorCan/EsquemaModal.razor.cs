using BlazorBootstrap;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para el modal de esquema.
    /// </summary>
    public partial class EsquemaModal : ComponentBase
    {
        /// <summary>
        /// paneles de esquemas.
        /// </summary>
        Tabs tabs = default!;

        /// <summary>
        /// Servicio de búsqueda.
        /// </summary>
        [Inject] private IBusquedaService? servicio { get; set; }

        /// <summary>
        /// Resultado de datos de búsqueda.
        /// </summary>
        [Parameter] public BuscadorResultadoDataDto? resultData { get; set; } = default!;

        /// <summary>
        /// Lista de esquemas.
        /// </summary>
        private List<HomologacionEsquemaDto>? listaEsquemas = new List<HomologacionEsquemaDto>();
        private int activeTabIndex = 0;
        private bool tabsActivados = false;
        /// <summary>
        /// Método de inicialización de datos.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            try
            {
                if (servicio != null)
                {
                    listaEsquemas = await servicio.FnHomologacionEsquemaTodoAsync(resultData?.VistaFK, resultData?.IdONA ?? 0);

                    if (listaEsquemas != null && listaEsquemas.Any())
                    {
                        activeTabIndex = 0; // ✅ Activar el primer tab
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"❌ Error en EsquemaModal: {e.Message}");
            }
        }
        private async Task ActivarPrimerTabSiCorresponde()
        {
            if (!tabsActivados && listaEsquemas != null && listaEsquemas.Any())
            {
                activeTabIndex = 0;
                tabsActivados = true;
                await InvokeAsync(StateHasChanged); // 🔄 Fuerza redibujado
            }
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await ActivarPrimerTabSiCorresponde();
            }
        }


    }
}