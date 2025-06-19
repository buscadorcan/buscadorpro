using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Forms;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.MigracionExcel
{
    /// <summary>
    /// Componente de formulario para la migraci�n de archivos Excel.
    /// Permite la carga y gesti�n de archivos de migraci�n, seleccionando un ONA asociado.
    /// </summary>
    public partial class Formulario
    {
        /// <summary>
        /// Bot�n de guardar con animaci�n de carga.
        /// </summary>
        private Button saveButton = default!;
        /// <summary>
        /// ID de la migraci�n (nulo si es una nueva migraci�n).
        /// </summary>
        [Parameter]
        public int? Id { get; set; }
        /// <summary>
        /// Servicio de migraci�n de archivos Excel.
        /// </summary>
        [Inject]
        private IMigracionExcelService? service { get; set; }
        /// <summary>
        /// Servicio de navegaci�n para redirigir a otras p�ginas.
        /// </summary>
        [Inject]
        public NavigationManager? navigationManager { get; set; }

        /// <summary>
        /// Objeto que almacena la informaci�n de la migraci�n a registrar.
        /// </summary>
        private MigracionExcelDto migracion = new MigracionExcelDto();
        /// <summary>
        /// Contexto de edici�n para la validaci�n del formulario.
        /// </summary>
        private EditContext? editContext = new EditContext(new MigracionExcelDto());
        /// <summary>
        /// Archivo seleccionado para la carga.
        /// </summary>
        private IBrowserFile? uploadedFile;
        /// <summary>
        /// Lista de ONAs disponibles para selecci�n.
        /// </summary>
        private List<OnaDto>? listaONAs;
        /// <summary>
        /// ONA seleccionado por el usuario.
        /// </summary>
        private OnaDto? onaSelected;
        /// <summary>
        /// Esquema seleccionado (puede ser opcional).
        /// </summary>
        private EsquemaDto? esquemaSelected;
        /// <summary>
        /// ID del usuario seleccionado.
        /// </summary>
        private int? selectedIdUsuario;
        /// <summary>
        /// Mensaje mostrado en el modal.
        /// </summary>
        private string modalMessage;
        /// <summary>
        /// Controla la visibilidad de la ventana modal.
        /// </summary>
        private bool showModal; // Controlar la visibilidad de la ventana modal  
        /// <summary>
        /// Servicio de almacenamiento local en el navegador.
        /// </summary>
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }
        /// <summary>
        /// Servicio para la gesti�n de ONAs.
        /// </summary>
        [Inject]
        public IONAService? iONAservice { get; set; }
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

        private bool showDropdown = false; // Controla la visibilidad del men�

        private void ToggleDropdown()
        {
            showDropdown = !showDropdown; // Alternar visibilidad
        }

        /// <summary>
        /// M�todo asincr�nico que se ejecuta al inicializar el componente.
        /// Carga la lista de ONAs disponibles y verifica permisos de usuario.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.NUEVO_MIGRACION_EXCEL;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "nueva-migarcion-excel";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            var onaPais = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
            var rol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            bool accessRol = rol ==Constantes.KEY_USER_CAN;
            if (accessRol)
            {
                if (listaONAs is null && iONAservice != null)
                {
                    await LoadONAs();
                }
            }
            else
            {
                await LoadONAs();
                listaONAs = listaONAs.Where(onas => onas.IdONA == onaPais).ToList();
            }
        }

        /// <summary>
        /// M�todo para cambiar la selecci�n del ONA.
        /// </summary>
        /// <param name="_onaSelected">ONA seleccionado.</param>
        private async Task CambiarSeleccionOna(OnaDto _onaSelected)
        {
            if (esquemaSelected != null)
            {
                onaSelected = _onaSelected;
            }
            else
            {
                onaSelected = _onaSelected;
            }
            showDropdown = false;
            StateHasChanged();
        }

        /// <summary>
        /// Carga la lista de ONAs disponibles.
        /// </summary>
        private async Task LoadONAs()
        {
            if (iONAservice != null)
            {
                listaONAs = await iONAservice.GetONAsAsync();
            }
        }

        /// <summary>
        /// Maneja la carga de un archivo en el formulario.
        /// </summary>
        /// <param name="e">Evento de cambio de archivo.</param>
        private async Task OnInputFileChange(InputFileChangeEventArgs e)
        {
            uploadedFile = e.File;
            Console.WriteLine("OnInputFileChange method called");
        }

        /// <summary>
        /// Registra la migraci�n de un archivo Excel al sistema.
        /// </summary>
        private async Task RegistrarMigracionExcel()
        {
            try
            {
                objEventTracking.CodigoHomologacionMenu =
            objEventTracking.CodigoHomologacionMenu = Routes.NUEVO_MIGRACION_EXCEL;
                objEventTracking.NombreAccion = "RegistrarMigracionExcel";
                objEventTracking.NombreControl =Constantes.BTN_GUARDAR;
                objEventTracking.NombreUsuario = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson =  Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                if (onaSelected != null && onaSelected.IdONA > 0)
                {
                    if (uploadedFile == null)
                    {
                        toastService?.CreateToastMessage(ToastType.Warning, "Debe seleccionar un archivo");
                        navigationManager?.NavigateTo(Routes.NUEVO_MIGRACION_EXCEL);
                        return;
                    }
                    saveButton.ShowLoading(Constantes.GUARDANDO);

                    var maxFileSize = 10485760; // 10 MB
                    var buffer = new byte[uploadedFile.Size];
                    await uploadedFile.OpenReadStream(maxFileSize).ReadAsync(buffer);

                    using var content = new MultipartFormDataContent();
                    content.Add(new ByteArrayContent(buffer), "file", uploadedFile.Name);

                    if (service != null)
                    {
                        var response = await service.ImportarExcel(content, onaSelected.IdONA);
                        if (response.IsSuccessStatusCode)
                        {
                            var result = await response.Content.ReadAsStringAsync();
                            Console.WriteLine(result);
                        }
                        else
                        {
                            saveButton.HideLoading();
                            var errorResult = await response.Content.ReadAsStringAsync();
                            Console.WriteLine($"Error: {errorResult}");
                        }
                    }

                    saveButton.HideLoading();
                    navigationManager?.NavigateTo(Routes.NUEVO_MIGRACION_EXCEL);
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Warning, "Seleccione un Ona");
                    navigationManager?.NavigateTo(Routes.NUEVO_MIGRACION_EXCEL);
                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        /// <summary>
        /// Abre el modal de confirmaci�n.
        /// </summary>
        private async Task OpenMigracionModal()
        {
            showModal = true;
        }

        /// <summary>
        /// Cierra el modal de confirmaci�n.
        /// </summary>
        private void CloseModal()
        {
            selectedIdUsuario = null;
            showModal = false;
        }

        /// <summary>
        /// Confirma la carga del archivo y ejecuta la migraci�n.
        /// </summary>
        private async Task ConfirmCarga()
        {
            if (service != null)
            {
                CloseModal();
                await RegistrarMigracionExcel();
            }

        }
        private void Regresar()
        {
            NavigationManager.NavigateTo(Routes.NUEVO_MIGRACION_EXCEL);
        }
    }
}