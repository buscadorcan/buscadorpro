using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.ONA
{
    public partial class Listado
    {
        private bool isLoading = false;
        private bool showModal = false;
        private int? selectedIdONA;
        private List<OnaDto>? listaONAs;
        private Button saveButton = default!;
        private Grid<OnaDto>? grid;

        [Inject] public IONAService? iONAservice { get; set; }
        [Inject] public Infractruture.Services.ToastService? toastService { get; set; }
        [Inject] public NavigationManager? navigationManager { get; set; }
        [Inject] public ILocalStorageService iLocalStorageService { get; set; }
        [Inject] private IBusquedaService iBusquedaService { get; set; }
        [Inject] IJSRuntime JSRuntime { get; set; }

        private EventTrackingDto objEventTracking { get; set; } = new();
        private bool isRolAdmin;

        // Nueva configuración de paginación
        private int DisplayPages = 10;
        private int ActivePageNumber = 1;
        private int TotalItems => listaONAs?.Count ?? 0;
        private int TotalPages => TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / DisplayPages) : 1;

        private IEnumerable<OnaDto> PaginatedItems => listaONAs?
            .Skip((ActivePageNumber - 1) * DisplayPages)
            .Take(DisplayPages)
            .ToList() ?? new List<OnaDto>();

        private async Task OnDisplayPagesChanged(int newDisplayPages)
        {
            DisplayPages = newDisplayPages;
            ActivePageNumber = 1;
            await LoadONAs();
        }

        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await LoadONAs();
        }

        private async Task LoadONAs()
        {
            isLoading = true;

            if (iONAservice != null)
            {
                var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                isRolAdmin = rolRelacionado == Constantes.KEY_USER_CAN;

                if (isRolAdmin)
                {
                    listaONAs = await iONAservice.GetONAsAsync() ?? new List<OnaDto>();
                }
                else
                {
                    int IdOna = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
                    listaONAs = await iONAservice.GetListByONAsAsync(IdOna) ?? new List<OnaDto>();
                }

                // Validar si la página actual existe tras el recálculo
                if (ActivePageNumber > TotalPages)
                {
                    ActivePageNumber = TotalPages;
                }
            }

            isLoading = false;
        }

        private async Task<GridDataProviderResult<OnaDto>> ONAsDataProvider(GridDataProviderRequest<OnaDto> request)
        {
            if (listaONAs is null && iONAservice != null)
            {
                await LoadONAs();
            }

            return await Task.FromResult(request.ApplyTo(listaONAs ?? new List<OnaDto>()));
        }

        private void OpenDeleteModal(int idONA)
        {
            selectedIdONA = idONA;
            showModal = true;
        }

        private void CloseModal()
        {
            selectedIdONA = null;
            showModal = false;
        }

        private async Task ConfirmDelete()
        {
            objEventTracking.CodigoHomologacionMenu = "/onas";
            objEventTracking.NombreAccion = Constantes.CONFIRMAR_DELETE;
            objEventTracking.NombreControl = "btnEliminar";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;

            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (selectedIdONA.HasValue && iONAservice != null)
            {
                var result = await iONAservice.DeleteONAAsync(selectedIdONA.Value);

                if (result)
                {
                    CloseModal();
                    toastService?.CreateToastMessage(ToastType.Success, "Registro eliminado exitosamente.");
                    await LoadONAs();
                    await grid?.RefreshDataAsync();
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar el registro.");
                }
            }
        }

        protected override async Task OnInitializedAsync()
        {
            objEventTracking.CodigoHomologacionMenu = "/onas";
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "onas";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;

            await iBusquedaService.AddEventTrackingAsync(objEventTracking);
            await LoadONAs();
        }

        private string sortColumn = nameof(OnaDto.RazonSocial);
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

            listaONAs = sortAscending
                ? listaONAs.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
                : listaONAs.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }

        private async Task ExportarExcel()
        {
            if (listaONAs == null || !listaONAs.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iONAservice.ExportarExcelAsync();
                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.xlsx";
                await JSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);
            }
            catch (Exception ex)
            {
                toastService?.CreateToastMessage(ToastType.Danger, $"Error al exportar Excel: {ex.Message}");
            }
        }

        private async Task ExportarPDF()
        {
            if (listaONAs == null || !listaONAs.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iONAservice.ExportarPdfAsync();
                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.pdf";
                await JSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);
            }
            catch (Exception ex)
            {
                toastService?.CreateToastMessage(ToastType.Danger, $"Error al exportar PDF: {ex.Message}");
            }
        }
    }
}
