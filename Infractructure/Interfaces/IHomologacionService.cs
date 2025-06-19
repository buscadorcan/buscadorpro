using Infractructure.Interfaces;
using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces {
    public interface IHomologacionService: IExportDocument
    {
        Task<List<HomologacionDto>> GetHomologacionsAsync();
        Task<HomologacionDto> GetHomologacionAsync(int idHomologacion);
        Task<RespuestaRegistro> Registrar(HomologacionDto registro);
        Task<RespuestaRegistro> Actualizar(HomologacionDto registro);
        Task<RespuestaRegistro> EliminarHomologacion(int idHomologacion);
        Task<bool> DeleteHomologacionAsync(int idHomologacion);
        Task<ResultadoPaginadoDto<List<HomologacionDto>>> GetHomologacionsSelectAsync(string codigoHomologacion, int PageNumber, int RowsPerPage);
        Task<List<HomologacionDto>> GetFindByAllAsync();

        Task<string> ExportarExcelAsync(string codigoHomologacion);
        Task<string> ExportarPdfAsync(string codigoHomologacion);

    }
}