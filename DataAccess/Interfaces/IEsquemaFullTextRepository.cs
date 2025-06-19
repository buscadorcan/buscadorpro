using DataAccess.Models;

namespace DataAccess.Interfaces
{
  public interface IEsquemaFullTextRepository
  {
        /// <summary>
        /// WebApp/Create: Crea un nuevo registro de EsquemaFullText en la base de datos.
        /// Este m�todo permite insertar un nuevo registro de EsquemaFullText con la informaci�n proporcionada.
        /// </summary>
        /// <param name="data">Objeto EsquemaFullText con los datos a registrar.</param>
        /// <returns>
        /// Devuelve un objeto EsquemaFullText con la informaci�n del registro creado.
        /// </returns>
        EsquemaFullText Create(EsquemaFullText data);

        /// <summary>
        /// WebApp/CreateAsync: Crea un nuevo registro de EsquemaFullText en la base de datos de forma as�ncrona.
        /// Este m�todo permite insertar un nuevo registro de EsquemaFullText de manera as�ncrona.
        /// </summary>
        /// <param name="data">Objeto EsquemaFullText con los datos a registrar.</param>
        /// <returns>
        /// Devuelve una tarea (`Task<EsquemaFullText>`) con el objeto EsquemaFullText del registro creado.
        /// </returns>
        Task<EsquemaFullText> CreateAsync(EsquemaFullText data);

        /// <summary>
        /// WebApp/FindById: Busca un registro de EsquemaFullText en la base de datos por su identificador �nico.
        /// Este m�todo permite recuperar un registro espec�fico de EsquemaFullText en funci�n de su ID.
        /// </summary>
        /// <param name="Id">Identificador �nico del registro a buscar.</param>
        /// <returns>
        /// Devuelve un objeto EsquemaFullText con la informaci�n del registro encontrado.
        /// Si no se encuentra el registro, devuelve un valor nulo.
        /// </returns>
        EsquemaFullText? FindById(int Id);


    }
}
