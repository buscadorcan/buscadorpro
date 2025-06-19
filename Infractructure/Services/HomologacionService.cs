using System.Net.Http.Json;
using System.Text;
using Infractruture.Interfaces;
using Infractruture.Models;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Response;

namespace Infractruture.Services
{
    public class HomologacionService : IHomologacionService
    {
        private readonly HttpClient _httpClient;
        private string url = "api/homologacion";

        public HomologacionService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<RespuestaRegistro> EliminarHomologacion(int idHomologacion)
        {
            HttpResponseMessage response = await _httpClient.DeleteAsync($"{url}/{idHomologacion}");
            if (response.IsSuccessStatusCode)
            {
                return new RespuestaRegistro { registroCorrecto = true };
            }
            else
            {
                var contentTemp = await response.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<RespuestasAPI<RespuestaRegistro>>(contentTemp).Result;
            }
        }
        public async Task<bool> DeleteHomologacionAsync(int IdHomologacion)
        {
            var response = await _httpClient.DeleteAsync($"{url}/{IdHomologacion}");
            if (!response.IsSuccessStatusCode)
            {
                return false;
            }
            var apiResponse = await response.Content.ReadFromJsonAsync<RespuestasAPI<bool>>();
            return apiResponse?.IsSuccess ?? false;
        }
        public async Task<HomologacionDto> GetHomologacionAsync(int idHomologacion)
        {
            var response = await _httpClient.GetAsync($"{url}/{idHomologacion}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<HomologacionDto>>()).Result;
        }

        public async Task<List<HomologacionDto>> GetHomologacionsAsync()
        {
            var response = await _httpClient.GetAsync($"{url}/findByParent");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<HomologacionDto>>>()).Result;
        }

        public async Task<RespuestaRegistro> Registrar(HomologacionDto registro)
        {
            var content = JsonConvert.SerializeObject(registro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

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

        public async Task<RespuestaRegistro> Actualizar(HomologacionDto registro)
        {
            var content = JsonConvert.SerializeObject(registro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

            response = await _httpClient.PutAsync($"{url}/{registro.IdHomologacion}", bodyContent);

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

        public async Task<List<HomologacionDto>> FindByMostrarWeb(string value)
        {
            var response = await _httpClient.GetAsync($"{url}/findByParent/{value}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<HomologacionDto>>>()).Result;
        }

        public async Task<ResultadoPaginadoDto<List<HomologacionDto>>> GetHomologacionsSelectAsync(string codigoHomologacion, int PageNumber, int RowsPerPage)
        {
            var response = await _httpClient.GetAsync($"{url}/findByCodigoHomologacion/{codigoHomologacion}?PageNumber={PageNumber}&RowsPerPage={RowsPerPage}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<ResultadoPaginadoDto<List<HomologacionDto>>>>()).Result;
        }

        public async Task<List<HomologacionDto>> GetFindByAllAsync()
        {
            var response = await _httpClient.GetAsync($"{url}/FindByAll");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<HomologacionDto>>>()).Result;
        }

        public async Task<string> ExportarExcelAsync(string codigoHomologacion)
        {
            var response = await _httpClient.PostAsync($"{url}/excel?codigoHomologacion={codigoHomologacion}", null);
            response.EnsureSuccessStatusCode();

            var responseContent = await response.Content.ReadAsStringAsync();
            var exportResponse = JsonConvert.DeserializeObject<ExportResponse>(responseContent);

            if (exportResponse != null && exportResponse.success)
            {
                return exportResponse.url;
            }

            throw new Exception("No se pudo exportar el archivo Excel.");
        }

        public async Task<string> ExportarPdfAsync(string codigoHomologacion)
        {
            var response = await _httpClient.PostAsync($"{url}/pdf?codigoHomologacion={codigoHomologacion}", null);
            response.EnsureSuccessStatusCode();

            var responseContent = await response.Content.ReadAsStringAsync();
            var exportResponse = JsonConvert.DeserializeObject<ExportResponse>(responseContent);

            if (exportResponse != null && exportResponse.success)
            {
                return exportResponse.url;
            }

            throw new Exception("No se pudo exportar el archivo PDF.");
        }
        public async Task<string> ExportarExcelAsync()
        {
            var response = await _httpClient.PostAsync($"{url}/excel_sin_codigo", null);
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
            var response = await _httpClient.PostAsync($"{url}/pdf_sin_codigo", null);
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