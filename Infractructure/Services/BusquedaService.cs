using System.Net.Http.Json;
using System.Text;
using Infractruture.Interfaces;
using Infractruture.Models;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Response;

namespace Infractruture.Services
{
    public class BusquedaService(HttpClient httpClient) : IBusquedaService
    {
        private readonly HttpClient _httpClient = httpClient;
        public async Task<BuscadorDto> PsBuscarPalabraAsync(string paramJSON, int PageNumber, int RowsPerPage)
        {
            string encodedJson = Uri.EscapeDataString(paramJSON);
            var response = await _httpClient.GetAsync($"api/buscador/search/phrase?paramJSON={encodedJson}&PageNumber={PageNumber}&RowsPerPage={RowsPerPage}");
            response.EnsureSuccessStatusCode();

            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<BuscadorDto>>()).Result;
        }
        public async Task<List<HomologacionEsquemaDto>>  FnHomologacionEsquemaTodoAsync(string vistaFK, int idOna)
        {
            try
            {
                var url = $"api/buscador/homologacionEsquemaTodo?VistaFk={Uri.EscapeDataString(vistaFK)}&idOna={idOna}";
                var response = await _httpClient.GetAsync(url);
                response.EnsureSuccessStatusCode();
                var result = await response.Content.ReadFromJsonAsync<RespuestasAPI<List<HomologacionEsquemaDto>>>();
                return result?.Result ?? new List<HomologacionEsquemaDto>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en FnHomologacionEsquemaTodoAsync: {ex.Message}");
                throw;
            }
        }

        public async Task<HomologacionEsquemaDto?> FnHomologacionEsquemaAsync(int idHomologacionEsquema)
        {
            var response = await _httpClient.GetAsync($"api/buscador/homologacionEsquema/{idHomologacionEsquema}");
            response.EnsureSuccessStatusCode();

            var result = await response.Content.ReadFromJsonAsync<RespuestasAPI<HomologacionEsquemaDto>>();

            if (result != null)
            {
                return result.Result;
            }

            return default;
        }
        public async Task<List<DataHomologacionEsquema>> FnHomologacionEsquemaDatoAsync(int idHomologacionEsquema, string VistaFK, int idOna)
        {
            try
            {
                var url = $"api/buscador/homologacionEsquemaDato/{idHomologacionEsquema}/{VistaFK}/{idOna}";
                var response = await _httpClient.GetAsync(url);
                response.EnsureSuccessStatusCode();
                var result = await response.Content.ReadFromJsonAsync<RespuestasAPI<List<DataHomologacionEsquema>>>();
                return result?.Result ?? new List<DataHomologacionEsquema>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en FnHomologacionEsquemaDatoAsync: {ex.Message}");
                throw;
            }
        }

        public async Task<List<DataEsquemaDatoBuscar>> FnEsquemaDatoBuscarAsync(int idEsquemaData, string TextoBuscar)
        {
            try
            {
                // Construcción correcta de la URL con los parámetros adecuados
                var url = $"api/buscador/EsquemaDatoBuscado?idEsquemaData={idEsquemaData}&TextoBuscar={Uri.EscapeDataString(TextoBuscar)}";

                var response = await _httpClient.GetAsync(url);
                response.EnsureSuccessStatusCode();

                var result = await response.Content.ReadFromJsonAsync<RespuestasAPI<List<DataEsquemaDatoBuscar>>>();

                return result?.Result ?? new List<DataEsquemaDatoBuscar>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en FnEsquemaDatoBuscarAsync: {ex.Message}");
                throw;
            }
        }

        public async Task<fnEsquemaCabeceraDto?> FnEsquemaCabeceraAsync(int IdEsquemadata)
        {
            var response = await _httpClient.GetAsync($"api/buscador/fnesquemacabecera/{IdEsquemadata}");
            response.EnsureSuccessStatusCode();

            var result = await response.Content.ReadFromJsonAsync<RespuestasAPI<fnEsquemaCabeceraDto>>();

            if (result != null)
            {
                return result.Result;
            }

            return default;
        }

