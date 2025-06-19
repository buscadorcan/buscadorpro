using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces {
    public interface ILogMigracionService
    {
        Task<ResultadoPaginadoDto<List<LogMigracionDto>>> GetLogMigracionesAsync(int PageNumber, int RowsPerPage);
    }
}