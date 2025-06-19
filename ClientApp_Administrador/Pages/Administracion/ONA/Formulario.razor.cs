using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using SharedApp.Dtos;
using Infractruture.Models;

namespace ClientAppAdministrador.Pages.Administracion.ONA
{
    /// <summary>
    /// Componente de formulario para la gesti�n de ONAs (Organismos Nacionales de Acreditaci�n).
    /// Permite registrar y actualizar ONAs, as� como la gesti�n de carga de archivos y pa�ses asociados.
    /// </summary>
    public partial class Formulario
    {
        // Bot�n de guardar con animaci�n de carga
        private Button saveButton = default!;
        // Objeto que almacena la informaci�n del ONA a registrar o actualizar
        private OnaDto onas = new OnaDto();
        // Lista de pa�ses disponibles
        private List<VwPaisDto> paises = new(); // Lista para almacenar pa�ses
        // ID del pa�s seleccionado
        private int? paisSeleccionado; // ID del pa�s seleccionado
        /// <summary>
        /// Servicio de gesti�n de ONAs.
        /// </summary>
        [Inject]
        public IONAService? iONAsService { get; set; }
        /// <summary>
        /// Servicio de utilidades para la gesti�n de archivos e iconos.
        /// </summary>
        [Inject]
        public IUtilitiesService? iUtilService { get; set; }
        /// <summary>
        /// Servicio de navegaci�n.
        /// </summary>

        [Inject]
        public NavigationManager? navigationManager { get; set; }

        /// <summary>
        /// ID del ONA a editar, nulo si se est� creando uno nuevo.
        /// </summary>
        [Parameter]
        public int? Id { get; set; }
        /// <summary>
        /// Servicio de notificaciones Toast.
        /// </summary>
        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        /// <summary>
        /// Servicio de b�squeda y registro de eventos.
        /// </summary>
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();
        /// <summary>
        /// Servicio de almacenamiento local en el navegador.
        /// </summary>
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }

        // Archivo cargado por el usuario
        private IBrowserFile? uploadedFile;

        /// <summary>
        /// M�todo para manejar la carga de archivos y validar formatos permitidos (.png y .svg).
        /// </summary>
        /// <param name="e">Evento que contiene la informaci�n del archivo subido.</param>
        /// <param name="idOna">ID del ONA al que se asociar� el archivo.</param>
        private async Task OnInputFileChange(InputFileChangeEventArgs e, int idOna)
        {
            try
            {
                uploadedFile = e.File;

                if (uploadedFile == null)
                {
                    Console.WriteLine("No se seleccion� ning�n archivo.");
                    return;
                }

                // Validar la extensi�n del archivo
                var fileExtension = Path.GetExtension(uploadedFile.Name).ToLower();
                if (fileExtension != ".png" && fileExtension != ".svg")
                {
                    Console.WriteLine("Formato de archivo no permitido.");
                    return;
                }

                // Llamar al servicio para subir el archivo con el idOna
                var uploadedFilePath = await iUtilService.UploadIconAsync(uploadedFile, idOna);

                // Actualizar la propiedad con la ruta relativa devuelta por el backend
                onas.UrlIcono = uploadedFilePath;

                Console.WriteLine($"Archivo cargado exitosamente: {uploadedFilePath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al cargar el archivo: {ex.Message}");
            }
        }

        /// <summary>
        /// M�todo asincr�nico que inicializa el formulario cargando la lista de pa�ses y el ONA si se est� editando.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            paises = await iONAsService.GetPaisesAsync();

            if (Id > 0 && iONAsService != null)
            {
                objEventTracking.CodigoHomologacionMenu = "/editar-ona";
                objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
                objEventTracking.NombreControl = "editar-ona";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                onas = await iONAsService.GetONAsAsync(Id.Value);
            }
            else
            {
                objEventTracking.CodigoHomologacionMenu = "/nuevo-ona";
                objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
                objEventTracking.NombreControl = "nuevo-ona";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);
            }
        }

        /// <summary>
        /// M�todo que registra o actualiza la informaci�n de un ONA en la base de datos.
        /// </summary>
        private async Task RegistrarONA()
        {
            objEventTracking.CodigoHomologacionMenu = "/nuevo-ona";
            objEventTracking.NombreAccion = "RegistrarONA";
            objEventTracking.NombreControl = Constantes.BTN_GUARDAR;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            saveButton.ShowLoading(Constantes.GUARDANDO);

            if (iONAsService != null)
            {


                RespuestaRegistro result;

                if (onas.IdONA == 0)
                {
                    result = await iONAsService.Registrar(onas);
                }
                else
                {
                    result = await iONAsService.Actualizar(onas);
                }

                if (result.registroCorrecto)
                {
                    toastService?.CreateToastMessage(ToastType.Success, "Registrado exitosamente");
                    navigationManager?.NavigateTo("/onas");
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al registrar en el servidor");
                }
            }

            saveButton.HideLoading();
        }

        /// <summary>
        /// M�todo que actualiza el pa�s seleccionado para el ONA.
        /// </summary>
        /// <param name="e">Evento de cambio en la selecci�n del pa�s.</param>
        private void ActualizarPais(ChangeEventArgs e)
        {
            // Obtener el ID seleccionado
            onas.IdHomologacionPais = int.TryParse(e.Value?.ToString(), out var valor) ? valor : null;

        }
        /// <summary>
        /// M�todo que redirige a la lista de ONAs sin guardar cambios.
        /// </summary>
        private void Regresar()
        {
            navigationManager?.NavigateTo("/onas");
        }
    }
}
