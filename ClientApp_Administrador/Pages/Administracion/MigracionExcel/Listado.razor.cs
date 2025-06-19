using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;
using Microsoft.JSInterop;
using iTextSharp.text;
using System.Drawing.Printing;


namespace ClientAppAdministrador.Pages.Administracion.MigracionExcel
{
    /// <summary>
    /// Componente de listado de logs de migración de archivos Excel.
    /// Controla el acceso según el rol del usuario y permite visualizar registros de migración.
    /// </summary>
    public partial class Listado
    {
        private bool isLoading = false;
        /// <summary>
        /// Servicio de navegación para redirigir a otras páginas.
        /// </summary>
        [Inject] public NavigationManager? navigationManager { get; set; }
        /// <summary>
        /// Servicio de almacenamiento local en el navegador.
        /// </summary>
        [Inject] ILocalStorageService iLocalStorageService { get; set; }
        /// <summary>
        /// Servicio de migración de archivos Excel.
        /// </summary>
        [Inject] private IMigracionExcelService? iMigracionExcelService { get; set; }
        /// <summary>
        /// Servicio de logs de migración.
        /// </summary>
        [Inject] private ILogMigracionService? iLogMigracionService { get; set; }
        // Componente de la grilla para mostrar los registros de migración
        private Grid<LogMigracionDto>? grid;
        // Variables de control de acceso según el rol del usuario
        private bool accessMigration;
        private bool isRolRead;
        private bool isRolOna;
        private bool isRolAdmin;

        /// <summary>
        /// Servicio de búsqueda y registro de eventos.
        /// </summary>
        [Inject] private IBusquedaService iBusquedaService { get; set; }
        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();
        // Lista que almacena los registros de logs de migración
        private List<LogMigracionDto> listasHevd = new();

        // Parámetros para la paginación
        private int currentPage = 1;
        private int pageSize = 10;
        private int totalItems = 0;
        private int totalPages = 0;

        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            objEventTracking.CodigoHomologacionMenu = Routes.MIGRACION_EXCEL;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "migracion-excel";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            var usuarioBaseDatos = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_BaseDatos_Local);
            var usuarioOrigenDatos = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_OrigenDatos_Local);
            var usuarioEstadoMigracion = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_EstadoMigracion_Local);
            var usuarioMigrar = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Migrar_Local);
            var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);

            isRolRead = rolRelacionado == Constantes.KEY_USER_READ;
            isRolOna = rolRelacionado == Constantes.KEY_USER_ONA;
            isRolAdmin = rolRelacionado ==Constantes.KEY_USER_CAN;

            // Verificación de acceso
            if (!isRolAdmin && !isRolOna)
            {
                if (!isRolRead)
                {
                    if (usuarioMigrar !=Constantes.SUSPENDIDO ||
                        usuarioEstadoMigracion != Constantes.ACTIVO ||
                        (usuarioBaseDatos != "INACAL" && usuarioBaseDatos != "DTA") ||
                        usuarioOrigenDatos != Constantes.EXCEL)
                    {
                        navigationManager?.NavigateTo(Routes.PAGE_NO_DISPONIBLE);
                        return;
                    }
                }
                else
                {
                    navigationManager?.NavigateTo(Routes.PAGE_NO_DISPONIBLE);
                    return;
                }
            }

            await CargarDatos();
            isLoading = false;
        }

        /// <summary>
        /// Método que obtiene la lista de homologaciones y aplica los criterios de filtrado.
        /// </summary>
        /// <returns>Lista de homologaciones aplicando los filtros.</returns>
        private async Task CargarDatos()
        {

            ResultadoPaginadoDto<List<LogMigracionDto>> response = await iLogMigracionService.GetLogMigracionesAsync(currentPage, pageSize);

            if (response.TotalCount > 0)
            {
                listasHevd = response.Data;
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


        private string sortColumn = nameof(LogMigracionDto.IdLogMigracion);
        private bool sortAscending = true;

        private void OrdenarPor(string column)
        {
            if (sortColumn == column)
            {
                sortAscending = !sortAscending;
            }
            else
            {
                sortColumn = column;
                sortAscending = true;
            }

            listasHevd = sortAscending
                ? listasHevd.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
                : listasHevd.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }

        private async Task ExportarExcel()
        {
            if (listasHevd == null || !listasHevd.Any())
            {
                return;
            }

            try
            {
                var base64 = await iMigracionExcelService.ExportarExcelAsync();

                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.xlsx";
                await JSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }

        private async Task ExportarPDF()
        {
            if (listasHevd == null || !listasHevd.Any())
            {
                return;
            }

            try
            {
                var base64 = await iMigracionExcelService.ExportarPdfAsync();

                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.pdf";
                await JSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
    }
}