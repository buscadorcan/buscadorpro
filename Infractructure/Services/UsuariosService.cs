using System.Net.Http.Json;
using System.Text;
using Infractruture.Interfaces;
using Infractruture.Models;
using Microsoft.Win32;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Response;

namespace Infractruture.Services
{
    public class UsuariosService : IUsuariosService
    {
        private readonly HttpClient _httpClient;
        private readonly string url = "api/usuarios";
        private readonly string url3 = "api/catalogos/roles";
        private readonly string url4 = "api/catalogos/onas";

        public UsuariosService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }
        public async Task<List<UsuarioDto>> GetUsuariosAsync()
        {


            var response = await _httpClient.GetAsync($"{url}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<UsuarioDto>>>()).Result;
        }
        public async Task<bool> DeleteUsuarioAsync(int IdUsuario)
        {
            var response = await _httpClient.DeleteAsync($"{url}/{IdUsuario}");
            if (!response.IsSuccessStatusCode)
            {
                return false;
            }
            var apiResponse = await response.Content.ReadFromJsonAsync<RespuestasAPI<bool>>();
            return apiResponse?.IsSuccess ?? false;
        }
        public async Task<UsuarioDto> GetUsuarioAsync(int IdUsuario)
        {
            var response = await _httpClient.GetAsync($"{url}/{IdUsuario}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<UsuarioDto>>()).Result;
        }
        public async Task<List<VwRolDto>> GetRolesAsync()
        {
            var response = await _httpClient.GetAsync($"{url3}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<VwRolDto>>>()).Result;
        }
        public async Task<List<OnaDto>> GetOnaAsync()
        {
            var response = await _httpClient.GetAsync($"{url4}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<OnaDto>>>()).Result;
        }

        public async Task<RespuestaRegistro> Registrar(UsuarioDto registro)
        {
            if (registro.Rol == null)
            {
                registro.Rol = "";
            }

            if (registro.RazonSocial == null)
            {
                registro.RazonSocial = "";
            }

            var settings = new JsonSerializerSettings
            {
                NullValueHandling = NullValueHandling.Ignore
            };
            var content = JsonConvert.SerializeObject(registro, settings);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response = null;

            try
            {

                // Si el IdUsuario es 0 o menor, realizamos un POST (registro)
                response = await _httpClient.PostAsync($"{url}/registro", bodyContent);

                // Lee el contenido de la respuesta
                var contentTemp = await response.Content.ReadAsStringAsync();
                var resultado = JsonConvert.DeserializeObject<RespuestaRegistro>(contentTemp);

                // Si la respuesta es exitosa (status code 2xx)
                if (response.IsSuccessStatusCode)
                {
                    return new RespuestaRegistro { registroCorrecto = true };
                }
                else
                {
                    // Si la respuesta no fue exitosa, retornamos el resultado de la deserializaci�n
                    return resultado ?? new RespuestaRegistro { registroCorrecto = false, mensajeError = "Error desconocido." };
                }
            }
            catch (Exception ex)
            {
                // En caso de una excepci�n, se maneja el error
                return new RespuestaRegistro
                {
                    registroCorrecto = false,
                    mensajeError = $"Excepción durante la solicitud: {ex.Message}"
                };
            }
        }

        public async Task<RespuestaRegistro> Actualizar(UsuarioDto registro)
        {
            if (registro.Rol == null)
            {
                registro.Rol = "";
            }

            if (registro.RazonSocial == null)
            {
                registro.RazonSocial = "";
            }

            var settings = new JsonSerializerSettings
            {
                NullValueHandling = NullValueHandling.Ignore
            };
            var content = JsonConvert.SerializeObject(registro, settings);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response = null;

            try
            {

                int idUsuario = registro.IdUsuario;
                response = await _httpClient.PutAsync($"{url}/{idUsuario}", bodyContent);

                // Lee el contenido de la respuesta
                var contentTemp = await response.Content.ReadAsStringAsync();
                var resultado = JsonConvert.DeserializeObject<RespuestaRegistro>(contentTemp);

                // Si la respuesta es exitosa (status code 2xx)
                if (response.IsSuccessStatusCode)
                {
                    return new RespuestaRegistro { registroCorrecto = true };
                }
                else
                {
                    // Si la respuesta no fue exitosa, retornamos el resultado de la deserializaci�n
                    return resultado ?? new RespuestaRegistro { registroCorrecto = false, mensajeError = "Error desconocido." };
                }
            }
            catch (Exception ex)
            {
                // En caso de una excepci�n, se maneja el error
                return new RespuestaRegistro
                {
                    registroCorrecto = false,
                    mensajeError = $"Excepción durante la solicitud: {ex.Message}"
                };
            }
        }

        public async Task<bool> ValidarEmailUnico(string email)
        {
            var response = await _httpClient.GetAsync($"{url}/validar-email?email={email}");
            return await response.Content.ReadFromJsonAsync<bool>();
        }

        public async Task<RespuestasAPI<bool>> ActualizarClave(UsuarioCambiarClaveDto usuarioCambiarClave)
        {
            var content = JsonConvert.SerializeObject(usuarioCambiarClave);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync($"{url}/cambiar_clave", bodyContent);
            var contentTemp = await response.Content.ReadAsStringAsync();

            if (response.IsSuccessStatusCode || contentTemp != null)
            {
                return JsonConvert.DeserializeObject<RespuestasAPI<bool>>(contentTemp);
            }
            else
            {
                return new RespuestasAPI<bool>
                {
                    IsSuccess = false,
                    ErrorMessages = new List<string>() { $"Error: {response.StatusCode}" }
                };
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