using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.ONA
{
    /// <summary>
    /// Página de listado de ONAs (Organismos Nacionales de Acreditación).
    /// Permite visualizar, paginar y eliminar registros de ONAs.
    /// </summary>
    public partial class Listado
    {
        private bool isLoading = false;
        // Controla la visibilidad del modal de eliminación
        private bool showModal = false; // Controla la visibilidad del modal
        // ID del ONA seleccionado para eliminación
        private int? selectedIdONA;    // Almacena el ID del ONA seleccionado
        // Lista de ONAs obtenidos desde el servicio
        private List<OnaDto>? listaONAs; // Lista de registros ONAs
        // Botón de guardar con animación de carga
        private Button saveButton = default!;
        // Componente de la grilla para mostrar la lista de ONAs
        private Grid<OnaDto>? grid;
        /// <summary>
        /// Servicio de gestión de ONAs.
        /// </summary>
        [Inject]
        public IONAService? iONAservice { get; set; }
        /// <summary>
        /// Servicio de notificaciones Toast.
        /// </summary>
        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        /// <summary>
        /// Servicio de navegación.
        /// </summary>
        [Inject]
        public NavigationManager? navigationManager { get; set; }
        /// <summary>
        /// Servicio de almacenamiento local en el navegador.
        /// </summary>
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }
        /// <summary>
        /// Servicio de búsqueda y registro de eventos.
        /// </summary>
        [Inject] private IBusquedaService iBusquedaService { get; set; }

        [Inject] IJSRuntime JSRuntime { get; set; }
        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();
        // Indica si el usuario tiene rol de administrador
        private bool isRolAdmin;

        /// <summary>
        /// Método que carga la lista de ONAs según el rol del usuario.
        /// </summary>
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
            }
            // Ajusta la paginación si la lista está vacía o cambia
            if (listaONAs.Count > 0 && CurrentPage > TotalPages)
            {
                CurrentPage = TotalPages;
            }
            isLoading = false;
        }
        // Configuración de paginación
        private int PageSize = 10; // Cantidad de registros por página
        private int CurrentPage = 1;

        /// <summary>
        /// Obtiene los elementos paginados para la grilla.
        /// </summary>
        private IEnumerable<OnaDto> PaginatedItems => listaONAs
            .Skip((CurrentPage - 1) * PageSize)
            .Take(PageSize);

        /// <summary>
        /// Calcula el número total de páginas basado en el número de registros.
        /// </summary>
        private int TotalPages => (listaONAs?.Count ?? 0) > 0 ? (int)Math.Ceiling((double)(listaONAs?.Count ?? 0) / PageSize) : 1;
        /// <summary>
        /// Calcula el número total de páginas basado en el número de registros.
        /// </summary>
        private bool CanGoPrevious => CurrentPage > 1;
        /// <summary>
        /// Indica si se puede avanzar a la siguiente página.
        /// </summary>
        private bool CanGoNext => CurrentPage < TotalPages;

        /// <summary>
        /// Cambia a la página anterior en la paginación.
        /// </summary>
        private void PreviousPage()
        {
            if (CanGoPrevious)
            {
                CurrentPage--;
            }
        }

        /// <summary>
        /// Cambia a la siguiente página en la paginación.
        /// </summary>
        private void NextPage()
        {
            if (CanGoNext)
            {
                CurrentPage++;
            }
        }

        /// <summary>
        /// Proveedor de datos para la grilla de ONAs.
        /// </summary>

        private async Task<GridDataProviderResult<OnaDto>> ONAsDataProvider(GridDataProviderRequest<OnaDto> request)
        {
            try
            {
                if (listaONAs is null && iONAservice != null)
                {
                    await LoadONAs(); // Carga los datos si aún no están cargados
                }

                return await Task.FromResult(request.ApplyTo(listaONAs ?? new List<OnaDto>()));
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Abre el modal de confirmación de eliminación.
        /// </summary>
        /// <param name="idONA">ID del ONA a eliminar.</param>
        private void OpenDeleteModal(int idONA)
        {
            selectedIdONA = idONA;
            showModal = true;
        }

        /// <summary>
        /// Cierra el modal de confirmación de eliminación.
        /// </summary>
        private void CloseModal()
        {
            selectedIdONA = null;
            showModal = false;
        }

        /// <summary>
        /// Confirma la eliminación de un ONA.
        /// </summary>
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
                    CloseModal(); // Cierra el modal
                    toastService?.CreateToastMessage(ToastType.Success, "Registro eliminado exitosamente.");
                    await LoadONAs(); // Actualiza la lista
                    await grid?.RefreshDataAsync(); //resfresca la grilla
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar el registro.");
                }
            }

        }

        /// <summary>
        /// Método asincrónico que se ejecuta al inicializar el componente.
        /// </summary>
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

            await LoadONAs(); // Carga la lista al iniciar el componente
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
                toastService?.CreateToastMessage(ToastType.Danger, $"Error al exportar Excel: {ex.Message}");
            }
        }
    }
}
