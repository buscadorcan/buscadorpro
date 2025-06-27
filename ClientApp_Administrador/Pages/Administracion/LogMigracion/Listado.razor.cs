using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;


namespace ClientAppAdministrador.Pages.Administracion.LogMigracion
{
    public partial class Listado
    {
        private bool isLoading = false;

        [Inject] private ILogMigracionService? iLogMigracionService { get; set; }

        // 🆕 Propiedades de paginación
        private int ActivePageNumber = 1;
        private int DisplayPages = 10;
        private int TotalItems = 0;
        private int TotalPages = 0;

        private List<LogMigracionDto> logMigraciones = new();

        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            await CargarDatos();
            isLoading = false;
        }

        private async Task CargarDatos()
        {
            var response = await iLogMigracionService.GetLogMigracionesAsync(ActivePageNumber, DisplayPages);

            if (response.TotalCount > 0)
            {
                logMigraciones = response.Data;
                TotalItems = response.TotalCount;
                TotalPages = response.TotalPages;
            }
            else
            {
                logMigraciones = new();
                TotalItems = 0;
                TotalPages = 0;
            }
        }

        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await CargarDatos();
        }

        private async Task OnDisplayPagesChanged(int newPageSize)
        {
            DisplayPages = newPageSize;
            ActivePageNumber = 1; // Reiniciar a la primera página
            await CargarDatos();
        }
    }
}
