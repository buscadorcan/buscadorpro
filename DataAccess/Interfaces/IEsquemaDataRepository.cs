using DataAccess.Models;

namespace DataAccess.Interfaces
{
  public interface IEsquemaDataRepository
  {
        /// <summary>
        /// WebApp/Update: Actualiza un registro en la base de datos con los datos proporcionados.
        /// Este m�todo permite modificar un registro existente en la base de datos con la informaci�n nueva ingresada.
        /// </summary>
        /// <param name="data">Objeto EsquemaData con los datos actualizados.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la actualizaci�n fue exitosa o no.
        /// </returns>
        bool Update(EsquemaData data);

        /// <summary>
        /// WebApp/Create: Crea un nuevo registro en la base de datos.
        /// Este m�todo permite insertar un nuevo registro en la base de datos con la informaci�n proporcionada.
        /// </summary>
        /// <param name="data">Objeto EsquemaData con los datos a registrar.</param>
        /// <returns>
        /// Devuelve un objeto EsquemaData con la informaci�n del registro creado.
        /// Si la creaci�n falla, devuelve un valor nulo.
        /// </returns>
        EsquemaData? Create(EsquemaData data);

        /// <summary>
        /// WebApp/CreateAsync: Crea un nuevo registro en la base de datos de forma as�ncrona.
        /// Este m�todo permite insertar un nuevo registro en la base de datos de manera as�ncrona.
        /// </summary>
        /// <param name="data">Objeto EsquemaData con los datos a registrar.</param>
        /// <returns>
        /// Devuelve una tarea (`Task<EsquemaData?>`) con el objeto EsquemaData del registro creado.
        /// Si la creaci�n falla, devuelve un valor nulo.
        /// </returns>
        Task<EsquemaData?> CreateAsync(EsquemaData data);

        /// <summary>
        /// WebApp/FindById: Busca un registro en la base de datos por su identificador �nico.
        /// Este m�todo permite recuperar un registro espec�fico en funci�n de su ID.
        /// </summary>
        /// <param name="Id">Identificador �nico del registro a buscar.</param>
        /// <returns>
        /// Devuelve un objeto EsquemaData con la informaci�n del registro encontrado.
        /// Si no se encuentra el registro, devuelve un valor nulo.
        /// </returns>
        EsquemaData? FindById(int Id);

        /// <summary>
        /// WebApp/FindAll: Obtiene la colecci�n completa de registros almacenados en la base de datos.
        /// Este m�todo permite recuperar todos los registros almacenados en la base de datos.
        /// </summary>
        /// <returns>
        /// Devuelve una colecci�n de objetos EsquemaData con todos los registros existentes en la base de datos.
        /// </returns>
        ICollection<EsquemaData> FindAll();

        /// <summary>
        /// WebApp/GetLastId: Obtiene el �ltimo identificador registrado en la base de datos.
        /// Este m�todo permite recuperar el ID m�s reciente de los registros almacenados en la base de datos.
        /// </summary>
        /// <returns>
        /// Devuelve un entero con el �ltimo identificador registrado.
        /// </returns>
        int GetLastId();


        /// <summary>
        /// WebApp/DeleteOldRecords: Elimina registros antiguos asociados a un ONA espec�fico.
        /// Este m�todo permite eliminar registros obsoletos de la base de datos que pertenecen a un Organismo Nacional de Acreditaci�n (ONA).
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la eliminaci�n fue exitosa.
        /// </returns>
        bool DeleteOldRecords(int idONA);

        /// <summary>
        /// WebApp/DeleteOldRecordsAsync: Elimina registros antiguos de un esquema de vista de manera as�ncrona.
        /// Este m�todo permite eliminar de forma as�ncrona los registros obsoletos asociados a un esquema de vista.
        /// </summary>
        /// <param name="IdEsquemaVista">Identificador del esquema de vista cuyos registros antiguos deben eliminarse.</param>
        /// <returns>
        /// Devuelve una tarea (`Task<bool>`) indicando si la eliminaci�n fue exitosa.
        /// </returns>
        Task<bool> DeleteOldRecordsAsync(int IdEsquemaVista);

        /// <summary>
        /// WebApp/DeleteOldRecord: Elimina un registro antiguo espec�fico utilizando identificadores de vista, ente, conexi�n y esquema de homologaci�n.
        /// Este m�todo permite borrar un registro obsoleto espec�fico en funci�n de m�ltiples identificadores clave.
        /// </summary>
        /// <param name="idVista">Identificador de la vista a la que pertenece el registro.</param>
        /// <param name="idEnte">Identificador del ente asociado al registro.</param>
        /// <param name="idConexion">Identificador de la conexi�n utilizada para el registro.</param>
        /// <param name="idHomologacionEsquema">Identificador del esquema de homologaci�n del registro.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la eliminaci�n del registro fue exitosa.
        /// </returns>
        bool DeleteOldRecord(string idVista, string idEnte, int idConexion, int idHomologacionEsquema);

        /// <summary>
        /// WebApp/DeleteByExcludingVistaIds: Elimina registros excluyendo aquellos con los identificadores de vista proporcionados.
        /// Este m�todo permite eliminar registros antiguos pero preservando aquellos cuyos identificadores de vista se encuentran en la lista dada.
        /// </summary>
        /// <param name="idsVista">Lista de identificadores de vista que no deben eliminarse.</param>
        /// <param name="idEnte">Identificador del ente asociado a los registros.</param>
        /// <param name="idConexion">Identificador de la conexi�n utilizada.</param>
        /// <param name="idEsquemaData">Identificador del esquema de datos.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la operaci�n de eliminaci�n fue exitosa.
        /// </returns>
        bool DeleteByExcludingVistaIds(List<string> idsVista, string idEnte, int idConexion, int idEsquemaData);

        /// <summary>
        /// WebApp/DeleteDataAntigua: Elimina datos antiguos de un ONA espec�fico.
        /// Este m�todo permite borrar datos obsoletos almacenados en la base de datos para un Organismo Nacional de Acreditaci�n (ONA).
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la eliminaci�n de los datos antiguos fue exitosa.
        /// </returns>
        bool DeleteDataAntigua(int idONA);


    }
}
