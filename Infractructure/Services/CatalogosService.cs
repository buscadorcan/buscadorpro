using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;
using Infractruture.Interfaces;
using SharedApp.Dtos;
using SharedApp.Helpers;
using SharedApp.Response;

namespace Infractruture.Services
{
    public class CatalogosService : ICatalogosService
    {
        private readonly HttpClient _httpClient;
        private string _urlBaseApi;

        public CatalogosService(HttpClient httpClient)
        {
            _httpClient = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
            _urlBaseApi = $"api/catalogos/";
        }
        public async Task<T?> GetHomologacionAsync<T>(string endpoint)
        {
            var url = _urlBaseApi;
            return await GetApiResponseAsync<T>($"{endpoint}");
        }
        public async Task<T?> GetFiltroDetalleAsync<T>(string endpoint, string CodigoHomologacion)
        {
            return await GetApiResponseAsync<T>($"{endpoint}/{CodigoHomologacion}");
        }
        private async Task<T?> GetApiResponseAsync<T>(string apiEndpoint)
        {
            
            var response = await _httpClient.GetAsync($"{_urlBaseApi}{apiEndpoint}");
            response.EnsureSuccessStatusCode();
            var respuesta = await response.Content.ReadFromJsonAsync<RespuestasAPI<T>>();

            if (respuesta != null && respuesta.IsSuccess && respuesta.Result != null)
            {
                return respuesta.Result;
            }

            return default;
        }

        public async Task<List<VwMenuDto>> GetMenusAsync()
        {
            var url = _urlBaseApi + "menu";
            var response = await _httpClient.GetAsync(url);
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<VwMenuDto>>>()).Result;
        }

        public async Task<List<VwFiltroDto>> GetFiltrosAsync()
        {
            try
            {
                var url = _urlBaseApi + "filters/schema";
                var response = await _httpClient.GetAsync(url);

                // Verificar si la respuesta es exitosa antes de continuar
                if (!response.IsSuccessStatusCode)
                {
                    Console.WriteLine($"Error en la respuesta HTTP: {response.StatusCode}");
                    return new List<VwFiltroDto>();
                }

                var jsonString = await response.Content.ReadAsStringAsync();
                Console.WriteLine($"Respuesta API: {jsonString}");

                // Verificar si la respuesta contiene JSON v�lido antes de deserializar
                if (string.IsNullOrWhiteSpace(jsonString))
                {
                    Console.WriteLine("La respuesta de la API est� vac�a.");
                    return new List<VwFiltroDto>();
                }

                // Intentar deserializar manualmente el JSON
                var apiResponse = JsonSerializer.Deserialize<RespuestasAPI<List<VwFiltroDto>>>(
                    jsonString,
                    new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

                if (apiResponse == null)
                {
                    Console.WriteLine("No se pudo deserializar la respuesta JSON.");
                    return new List<VwFiltroDto>();
                }

                return apiResponse.Result ?? new List<VwFiltroDto>();
            }
            catch (HttpRequestException ex)
            {
                Console.WriteLine($"Error en la solicitud HTTP: {ex.Message}");
            }
            catch (JsonException ex)
            {
                Console.WriteLine($"Error en la deserializaci�n JSON: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error inesperado: {ex.Message}");
            }

            return new List<VwFiltroDto>();
        }

        public async Task<List<vwPanelONADto>> GetPanelOnaAsync()
        {
            try
            {
                var url = _urlBaseApi + "panel";

                var request = new HttpRequestMessage(HttpMethod.Get, url);
                request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var response = await _httpClient.SendAsync(request);
                var content = await response.Content.ReadAsStringAsync();
                response.EnsureSuccessStatusCode();

                return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<vwPanelONADto>>>()).Result;
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw ex;
            }
  
        }

        public async Task<List<vwONADto>> GetvwOnaAsync()
        {
            var url = _urlBaseApi + "vwona";
            var response = await _httpClient.GetAsync(url);
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<vwONADto>>>()).Result;
        }

        public async Task<List<vwEsquemaOrganizaDto>> GetvwEsquemaOrganizaAsync()
        {
            var url = _urlBaseApi + "EsquemaOrganiza";
            var response = await _httpClient.GetAsync(url);
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<vwEsquemaOrganizaDto>>>()).Result;
        }

        public async Task<Dictionary<string, List<vw_FiltrosAnidadosDto>>> GetFiltrosAnidadosAsync(List<FiltrosBusquedaSeleccionDto> filtros)
        {
            var url = _urlBaseApi + "filters/anidados";
            var response = await _httpClient.PostAsJsonAsync(url, filtros);
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<Dictionary<string, List<vw_FiltrosAnidadosDto>>>()
                   ?? new Dictionary<string, List<vw_FiltrosAnidadosDto>>();
        }

        public async Task<List<vw_FiltrosAnidadosDto>> ObtenerFiltrosAnidadosAllAsync()
        {
            var url = _urlBaseApi + "anidados";

            var resultado = await _httpClient.GetFromJsonAsync<List<vw_FiltrosAnidadosDto>>(url);
            return resultado ?? new List<vw_FiltrosAnidadosDto>();
        }
    }
}