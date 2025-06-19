using DataAccess.Models;

namespace DataAccess.Interfaces
{
    public interface IEsquemaVistaColumnaRepository
    {
        /// <summary>
        /// WebApp/Update: Actualiza un registro de EsquemaVistaColumna en la base de datos.
        /// Este m�todo permite modificar la informaci�n de una columna de un esquema vista existente.
        /// </summary>
        /// <param name="data">Objeto EsquemaVistaColumna con la informaci�n actualizada.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.
        /// </returns>
        bool Update(EsquemaVistaColumna data);

        /// <summary>
        /// WebApp/Create: Crea un nuevo registro de EsquemaVistaColumna en la base de datos.
        /// Este m�todo permite registrar una nueva columna dentro de un esquema vista.
        /// </summary>
        /// <param name="data">Objeto EsquemaVistaColumna con la informaci�n a registrar.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la creaci�n fue exitosa.
        /// </returns>
        bool Create(EsquemaVistaColumna data);

        /// <summary>
        /// WebApp/FindById: Busca un registro de EsquemaVistaColumna en la base de datos por su identificador �nico.
        /// Este m�todo permite recuperar informaci�n de una columna espec�fica dentro de un esquema vista en funci�n de su ID.
        /// </summary>
        /// <param name="Id">Identificador �nico de la columna dentro del esquema vista.</param>
        /// <returns>
        /// Devuelve un objeto EsquemaVistaColumna con la informaci�n de la columna encontrada.
        /// Si no se encuentra el registro, devuelve un valor nulo.
        /// </returns>
        EsquemaVistaColumna? FindById(int Id);

        /// <summary>
        /// WebApp/FindByIdEsquemaVista: Obtiene una lista de columnas de un esquema vista espec�fico.
        /// Este m�todo permite recuperar todas las columnas pertenecientes a un esquema vista.
        /// </summary>
        /// <param name="IdEsquemaVista">Identificador del esquema vista.</param>
        /// <returns>
        /// Devuelve una lista de objetos EsquemaVistaColumna con la informaci�n de las columnas encontradas.
        /// </returns>
        List<EsquemaVistaColumna> FindByIdEsquemaVista(int IdEsquemaVista);

        /// <summary>
        /// WebApp/FindByIdEsquemaVistaOna: Obtiene una lista de columnas de un esquema vista espec�fico dentro de un ONA.
        /// Este m�todo permite recuperar todas las columnas de un esquema vista en un Organismo Nacional de Acreditaci�n (ONA) espec�fico.
        /// </summary>
        /// <param name="IdEsquemaVista">Identificador del esquema vista.</param>
        /// <param name="IdOna">Identificador del ONA.</param>
        /// <returns>
        /// Devuelve una lista de objetos EsquemaVistaColumna con la informaci�n de las columnas encontradas.
        /// </returns>
        List<EsquemaVistaColumna> FindByIdEsquemaVistaOna(int IdEsquemaVista, int IdOna);

        /// <summary>
        /// WebApp/FindByIdEsquemaVistaOnaAsync: Obtiene de forma as�ncrona una lista de columnas de un esquema vista espec�fico dentro de un ONA.
        /// Este m�todo permite recuperar de manera as�ncrona todas las columnas de un esquema vista en un Organismo Nacional de Acreditaci�n (ONA) espec�fico.
        /// </summary>
        /// <param name="IdEsquemaVista">Identificador del esquema vista.</param>
        /// <param name="IdOna">Identificador del ONA.</param>
        /// <returns>
        /// Devuelve una tarea (`Task<List<EsquemaVistaColumna>>`) con la lista de objetos EsquemaVistaColumna de las columnas encontradas.
        /// </returns>
        Task<List<EsquemaVistaColumna>> FindByIdEsquemaVistaOnaAsync(int IdEsquemaVista, int IdOna);

        /// <summary>
        /// WebApp/FindAll: Obtiene la lista completa de registros de EsquemaVistaColumna almacenados en la base de datos.
        /// Este m�todo permite recuperar todos los registros de columnas en esquemas vista almacenados en la base de datos.
        /// </summary>
        /// <returns>
        /// Devuelve una lista de objetos EsquemaVistaColumna con la informaci�n de todas las columnas registradas.
        /// </returns>
        List<EsquemaVistaColumna> FindAll();


    }
}