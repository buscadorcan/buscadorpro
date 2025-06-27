// ... usings omitidos para brevedad
using BlazorBootstrap;
using Blazored.LocalStorage;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;
using SharedApp.Helpers;

namespace ClientAppAdministrador.Pages.Administracion.Usuarios
{
    public partial class Listado
    {
        private List<UsuarioDto>? listaUsuarios;
        private List<VwRolDto>? listaRoles;
        private List<OnaDto>? listaOna;

        private bool isRolRead;
        private bool showModal;
        private string modalMessage;
        private int rolCargo;
        private int onaPais;
        private bool isLoading = false;

        private Button saveButton = default!;
        private Grid<UsuarioDto>? grid;
        private int? selectedIdUsuario;

        [Inject] IUsuariosService? iUsuariosService { get; set; }
        [Inject] ILocalStorageService iLocalStorageService { get; set; }
        [Inject] private NavigationManager iNavigationManager { get; set; }
        [Inject] public Infractruture.Services.ToastService? toastService { get; set; }
        [Inject] private IBusquedaService iBusquedaService { get; set; }
        [Inject] IJSRuntime JSRuntime { get; set; }

        private EventTrackingDto objEventTracking { get; set; } = new();

        // 🆕 Paginación
        private int DisplayPages = 10;
        private int ActivePageNumber = 1;
        private int TotalItems => listaUsuarios?.Count ?? 0;
        private int TotalPages => TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / DisplayPages) : 1;

        private IEnumerable<UsuarioDto> PaginatedItems => listaUsuarios?
            .Skip((ActivePageNumber - 1) * DisplayPages)
            .Take(DisplayPages)
            .ToList() ?? new List<UsuarioDto>();

        private async Task OnDisplayPagesChanged(int newDisplayPages)
        {
            DisplayPages = newDisplayPages;
            ActivePageNumber = 1;
            await LoadUsuarios();
        }

        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await LoadUsuarios();
        }

        protected override async Task OnInitializedAsync()
        {
            isLoading = true;

            objEventTracking.CodigoHomologacionMenu = "/usuarios";
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "usuarios";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;

            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            onaPais = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
            listaUsuarios = await iUsuariosService.GetUsuariosAsync();
            listaOna = await iUsuariosService.GetOnaAsync();

            var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            isRolRead = rolRelacionado == Constantes.KEY_USER_READ;

            if (listaUsuarios.Count > 0 && ActivePageNumber > TotalPages)
            {
                ActivePageNumber = TotalPages;
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
                modalMessage = "No tiene permisos para editar este usuario.";
                showModal = true;
                StateHasChanged();
            }

            if (usuario.IdONA != onaPais && rolRelacionado == Constantes.KEY_USER_ONA)
            {
                modalMessage = "No tiene permisos para editar este usuario porque no pertenece a este País.";
                showModal = true;
                StateHasChanged();
            }

            if (usuario.IdONA == onaPais && rolRelacionado == Constantes.KEY_USER_CAN)
            {
                modalMessage = "No tiene permisos para editar este usuario porque no pertenece a este País.";
                showModal = true;
                StateHasChanged();
            }

            if (rolRelacionado == Constantes.KEY_USER_ONA && usuario.IdONA == onaPais && rolUsuario.CodigoHomologacion != Constantes.KEY_USER_CAN)
            {
                iNavigationManager.NavigateTo($"/editar-usuario/{usuario.IdUsuario}");
            }

            if (rolRelacionado == Constantes.KEY_USER_CAN)
            {
                iNavigationManager.NavigateTo($"/editar-usuario/{usuario.IdUsuario}");
            }
        }

        private void CerrarModal() => showModal = false;

        private async Task<GridDataProviderResult<UsuarioDto>> UsuariosDataProvider(GridDataProviderRequest<UsuarioDto> request)
        {
            if (listaUsuarios is null && iUsuariosService != null)
            {
                listaUsuarios = await iUsuariosService.GetUsuariosAsync();
            }

            return await Task.FromResult(request.ApplyTo(listaUsuarios ?? new List<UsuarioDto>()));
        }

        private void OpenDeleteModal(int idUsuario)
        {
            selectedIdUsuario = idUsuario;
            showModal = true;
        }

        private void CloseModal()
        {
            selectedIdUsuario = null;
            showModal = false;
        }

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
                    CloseModal();
                    toastService?.CreateToastMessage(ToastType.Success, "Registro eliminado exitosamente.");
                    iNavigationManager?.NavigateTo("/usuarios");
                    await LoadUsuarios();
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar el registro.");
                    iNavigationManager?.NavigateTo("/usuarios");
                }
            }
        }

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
                sortAscending = !sortAscending;
            }
            else
            {
                sortColumn = columnName;
                sortAscending = true;
            }

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
                toastService?.CreateToastMessage(ToastType.Danger, $"Error al exportar PDF: {ex.Message}");
            }
        }
    }
}
