using Infractruture.Interfaces;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Response;
using System.Net.Http.Json;

namespace Infractruture.Services
{
    public class MigracionExcelService : IMigracionExcelService
    {
        private readonly HttpClient _httpClient;
        private string url = "api/migracionexcel";

        public MigracionExcelService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<MigracionExcelDto>> GetMigracionExcelsAsync(int PageNumber, int RowsPerPage)
        {
            var response = await _httpClient.GetAsync($"{url}?PageNumber={PageNumber}&RowsPerPage={RowsPerPage}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<MigracionExcelDto>>>()).Result;
        }

        public async Task<HttpResponseMessage> ImportarExcel(MultipartFormDataContent content, int idOna)
        {
            return await _httpClient.PostAsync($"{url}/upload?idOna={idOna}", content);
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