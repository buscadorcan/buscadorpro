using Infractructure.Interfaces;
using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces {
    public interface IConexionService : IExportDocument
    {
        Task<List<ONAConexionDto>> GetConexionsAsync();
        Task<ONAConexionDto> GetConexionAsync(int idConexion);
        public Task<RespuestaRegistro> Registrar(ONAConexionDto registro);
        public Task<RespuestaRegistro> Actualizar(ONAConexionDto registro);  
        public Task<RespuestaRegistro> RegistrarCronograma(int? idOna, OnaConexionCronDto registro);
        Task<RespuestaRegistro> EliminarConexion(int idConexion);
        Task<HttpResponseMessage> ImportarExcel(MultipartFormDataContent content);
        Task<ONAConexionDto> GetOnaConexionByOnaAsync(int idOna);
        Task<List<ONAConexionDto>> GetOnaConexionByOnaListAsync(int idOna);
    }
}