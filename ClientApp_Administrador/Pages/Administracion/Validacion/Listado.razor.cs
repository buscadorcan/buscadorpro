using BlazorBootstrap;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Newtonsoft.Json;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using SharedApp.Dtos;
using Microsoft.JSInterop;

namespace ClientAppAdministrador.Pages.Administracion.Validacion
{
    public partial class Listado
    {
        [Inject]
        public IHomologacionService? iHomologacionService { get; set; }

        [Inject]
        private IBusquedaService? servicio { get; set; }
        [Inject]
        public IDynamicService? iDynamicService { get; set; }
        [Inject]
        public IONAService? iONAservice { get; set; }
        [Inject]
        public IEsquemaService? iEsquemaService { get; set; }
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }

        [Inject]
        public Infractruture.Services.ToastService? toastService { get; set; }
        [Inject]
        public NavigationManager? navigationManager { get; set; }
        [Inject]
        private IConexionService? iConexionService { get; set; }
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        private EventTrackingDto objEventTracking { get; set; } = new();

        private Button saveButton = default!;
        private Button validateButton = default!;
        
        private Grid<EsquemaVistaDto>? grid = default;
        private List<HomologacionDto>? listaOrganizaciones = new List<HomologacionDto>();
        private List<OnaDto>? listaONAs;
        private List<HomologacionEsquemaDto>? listaHomologacionEsquemas = new List<HomologacionEsquemaDto>();
        //private EsquemaVistaOnaDto? esquemaSelected;
        private EsquemaDto? esquemaSelected;
        private bool enabledCeldas;
        private HomologacionDto? organizacionSelected;
        private OnaDto? onaSelected;
        private List<EsquemaVistaDto> listasHevd = new List<EsquemaVistaDto>();
        private List<EsquemaVistaColumnaDto> listaEsquemaVistaColumna = new List<EsquemaVistaColumnaDto>();

        public string nombreSugerido =  Constantes.VACIO;
        public string origenDatosValidar =  Constantes.VACIO;
        //private List<EsquemaVistaOnaDto>? listaEsquemasOna = new List<EsquemaVistaOnaDto>();
        private List<EsquemaDto>? listaEsquemasOna = new List<EsquemaDto>();

