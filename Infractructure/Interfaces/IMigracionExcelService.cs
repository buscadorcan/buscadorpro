using Infractructure.Interfaces;
using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces {
    public interface IMigracionExcelService: IExportDocument
    {
        Task<List<MigracionExcelDto>> GetMigracionExcelsAsync(int PageNumber, int RowsPerPage);
        Task<HttpResponseMessage> ImportarExcel(MultipartFormDataContent content, int idOna);
    }
}