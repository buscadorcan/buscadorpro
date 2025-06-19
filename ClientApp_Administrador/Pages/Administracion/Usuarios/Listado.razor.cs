using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;
using Microsoft.JSInterop;
using Newtonsoft.Json;
using SharedApp.Response;
using System.Net.Http;
using System;

namespace ClientAppAdministrador.Pages.Administracion.Usuarios
{
    public partial class Listado
    {
        private List<UsuarioDto>? listaUsuarios;
        private bool isRolRead; // Variable para controlar la visibilidad del bot�n
        private bool showModal; // Controlar la visibilidad de la ventana modal  
        private string modalMessage;
        private int rolCargo;
        private int onaPais;
        private bool isLoading = false;

        [Inject]
        IUsuariosService? iUsuariosService { get; set; }
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }
        [Inject]
        private NavigationManager iNavigationManager { get; set; }

        private List<VwRolDto>? listaRoles;
        private List<OnaDto>? listaOna;

        private Button saveButton = default!;
        private Grid<UsuarioDto>? grid;
        private int? selectedIdUsuario;    // Almacena el ID del usuario seleccionado
        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        [Inject] IJSRuntime JSRuntime { get; set; }
        private EventTrackingDto objEventTracking { get; set; } = new();
        private int PageSize = 10; // Cantidad de registros por p�gina
        private int CurrentPage = 1;

        private IEnumerable<UsuarioDto> PaginatedItems => listaUsuarios
            .Skip((CurrentPage - 1) * PageSize)
            .Take(PageSize);

        private int TotalPages => (listaUsuarios?.Count ?? 0) > 0 ? (int)Math.Ceiling((double)(listaUsuarios?.Count ?? 0) / PageSize) : 1;

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
        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            objEventTracking.CodigoHomologacionMenu = "/usuarios";
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "usuarios";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local); objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            onaPais = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
            listaUsuarios = await iUsuariosService.GetUsuariosAsync();
            listaOna = await iUsuariosService.GetOnaAsync();

            var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            var onaRelacionado = listaOna.FirstOrDefault(ona => ona.IdONA == onaPais);

            isRolRead = rolRelacionado == Constantes.KEY_USER_READ;

            // Ajusta la paginaci�n si la lista est� vac�a o cambia
            if (listaUsuarios.Count > 0 && CurrentPage > TotalPages)
            {
                CurrentPage = TotalPages;
            }
            isLoading = false;
        }
        private async void EditarUsuario(UsuarioDto usuario)
        {

            onaPais = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
            listaUsuarios = await iUsuariosService.GetUsuariosAsync();

            listaRoles = await iUsuariosService.GetRolesAsync();
            listaOna = await iUsuariosService.GetOnaAsync();

            var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            var onaRelacionado = listaOna.FirstOrDefault(ona => ona.IdONA == onaPais);
            var Homolog = listaUsuarios.FirstOrDefault(usu => usu.IdUsuario == usuario.IdUsuario);
            var rolUsuario = listaRoles.FirstOrDefault(rol => rol.IdHomologacionRol == Homolog.IdHomologacionRol);

            if (rolRelacionado == Constantes.KEY_USER_ONA && rolUsuario.CodigoHomologacion == Constantes.KEY_USER_CAN)
            {
                // No tiene permisos, mostrar la modal
                modalMessage = "No tiene permisos para editar este usuario.";
                showModal = true;
                StateHasChanged(); // Forzar la actualizaci�n de la interfaz
            }

            if (usuario.IdONA != onaPais && rolRelacionado == Constantes.KEY_USER_ONA)
            {
                modalMessage = "No tiene permisos para editar este usuario porque no pertenece a este Pa�s.";
                showModal = true;
                StateHasChanged(); // Forzar la actualizaci�n de la interfaz
            }

            if (usuario.IdONA == onaPais && rolRelacionado == Constantes.KEY_USER_CAN)
            {
                modalMessage = "No tiene permisos para editar este usuario porque no pertenece a este Pa�s.";
                showModal = true;
                StateHasChanged(); // Forzar la actualizaci�n de la interfaz
            }

            if (rolRelacionado == Constantes.KEY_USER_ONA && usuario.IdONA == onaPais && rolUsuario.CodigoHomologacion != Constantes.KEY_USER_CAN)
            {
                // Navegar al editar usuario
                iNavigationManager.NavigateTo($"/editar-usuario/{usuario.IdUsuario}");
            }

            if (rolRelacionado == Constantes.KEY_USER_CAN)
            {
                // Navegar al editar usuario
                iNavigationManager.NavigateTo($"/editar-usuario/{usuario.IdUsuario}");
            }
        }
        private void CerrarModal()
        {
            showModal = false;
        }
        private async Task<GridDataProviderResult<UsuarioDto>> UsuariosDataProvider(GridDataProviderRequest<UsuarioDto> request)
        {
            if (listaUsuarios is null && iUsuariosService != null)
            {
                listaUsuarios = await iUsuariosService.GetUsuariosAsync();
            }

            return await Task.FromResult(request.ApplyTo(listaUsuarios ?? new List<UsuarioDto>()));
        }
        // Abre el modal
        private void OpenDeleteModal(int idUsuario)
        {
            selectedIdUsuario = idUsuario;
            showModal = true;
        }

        // Cierra el modal
        private void CloseModal()
        {
            selectedIdUsuario = null;
            showModal = false;
        }

        // Confirmar eliminaci�n del registro
        private async Task ConfirmDelete()
        {
            objEventTracking.CodigoHomologacionMenu = "/usuarios";
            objEventTracking.NombreAccion = Constantes.CONFIRMAR_DELETE;
            objEventTracking.NombreControl = "btnEliminar";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);
            if (selectedIdUsuario.HasValue && iUsuariosService != null)
            {
                var result = await iUsuariosService.DeleteUsuarioAsync(selectedIdUsuario.Value);
                if (result)
                {
                    CloseModal(); // Cierra el modal
                    toastService?.CreateToastMessage(ToastType.Success, "Registro eliminado exitosamente.");
                    iNavigationManager?.NavigateTo("/usuarios");
                    await LoadUsuarios(); // Actualiza la lista
                    //await grid?.RefreshDataAsync(); //resfresca la grilla
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar el registro.");
                    iNavigationManager?.NavigateTo("/usuarios");
                }
            }

        }
        // M�todo para cargar la lista de Usuarios
        private async Task LoadUsuarios()
        {
            if (iUsuariosService != null)
            {
                listaUsuarios = await iUsuariosService.GetUsuariosAsync();
            }
        }

        private string sortColumn = nameof(UsuarioDto.Nombre);
        private bool sortAscending = true;

        private void OrdenarPor(string columnName)
        {
            if (sortColumn == columnName)
            {
                sortAscending = !sortAscending; // Invierte el orden si es la misma columna
            }
            else
            {
                sortColumn = columnName;
                sortAscending = true;
            }

            // Ordenar la lista
            listaUsuarios = sortAscending
                ? listaUsuarios.OrderBy(u => typeof(UsuarioDto).GetProperty(sortColumn)?.GetValue(u, null)).ToList()
                : listaUsuarios.OrderByDescending(u => typeof(UsuarioDto).GetProperty(sortColumn)?.GetValue(u, null)).ToList();
        }
        private async Task ExportarExcel()
        {
            if (listaUsuarios == null || !listaUsuarios.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iUsuariosService.ExportarExcelAsync();
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
            if (listaUsuarios == null || !listaUsuarios.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iUsuariosService.ExportarPdfAsync();
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