        private bool isLoading = false;
        private List<string> NombresVistas { get; set; }
        private ONAConexionDto? currentConexion = null;
        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            objEventTracking.CodigoHomologacionMenu = "/validacion";
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "validacion";
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
                    listaEsquemasOna = await iEsquemaService.GetListEsquemasAsync();
                }
            }
            else
            {
                await LoadONAs();
                listaONAs = listaONAs.Where(onas => onas.IdONA == onaPais).ToList();
                listaEsquemasOna = await iEsquemaService.GetListEsquemasAsync();
            }
            isLoading = false;
        }

        private async Task LoadONAs()
        {
            if (iONAservice != null)
            {
                listaONAs = await iONAservice.GetONAsAsync();
            }
        }

        private async Task CambiarSeleccionOna(ChangeEventArgs e)
        {
            var selectedId = Convert.ToInt32(e.Value);

            if (listaONAs == null || !listaONAs.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay ONAs disponibles.");
                navigationManager?.NavigateTo("/validacion");
                return;
            }

            // Busca el objeto correspondiente en la lista
            onaSelected = listaONAs?.FirstOrDefault(o => o.IdONA == selectedId);

            if (onaSelected != null)
            {
                if (esquemaSelected != null)
                {
                    await CambiarSeleccionEsquema(esquemaSelected);
                }
                StateHasChanged();
            }
        }
        private async Task HandleEsquemaSelectionChange(ChangeEventArgs e)
        {
            Console.WriteLine($"Evento onchange detectado con valor: {e.Value}");

            if (e.Value is null)
            {
                toastService?.CreateToastMessage(ToastType.Warning, "Debe seleccionar un esquema v�lido.");
                return;
            }

            // Convierte el valor a un n�mero
            if (!int.TryParse(e.Value.ToString(), out int selectedId))
            {
                toastService?.CreateToastMessage(ToastType.Warning, "El ID del esquema seleccionado no es v�lido.");
                return;
            }

            // Busca el esquema en la lista
            var selectedEsquema = listaEsquemasOna?.FirstOrDefault(es => es.IdEsquema == selectedId);

            if (selectedEsquema != null)
            {
                // Asignamos el esquema seleccionado
                esquemaSelected = selectedEsquema;

                // Llamamos al m�todo asincr�nico
                await CambiarSeleccionEsquema(esquemaSelected);

                // Refrescamos la UI
                StateHasChanged();
            }
            else
            {
                toastService?.CreateToastMessage(ToastType.Warning, "Esquema seleccionado no encontrado.");
            }
        }

        private async Task CambiarSeleccionEsquema(EsquemaDto _esquemaSelected)
        {
            // Obtiene el rol del usuario desde el LocalStorage
            var rol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            bool accessRol = rol ==Constantes.KEY_USER_CAN;

            // Configura `currentConexion` y `enabledCeldas` dependiendo del rol
            if (accessRol)
            {
                if (onaSelected == null)
                {
                    toastService?.CreateToastMessage(ToastType.Warning, "Debe seleccionar una ONA antes de continuar.");
                    navigationManager?.NavigateTo("/validacion");
                    return;
                }
                currentConexion = await iConexionService.GetOnaConexionByOnaAsync(onaSelected.IdONA);
            }
            else
            {
                int IdOna = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
                currentConexion = await iConexionService.GetOnaConexionByOnaAsync(IdOna);
            }

            if (currentConexion?.OrigenDatos == "EXCEL")
            {
                origenDatosValidar = currentConexion.OrigenDatos;
                enabledCeldas = true;
            }
            else
            {
                origenDatosValidar = currentConexion.OrigenDatos;
                enabledCeldas = false;
            }

            // Actualiza el esquema seleccionado y el nombre sugerido
            esquemaSelected = _esquemaSelected;
            nombreSugerido = esquemaSelected.EsquemaVista;

            // L�gica para obtener y procesar las columnas del esquema
            List<HomologacionDto> Columnas;
            var homologacionEsquema = await servicio.FnHomologacionEsquemaAsync(esquemaSelected.IdEsquema);

            if (homologacionEsquema == null || string.IsNullOrWhiteSpace(homologacionEsquema.EsquemaJson))
            {
                toastService?.CreateToastMessage(ToastType.Danger, "Error: No hay datos en el esquema seleccionado.");
                navigationManager?.NavigateTo("/validacion");
                return;
            }

            Columnas = JsonConvert.DeserializeObject<List<HomologacionDto>>(homologacionEsquema.EsquemaJson)
                .OrderBy(c => c.MostrarWebOrden)
                .ToList();

            listasHevd = new List<EsquemaVistaDto>();

            var vistas = await iDynamicService.GetListaValidacionEsquema(onaSelected.IdONA, esquemaSelected.IdEsquema);

            foreach (var c in Columnas)
            {
                var vistaCorrespondiente = vistas.FirstOrDefault(n => n.NombreEsquema != null && n.NombreEsquema.Equals(c.NombreHomologado));
                var count = vistas.Count(n => n.NombreVista != null && n.NombreVista.Equals(c.NombreHomologado));

                listasHevd.Add(new EsquemaVistaDto
                {
                    NombreEsquema = c.NombreHomologado,
                    NombreVista = vistaCorrespondiente?.NombreVista ?? c.NombreHomologado.Trim(),
                    IsValid = count > 0
                });
            }

        }

        private async Task<GridDataProviderResult<EsquemaVistaDto>> EsquemaVistaDataProvider(GridDataProviderRequest<EsquemaVistaDto> request)
        {
            return await Task.FromResult(request.ApplyTo(listasHevd));
        }

        private async Task GuardarCambios()
        {
            try
            {
                saveButton.ShowLoading(Constantes.GUARDANDO);

                if (onaSelected == null)
                {
                    toastService?.CreateToastMessage(ToastType.Warning, "Por favor, selecciona una ONA antes de guardar.");
                    navigationManager?.NavigateTo("/validacion");
                    saveButton.HideLoading();
                    return;
                }

                if (esquemaSelected == null)
                {
                    toastService?.CreateToastMessage(ToastType.Warning, "Por favor, selecciona un esquema antes de guardar.");
                    navigationManager?.NavigateTo("/validacion");
                    saveButton.HideLoading();
                    return;
                }

                if (string.IsNullOrEmpty(nombreSugerido))
                {
                    toastService?.CreateToastMessage(ToastType.Warning, "El nombre sugerido no puede estar vac�o.");
                    navigationManager?.NavigateTo("/validacion");
                    saveButton.HideLoading();
                    return;
                }

                var esquemaRegistro = new EsquemaVistaValidacionDto
                {
                    IdOna = onaSelected.IdONA,
                    IdEsquema = esquemaSelected.IdEsquema,
                    VistaOrigen = nombreSugerido,
                    Estado = Constantes.ACTIVO
                };

                var resultado = await iEsquemaService.GuardarEsquemaVistaValidacionAsync(esquemaRegistro);

                if (resultado?.registroCorrecto != true)
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al guardar el esquema.");
                    navigationManager?.NavigateTo("/validacion");
                    saveButton.HideLoading();
                    return;
                }

                // Elimina columnas asociadas
                var success = await iEsquemaService.EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(esquemaRegistro);
                if (!success)
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al eliminar columnas existentes.");
                    navigationManager?.NavigateTo("/validacion");
                    saveButton.HideLoading();
                    return;
                }

                // Procesa columnas
                listaEsquemaVistaColumna = new List<EsquemaVistaColumnaDto>();
                var homologacionEsquema = await servicio.FnHomologacionEsquemaAsync(esquemaSelected.IdEsquema);
                var Columnas = JsonConvert.DeserializeObject<List<HomologacionDto>>(homologacionEsquema.EsquemaJson)
                    .OrderBy(c => c.MostrarWebOrden)
                    .ToList();

                foreach (var c in Columnas)
                {
                    var vistaCorrespondiente = listasHevd.FirstOrDefault(v => v.NombreEsquema == c.NombreHomologado);

                    listaEsquemaVistaColumna.Add(new EsquemaVistaColumnaDto
                    {
                        ColumnaEsquemaIdH = c.IdHomologacion,
                        ColumnaEsquema = c.NombreHomologado,
                        ColumnaVista = vistaCorrespondiente?.NombreVista,
                        ColumnaVistaPK = false,
                        Estado = Constantes.ACTIVO
                    });
                }

                var successRows = await iEsquemaService.GuardarListaEsquemaVistaColumna(listaEsquemaVistaColumna, onaSelected.IdONA, esquemaSelected.IdEsquema);

                if (successRows?.registroCorrecto == true)
                {
                    toastService?.CreateToastMessage(ToastType.Success, "Guardado exitosamente.");
                    navigationManager?.NavigateTo("/validacion");
                }
                else
                {
                    toastService?.CreateToastMessage(ToastType.Danger, "Error al guardar columnas.");
                    navigationManager?.NavigateTo("/validacion");
                }
            }
            catch (Exception ex)
            {
                toastService?.CreateToastMessage(ToastType.Danger, $"Error inesperado: {ex.Message}");
                navigationManager?.NavigateTo("/validacion");
            }
            finally
            {
                saveButton.HideLoading();
            }
        }


        private async Task ValidarDatos()
        {
            try
            {
                objEventTracking.CodigoHomologacionMenu = "/validacion";
                objEventTracking.NombreAccion = "ValidarDatos";
                objEventTracking.NombreControl =Constantes.BTN_GUARDAR;
                objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
                objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
                objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
                objEventTracking.UbicacionJson =  Constantes.VACIO;
                await iBusquedaService.AddEventTrackingAsync(objEventTracking);

                validateButton.ShowLoading("Validando...");

                int IdOna = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_IdOna_Local);
                currentConexion = await iConexionService.GetOnaConexionByOnaAsync(IdOna);

                if (origenDatosValidar.Equals("EXCEL"))
                {
                    var esquemaRegistro = new EsquemaVistaValidacionDto
                    {
                        IdOna = onaSelected.IdONA,
                        IdEsquema = esquemaSelected.IdEsquema,
                        VistaOrigen = nombreSugerido,
                        Estado = Constantes.ACTIVO
                    };
                    
                    var success = await iEsquemaService.EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(esquemaRegistro);
                    if (success)
                    {
                        listaEsquemaVistaColumna = new List<EsquemaVistaColumnaDto>();

                        var vistas = listasHevd.Select(item => new EsquemaVistaDto
                        {
                            NombreEsquema = item.NombreEsquema,
                            NombreVista = item.NombreVista,
                            IsValid = false
                        }).ToList();

                        var homologacionEsquema = await servicio.FnHomologacionEsquemaAsync(esquemaSelected.IdEsquema);
                        var Columnas = JsonConvert.DeserializeObject<List<HomologacionDto>>(homologacionEsquema.EsquemaJson)
                            .OrderBy(c => c.MostrarWebOrden).ToList();

                        var filasNoCoinciden = new List<string>();

                        foreach (var c in Columnas)
                        {
                            // Buscar el elemento correspondiente en vistas
                            var vistaCorrespondiente = vistas.FirstOrDefault(v => v.NombreEsquema != null && v.NombreEsquema.Equals(c.NombreHomologado));

                            // Validar coincidencias y agregar solo las filas que coincidan
                            if (vistaCorrespondiente != null && vistaCorrespondiente.NombreVista == c.NombreHomologado)
                            {
                                vistaCorrespondiente.IsValid = true;

                                listaEsquemaVistaColumna.Add(new EsquemaVistaColumnaDto
                                {
                                    ColumnaEsquemaIdH = c.IdHomologacion,
                                    ColumnaEsquema = vistaCorrespondiente.NombreEsquema,
                                    ColumnaVista = vistaCorrespondiente.NombreVista,
                                    ColumnaVistaPK = false,
                                    Estado = Constantes.ACTIVO
                                });
                            }
                            else
                            {
                                filasNoCoinciden.Add(c.NombreHomologado);
                            }
                        }

                        var successRows = await iEsquemaService.GuardarListaEsquemaVistaColumna(listaEsquemaVistaColumna, onaSelected.IdONA, esquemaSelected.IdEsquema);

                        if (successRows.registroCorrecto)
                        {
                            toastService?.CreateToastMessage(ToastType.Success, "Registrado exitosamente");
                            navigationManager?.NavigateTo("/validacion");

                            if (filasNoCoinciden.Any())
                            {
                                toastService?.CreateToastMessage(ToastType.Warning, $"No se pudo guardar las siguientes filas no coinciden o tienen espacios en blanco: {string.Join(", ", filasNoCoinciden)}");
                                navigationManager?.NavigateTo("/validacion");
                            }
                            if (esquemaSelected != null)
                            {
                                await CambiarSeleccionEsquema(esquemaSelected);
                            }
                            validateButton.HideLoading();
                            validateButton.HideLoading();
                        }
                        else
                        {
                            toastService?.CreateToastMessage(ToastType.Danger, "No se pudo guardar");
                            navigationManager?.NavigateTo("/validacion");
                            validateButton.HideLoading();
                        }
                    }
                    else
                    {
                        var resultado = await iEsquemaService.GuardarEsquemaVistaValidacionAsync(esquemaRegistro);
                        if (resultado != null && resultado.registroCorrecto)
                        {
                            listaEsquemaVistaColumna = new List<EsquemaVistaColumnaDto>();

                            var vistas = listasHevd.Select(item => new EsquemaVistaDto
                            {
                                NombreEsquema = item.NombreEsquema,
                                NombreVista = item.NombreVista,
                                IsValid = false
                            }).ToList();

                            var homologacionEsquema = await servicio.FnHomologacionEsquemaAsync(esquemaSelected.IdEsquema);
                            var Columnas = JsonConvert.DeserializeObject<List<HomologacionDto>>(homologacionEsquema.EsquemaJson)
                                .OrderBy(c => c.MostrarWebOrden).ToList();

                            var filasNoCoinciden = new List<string>();

                            foreach (var c in Columnas)
                            {
                                // Buscar el elemento correspondiente en vistas
                                var vistaCorrespondiente = vistas.FirstOrDefault(v => v.NombreEsquema != null && v.NombreEsquema.Equals(c.NombreHomologado));

                                // Validar coincidencias y agregar solo las filas que coincidan
                                if (vistaCorrespondiente != null && vistaCorrespondiente.NombreVista == c.NombreHomologado)
                                {
                                    vistaCorrespondiente.IsValid = true;

                                    listaEsquemaVistaColumna.Add(new EsquemaVistaColumnaDto
                                    {
                                        ColumnaEsquemaIdH = c.IdHomologacion,
                                        ColumnaEsquema = vistaCorrespondiente.NombreEsquema,
                                        ColumnaVista = vistaCorrespondiente.NombreVista,
                                        ColumnaVistaPK = false,
                                        Estado = Constantes.ACTIVO
                                    });
                                }
                                else
                                {
                                    filasNoCoinciden.Add(c.NombreHomologado);
                                }
                            }

                            var successRows = await iEsquemaService.GuardarListaEsquemaVistaColumna(listaEsquemaVistaColumna, onaSelected.IdONA, esquemaSelected.IdEsquema);

                            if (successRows.registroCorrecto)
                            {
                                toastService?.CreateToastMessage(ToastType.Success, "Registrado exitosamente");
                                navigationManager?.NavigateTo("/validacion");

                                if (filasNoCoinciden.Any())
                                {
                                    toastService?.CreateToastMessage(ToastType.Warning, $"No se pudo guardar las siguientes filas no coinciden o tienen espacios en blanco: {string.Join(", ", filasNoCoinciden)}");
                                    navigationManager?.NavigateTo("/validacion");
                                }
                                if (esquemaSelected != null)
                                {
                                    await CambiarSeleccionEsquema(esquemaSelected);
                                }
                                validateButton.HideLoading();
                            }
                            else
                            {
                                toastService?.CreateToastMessage(ToastType.Danger, "No se pudo guardar");
                                navigationManager?.NavigateTo("/validacion");
                                validateButton.HideLoading();
                            }
                        }
                        else
                        {
                            navigationManager?.NavigateTo("/validacion");
                            validateButton.HideLoading();
                        }


                    }
                }
                else
                {
                    navigationManager?.NavigateTo("/validacion");
                    validateButton.HideLoading();
                }
            }
            catch (Exception ex)
            {
                validateButton.HideLoading();
            }
            
        }

        private async Task ExportarExcel()
        {
            if (listaEsquemaVistaColumna == null || !listaEsquemaVistaColumna.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }
            try
            {
                var base64 = await iEsquemaService.ExportarExcelAsync();
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
            if (listaEsquemaVistaColumna == null || !listaEsquemaVistaColumna.Any())
            {
                toastService?.CreateToastMessage(ToastType.Warning, "No hay datos para exportar.");
                return;
            }
            try
            {
                var base64 = await iEsquemaService.ExportarPdfAsync();
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
