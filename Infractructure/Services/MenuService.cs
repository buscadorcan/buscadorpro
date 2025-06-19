﻿using Infractruture.Interfaces;
using Infractruture.Models;
using Newtonsoft.Json;
using SharedApp.Dtos;
using SharedApp.Response;
using System.Net.Http.Json;
using System.Text;

namespace Infractruture.Services
{
    public class MenuService : IMenuService
    {
        private readonly HttpClient _httpClient;
        private string url = "api/menu";

        public MenuService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<MenuRolDto>> GetMenusAsync()
        {
            var response = await _httpClient.GetAsync($"{url}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<MenuRolDto>>>()).Result;
        }

        public async Task<MenuRolDto> GetMenuAsync(int idHRol, int idHMenu)
        {
            var response = await _httpClient.GetAsync($"{url}/{idHRol}/{idHMenu}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<MenuRolDto>>()).Result;
        }

        public async Task<RespuestaRegistro> RegistrarMenuActualizar(MenuRolDto menuParaRegistro)
        {
            var content = JsonConvert.SerializeObject(menuParaRegistro);
            var bodyContent = new StringContent(content, Encoding.UTF8, "application/json");
            HttpResponseMessage response;

            response = await _httpClient.PostAsync($"{url}", bodyContent);

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

        public async Task<bool> DeleteMenuAsync(int? idHRol, int? idHMenu)
        {
            var response = await _httpClient.DeleteAsync($"{url}/{idHRol}/{idHMenu}");
            if (!response.IsSuccessStatusCode)
            {
                return false;
            }
            var apiResponse = await response.Content.ReadFromJsonAsync<RespuestasAPI<bool>>();
            return apiResponse?.IsSuccess ?? false;
        }
        public async Task<List<MenuPaginaDto>> GetMenusPendingConfigAsync(int? idHomologacionRol)
        {
            var response = await _httpClient.GetAsync($"{url}/{idHomologacionRol}");
            response.EnsureSuccessStatusCode();
            return (await response.Content.ReadFromJsonAsync<RespuestasAPI<List<MenuPaginaDto>>>()).Result;
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
