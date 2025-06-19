using BlazorBootstrap;
using Blazored.LocalStorage;
using Infractruture.Interfaces;
using Infractruture.Services;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;
using SharedApp.Helpers;

namespace ClientAppAdministrador.Pages.Administracion.LogMigracion
{
    /// <summary>
    /// Componente de listado de logs de migraci�n.
    /// Permite visualizar el historial de migraciones realizadas en el sistema.
    /// </summary>
    public partial class Listado
    {
        private bool isLoading = false;

        /// <summary>
        /// Servicio de logs de migraci�n, utilizado para obtener registros hist�ricos.
        /// </summary>
        [Inject] private ILogMigracionService? iLogMigracionService { get; set; }

        private int currentPage = 1;
        private int pageSize = 10;
        private int totalItems = 0;
        private int totalPages = 0;

        private List<LogMigracionDto> logMigraciones = new();

        /// <summary>
        /// M�todo asincr�nico que inicializa la lista de campos de homologaci�n.
        /// </summary>
        /// <returns>Devuelve la lista de homologaciones al iniciar la aplicaci�n.</returns>
        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            await CargarDatos();
            isLoading = false;
        }

        /// <summary>
        /// M�todo que obtiene la lista de homologaciones y aplica los criterios de filtrado.
        /// </summary>
        /// <returns>Lista de homologaciones aplicando los filtros.</returns>
        private async Task CargarDatos()
        {

            ResultadoPaginadoDto<List<LogMigracionDto>> response = await iLogMigracionService.GetLogMigracionesAsync(currentPage, pageSize);
    
            if (response.TotalCount > 0)
            {
                logMigraciones = response.Data;
                totalItems = response.TotalCount;
                totalPages = response.TotalPages;
            }
        }

        private async Task Anterior()
        {
            if (currentPage > 1)
            {
                currentPage--;
                await CargarDatos();
            }
        }

        private async Task Siguiente()
        {
            if (currentPage < totalPages)
            {
                currentPage++;
                await CargarDatos();
            }
        }

    }
}