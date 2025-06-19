
namespace Core.Interfaces
{
    public interface IUtilitiesService
    {
        Task<string> ExportExcel(List<Dictionary<string, string>> data);
        Task<string> ExportPdf(List<Dictionary<string, string>> data);
        Task<List<Dictionary<string, string>>> ExportDocumentAsync<T>(List<T> data);
    }
}