        public async Task<List<FnPredictWordsDto>> FnPredictWords(string word)
        {
            var response = await _httpClient.GetAsync($"api/buscador/predictWords?word={word}");
            response.EnsureSuccessStatusCode();

            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<FnPredictWordsDto>>>()).Result;
        }

        public  async Task<bool> ValidateWords(List<string> words)
        {
            
            var content = JsonConvert.SerializeObject(words);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");

            HttpResponseMessage response = await _httpClient.PostAsync($"api/buscador/validateWords", bodyContent);

            if (response.IsSuccessStatusCode)
            {
                var respuesta = await response.Content.ReadFromJsonAsync<RespuestasAPI<bool>>();
                return respuesta?.Result ?? false; 
            }
            else
            {
                return false; 
            }

        }

        public async Task<bool> AddEventTrackingAsync(EventTrackingDto eventTracking)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync($"api/buscador/addEventTracking", eventTracking);

                response.EnsureSuccessStatusCode(); // Lanza una excepción si la respuesta no es exitosa

                var result = await response.Content.ReadFromJsonAsync<RespuestasAPI<string>>();

                return result != null && result.Result == "Evento registrado con éxito.";
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en AddEventTrackingAsync: {ex.Message}");
                return false; // Devuelve false en caso de error
            }
        }

        public async Task<GeocodeResponseDto?> ObtenerCoordenadasAsync(string pais, string ciudad)
        {
            try
            {
                // Construimos la dirección uniendo ciudad y país
                var fullAddress = $"{ciudad}, {pais}";
                // Escapamos los caracteres especiales
                var encodedAddress = Uri.EscapeDataString(fullAddress);

                // Incluimos el parámetro address en la URL
                var url = $"api/buscador/geocode?address={encodedAddress}";

                var response = await _httpClient.GetAsync(url);
                response.EnsureSuccessStatusCode();

                return await response.Content.ReadFromJsonAsync<GeocodeResponseDto>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error en ObtenerCoordenadasAsync: {ex.Message}");
                return null;
            }
        }


        public async Task<byte[]> ExportarExcelAsync(List<BuscadorResultadoDataDto> data)
        {
            var json = JsonConvert.SerializeObject(data);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"api/buscador/excel", content);
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadAsByteArrayAsync();
        }

        public async Task<byte[]> ExportarPdfAsync(List<BuscadorResultadoDataDto> data)
        {
            var json = JsonConvert.SerializeObject(data);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"api/buscador/pdf", content);
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadAsByteArrayAsync();
        }

        public async Task<string> ExportarExcelBuscAsync(string paramJson)
        {
            if (string.IsNullOrWhiteSpace(paramJson))
                throw new ArgumentException("paramJson no puede ser null ni vacío.", nameof(paramJson));

            var payload = new { paramJSON = paramJson };
            var jsonString = System.Text.Json.JsonSerializer.Serialize(payload);
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync("api/buscador/excel", content);
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var resultado = JsonConvert.DeserializeObject<ExportResultDto>(json)
                            ?? throw new InvalidOperationException("La respuesta no pudo deserializarse.");

            if (!resultado.Success)
                throw new InvalidOperationException("La API devolvió success=false al generar el Excel.");

            return resultado.base64;
        }

        public async Task<string> ExportarPdfBuscAsync(string paramJson)
        {
            if (string.IsNullOrWhiteSpace(paramJson))
                throw new ArgumentException("paramJson no puede ser null ni vacío.", nameof(paramJson));


            var payload = new { paramJSON = paramJson };
            var jsonString = System.Text.Json.JsonSerializer.Serialize(payload);
            var content = new StringContent(jsonString, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync("api/buscador/pdf", content);

            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var resultado = JsonConvert.DeserializeObject<ExportResultDto>(json)
                            ?? throw new InvalidOperationException("La respuesta no pudo deserializarse.");


            if (!resultado.Success)
                throw new InvalidOperationException("La API devolvió success=false al generar el Excel.");

            // 4) Devolver la URL
            return resultado.base64;

        }

        public async Task<string> DescargarPDF(string url)
        {
            try
            {
                var response = await _httpClient.GetAsync($"api/buscador/descargar-pdf?url={url}");
                response.EnsureSuccessStatusCode();
                var pdfBytes = await response.Content.ReadAsByteArrayAsync();
                var base64 = Convert.ToBase64String(pdfBytes);
                return $"data:application/pdf;base64,{base64}";
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}