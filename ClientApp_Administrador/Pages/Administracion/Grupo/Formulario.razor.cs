using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;
using Infractruture.Models;

namespace ClientAppAdministrador.Pages.Administracion.Grupo
{
    /// <summary>
    /// Componente de formulario para la gestión de homologaciones dentro de un grupo.
    /// Permite registrar y actualizar registros de homologación.
    /// </summary>
    public partial class Formulario
    {
        // Botón de guardar con animación de carga
        private Button saveButton = default!;
        // Objeto que almacena la información de la homologación a registrar o actualizar
        private HomologacionDto homologacion = new HomologacionDto();
        /// <summary>
        /// Servicio de homologaciones, utilizado para registrar y actualizar datos.
        /// </summary>
        [Inject]
        public IHomologacionService? iHomologacionService { get; set; }
        /// <summary>
        /// Servicio de navegación entre páginas.
        /// </summary>
        [Inject]
        public NavigationManager? navigationManager { get; set; }

        /// <summary>
        /// ID del grupo de homologaciones, nulo si se está creando un nuevo registro.
        /// </summary>
        [Parameter]
        public int? Id { get; set; }
        /// <summary>
        /// Servicio de notificaciones Toast.
        /// </summary>
        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        /// <summary>
        /// Servicio de búsqueda y registro de eventos.
        /// </summary>
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        /// <summary>
        /// Servicio de almacenamiento local en el navegador.
        /// </summary>
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }

        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();

        // Lista de homologaciones asociadas al grupo
        private IEnumerable<HomologacionDto>? lista = new List<HomologacionDto>();

        /// <summary>
        /// Método asincrónico que se ejecuta al inicializar el componente.
        /// Carga la información de la homologación si se está editando.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.EDITAR_GRUPO; 
            objEventTracking.NombreAccion = "editar-grupos";
            objEventTracking.NombreControl = Constantes.ON_INITIALIZED;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (Id > 0 && iHomologacionService != null) {
                homologacion = await iHomologacionService.GetHomologacionAsync(Id.Value);
            } else {
                homologacion.InfoExtraJson =  Constantes.JSON_VACIO;
            }
        }

        /// <summary>
        /// Método invocable desde JavaScript para actualizar el orden de las homologaciones en la lista.
        /// </summary>
        /// <param name="sortedIds">Lista ordenada de IDs de homologaciones.</param>
        [JSInvokable]
        public async Task OnDragEnd(string[] sortedIds)
        {
            var tempList = new List<HomologacionDto>();
            for (int i = 0; i < sortedIds.Length; i++)
            {
                var homo = lista?.FirstOrDefault(h => h.IdHomologacion == int.Parse(sortedIds[i]));
                if (homo != null)
                {
                    homo.MostrarWebOrden = i + 1;
                    tempList.Add(homo);
                }
            }
            lista = tempList;
            await Task.CompletedTask;
        }

        /// <summary>
        /// Método que guarda o actualiza una homologación en la base de datos.
        /// </summary>
        private async Task GuardarHomologacion()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.EDITAR_GRUPO;
            objEventTracking.NombreAccion = "GuardarHomologacion";
            objEventTracking.NombreControl =Constantes.BTN_GUARDAR;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            saveButton.ShowLoading(Constantes.GUARDANDO);

            if (iHomologacionService != null)
            {
                RespuestaRegistro result;

                if (homologacion.IdHomologacion == 0)
                {
                    result = await iHomologacionService.Registrar(homologacion);
                }
                else
                {
                    result = await iHomologacionService.Actualizar(homologacion);
                }

                if (result.registroCorrecto)
                {
                    toastService?.CreateToastMessage(ToastType.Success, "Registrado exitosamente");
                    navigationManager?.NavigateTo(Routes.GRUPO);
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Debe llenar todos los campos");
                }
            }

            saveButton.HideLoading();
        }
        private void Regresar()
        {
            NavigationManager.NavigateTo(Routes.GRUPO);
        }
    }
}
