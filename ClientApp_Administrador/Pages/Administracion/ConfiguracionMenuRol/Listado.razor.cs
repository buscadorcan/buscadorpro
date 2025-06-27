using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.ConfiguracionMenuRol
{
    public partial class Listado
    {
        private bool showModal = false;
        private int? selectedIdHRol;
        private int? selectedIdHMenu;
        private List<MenuRolDto>? listaMenus;
        private Button saveButton = default!;
        private bool isLoading = false;

        [Inject]
        public IMenuService? iMenuService { get; set; }

        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }

        [Inject]
        public NavigationManager? navigationManager { get; set; }
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        private EventTrackingDto objEventTracking { get; set; } = new();
        private List<MenuRolDto> listaMenusOriginal = new();
        private bool estadoActivo;
        private MenuRolDto configuracionMenu = new MenuRolDto();

        // 🆕 Paginación
        private int DisplayPages = 10;
        private int ActivePageNumber = 1;
        private int TotalItems => listaMenus?.Count ?? 0;
        private int TotalPages => TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / DisplayPages) : 1;

        private IEnumerable<MenuRolDto> PaginatedItems => listaMenus?
            .Skip((ActivePageNumber - 1) * DisplayPages)
            .Take(DisplayPages)
            .ToList() ?? new List<MenuRolDto>();

        private async Task OnDisplayPagesChanged(int newDisplayPages)
        {
            DisplayPages = newDisplayPages;
            ActivePageNumber = 1;
            await LoadMenus();
        }

        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await LoadMenus();
        }
        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            objEventTracking.CodigoHomologacionMenu = Routes.MENU_ROL;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "menu-config-lista";
            objEventTracking.NombreUsuario = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Nombre_Local) + ' ' +
                                              await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Apellido_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            await LoadMenus();
            listaMenusOriginal = new List<MenuRolDto>(listaMenus);
            isLoading = false;
        }
        private async Task LoadMenus()
        {
            listaMenus = await iMenuService.GetMenusAsync() ?? new List<MenuRolDto>();
        }

        private void OpenDeleteModal(int? idHRol, int? idHMenu)
        {
            selectedIdHRol = idHRol;
            selectedIdHMenu = idHMenu;
            showModal = true;
        }

        private void CloseModal()
        {
            selectedIdHRol = null;
            selectedIdHMenu = null;
            showModal = false;
        }

        //Modificación: No recargar toda la lista después de eliminar un elemento
        private async Task ConfirmDelete(MenuRolDto menu)
        {
            objEventTracking.CodigoHomologacionMenu = Routes.MENU_ROL;
            objEventTracking.NombreAccion =Constantes.CONFIRMAR_DELETE;
            objEventTracking.NombreControl = Constantes.BTN_DELETE;
            objEventTracking.NombreUsuario = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Nombre_Local) + ' ' +
                                              await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Apellido_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (menu != null && iMenuService != null)
            {

                var result = await iMenuService.DeleteMenuAsync(menu.IdHRol, menu.IdHMenu);
                if (result)
                {
                    // Modificar solo el estado del elemento en la lista sin recargar toda la lista
                    var menuModificado = listaMenus?.FirstOrDefault(m => m.IdHRol == menu.IdHRol && m.IdHMenu == menu.IdHMenu);
                    if (menuModificado != null)
                    {
                        menuModificado.Estado = menuModificado.Estado == Constantes.ACTIVO ? "X" : Constantes.ACTIVO;
                    }

 
                    CloseModal();
                    if (menuModificado.Estado == Constantes.ACTIVO)
                    {
                        toastService?.CreateToastMessage(ToastType.Success, "Menú activado correctamente.");
                    }
                    else
                    {
                        toastService?.CreateToastMessage(ToastType.Success, "Menú desactivado correctamente.");
                    }

                    StateHasChanged(); // Forzar actualización sin recargar toda la página
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al desactivar el registro.");
                }
            }
        }

        private string filtroBusqueda =  Constantes.VACIO;

        private void FiltrarLista(ChangeEventArgs e)
        {
            isLoading = true;
            filtroBusqueda = e.Value?.ToString()?.ToLower() ??  Constantes.VACIO;

            if (string.IsNullOrWhiteSpace(filtroBusqueda))
            {
                // Restaurar la lista original y la paginación
                listaMenus = new List<MenuRolDto>(listaMenusOriginal);
            }
            else
            {
                // Aplicar el filtro sobre la lista original
                listaMenus = listaMenusOriginal
                    .Where(m => m.Rol.ToLower().Contains(filtroBusqueda) || m.Menu.ToLower().Contains(filtroBusqueda))
                    .ToList();
            }

            // Reiniciar a la primera página para mostrar resultados correctamente

            isLoading = false;
        }


        private string sortColumn = nameof(MenuRolDto.Rol);
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

            listaMenus = sortAscending
                ? listaMenus.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
                : listaMenus.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }

        private async Task ExportarExcel()
        {
            if (listaMenus == null || !listaMenus.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }
            var datos = listaMenus.ToList();
            try
            {
                var base64 = await iMenuService.ExportarExcelAsync();
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
            if (listaMenus == null || !listaMenus.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }
            try
            {
                var base64 = await iMenuService.ExportarPdfAsync();
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
