﻿using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Newtonsoft.Json;
using SharedApp.Dtos;

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para la página de búsqueda de CAN.
    /// </summary>
    /// 
    public partial class Index : ComponentBase
    {
        /// <summary>
        /// Servicio para obtener catálogos.
        /// </summary>
        [Inject] public ICatalogosService? iCatalogosService { get; set; }

        /// <summary>
        /// servicio de busqueda
        /// </summary>
        [Inject] public IBusquedaService? iservicio { get; set; }

        /// <summary>
        /// servicio de busqueda
        /// </summary>
        [Inject] public IONAService? iOnaService { get; set; }

        /// <summary>
        /// Gets or sets the total items.
        /// </summary>
        private int TotalItems = 0;

        /// <summary>
        /// Gets or sets the total pages.
        /// </summary>
        private int TotalPages = 0;

        /// <summary>
        /// Gets or sets the display pages.
        /// </summary>
        private int DisplayPages = 25;

        /// <summary>
        /// Gets or sets the active page number.
        /// </summary>
        private int ActivePageNumber = 1;

        /// <summary>
        /// Lista de valores seleccionados
        /// </summary>
        private List<FiltrosBusquedaSeleccionDto> selectedFilter = new List<FiltrosBusquedaSeleccionDto>();

        /// <summary>
        /// Lista de urls devuerltos por el servicio
        /// </summary>
        private Dictionary<int, string> iconUrls = new();

        /// <summary>
        /// Variable para almacenar la información de la ONA.
        /// </summary>
        private OnaDto? OnaDto;

        /// <summary>
        /// Lista de resultados de la búsqueda.
        /// </summary>
        private List<BuscadorResultadoDataDto> listBuscadorResultadoDataDto = new List<BuscadorResultadoDataDto>();

        /// <summary>
        /// Método para mostrar el resultados
        /// </summary>
        private bool isGridVisible = true;

        /// <summary>
        /// Texto de busqueda
        /// </summary>
        private string searchText = string.Empty;

        /// <summary>
        /// Variable para indicar si la busqueda es exacta
        /// </summary>
        private bool isExactSearch = false;

        /// <summary>
        /// Gets or sets informations ONA.
        /// </summary>
        private List<vwPanelONADto>? PanelONA = new List<vwPanelONADto>();

        /// <summary>
        /// Listado de etiquetas de la grilla.
        /// </summary>
        private List<VwGrillaDto>? listaEtiquetasGrilla;

        /// <summary>
        /// Listado de etiquetas de la grilla.
        /// </summary>
        private List<VwGrillaDto>? listaEtiquetasCards;

        [Inject]
        private IBusquedaService iBusquedaService { get; set; }

        [Inject]
        public Blazored.LocalStorage.ILocalStorageService localStorage { get; set; } = default!;

        private EventTrackingDto objEventTracking { get; set; } = new();

        private FiltrosBusquedaDto filtros { get; set; } = new();

        private bool mostrarFiltrosAvanzados = false;

        private bool isSearching = false;

        private bool isSearchingExport = false;

        /// <summary>
        /// Método de inicialización del componente.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            try
            {
                if (iCatalogosService != null)
                {
                    listaEtiquetasGrilla = await iCatalogosService.GetHomologacionAsync<List<VwGrillaDto>>("grid/schema");
                    //var ordenPersonalizado = new Dictionary<int, int>
                    //{
                    //    { 84, 1 },
                    //    { 78, 2 },
                    //    { 82, 3 }, // Eliminado el duplicado
                    //    { 83, 4 },
                    //    { 90, 5 },
                    //    { 93, 6 },
                    //    { 81, 7 },
                    //    { 92, 8 },
                    //    { 91, 9 }
                    //};

                    //listaEtiquetasCards = listaEtiquetasGrilla
                    //             ?.OrderBy(x => ordenPersonalizado.ContainsKey(x.IdHomologacion) ? ordenPersonalizado[x.IdHomologacion] : int.MaxValue)
                    //             .ToList();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        private void HandlePanelONAChange(List<vwPanelONADto> newPanelONA)
        {
            var nroOrg = newPanelONA.Sum(x => x.NroOrg);
            PanelONA = newPanelONA;
        }

        /// <summary>
        /// Método para manejar el cambio de filtros.
        /// </summary>
        private async Task HandleFilterChange(List<FiltrosBusquedaSeleccionDto> newFilter)
        {
            selectedFilter = newFilter;
            await Task.CompletedTask; // o hacer algo asíncrono si lo necesitas
        }


        /// <summary>
        /// Servicio de catálogos inyectado.
        /// </summary>
        /// <param name="_searchText"></param>
        /// <param name="_isExactSearch"></param>
        /// <returns></returns>
        private async Task onClickSearch(string _searchText, bool _isExactSearch)
        {
            searchText = _searchText;
            isExactSearch = _isExactSearch;
            ActivePageNumber = 1;
            isSearching = true; // ✅ comienza la búsqueda
            await BuscarEsquemas(_searchText, _isExactSearch);
            // 🔐 Guardar en localStorage para que el hijo los reutilice
            await localStorage.SetItemAsync("FiltrosBusqueda", filtros);

            isSearching = false; // ✅ termina la búsqueda
            // Registra los Eventos
            registeEvent("BuscarEsquema", "Buscar", "KEY_USER_SEARCH", JsonConvert.SerializeObject(filtros));

        }

        /// <summary>
        /// Método para manejar el cambio de página.
        /// </summary>
        private async Task ActivePageNumberChanged(int pageNumber)
        {
            ActivePageNumber = pageNumber;
            await BuscarEsquemas(searchText, isExactSearch);
            isSearching = false;
        }

        /// <summary>
        /// Método para manejar el cambio de cantidad de items por páginas a mostrar.
        /// </summary>
        private async Task DisplayPagesChanged(int displayPages)
        {
            isSearching = true;
            ActivePageNumber = 1;
            DisplayPages = displayPages;
            await BuscarEsquemas(searchText, isExactSearch);
            isSearching = false;
        }

        /// <summary>
        /// Método para manejar el cambio de visibilidad de la grilla.
        /// </summary>
        private async Task isGridVisibleChanged(bool isVisible)
        {
            isGridVisible = isVisible;
        }

        /// <summary>
        /// Método para realizar la busqueda correspondiente
        /// </summary>
        private async Task<List<BuscadorResultadoDataDto>> BuscarEsquemas(string searchText, bool isExactSearch)
        {
            try
            {
                if (iservicio != null)
                {
                    filtros = new FiltrosBusquedaDto
                    {
                        ExactaBuscar = isExactSearch,
                        TextoBuscar = searchText ?? "",
                        FiltroPais = selectedFilter?.FirstOrDefault(c => c.CodigoHomologacion == "KEY_FIL_PAI")?.Seleccion ?? new List<string>(),
                        FiltroOna = selectedFilter?.FirstOrDefault(c => c.CodigoHomologacion == "KEY_FIL_ONA")?.Seleccion ?? new List<string>(),
                        FiltroNorma = selectedFilter?.FirstOrDefault(c => c.CodigoHomologacion == "KEY_FIL_NOR")?.Seleccion ?? new List<string>(),
                        FiltroEsquema = selectedFilter?.FirstOrDefault(c => c.CodigoHomologacion == "KEY_FIL_ESQ")?.Seleccion ?? new List<string>(),
                        FiltroEstado = selectedFilter?.FirstOrDefault(c => c.CodigoHomologacion == "KEY_FIL_EST")?.Seleccion ?? new List<string>(),
                        //FiltroRecomocimiento = selectedFilter?.FirstOrDefault(c => c.CodigoHomologacion == "KEY_FIL_REC")?.Seleccion ?? new List<string>()
                    };

                    var result = await iservicio.PsBuscarPalabraAsync(JsonConvert.SerializeObject(filtros), ActivePageNumber, DisplayPages);

                    if (!(result.Data is null))
                    {
                        listBuscadorResultadoDataDto = result.Data;

                        // Prepara las URLs de los íconos
                        var itemsSinIcono = listBuscadorResultadoDataDto
                                            .Where(item => item.IdONA.HasValue && !iconUrls.ContainsKey(item.IdONA.Value))
                                            .ToList();

                        var tareas = itemsSinIcono.Select(async item =>
                        {
                            var iconUrl = await getIconUrl(item);
                            var parteRelativa = iconUrl.TrimStart('/');
                            var urlCompleta = $"{parteRelativa}";
                            return (IdONA: item.IdONA.Value, Url: urlCompleta);
                        });

                        var resultados = await Task.WhenAll(tareas);

                        foreach (var resultado in resultados)
                        {
                            iconUrls[resultado.IdONA] = resultado.Url;
                        }

                    }

                    if (ActivePageNumber == 1 && result.PanelONA != null)
                    {
                        TotalItems = result.TotalCount;
                        TotalPages = (int)Math.Ceiling((double)TotalItems / DisplayPages);
                        PanelONA = result.PanelONA;
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error en BuscarEsquemas: {e.Message}");
            }

            return listBuscadorResultadoDataDto;
        }

        /// <summary>
        /// Método obtener el icono correspondiente a la ONA.
        /// </summary>
        private async Task<string> getIconUrl(BuscadorResultadoDataDto resultData)
        {
            try
            {
                var idOna = resultData.IdONA;
                OnaDto = await iOnaService?.GetONAsAsync(idOna ?? 0);

                if (!string.IsNullOrEmpty(OnaDto.UrlIcono))
                {
                    var deserialized = JsonConvert.DeserializeObject<Dictionary<string, string>>(OnaDto.UrlIcono);

                    if (deserialized != null && deserialized.ContainsKey("filePath"))
                    {
                        // Obtener el filePath sin la barra inicial
                        var filePath = deserialized["filePath"]?.TrimStart('/');
                        if (!string.IsNullOrEmpty(filePath))
                        {
                            // Concatenar UrlBaseAdmin con el filePath
                            return $"{UrlBasesOptions.UrlBaseBuscador.TrimEnd('/')}/{filePath}";
                        }
                    }
                }

                return "https://via.placeholder.com/16";
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);

                return "https://via.placeholder.com/16";
            }
        }

        private async void registeEvent(string nombreAccion,
                                        string nombreControl,
                                        string codigoHomologacion,
                                        string filtros)
        {
            objEventTracking.CodigoHomologacionMenu = "/";
            objEventTracking.NombreAccion = nombreAccion;
            objEventTracking.NombreControl = nombreControl;
            objEventTracking.idUsuario = 0;
            objEventTracking.CodigoHomologacionRol = codigoHomologacion;
            objEventTracking.ParametroJson = filtros; ;
            objEventTracking.UbicacionJson = "";
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);
        }

        private void CambiarVisibilidadFiltrosAvanzados(bool mostrar)
        {
            mostrarFiltrosAvanzados = mostrar;
        }

        private async Task MostrarOverlayTemporal()
        {
            isSearching = true;
            StateHasChanged(); // Refresca UI para mostrar overlay
        }
    }


}