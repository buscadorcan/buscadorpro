using Infractruture.Interfaces;
using Infractruture.Models;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Helpers;
using System.Net.Http.Json;
using System.Text;

namespace Infractruture.Services
{
    public class ThesaurusService : IThesaurusService
    {
        private readonly HttpClient _httpClient;
        private readonly string _urlBaseApi;



        public ThesaurusService(HttpClient httpClient)
        {
            _httpClient = httpClient ?? throw new ArgumentNullException(nameof(httpClient));
            _urlBaseApi = "api/thesaurus/";
        }

        ///<summary>
        ///GetThesaurusAsync: Obtiene el archivo thesauros en formato json
        ///</summary>
        public async Task<ThesaurusDto> GetThesaurusAsync(string endpoint)
        {
            var response = await _httpClient.GetAsync($"{_urlBaseApi}{endpoint}");
            response.EnsureSuccessStatusCode();
            var respuesta = await response.Content.ReadFromJsonAsync<SharedApp.Response.RespuestasAPI<ThesaurusDto>>();

            if (respuesta != null && respuesta.IsSuccess && respuesta.Result != null)
            {
                return respuesta.Result;
            }

            return default;
        }

        ///<summary>
        ///UpdateExpansionAsync: Actualiza la lista de expansion del archivo thesauros
        ///</summary>
        public async Task<RespuestaRegistro> UpdateExpansionAsync(string endpoint, List<ExpansionDto> expansions)
        {
            var content = JsonConvert.SerializeObject(expansions);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

            response = await _httpClient.PostAsync($"{_urlBaseApi}{endpoint}", bodyContent);

            if (response.IsSuccessStatusCode)
            {
                return new RespuestaRegistro { registroCorrecto = true };
            }
            else
            {
                return new RespuestaRegistro { registroCorrecto = false }; ;
            }
        }

        ///<summary>
        ///EjecutarBatAsync: realiza la acci�m de reemplazo del archivo thesaurus en la carpeta de sqlserver
        ///</summary>
        public async Task<string> EjecutarBatAsync(string endpoint)
        {
            var response = await _httpClient.GetAsync($"{_urlBaseApi}{endpoint}");
            response.EnsureSuccessStatusCode();
            var respuesta = await response.Content.ReadFromJsonAsync<SharedApp.Response.RespuestasAPI<string>>();

            if (respuesta != null && respuesta.IsSuccess && respuesta.Result != null)
            {
                return respuesta.Result;
            }

            return default;
        }

        ///<summary>
        ///ResetSqlServerAsync: ejecuta la acci�n de reinicio del servicio de sqlserver
        ///</summary>
        public async Task<string> ResetSqlServerAsync(string endpoint)
        {
            var response = await _httpClient.GetAsync($"{_urlBaseApi}{endpoint}");
            response.EnsureSuccessStatusCode();
            var respuesta = await response.Content.ReadFromJsonAsync<SharedApp.Response.RespuestasAPI<string>>();

            if (respuesta != null && respuesta.IsSuccess && respuesta.Result != null)
            {
                return respuesta.Result;
            }

            return default;
        }
    }
}