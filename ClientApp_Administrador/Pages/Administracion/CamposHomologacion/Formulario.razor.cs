using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;
using Infractruture.Models;

namespace ClientAppAdministrador.Pages.Administracion.CamposHomologacion
{
    /// <summary>
    /// Componente de formulario para la gesti�n de homologaciones.
    /// Permite registrar y actualizar campos de homologaci�n en la plataforma.
    /// </summary>
    public partial class Formulario
    {
        // Bot�n de guardar con animaci�n de carga
        private Button saveButton = default!;
        // Objeto que almacena los datos de la homologaci�n a registrar/actualizar
        private HomologacionDto homologacion = new HomologacionDto();
        // Objeto que almacena la homologaci�n padre del grupo
        private HomologacionDto homologacionGrupo = new HomologacionDto();
        // Lista de filtros disponibles para la homologaci�n
        private List<VwFiltroDto> filtros = new();
        // Servicio de homologaci�n inyectado
        [Inject]
        public IHomologacionService? iHomologacionService { get; set; }
        // Servicio de cat�logos inyectado
        [Inject]
        public ICatalogosService? iCatalogoService { get; set; }
        // Administrador de navegaci�n inyectado
        [Inject]
        public NavigationManager? navigationManager { get; set; }
        // ID de la homologaci�n (puede ser nulo si se est� creando una nueva)
        [Parameter]
        public int? Id { get; set; }
        // ID del grupo padre de la homologaci�n (puede ser nulo)
        [Parameter]
        public int? IdPadre { get; set; }
        // Servicio de notificaciones Toast inyectado
        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        // Servicio de b�squeda inyectado
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();
        // Servicio de almacenamiento local en el navegador
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }


        /// <summary>
        /// M�todo asincr�nico que inicializa el formulario de homologaci�n.
        /// Carga los filtros disponibles y los datos de la homologaci�n si se est� editando.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            // Obtener los filtros de la base de datos
            filtros = await iCatalogoService.GetFiltrosAsync();
            // Obtener la homologaci�n padre (grupo)
            homologacionGrupo = await iHomologacionService.GetHomologacionAsync((int)IdPadre);
            if (Id > 0)
            {
                objEventTracking.CodigoHomologacionMenu = "/editar-campos-homologacion";
                objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
                objEventTracking.NombreControl = "editar-campos-homologacion";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                homologacion = await iHomologacionService.GetHomologacionAsync(Id.Value);
            }
            else
            {

                objEventTracking.CodigoHomologacionMenu = "/nuevo-campos-homologacion";
                objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
                objEventTracking.NombreControl = "nuevo-campos-homologacion";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                homologacion.IdHomologacionGrupo = IdPadre;
                homologacion.InfoExtraJson = Constantes.JSON_VACIO;
                homologacion.MascaraDato = Constantes.MASCAR_DATOS_TEXTO;
                homologacion.CodigoHomologacion = Constantes.VACIO;
                homologacion.SiNoHayDato = Constantes.VACIO;
            }
        }


        /// <summary>
        /// M�todo que guarda o actualiza una homologaci�n en la base de datos.
        /// </summary>
        private async Task GuardarHomologacion()
        {
            objEventTracking.CodigoHomologacionMenu = "/nuevo-campos-homologacion";
            objEventTracking.NombreAccion = "GuardarHomologacion";
            objEventTracking.NombreControl = Constantes.BTN_GUARDAR;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.JSON_VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            saveButton.ShowLoading(Constantes.GUARDANDO);

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
                navigationManager?.NavigateTo(Routes.CAMPO_HOMOLOGACION);
            }
            else
            {
                toastService?.CreateToastMessage(ToastType.Danger, "Debe llenar todos los campos");
            }

            saveButton.HideLoading();
        }

        /// <summary>
        /// M�todo que actualiza el valor de la m�scara de datos cuando el usuario cambia la selecci�n.
        /// </summary>
        /// <param name="mascaraDato">Valor seleccionado en el campo de m�scara.</param>
        private void OnAutoCompleteChanged(string mascaraDato)
        {
            homologacion.MascaraDato = mascaraDato;
        }

        /// <summary>
        /// M�todo que actualiza el filtro seleccionado en la homologaci�n.
        /// </summary>
        /// <param name="e">Evento de cambio en la selecci�n.</param>
        private void ActualizarFiltro(ChangeEventArgs e)
        {
            // Obtener el valor seleccionado
            var selectedValue = e.Value?.ToString();

            // Si el valor es "Sin Filtro" (vac�o), asignar null a la variable
            if (string.IsNullOrEmpty(selectedValue))
            {
                homologacion.IdHomologacionFiltro = null;
            }
            else
            {
                // Convertir el valor a int, si es v�lido
                homologacion.IdHomologacionFiltro = int.TryParse(selectedValue, out var valor) ? valor : null;
            }
        }

        private void Regresar()
        {
            NavigationManager.NavigateTo(Routes.CAMPO_HOMOLOGACION);
        }

        /// <summary>
        /// Propiedad booleana vinculada al Switch para la indexaci�n del campo.
        /// </summary>
        private bool isIndexar // Propiedad booleana vinculada al Switch
        {
            get => homologacion.Indexar == Constantes.SUSPENDIDO; // ConvertirConstantes.SUSPENDIDO a true
            set => homologacion.Indexar = value ? Constantes.SUSPENDIDO : Constantes.NO; // Convertir true aConstantes.SUSPENDIDO
        }

        /// <summary>
        /// Propiedad booleana vinculada al Switch para la visibilidad del campo.
        /// </summary>
        private bool isMostrar
        {
            get => homologacion.Mostrar == Constantes.SUSPENDIDO; // ConvertirConstantes.SUSPENDIDO a true
            set => homologacion.Mostrar = value ? Constantes.SUSPENDIDO : Constantes.NO; // Convertir true aConstantes.SUSPENDIDO
        }
    }
}