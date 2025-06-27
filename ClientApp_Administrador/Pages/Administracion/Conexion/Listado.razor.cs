using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using SharedApp.Dtos;
using Microsoft.JSInterop;
using Infractruture.Services;


namespace ClientAppAdministrador.Pages.Administracion.Conexion
{

    public partial class Listado
    {
        ToastsPlacement toastsPlacement = ToastsPlacement.TopRight;
        private bool showModal; // Controlar la visibilidad de la ventana modal  
        private bool showModalTimer;
        private int? selectedIdOna;

        private TimeSpan? HoraMigracion1 { get; set; }
        private TimeSpan? HoraMigracion2 { get; set; }
        private TimeSpan? HoraMigracion3 { get; set; }

        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        List<ToastMessage> messages = new();

        [Inject]
        private IConexionService? iConexionService { get; set; }
        [Inject]
        private IDynamicService? iDynamicService { get; set; }
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }

        private List<ONAConexionDto> listasHevd = new();
        private bool isRolAdmin;

        private EventTrackingDto objEventTracking { get; set; } = new();
        private bool IsLoading { get; set; } = false;
        private int ProgressValue { get; set; } = 0;
        private string sortColumn = nameof(ONAConexionDto.Host);
        private bool sortAscending = true;
        private bool isLoading = false;

