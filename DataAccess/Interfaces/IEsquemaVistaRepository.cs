using DataAccess.Models;

namespace DataAccess.Interfaces
{
  public interface IEsquemaVistaRepository
  {
        /// <summary>
        /// Actualiza un registro de EsquemaVista en la base de datos.
        /// </summary>
        /// <param name="data">Objeto EsquemaVista con los datos actualizados.</param>
        /// <returns>Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.</returns>
        bool Update(EsquemaVista data);

        /// <summary>
        /// Crea un nuevo registro de EsquemaVista en la base de datos.
        /// </summary>
        /// <param name="data">Objeto EsquemaVista con los datos a insertar.</param>
        /// <returns>Devuelve un valor booleano indicando si la creaci�n fue exitosa.</returns>
        bool Create(EsquemaVista data);

        /// <summary>
        /// Busca un registro de EsquemaVista en la base de datos por su identificador �nico.
        /// </summary>
        /// <param name="Id">Identificador �nico del EsquemaVista.</param>
        /// <returns>Devuelve un objeto EsquemaVista si se encuentra el registro; de lo contrario, devuelve null.</returns>
        EsquemaVista? FindById(int Id);

        /// <summary>
        /// Busca un esquema vista en la base de datos utilizando el identificador de esquema.
        /// </summary>
        /// <param name="IdEsquema">Identificador �nico del esquema.</param>
        /// <returns>Devuelve un objeto EsquemaVista si se encuentra el registro; de lo contrario, devuelve null.</returns>
        EsquemaVista? FindByIdEsquema(int IdEsquema);

        /// <summary>
        /// Busca un esquema vista en la base de datos utilizando el identificador de esquema y el ONA.
        /// </summary>
        /// <param name="IdEsquema">Identificador �nico del esquema.</param>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>Devuelve un objeto EsquemaVista si se encuentra el registro; de lo contrario, devuelve null.</returns>
        EsquemaVista? _FindByIdEsquema(int IdEsquema, int idOna);

        /// <summary>
        /// Busca de forma as�ncrona un esquema vista en la base de datos utilizando el identificador de esquema y el ONA.
        /// </summary>
        /// <param name="IdEsquema">Identificador �nico del esquema.</param>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>Devuelve una tarea que representa la operaci�n as�ncrona. El resultado es un objeto EsquemaVista si se encuentra el registro; de lo contrario, devuelve null.</returns>
        Task<EsquemaVista?> _FindByIdEsquemaAsync(int IdEsquema, int idOna);

        /// <summary>
        /// Obtiene la lista completa de registros de EsquemaVista almacenados en la base de datos.
        /// </summary>
        /// <returns>Devuelve una lista de objetos EsquemaVista con todos los registros almacenados.</returns>
        List<EsquemaVista> FindAll();


    }
}