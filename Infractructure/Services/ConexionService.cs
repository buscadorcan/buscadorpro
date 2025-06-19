using System.Net;
using System.Net.Http.Json;
using System.Text;
using Infractruture.Interfaces;
using Infractruture.Models;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Helpers;
using SharedApp.Response;

namespace Infractruture.Services
{
    public class ConexionService : IConexionService
    {
        private readonly HttpClient _httpClient;
        private string url = "api/conexion";

        public ConexionService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<RespuestaRegistro> EliminarConexion(int idConexion)
        {
            HttpResponseMessage response = await _httpClient.DeleteAsync($"{url}/{idConexion}");
            if (response.IsSuccessStatusCode)
            {
                return new RespuestaRegistro { registroCorrecto = true };
            }
            else
            {
                var contentTemp = await response.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<RespuestaRegistro>(contentTemp);
            }
        }

        public async Task<ONAConexionDto> GetConexionAsync(int idConexion)
        {
            var response = await _httpClient.GetAsync($"{url}/{idConexion}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<ONAConexionDto>>()).Result;
        }
        public async Task<ONAConexionDto> GetOnaConexionByOnaAsync(int idOna)
        {
            var response = await _httpClient.GetAsync($"{url}/{idOna}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<ONAConexionDto>>()).Result;
        }
        public async Task<List<ONAConexionDto>> GetOnaConexionByOnaListAsync(int idOna)
        {
            var response = await _httpClient.GetAsync($"{url}/ListaOna/{idOna}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<ONAConexionDto>>>()).Result;
        }
        public async Task<List<ONAConexionDto>> GetConexionsAsync()
        {
            var response = await _httpClient.GetAsync($"{url}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<ONAConexionDto>>>()).Result;
        }

        public async Task<RespuestaRegistro> Registrar(ONAConexionDto registro)
        {
            var content = JsonConvert.SerializeObject(registro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

            // Crear nuevo registro
            response = await _httpClient.PostAsync(url, bodyContent);

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

        public async Task<RespuestaRegistro> Actualizar(ONAConexionDto registro)
        {

            var content = JsonConvert.SerializeObject(registro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;


            var UrlNew = $"{url}/{registro.IdONA}";
            // Actualizar registro existente
            response = await _httpClient.PutAsync($"{url}/{registro.IdONA}", bodyContent);


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

        public async Task<RespuestaRegistro> RegistrarCronograma(int? idOna, OnaConexionCronDto registro)
        {
            HttpResponseMessage response;
            var content = JsonConvert.SerializeObject(registro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");

            response = await _httpClient.PutAsync($"{url}/cronograma/{idOna}", bodyContent);
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

        public async Task<HttpResponseMessage> ImportarExcel(MultipartFormDataContent content)
        {
            return await _httpClient.PostAsync($"{url}/upload", content);
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