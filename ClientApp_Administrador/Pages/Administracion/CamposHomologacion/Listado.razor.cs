using BlazorBootstrap;
using Blazored.LocalStorage;
using Infractruture.Interfaces;
using iTextSharp.text;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;
using SharedApp.Helpers;

namespace ClientAppAdministrador.Pages.Administracion.CamposHomologacion
{
    public partial class Listado
    {
        private HomologacionDto? homologacionSelected;
        private List<HomologacionDto>? listaHomologacions = new();
        private List<HomologacionDto>? listaVwHomologacion;
        private int? selectedIdHomologacion;
        private bool showModal;
        private bool IsAdd;
        private bool isLoading = false;

        [Inject] private ICatalogosService? iCatalogosService { get; set; }
        [Inject] private IHomologacionService? iHomologacionService { get; set; }
        [Inject] public Infractruture.Services.ToastService? toastService { get; set; }
        [Inject] protected IJSRuntime? JSRuntime { get; set; }
        [Inject] private IBusquedaService iBusquedaService { get; set; }
        [Inject] ILocalStorageService iLocalStorageService { get; set; }

        private EventTrackingDto objEventTracking { get; set; } = new();

        // Paginación
        private int ActivePageNumber = 1;
        private int DisplayPages = 10;
        private int TotalItems = 0;
        private int TotalPages = 0;

        private List<HomologacionDto> homologaciones = new();

        protected override async Task OnInitializedAsync()
        {
            isLoading = true;

            objEventTracking.CodigoHomologacionMenu = Routes.CAMPO_HOMOLOGACION;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = Constantes.NOMBRE_CONTROL_HOMOLOGACION;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (iCatalogosService != null)
            {
                listaVwHomologacion = await iCatalogosService.GetHomologacionAsync<List<HomologacionDto>>("grupos");
            }

            await CargarDatos();

            isLoading = false;
        }

        private async Task CargarDatos()
        {
            if (homologacionSelected == null)
                return;

            listaHomologacions.Clear();
            IsAdd = homologacionSelected.CodigoHomologacion == Constantes.KEY_DIM_ESQUEMA;

            var response = await iHomologacionService.GetHomologacionsSelectAsync(homologacionSelected.CodigoHomologacion, ActivePageNumber, DisplayPages);

            listaHomologacions = response.Data;

            if (response.TotalCount > 0)
            {
                homologaciones = response.Data;
                TotalItems = response.TotalCount;
                TotalPages = response.TotalPages;
            }
            else
            {
                homologaciones = new();
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
            ActivePageNumber = 1;
            await CargarDatos();
        }

        private async Task OnAutoCompleteChangedHandler(ChangeEventArgs e)
        {
            var selectedId = Convert.ToInt32(e.Value);
            var selectedHomologacion = listaVwHomologacion?.FirstOrDefault(h => h.IdHomologacion == selectedId);

            if (selectedHomologacion != null)
            {
                homologacionSelected = selectedHomologacion;
                IsAdd = homologacionSelected.CodigoHomologacion == Constantes.KEY_DIM_ESQUEMA;
                await CargarDatos();
            }
        }

        [JSInvokable]
        public async Task OnDragEnd(string[] sortedIds)
        {
            for (int i = 0; i < sortedIds.Length; i++)
            {
                var homo = listaHomologacions.FirstOrDefault(h => h.IdHomologacion == int.Parse(sortedIds[i]));
                if (homo != null && homo.MostrarWebOrden != i + 1)
                {
                    homo.MostrarWebOrden = i + 1;
                    if (homo.IdHomologacion == 0)
                        await iHomologacionService.Registrar(homo);
                    else
                        await iHomologacionService.Actualizar(homo);
                }
            }
        }

        private void OpenDeleteModal(int idHomologacion)
        {
            selectedIdHomologacion = idHomologacion;
            showModal = true;
        }

        private void CloseModal()
        {
            selectedIdHomologacion = null;
            showModal = false;
        }

        private async Task ConfirmDelete()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.CAMPO_HOMOLOGACION;
            objEventTracking.NombreAccion = Constantes.CONFIRMAR_DELETE;
            objEventTracking.NombreControl = Constantes.BTN_DELETE;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (selectedIdHomologacion.HasValue && iHomologacionService != null)
            {
                var result = await iHomologacionService.DeleteHomologacionAsync(selectedIdHomologacion.Value);
                if (result)
                {
                    CloseModal();
                    toastService?.CreateToastMessage(ToastType.Success, "Registro eliminado exitosamente.");
                    await LoadHomologacion();
                    await CargarDatos();
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar el registro.");
                }
            }
        }

        private async Task LoadHomologacion()
        {
            if (iHomologacionService != null)
            {
                listaHomologacions = await iHomologacionService.GetHomologacionsAsync();
            }
        }

        private async Task ExportarExcel()
        {
            if (listaHomologacions == null || !listaHomologacions.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iHomologacionService.ExportarExcelAsync(homologacionSelected.CodigoHomologacion);
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
            if (listaHomologacions == null || !listaHomologacions.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iHomologacionService.ExportarPdfAsync(homologacionSelected.CodigoHomologacion);
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
