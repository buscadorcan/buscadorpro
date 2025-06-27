using BlazorBootstrap;
using Blazored.LocalStorage;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;
using SharedApp.Helpers;

namespace ClientAppAdministrador.Pages.Administracion.MigracionExcel
{
    public partial class Listado
    {
        private bool isLoading = false;
        private Grid<LogMigracionDto>? grid;

        private bool accessMigration;
        private bool isRolRead;
        private bool isRolOna;
        private bool isRolAdmin;

        private List<LogMigracionDto> listasHevd = new();

        [Inject] public NavigationManager? navigationManager { get; set; }
        [Inject] ILocalStorageService iLocalStorageService { get; set; }
        [Inject] private IMigracionExcelService? iMigracionExcelService { get; set; }
        [Inject] private ILogMigracionService? iLogMigracionService { get; set; }
        [Inject] private IBusquedaService iBusquedaService { get; set; }

        private EventTrackingDto objEventTracking { get; set; } = new();

        // 🆕 Propiedades de paginación
        private int DisplayPages = 10;
        private int ActivePageNumber = 1;
        private int TotalItems = 0;
        private int TotalPages = 0;

        // 🆕 Método de cambio de página
        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await CargarDatos();
        }

        private async Task OnDisplayPagesChanged(int newDisplayPages)
        {
            DisplayPages = newDisplayPages;
            ActivePageNumber = 1;
            await CargarDatos();
        }

        protected override async Task OnInitializedAsync()
        {
            isLoading = true;

            objEventTracking.CodigoHomologacionMenu = Routes.MIGRACION_EXCEL;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "migracion-excel";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            var usuarioBaseDatos = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_BaseDatos_Local);
            var usuarioOrigenDatos = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_OrigenDatos_Local);
            var usuarioEstadoMigracion = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_EstadoMigracion_Local);
            var usuarioMigrar = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Migrar_Local);
            var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);

            isRolRead = rolRelacionado == Constantes.KEY_USER_READ;
            isRolOna = rolRelacionado == Constantes.KEY_USER_ONA;
            isRolAdmin = rolRelacionado == Constantes.KEY_USER_CAN;

            if (!isRolAdmin && !isRolOna)
            {
                if (!isRolRead)
                {
                    if (usuarioMigrar != Constantes.SUSPENDIDO ||
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

        private async Task CargarDatos()
        {
            var response = await iLogMigracionService.GetLogMigracionesAsync(ActivePageNumber, DisplayPages);

            listasHevd = response.Data ?? new List<LogMigracionDto>();
            TotalItems = response.TotalCount;
            TotalPages = response.TotalPages;
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
                return;

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
                return;

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
