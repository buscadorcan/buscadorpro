using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces {
    public interface IBusquedaService
    {
        Task<BuscadorDto> PsBuscarPalabraAsync(string paramJSON, int PageNumber, int RowsPerPage);
        Task<List<HomologacionEsquemaDto>> FnHomologacionEsquemaTodoAsync(string vistaFK, int idOna);
        Task<HomologacionEsquemaDto?> FnHomologacionEsquemaAsync(int idHomologacionEsquema);
        Task<List<DataHomologacionEsquema>> FnHomologacionEsquemaDatoAsync(int idHomologacionEsquema, string VistaFK, int idOna);
        Task<List<DataEsquemaDatoBuscar>> FnEsquemaDatoBuscarAsync(int idEsquemaData, string TextoBuscar);
        Task<List<FnPredictWordsDto>> FnPredictWords(string word);
        Task<bool> ValidateWords(List<string> words);
        Task<fnEsquemaCabeceraDto?> FnEsquemaCabeceraAsync(int IdEsquemadata);
        Task<bool> AddEventTrackingAsync(EventTrackingDto eventTracking);
        Task<GeocodeResponseDto?> ObtenerCoordenadasAsync(string pais, string ciudad);
        Task<byte[]> ExportarExcelAsync(List<BuscadorResultadoDataDto> data);
        Task<byte[]> ExportarPdfAsync(List<BuscadorResultadoDataDto> data);
        Task<string> ExportarExcelBuscAsync(string paramJson);
        Task<string> ExportarPdfBuscAsync(string paramJson);
        Task<string> DescargarPDF(string url);

    }
}