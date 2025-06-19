using Infractructure.Interfaces;
using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces
{
    public interface IONAService: IExportDocument
    {
        Task<List<OnaDto>> GetONAsAsync();

        Task<List<VwPaisDto>> GetPaisesAsync();

        Task<OnaDto> GetONAsAsync(int IdONA);

        Task<RespuestaRegistro> Registrar(OnaDto ONAParaRegistro);

        Task<RespuestaRegistro> Actualizar(OnaDto ONAParaRegistro);

        Task<bool> DeleteONAAsync(int IdONA);

        Task<List<OnaDto>> GetListByONAsAsync(int idOna);
    }
}