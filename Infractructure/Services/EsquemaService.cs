using Newtonsoft.Json;
using SharedApp.Response;
using System.Net.Http.Json;
using System.Text;
using Infractruture.Interfaces;
using SharedApp.Dtos;
using SharedApp.Helpers;
using Infractruture.Models;

namespace Infractruture.Services
{
    public class EsquemaService : IEsquemaService
    {
        private readonly HttpClient _httpClient;
        private string url = "api/esquema";

        public EsquemaService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }
        public async Task<List<EsquemaDto>> GetListEsquemasAsync()
        {
            var response = await _httpClient.GetAsync($"{url}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<EsquemaDto>>>()).Result;
        }

        public async Task<EsquemaDto> GetEsquemaAsync(int idEsquema)
        {
            var response = await _httpClient.GetAsync($"{url}/{idEsquema}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<EsquemaDto>>()).Result;
        }
        
        public async Task<RespuestaRegistro> RegistrarEsquemaActualizar(EsquemaDto esquemaRegistro)
        {
            var content = JsonConvert.SerializeObject(esquemaRegistro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;
            if (esquemaRegistro.IdEsquema > 0)
            {
                response = await _httpClient.PutAsync($"{url}/{esquemaRegistro.IdEsquema}", bodyContent);
            }
            else
            {
                response = await _httpClient.PostAsync($"{url}", bodyContent);
            }

            var contentTemp = await response.Content.ReadAsStringAsync();
            var resultado = JsonConvert.DeserializeObject<RespuestaRegistro>(contentTemp);

            if (response.IsSuccessStatusCode)
            {
                return new RespuestaRegistro { registroCorrecto = true };
            }
            else
            {
                return resultado;
            }
        }

        public async Task<bool> DeleteEsquemaAsync(int IdEsquema)
        {
            var response = await _httpClient.DeleteAsync($"{url}/{IdEsquema}");
            if (!response.IsSuccessStatusCode)
            {
                return false;
            }
            var apiResponse = await response.Content.ReadFromJsonAsync<RespuestasAPI<bool>>();
            return apiResponse?.IsSuccess ?? false;
        }
        
        public async Task<bool> EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(EsquemaVistaValidacionDto esquemaRegistro)
        {
            // Serializar esquemaRegistro como contenido JSON
            var content = JsonConvert.SerializeObject(esquemaRegistro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");

            // Realizar la solicitud DELETE con el cuerpo JSON
            var response = await _httpClient.SendAsync(new HttpRequestMessage
            {
                Method = HttpMethod.Delete,
                RequestUri = new Uri($"{url}/validacion"),
                Content = bodyContent
            });

            if (!response.IsSuccessStatusCode)
            {
                return false;
            }

            var apiResponse = await response.Content.ReadFromJsonAsync<RespuestasAPI<bool>>();
            return apiResponse?.IsSuccess ?? false;
        }

        public async Task<List<EsquemaDto>> GetEsquemaByOnaAsync(int idOna)
        {
            var response = await _httpClient.GetAsync($"{url}/esquemas/{idOna}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<EsquemaDto>>>()).Result;
        }
        public async Task<RespuestaRegistro> GuardarEsquemaVistaValidacionAsync(EsquemaVistaValidacionDto esquemaRegistro)
        {
            var content = JsonConvert.SerializeObject(esquemaRegistro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

            response = await _httpClient.PutAsync($"{url}/validacion/actualizar", bodyContent);

            var contentTemp = await response.Content.ReadAsStringAsync();
            var resultado = JsonConvert.DeserializeObject<RespuestaRegistro>(contentTemp);

            if (response.IsSuccessStatusCode)
            {
                return new RespuestaRegistro { registroCorrecto = true };
            }
            else
            {
                return resultado;
            }
        }

        public async Task<RespuestaRegistro> GuardarListaEsquemaVistaColumna(List<EsquemaVistaColumnaDto> listaEsquemaVistaColumna, int idOna, int idEsquema)
        {
            var content = JsonConvert.SerializeObject(listaEsquemaVistaColumna);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

            // Agregar parámetros idOna y idEsquema en la URL
            string requestUrl = $"{url}/vista/columna?idOna={idOna}&idEsquema={idEsquema}";
            response = await _httpClient.PostAsync(requestUrl, bodyContent);

            var contentTemp = await response.Content.ReadAsStringAsync();
            var resultado = JsonConvert.DeserializeObject<RespuestaRegistro>(contentTemp);

            if (response.IsSuccessStatusCode)
            {
                return new RespuestaRegistro { registroCorrecto = true };
            }
            else
            {
                return resultado;
            }
        }

        public async Task<string> ExportarExcelAsync()
        {
  
            var response = await _httpClient.PostAsync($"{url}/excel", null);
            response.EnsureSuccessStatusCode();

            var responseContent = await response.Content.ReadAsStringAsync();
            var exportResponse = JsonConvert.DeserializeObject<ExportResponse>(responseContent);

            if (exportResponse != null && exportResponse.success)
            {
                return exportResponse.url;
            }

            throw new Exception("No se pudo exportar el archivo Excel.");
        }

        public async Task<string> ExportarPdfAsync()
        {
            var response = await _httpClient.PostAsync($"{url}/pdf", null);
            response.EnsureSuccessStatusCode();

            var responseContent = await response.Content.ReadAsStringAsync();
            var exportResponse = JsonConvert.DeserializeObject<ExportResponse>(responseContent);

            if (exportResponse != null && exportResponse.success)
            {
                return exportResponse.url;
            }

            throw new Exception("No se pudo exportar el archivo PDF.");
        }

    }
}
