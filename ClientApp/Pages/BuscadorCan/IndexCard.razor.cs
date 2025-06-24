using BlazorBootstrap;
using Infractruture.Interfaces;
using Infractruture.Services;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;
using SharedApp.Helpers;

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para la página de búsqueda de CAN.
    /// </summary>
    public partial class IndexCard : ComponentBase
    {
        /// <summary>
        /// Servicio para obtener catálogos.
        /// </summary>
        [Inject] public ICatalogosService? iCatalogosService { get; set; }

        /// <summary>
        /// Servicio para obtener la ruta de onas.
        /// </summary>
        [Inject] public IONAService? iONAService { get; set; }

        /// <summary>
        /// Servicio de JavaScript.
        /// </summary>
        [Inject] public IJSRuntime? iJSRuntime { get; set; }

        /// <summary>
        /// Servicio de búsqueda.
        /// </summary>
        [Inject] public IBusquedaService? Servicio { get; set; }

        /// <summary>
        /// Servicio de homologación.
        /// </summary>
        [Inject] public IHomologacionService? HomologacionService { get; set; }

        ///<summary>
        /// Configuración
        /// </summary>
        [Inject] public IConfiguration configuration { get; set; }

        /// <summary>
        /// Gets or sets the list data dto.
        /// </summary>
        private List<BuscadorResultadoDataDto>? _listDataDto;

        /// <summary>
        /// Gets or sets the list data dto.
        /// </summary>
        [Parameter]
        public List<BuscadorResultadoDataDto>? ListDataDto
        {
            get => _listDataDto;
            set
            {
                // ✅ Verificar que no sea null ni vacío y que haya diferencias
                if (value != null && value.Any() &&
                    !Enumerable.SequenceEqual(_listDataDto ?? new(), value))
                {
                    _listDataDto = value;
                    CurrentPage = 1;

                    // 🔒 Llama solo si hay datos
                    _ = ObtenerCoordenadasYMarcarMapa();
                }
                else
                {
                    // 🧹 Si no hay datos, limpiar el mapa también
                    _listDataDto = value;
                    markers.Clear();
                }
            }
        }


        /// <summary>
        /// Gets or sets the list url data dto.
        /// </summary>
        [Parameter] public Dictionary<int, string>? iconUrls { get; set; }

        /// <summary>
        /// Listado de coordenadas del resultado de la búsquedda.
        /// </summary>
        [Parameter] public List<(string Pais, string Ciudad)> uniqueLocations { get; set; } = new();

        /// <summary>
        /// Listado de etiquetas de la grilla.
        /// </summary>
        [Parameter] public List<VwGrillaDto>? listaEtiquetasGrilla { get; set; }

        /// <summary>
        /// Componente modal.
        /// </summary>
        private Modal modal = default!;

        /// <summary>
        /// google maps module
        /// </summary>
        private IJSObjectReference? _googleMapsModule;

        /// <summary>
        /// key google maps
        /// </summary>
        private string ApiKey = string.Empty;

        /// <summary>
        /// google maps point center
        /// </summary>
        private GoogleMapCenter mapCenter = new(-4, -78);
        /// <summary>
        /// google maps markers
        /// </summary>
        private List<GoogleMapMarker> markers = new();

        /// <summary>
        /// google maps
        /// </summary>
        private GoogleMap? mapa;

        [Parameter] 
        public int CurrentPage { get; set; } = 1;
      
        [Parameter] 
        public int PageSize { get; set; } = 10;

        private IEnumerable<BuscadorResultadoDataDto> PagedListDataDto =>
       _listDataDto?.Skip((CurrentPage - 1) * PageSize).Take(PageSize) ?? Enumerable.Empty<BuscadorResultadoDataDto>();

        private int TotalPages => (int)Math.Ceiling((_listDataDto?.Count ?? 0) / (double)PageSize);

        [Parameter]
        public bool IsGridVisible { get; set; }

        private bool? _previousIsGridVisible;
        private bool _mapaCargando = true;
        private static readonly Dictionary<string, GoogleMapCenter> _coordCache = new Dictionary<string, GoogleMapCenter>();

        /// <summary>
        /// Inicializar vaklores
        /// </summary>
        /// <returns></returns>
        protected override async Task OnInitializedAsync()
        {
            this.ApiKey = configuration["GoogleOAuth:ApiKeyGoogleMaps"];
            await ObtenerCoordenadasYMarcarMapa();
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async void MostrarDetalle(BuscadorResultadoDataDto item)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", item);
            modal.Size = ModalSize.ExtraLarge;
            modal.Style = "font-size: 10px !important;";
            await modal.ShowAsync<EsquemaModal>(title: "Información Detallada", parameters: parameters);
            await OnModalClosed();
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async void showModalOna(BuscadorResultadoDataDto resultData)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Size = ModalSize.Regular;
            modal.Style = "font-size: 10px !important;";
            await modal.ShowAsync<OnaModal>(title: "Información Organizacion", parameters: parameters);
            await OnModalClosed();
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        /// <param name="resultData"></param>
        private async void showModalOEC(BuscadorResultadoDataDto resultData)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Style = "font-size: 10px !important;";
            modal.Size = ModalSize.Regular;
            await modal.ShowAsync<OECModal>(title: "Información del OEC", parameters: parameters);
            await OnModalClosed();
        }

        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        private async void showModalESQ(BuscadorResultadoDataDto resultData)
        {
            var parameters = new Dictionary<string, object>();
            parameters.Add("resultData", resultData);
            modal.Style = "font-size: 10px !important;";
            modal.Size = ModalSize.ExtraLarge;
            await modal.ShowAsync<IndvEsquemaModal>(title: "Información Esquema", parameters: parameters);
            await OnModalClosed();
        }

        //TODO: En las tarjetas tambien llamar al modal de PETMODAL
        /// <summary>
        /// Método para mostrar el resultados en ventana modal
        /// </summary>
        //private async Task AbrirPdf(BuscadorResultadoDataDto item)
        //{
        //    // Obtener la URL del certificado
        //    var base64 = await GetPdfUrlFromEsquema(item);

        //    if (string.IsNullOrWhiteSpace(base64))
        //    {
        //        Console.WriteLine("Archivo no encontrado.");
        //    }

        //    var parameters = new Dictionary<string, object>();
        //    parameters.Add("PdfUrl", base64);
        //    await modal.ShowAsync<PdfModal>(title: "Información", parameters: parameters);
        //    await OnModalClosed();
        //}

        /// <summary>
        /// Método para obtener la URL del certificado.
        /// </summary>
        private async Task<string?> GetPdfUrlFromEsquema(BuscadorResultadoDataDto resultData)
        {
            try
            {
                if (resultData.DataEsquemaJson == null || !resultData.DataEsquemaJson.Any())
                    return null;

                var homologaciones = await HomologacionService.GetHomologacionsAsync();
                var idHomologacion = homologaciones.FirstOrDefault(x => x.CodigoHomologacion == "KEY_ESQ_CERT")?.IdHomologacion;

                if (idHomologacion == null)
                    return null;

                var urlPdf = resultData.DataEsquemaJson?.FirstOrDefault(f => f.IdHomologacion == idHomologacion)?.Data;


                return await Servicio.DescargarPDF(urlPdf);
                await OnModalClosed();
            }
            catch (Exception ex)
            {
                throw new Exception("Archivo no encontrado", ex);
            }
        }

        /// <summary>
        /// Método para obtener las coordenadas y marcar el mapa.
        /// </summary>

        private async Task ObtenerCoordenadasYMarcarMapa()
        {
            if (_listDataDto == null || !_listDataDto.Any())
                return;

            // 1) Agrupación País–Ciudad → cantidad OECs
            var agrupacionONAs = ListDataDto!
              .Where(d => d.DataEsquemaJson != null)
              .GroupBy(d => new
              {
                  Pais = d.DataEsquemaJson.FirstOrDefault(f => f.IdHomologacion == 162)?.Data?.Trim(),
                  Ciudad = d.DataEsquemaJson.FirstOrDefault(f => f.IdHomologacion == 163)?.Data?.Trim()
              })
              .Where(g => !string.IsNullOrEmpty(g.Key.Pais) && !string.IsNullOrEmpty(g.Key.Ciudad))
              .ToDictionary(
                g => $"{g.Key.Pais}-{g.Key.Ciudad}",
                g => g.Select(x => x.DataEsquemaJson
                                    .FirstOrDefault(f => f.IdHomologacion == 160)?.Data?.Trim())
                      .Where(oec => !string.IsNullOrEmpty(oec))
                      .Distinct()
                      .Count()
              );

            // 2) Lanzar concurrencia controlada (máx. 5 peticiones geocoding simultáneas)
            var throttler = new SemaphoreSlim(5);
            var tareas = new List<Task>();

            foreach (var locKey in agrupacionONAs.Keys)
            {
                if (_coordCache.ContainsKey(locKey))
                    continue; // ya cacheado

                tareas.Add(Task.Run(async () =>
                {
                    await throttler.WaitAsync();
                    try
                    {
                        var parts = locKey.Split('-');
                        var coord = await ObtenerCoordenadas(parts[0], parts[1]);
                        if (coord != null)
                            _coordCache[locKey] = coord;
                    }
                    finally
                    {
                        throttler.Release();
                    }
                }));
            }

            await Task.WhenAll(tareas);

            // 3) Recrear marcadores usando la cache
            markers.Clear();
            bool primero = true;

            foreach (var kvp in agrupacionONAs)
            {
                var locKey = kvp.Key;               // "Perú-Lima"
                if (!_coordCache.TryGetValue(locKey, out var center))
                    continue;                       // si falló geocoding

                // Extraer país y ciudad
                var parts = locKey.Split('-');
                var pais = parts[0];
                var ciudad = parts[1];

                // Obtener icono para esta ONA
                string? iconoRuta = await ObtenerIconoONA(pais, ciudad);

                // Añadir marcador al mapa 
                // <span style='font-size:13px;'>{ciudad}, {pais}</span><br/> --> para mostrar ciudad y pais en caso sea necesario
                markers.Add(new GoogleMapMarker
                {
                    Position = new GoogleMapMarkerPosition(center.Latitude, center.Longitude),
                    Title = $"{ciudad}, {pais} – {kvp.Value} E&E",
                    Content = $@"
                    <div style='text-align:center;font-size:12px;'>
                      <p style='margin:2px 0;font-weight:bold;'>                 
                        <span style='color:red;font-weight:bold;font-size:14px;'>E&E: {kvp.Value}</span>
                      </p>
                      <img src='{iconoRuta}' width='28' height='28' style='border-radius:50%;' />
                    </div>"
                });

                if (primero)
                {
                    mapCenter = center;  // centrar en el primer marcador
                    primero = false;
                }
            }
            _mapaCargando = false;
            // Refrescar el render y el mapa
            StateHasChanged();
            if (mapa != null)
                await mapa.RefreshAsync();
        }

        /// <summary>
        /// Método para obtener las coordenadas de un lugar.
        /// </summary>
        private async Task<GoogleMapCenter?> ObtenerCoordenadas(string pais, string ciudad)
        {
            try
            {

                var response = await Servicio.ObtenerCoordenadasAsync(pais, ciudad);

                if (response?.Results?.Length > 0)
                {
                    var location = response.Results[0].Geometry.Location;
                    return new GoogleMapCenter(location.Lat, location.Lng);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error obteniendo coordenadas desde el servicio: {ex.Message}");
            }
            return null;
        }

        /// <summary>
        /// Clase para deserializar la respuesta de la API de Google Maps.
        /// </summary>
        private class GeocodeResponse { public GeocodeResult[] Results { get; set; } }

        /// <summary>
        /// Clase para deserializar la ubicación de la respuesta de la API de Google Maps.
        /// </summary>
        private class GeocodeResult { public Geometry Geometry { get; set; } }

        /// <summary>
        /// Clase para deserializar la geometría de la respuesta de la API de Google Maps.
        /// </summary>
        private class Geometry { public Location Location { get; set; } }

        /// <summary>
        /// Clase para deserializar la ubicación de la respuesta de la API de Google Maps.
        /// </summary>
        private class Location { public double Lat { get; set; } public double Lng { get; set; } }

        private async Task<string?> ObtenerIconoONA(string pais, string ciudad)
        {
            try
            {
                // Buscar el objeto que contiene el ID del ONA basado en la ciudad y el país
                var resultData = ListDataDto?
                    .FirstOrDefault(d =>
                        d.DataEsquemaJson?.Any(f => f.IdHomologacion == 162 && f.Data?.Trim() == pais) == true &&
                        d.DataEsquemaJson?.Any(f => f.IdHomologacion == 163 && f.Data?.Trim() == ciudad) == true);

                if (resultData == null || resultData.IdONA == null)
                    return "/Icono/default-marker.png"; // Icono por defecto

                // Obtener la URL del ícono para este ONA
                var Onas = await iONAService.GetONAsAsync(Convert.ToInt32(resultData.IdONA));
                var jsonRuta = Onas?.UrlIcono;

                if (string.IsNullOrWhiteSpace(jsonRuta))
                    return "/Icono/default-marker.png"; // Si está vacío, usa icono por defecto

                // Deserializar JSON para obtener la ruta correcta
                var objetoRuta = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(jsonRuta);

                if (objetoRuta != null && objetoRuta.ContainsKey("filePath"))
                {
                    var rutaFinal = $"{UrlBasesOptions.UrlBaseBuscador.TrimEnd('/')}/{objetoRuta["filePath"].TrimStart('/')}";
                    return rutaFinal;
                }

                return "/Icono/default-marker.png"; // Si algo falla, usar ícono por defecto
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error obteniendo icono ONA: {ex.Message}");
                return "/Icono/default-marker.png"; // En caso de error, usar un ícono por defecto
            }
        }

        protected override async Task OnParametersSetAsync()
        {
            // Si _previousIsGridVisible es null, es la primera vez que recibe el valor.
            // Si no es null, comparamos el valor anterior con el actual
            if (_previousIsGridVisible.HasValue
                && _previousIsGridVisible.Value == true
                && IsGridVisible == false)
            {
                // Aquí detectamos que cambió de “true” a “false”
                await ObtenerCoordenadasYMarcarMapa();
            }

            // Actualizamos el valor anterior para la próxima vez
            _previousIsGridVisible = IsGridVisible;
        }

        private async Task OnModalClosed()
        {
            if (mapa != null)
            {
                await mapa.RefreshAsync();
            }
        }

    }
}
