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
            if (listaMenus.Count > 0 && CurrentPage > TotalPages)
            {
                CurrentPage = TotalPages;
            }
        }

        private int PageSize = 10;
        private int CurrentPage = 1;
        private IEnumerable<MenuRolDto> PaginatedItems => listaMenus
            .Skip((CurrentPage - 1) * PageSize)
            .Take(PageSize);

        private int TotalPages => (listaMenus?.Count ?? 0) > 0
        ? (int)Math.Ceiling((double)(listaMenus?.Count ?? 0) / PageSize)
        : 1;

        private bool CanGoPrevious => CurrentPage > 1;
        private bool CanGoNext => CurrentPage < TotalPages;

        private void PreviousPage()
        {
            if (CanGoPrevious)
            {
                CurrentPage--;
            }
        }

        private void NextPage()
        {
            if (CanGoNext)
            {
                CurrentPage++;
            }
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

        //Modificaci�n: No recargar toda la lista despu�s de eliminar un elemento
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
                // Guardamos la p�gina actual antes de la modificaci�n
                int paginaActual = CurrentPage;

                var result = await iMenuService.DeleteMenuAsync(menu.IdHRol, menu.IdHMenu);
                if (result)
                {
                    // Modificar solo el estado del elemento en la lista sin recargar toda la lista
                    var menuModificado = listaMenus?.FirstOrDefault(m => m.IdHRol == menu.IdHRol && m.IdHMenu == menu.IdHMenu);
                    if (menuModificado != null)
                    {
                        menuModificado.Estado = menuModificado.Estado == Constantes.ACTIVO ? "X" : Constantes.ACTIVO;
                    }

                    // Restauramos la p�gina actual
                    CurrentPage = paginaActual;

                    CloseModal();
                    if (menuModificado.Estado == Constantes.ACTIVO)
                    {
                        toastService?.CreateToastMessage(ToastType.Success, "Men� activado correctamente.");
                    }
                    else
                    {
                        toastService?.CreateToastMessage(ToastType.Success, "Men� desactivado correctamente.");
                    }

                    StateHasChanged(); // Forzar actualizaci�n sin recargar toda la p�gina
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
                // Restaurar la lista original y la paginaci�n
                listaMenus = new List<MenuRolDto>(listaMenusOriginal);
            }
            else
            {
                // Aplicar el filtro sobre la lista original
                listaMenus = listaMenusOriginal
                    .Where(m => m.Rol.ToLower().Contains(filtroBusqueda) || m.Menu.ToLower().Contains(filtroBusqueda))
                    .ToList();
            }

            // Reiniciar a la primera p�gina para mostrar resultados correctamente
            CurrentPage = 1;

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