        // 🆕 Paginación
        private int DisplayPages = 10;
        private int ActivePageNumber = 1;
        private int TotalItems => listasHevd?.Count ?? 0;
        private int TotalPages => TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / DisplayPages) : 1;

        private IEnumerable<ONAConexionDto> PaginatedItems => listasHevd?
            .Skip((ActivePageNumber - 1) * DisplayPages)
            .Take(DisplayPages)
            .ToList() ?? new List<ONAConexionDto>();

        private async Task OnDisplayPagesChanged(int newDisplayPages)
        {
            DisplayPages = newDisplayPages;
            ActivePageNumber = 1;
            await LoadConexion();
        }

        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await LoadConexion();
        }

        public DateTime? HoraMigracion1Time
        {
            get => HoraMigracion1.HasValue ? DateTime.Today.Add(HoraMigracion1.Value) : (DateTime?)null;
            set => HoraMigracion1 = value.HasValue ? value.Value.TimeOfDay : (TimeSpan?)null;
        }

        public DateTime? HoraMigracion2Time
        {
            get => HoraMigracion2.HasValue ? DateTime.Today.Add(HoraMigracion2.Value) : (DateTime?)null;
            set => HoraMigracion2 = value.HasValue ? value.Value.TimeOfDay : (TimeSpan?)null;
        }

        public DateTime? HoraMigracion3Time
        {
            get => HoraMigracion3.HasValue ? DateTime.Today.Add(HoraMigracion3.Value) : (DateTime?)null;
            set => HoraMigracion3 = value.HasValue ? value.Value.TimeOfDay : (TimeSpan?)null;
        }


        /// <summary>
        /// OnInitializedAsync: Iniciado del listado, carga del rol relacionado y de conexiones.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            objEventTracking.CodigoHomologacionMenu = Routes.CONEXION;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "conexion";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);
            if (listasHevd != null && iConexionService != null)
            {
                var rolRelacionado = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                isRolAdmin = rolRelacionado == Constantes.KEY_USER_CAN;
                if (isRolAdmin)
                {
                    listasHevd = await iConexionService.GetConexionsAsync() ?? new List<ONAConexionDto>();
                }
                else
                {
                    int IdOna = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
                    listasHevd = await iConexionService.GetOnaConexionByOnaListAsync(IdOna) ?? new List<ONAConexionDto>();
                }
            }
            isLoading = false;
        }

        /// <summary>
        /// OnTestconexionClick: Test de la conexión externa, comprobando si la conexion esta en linea.
        /// </summary>
        /// <param name="conexion">
        /// <returns cref="Task"> devuelve un valor true o false dependiendo de la conexion</returns>
        private async Task<bool> OnTestconexionClick(int conexion)
        {
            try
            {
                objEventTracking.CodigoHomologacionMenu = Routes.CONEXION;
                objEventTracking.NombreAccion = "OnTestconexionClick";
                objEventTracking.NombreControl = "OnTestconexionClick";
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson = Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson = Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                if (iDynamicService != null && listasHevd != null)
                {
                    IsLoading = true;
                    ProgressValue = 0;
                    StateHasChanged();

                    try
                    {
                        // 🔹 Iniciar la prueba de conexión en un Task separado
                        var connectionTask = iDynamicService.TestConnectionAsync(conexion);

                        // 🔥 Simular el progreso en intervalos de 500ms, pero limitándolo a 95% antes de que termine la conexión
                        while (!connectionTask.IsCompleted)
                        {
                            await Task.Delay(500); // Espera 500ms antes de aumentar
                            if (ProgressValue < 95)
                            {
                                ProgressValue += 5; // Aumenta en 5% cada 500ms hasta 95%
                                StateHasChanged();
                            }
                        }

                        // 🔥 Esperar el resultado de la prueba de conexión
                        bool isConnected = await connectionTask;

                        // 🔹 Asegurar que la barra llegue al 100% solo cuando la prueba de conexión termine
                        ProgressValue = 100;
                        StateHasChanged();

                        var toastMessage = new ToastMessage
                        {
                            Type = isConnected ? ToastType.Success : ToastType.Danger,
                            Title = "Mensaje de confirmación",
                            HelpText = $"{DateTime.Now}",
                            Message = isConnected ? "Conexión satisfactoria" : "Conexión fallida",
                        };

                        messages.Add(toastMessage);
                        StateHasChanged();

                        // Mantener el mensaje visible por más tiempo (5 segundos)
                        await Task.Delay(5000);

                        // Remover mensaje después de la espera
                        messages.Remove(toastMessage);
                        InvokeAsync(StateHasChanged);

                        return isConnected;
                    }
                    finally
                    {
                        IsLoading = false;
                        ProgressValue = 0;
                        StateHasChanged();
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error en OnTestconexionClick: {ex.Message}");
                return false;
            }
        }


        /// <summary>
        /// OnMigrarClick: Migrar los datos de la ONA desde el servidor externo.
        /// </summary>
        /// <param name="conexion">
        /// <returns> devuelve un valor true o false dependiendo de la migracion</returns>
        private async Task<bool> OnMigrarClick(int conexion)
        {
            objEventTracking.CodigoHomologacionMenu = Routes.CONEXION;
            objEventTracking.NombreAccion = "OnMigrarClick";
            objEventTracking.NombreControl = "OnMigrarClick";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (iDynamicService != null && listasHevd != null)
            {
                IsLoading = true;
                ProgressValue = 0;
                StateHasChanged();

                try
                {
                    // 🔹 Iniciar la migración en un Task separado para permitir la actualización de la UI
                    var migrationTask = iDynamicService.MigrarConexionAsync(conexion);

                    // 🔥 Simular el progreso en intervalos de 500ms, pero limitándolo a 95% antes de que termine la migración
                    while (!migrationTask.IsCompleted)
                    {
                        await Task.Delay(500); // Espera 500ms antes de aumentar
                        if (ProgressValue < 95)
                        {
                            ProgressValue += 5; // Aumenta en 5% cada 500ms hasta 95%
                            StateHasChanged();
                        }
                    }

                    // 🔥 Esperar el resultado de la migración
                    bool migracion = await migrationTask;

                    // 🔹 Asegurar que la barra llegue al 100% solo cuando termine la migración
                    ProgressValue = 100;
                    StateHasChanged();

                    var toastMessage = new ToastMessage
                    {
                        Type = migracion ? ToastType.Success : ToastType.Danger,
                        Title = "Mensaje de confirmación",
                        HelpText = $"{DateTime.Now}",
                        Message = migracion ? "Migración satisfactoria" : "Migración no realizada",
                    };

                    messages.Add(toastMessage);
                    StateHasChanged();

                    // Mantener el mensaje visible por más tiempo (7 segundos)
                    await Task.Delay(7000);

                    // Remover mensaje después de la espera
                    messages.Remove(toastMessage);
                    InvokeAsync(StateHasChanged);

                    return migracion;
                }
                finally
                {
                    IsLoading = false;
                    ProgressValue = 0;
                    StateHasChanged();
                }
            }
            return false;
        }



        /// <summary>
        /// OpenDeleteModal: Abre el modal.
        /// </summary>
        private void OpenDeleteModal(int idOna)
        {
            selectedIdOna = idOna;
            showModal = true;
        }

        /// <summary>
        /// CloseModal: Cerrar el modal.
        /// </summary>
        private void CloseModal()
        {
            selectedIdOna = null;
            showModal = false;
        }

        private void CloseModalTime()
        {
            showModalTimer = false;
        }

        /// <summary>
        /// ConfirmDelete: Elimina la conexion externa de la organizacion.
        /// </summary>
        private async Task ConfirmDelete()
        {
            objEventTracking.CodigoHomologacionMenu = Routes.CONEXION;
            objEventTracking.NombreAccion = Constantes.CONFIRMAR_DELETE;
            objEventTracking.NombreControl = Constantes.BTN_DELETE;
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson = Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson = Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (selectedIdOna.HasValue && iConexionService != null)
            {
                int idOna = selectedIdOna.Value;
                var respuesta = await iConexionService.EliminarConexion(selectedIdOna.Value);
                if (respuesta.registroCorrecto)
                {
                    CloseModal();
                    listasHevd = listasHevd.Where(c => c.IdONA != idOna).ToList();
                    await OnInitializedAsync();
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar el registro.");
                }
            }

        }

        private void ProgramMigrar(ONAConexionDto con)
        {
            showModalTimer = true;

            HoraMigracion1 = null;
            HoraMigracion2 = null;
            HoraMigracion3 = null;

            selectedIdOna = con.IdONA;

            if (con.HoraMigracion1.HasValue)
                HoraMigracion1 = con.HoraMigracion1.Value;

            if (con.HoraMigracion2.HasValue)
                HoraMigracion2 = con.HoraMigracion2.Value;

            if (con.HoraMigracion3.HasValue)
                HoraMigracion3 = con.HoraMigracion3.Value;
        }


        private async Task RegistrarCronogramaAsync()
        {
            try
            {
                var onaCronDto = new OnaConexionCronDto
                {
                    HoraMigracion1 = HoraMigracion1,
                    HoraMigracion2 = HoraMigracion2,
                    HoraMigracion3 = HoraMigracion3
                };

                await iConexionService.RegistrarCronograma(selectedIdOna, onaCronDto);

                listasHevd = await iConexionService.GetConexionsAsync() ?? new List<ONAConexionDto>();

                showModalTimer = false;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Error al registrar cronograma: {ex.Message}");
            }
        }


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

            listasHevd = sortAscending
                ? listasHevd.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
                : listasHevd.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }

        private async Task LoadConexion()
        {
            if (iConexionService != null)
            {
                listasHevd = await iConexionService.GetConexionsAsync();
            }
        }

        private async Task ExportarExcel()
        {
            if (listasHevd == null || !listasHevd.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                string base64 = await iConexionService.ExportarExcelAsync();

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
            if (listasHevd == null || !listasHevd.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }

            try
            {
                var base64 = await iConexionService.ExportarPdfAsync();

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