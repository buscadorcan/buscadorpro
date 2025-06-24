

using Core.Interfaces;
using DataAccess.Interfaces;
using Microsoft.Extensions.Configuration;
using SharedApp.Dtos;
using System.Text.Json;

namespace Core.Service
{
    public class BuscadorService : IBuscadorService
    {
        private readonly IBuscadorRepository _buscadorRepository;
        private readonly IConfiguration configuration;
        private readonly HttpClient httpClient;
        private readonly IUtilitiesService _utilitiesService;
        public BuscadorService(IBuscadorRepository buscadorRepository, IConfiguration configuration, IHttpClientFactory httpClient, IUtilitiesService utilitiesService)
        {
            this._buscadorRepository = buscadorRepository;
            this.configuration = configuration;
            this.httpClient = httpClient.CreateClient();
            _utilitiesService = utilitiesService;
        }

        private async Task<IpLocationDto> GetIpLocationInfo(string ipAddress)
        {
            try
            {
                if (string.IsNullOrEmpty(ipAddress) || ipAddress == "::1")
                    return new IpLocationDto { Country = "Local", City = "Local", Isp = "Local" };

                using var httpClient = new HttpClient();
                var response = await httpClient.GetStringAsync($"http://ip-api.com/json/{ipAddress}");
                return JsonSerializer.Deserialize<IpLocationDto>(response) ?? new();
            }
            catch
            {
                return new IpLocationDto { Country = "Desconocido", City = "Desconocido", Isp = "Desconocido" };
            }
        }
        public int AddEventTracking(EventTrackingDto eventTracking, string ipAddress)
        {
            // IP & ubicación
            var ipInfo = GetIpLocationInfo(ipAddress).Result;

            eventTracking.UbicacionJson = JsonSerializer.Serialize(new
            {
                IpAddress = ipAddress,
                ipInfo.Country,
                ipInfo.City,
                ipInfo.Isp
            });

            return _buscadorRepository.AddEventTracking(eventTracking);
        }

        public fnEsquemaCabeceraDto? FnEsquemaCabecera(int IdEsquemadata)
        {
            return _buscadorRepository.FnEsquemaCabecera(IdEsquemadata);
        }

        public List<FnEsquemaDataBuscadoDto> FnEsquemaDatoBuscar(int IdEsquemaData, string TextoBuscar)
        {
            return _buscadorRepository.FnEsquemaDatoBuscar(IdEsquemaData, TextoBuscar);
        }

        public FnEsquemaDto? FnHomologacionEsquema(int idHomologacionEsquema)
        {
            return _buscadorRepository.FnHomologacionEsquema(idHomologacionEsquema);
        }

        public List<FnHomologacionEsquemaDataDto> FnHomologacionEsquemaDato(int idEsquema, string VistaFK, int idOna)
        {
            return _buscadorRepository.FnHomologacionEsquemaDato(idEsquema, VistaFK, idOna);
        }

        public List<EsquemaDto> FnHomologacionEsquemaTodo(string VistaFK, int idOna)
        {
            return _buscadorRepository.FnHomologacionEsquemaTodo(VistaFK, idOna);
        }

        public List<FnPredictWordsDto> FnPredictWords(string word)
        {
            return _buscadorRepository.FnPredictWords(word);
        }

        public BuscadorDto PsBuscarPalabra(string paramJSON, int PageNumber, int RowsPerPage)
        {
            return _buscadorRepository.PsBuscarPalabra(paramJSON, PageNumber, RowsPerPage);
        }

        public BuscadorDtoExpo PsBuscarPalabraExpor(string paramJSON)
        {
            return _buscadorRepository.PsBuscarPalabraExpor(paramJSON);
        }
        public bool ValidateWords(List<string> words)
        {
            return _buscadorRepository.ValidateWords(words);
        }

        public async Task<string> GetCoordinates(string address)
        {
            //Mover a appsetting.json
            var apiKey = "AIzaSyC7NUCEvrqrrQDDDRLK2q0HSqswPxtBVAk";
            var url = $"{configuration["GoogleOAuth:getcode"]}{Uri.EscapeDataString(address)}&key={apiKey}";
            return await httpClient.GetStringAsync(url);
        }

        public async Task<string> ExportExcel(string paramJSON)
        {
            var data = _buscadorRepository.PsBuscarPalabraExpor(paramJSON);
            var dictData = await _utilitiesService.ExportDocumentAsync(data.Data);
            return await _utilitiesService.ExportExcel(dictData);
        }

        public async Task<string> ExportPdf(string paramJSON)
        {
            var data = PsBuscarPalabraExpor(paramJSON).Data;

            if (data == null || !data.Any())
                return null;

            var dictData = await _utilitiesService.ExportDocumentAsync(data);

            return await _utilitiesService.ExportPdf(dictData);
            //using var stream = new MemoryStream();
            //var doc = new Document();
            //PdfWriter.GetInstance(doc, stream);
            //doc.Open();

            //if (data.Count == 0)
            //{
            //    doc.Add(new Paragraph("No hay datos para exportar"));
            //}
            //else
            //{
            //    var headers = data[0].Keys.ToList();
            //    var table = new PdfPTable(headers.Count);

            //    foreach (var header in headers)
            //        table.AddCell(new PdfPCell(new Phrase(header)) { BackgroundColor = BaseColor.LIGHT_GRAY });

            //    foreach (var row in data)
            //        foreach (var header in headers)
            //            table.AddCell(row.TryGetValue(header, out var v) ? v : string.Empty);

            //    doc.Add(table);
            //}

            //doc.Close();

            //return stream.ToArray();
        }

        public async Task<byte[]> DescargarPDF(string url)
        {

            using var httpClient = new HttpClient();
            var response = await httpClient.GetAsync(url);

            if (!response.Content.Headers.ContentType?.MediaType?.Equals("application/pdf", StringComparison.OrdinalIgnoreCase) ?? true)
            {
                return null;
            }

            if (!response.IsSuccessStatusCode)
            {
                return null;
            }


            return await response.Content.ReadAsByteArrayAsync();
        }
    }
}
