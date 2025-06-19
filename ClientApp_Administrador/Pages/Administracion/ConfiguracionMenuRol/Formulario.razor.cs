using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.ConfiguracionMenuRol
{
    public partial class Formulario
    {
        private Button saveButton = default!;
        private MenuRolDto configuracionMenu = new MenuRolDto();
        private List<VwRolDto> roles = new(); // Lista para almacenar roles
        public List<MenuPaginaDto> menus = new(); // Lista para almacenar menus
        [Parameter] public int? IdHRol { get; set; }
        [Parameter] public int? IdHMenu { get; set; }
        [Inject]
        public IMenuService? iMenuService { get; set; }
        [Inject]
        public IUtilitiesService? iUtilService { get; set; }
        [Inject]
        public NavigationManager? navigationManager { get; set; }
        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }
        private bool isRol16; 

        [Inject]
        public IUsuariosService? iUsuariosService { get; set; }
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        private EventTrackingDto objEventTracking { get; set; } = new();
        protected override async Task OnInitializedAsync()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.NUEVO_MENU_ROL;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "nuevo-config-menu";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (iUsuariosService != null)
            {
                roles = await iUsuariosService.GetRolesAsync();
            }

            //var rol = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Rol_Local);
            var rol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            
            var rolCombox = roles.FirstOrDefault(role => role.CodigoHomologacion == rol);
            isRol16 = rolCombox.CodigoHomologacion == Constantes.KEY_USER_ONA;

            if (roles != null && roles.Any())
            {
                // Filtrar los roles cuando isRol16 es verdadero
                if (isRol16)
                {
                    roles = roles.Where(rol => rol.CodigoHomologacion == Constantes.KEY_USER_ONA || rol.CodigoHomologacion == Constantes.KEY_USER_READ).ToList();
                }
                else
                {
                    roles = await iUsuariosService.GetRolesAsync();
                    
                }
            }
            else
            {
                roles = new List<VwRolDto>();
            }

        }
        private async Task CargarMenus(ChangeEventArgs e)
        {
            if (int.TryParse(e.Value?.ToString(), out int idRol))
            {
                configuracionMenu.IdHRol = idRol;

                if (iMenuService != null)
                {
                    menus = await iMenuService.GetMenusPendingConfigAsync(idRol);
                    // Si hay menús, asignar el primero por defecto
                    if (menus.Any())
                    {
                        configuracionMenu.IdHMenu = menus.First().IdHomologacion;
                    }
                }
            }
            else
            {
                menus = new List<MenuPaginaDto>(); // Si no hay rol seleccionado, vaciar la lista
            }

            StateHasChanged();
        }

        private async Task RegistrarConfiguracionMenu()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.NUEVO_MENU_ROL;
            objEventTracking.NombreAccion = "RegistrarConfiguracionMenu";
            objEventTracking.NombreControl = Constantes.BTN_GUARDAR;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            saveButton.ShowLoading(Constantes.GUARDANDO);
            if (configuracionMenu.IdHRol <= 0)
            {
                toastService?.CreateToastMessage(ToastType.Warning, "Debe seleccionar un Rol antes de guardar.");
                navigationManager?.NavigateTo(Routes.NUEVO_MENU_ROL);
                saveButton.HideLoading();
                return;
            }

            if (configuracionMenu.IdHMenu <= 0)
            {
                toastService?.CreateToastMessage(ToastType.Warning, "Debe seleccionar un Menú antes de guardar.");
                navigationManager?.NavigateTo(Routes.NUEVO_MENU_ROL);
                saveButton.HideLoading();
                return;
            }
            if (iMenuService != null)
            {
                var result = await iMenuService.RegistrarMenuActualizar(configuracionMenu);
                if (result.registroCorrecto)
                {
                    toastService?.CreateToastMessage(ToastType.Success, "Configuración guardada exitosamente");
                    navigationManager?.NavigateTo(Routes.MENU_ROL);
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al guardar la configuración");
                    navigationManager?.NavigateTo(Routes.NUEVO_MENU_ROL);
                }
            }

            saveButton.HideLoading();
        }

        private void Regresar()
        {
            navigationManager?.NavigateTo(Routes.MENU_ROL);
        }
    }
}
