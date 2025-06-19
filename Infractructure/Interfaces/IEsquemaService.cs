﻿using Infractructure.Interfaces;
using Infractruture.Models;
using SharedApp.Dtos;

namespace Infractruture.Interfaces
{
    public interface IEsquemaService : IExportDocument
    {
        Task<List<EsquemaDto>> GetListEsquemasAsync();
        Task<EsquemaDto> GetEsquemaAsync(int idEsquema);
        Task<RespuestaRegistro> RegistrarEsquemaActualizar(EsquemaDto esquemaRegistro);
        Task<bool> DeleteEsquemaAsync(int IdEsquema);
        Task<List<EsquemaDto>> GetEsquemaByOnaAsync(int idOna);
        Task<RespuestaRegistro> GuardarEsquemaVistaValidacionAsync(EsquemaVistaValidacionDto esquemaRegistro);
        Task<bool> EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(EsquemaVistaValidacionDto esquemaRegistro);
        //Task<RespuestaRegistro> GuardarListaEsquemaVistaColumna(List<EsquemaVistaColumnaDto> listaEsquemaVistaColumna);
        Task<RespuestaRegistro> GuardarListaEsquemaVistaColumna(List<EsquemaVistaColumnaDto> listaEsquemaVistaColumna, int idOna, int idEsquema);


    }
}
