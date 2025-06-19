using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;
using Infractruture.Models;

namespace ClientAppAdministrador.Pages.Administracion.Conexion
{
    /// <summary>
    /// P�gina de formulario para la gesti�n de conexiones a diferentes motores de base de datos.
    /// Permite registrar o editar conexiones hacia servidores como: EXCEL, MSSQLSERVER, MYSQL, POSTGRESQL, SQLITE.
    /// </summary>
    public partial class Formulario
    {
        // Bot�n con animaci�n de carga
        private Button saveButton = default!;
        /// <summary>
        /// ID de la conexi�n, nulo si es un nuevo registro.
        /// </summary>
        [Parameter]
        public int? Id { get; set; }
        // Servicio de gesti�n de conexiones
        [Inject]
        private IConexionService? service { get; set; }
        // Servicio para gestionar Organismos Nacionales de Acreditaci�n (ONA)
        [Inject]
        private IONAService? iOnaService { get; set; }
        // Administrador de navegaci�n inyectado
        [Inject]
        public NavigationManager? navigationManager { get; set; }
        // Objeto que almacena la informaci�n de la conexi�n
        private ONAConexionDto conexion = new ONAConexionDto();
        // Servicio de homologaci�n inyectado
        [Inject]
        public IHomologacionService? HomologacionService { get; set; }
        // Servicio de homologaci�n inyectado (duplicado, se podr�a eliminar uno)
        [Inject]
        public IHomologacionService? iHomologacionService { get; set; }

        // Servicio de notificaciones Toast

        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        // Servicio de b�squeda inyectado
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        // Servicio de almacenamiento local
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }

        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();

        // Lista de organizaciones disponibles
        private List<OnaDto>? listaOrganizaciones = default;
        // Nombre de la homologaci�n seleccionada
        private string? homologacionName;
        // Lista de homologaciones obtenidas desde la base de datos
        private List<HomologacionDto>? listaVwHomologacion;
        // Lista de homologaciones filtradas
        private IEnumerable<HomologacionDto>? lista = new List<HomologacionDto>();

        /// <summary>
        /// M�todo asincr�nico que inicializa la p�gina cargando las conexiones disponibles y organizaciones.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            if (iOnaService != null)
            {
                listaOrganizaciones = await iOnaService.GetONAsAsync();
            }

            if (listaVwHomologacion == null)
                listaVwHomologacion = await iHomologacionService.GetHomologacionsAsync();

            if (Id > 0 && service != null)
            {
                objEventTracking.CodigoHomologacionMenu = "/editar-conexion";
                objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
                objEventTracking.NombreControl = "editar-conexion";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                conexion = await service.GetConexionAsync(Id.GetValueOrDefault());
            }
            else
            {
                objEventTracking.CodigoHomologacionMenu = Routes.NUEVO_CONEXION;
                objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
                objEventTracking.NombreControl = "nuevo-conexion";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);
            }


        }

        /// <summary>
        /// M�todo que guarda o actualiza una conexi�n en la base de datos.
        /// </summary>
        private async Task RegistrarConexion()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.NUEVO_CONEXION;
            objEventTracking.NombreAccion = "RegistrarConexion";
            objEventTracking.NombreControl = Constantes.BTN_GUARDAR;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            saveButton.ShowLoading(Constantes.GUARDANDO);

            if (service != null)
            {
                try
                {
                    RespuestaRegistro result;

                    if (conexion.IdONA != 0)
                    {
                        result = await service.Actualizar(conexion);
                    }
                    else
                    {
                        result = await service.Registrar(conexion);
                    }


                    if (result.registroCorrecto)
                    {
                        //Mensaje de �xito
                        toastService?.CreateToastMessage(ToastType.Success, "Registrado exitosamente");
                        navigationManager?.NavigateTo(Routes.CONEXION);
                    }
                    else
                    {
                        // Mensaje de error
                        toastService?.CreateToastMessage(ToastType.Danger, "Error al registrar en el servidor");
                    }
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                    Console.WriteLine($"Error al registrar conexi�n: {ex.Message}");
                }
            }

            saveButton.HideLoading();
        }

        private void CambiarSeleccionMotor(ChangeEventArgs e)
        {
            conexion.BaseDatos = e.Value?.ToString();
            conexion.OrigenDatos = e.Value?.ToString();
        }

        /// <summary>
        /// Propiedad booleana vinculada al Switch para la opci�n de migraci�n.
        /// </summary>
        private bool isMigrar // Propiedad booleana vinculada al Switch
        {
            get => conexion.Migrar == Constantes.SUSPENDIDO; // ConvertirConstantes.SUSPENDIDO a true
            set => conexion.Migrar = value ? Constantes.SUSPENDIDO : Constantes.NO; // Convertir true aConstantes.SUSPENDIDO
        }

        private void Regresar()
        {
            NavigationManager.NavigateTo(Routes.CONEXION);
        }

    }
}