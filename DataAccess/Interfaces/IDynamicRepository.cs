using SharedApp.Dtos;
using DataAccess.Models;

namespace DataAccess.Interfaces
{
    public interface IDynamicRepository
    {
        /// <summary>
        /// WebApp/GetProperties: Obtiene las propiedades de una tabla dentro de una vista espec�fica.
        /// Este m�todo permite recuperar la configuraci�n y estructura de las columnas de una tabla en una vista dentro de un ONA.
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <param name="viewName">Nombre de la vista en la que se encuentra la tabla.</param>
        /// <returns>
        /// Devuelve una lista de objetos PropiedadesTablaDto con las propiedades de la tabla dentro de la vista.
        /// </returns>
        List<PropiedadesTablaDto> GetProperties(int idONA, string viewName);

        /// <summary>
        /// WebApp/GetValueColumna: Obtiene los valores de una columna espec�fica dentro de una vista.
        /// Este m�todo permite recuperar los valores almacenados en una columna de una vista espec�fica dentro de un ONA.
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <param name="valueColumn">Nombre de la columna cuyos valores se desean obtener.</param>
        /// <param name="viewName">Nombre de la vista en la que se encuentra la columna.</param>
        /// <returns>
        /// Devuelve una lista de objetos PropiedadesTablaDto con los valores de la columna dentro de la vista.
        /// </returns>
        List<PropiedadesTablaDto> GetValueColumna(int idONA, string valueColumn, string viewName);

        /// <summary>
        /// WebApp/GetViewNames: Obtiene la lista de nombres de vistas disponibles en un ONA.
        /// Este m�todo permite recuperar todas las vistas disponibles dentro de la base de datos de un ONA.
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve una lista de nombres de vistas disponibles en el ONA.
        /// </returns>
        List<string> GetViewNames(int idONA);

        /// <summary>
        /// WebApp/GetListaValidacionEsquema: Obtiene la lista de validaciones de un esquema en un ONA.
        /// Este m�todo permite recuperar las validaciones configuradas dentro de un esquema espec�fico en un ONA.
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <param name="idEsquemaVista">Identificador del esquema de validaci�n dentro del ONA.</param>
        /// <returns>
        /// Devuelve una lista de objetos EsquemaVistaDto con la informaci�n de las validaciones del esquema.
        /// </returns>
        List<EsquemaVistaDto> GetListaValidacionEsquema(int idONA, int idEsquemaVista);

        /// <summary>
        /// WebApp/GetConexion: Obtiene los datos de conexi�n de un ONA espec�fico.
        /// Este m�todo permite recuperar la configuraci�n de conexi�n a la base de datos de un Organismo Nacional de Acreditaci�n.
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve un objeto ONAConexion con los datos de conexi�n del ONA especificado.
        /// </returns>
        ONAConexion GetConexion(int idONA);

        /// <summary>
        /// WebApp/TestDatabaseConnection: Prueba la conexi�n a la base de datos de un ONA.
        /// Este m�todo permite validar si una conexi�n a la base de datos de un Organismo Nacional de Acreditaci�n es funcional.
        /// </summary>
        /// <param name="conexion">Objeto ONAConexion que contiene la configuraci�n de la conexi�n.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la conexi�n es exitosa o no.
        /// </returns>
        bool TestDatabaseConnection(ONAConexion conexion);

        /// <summary>
        /// WebApp/MigrarConexionAsync: Realiza la migraci�n de la conexi�n de un ONA de forma as�ncrona.
        /// Este m�todo permite realizar el proceso de migraci�n de conexi�n para un Organismo Nacional de Acreditaci�n de manera as�ncrona.
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve una tarea (`Task<bool>`) indicando si la migraci�n se complet� exitosamente.
        /// </returns>
        Task<bool> MigrarConexionAsync(int idONA);


    }
}
