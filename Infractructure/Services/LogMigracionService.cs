using System.Net.Http.Json;
using Infractruture.Interfaces;
using SharedApp.Dtos;
using SharedApp.Helpers;
using SharedApp.Response;

namespace Infractruture.Services {
    public class LogMigracionService : ILogMigracionService
    {
        private readonly HttpClient _httpClient;
        private string url = "api/logmigracion";

        public LogMigracionService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<ResultadoPaginadoDto<List<LogMigracionDto>>> GetLogMigracionesAsync(int PageNumber, int RowsPerPage)
        {
            var response = await _httpClient.GetAsync($"{url}?PageNumber={PageNumber}&RowsPerPage={RowsPerPage}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<ResultadoPaginadoDto<List<LogMigracionDto>>>>()).Result;
        }
    }
}