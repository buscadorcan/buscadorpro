namespace Infractructure.Interfaces
{
    public interface IExportDocument
    {
        Task<string> ExportarExcelAsync();
        Task<string> ExportarPdfAsync();
    }
}
