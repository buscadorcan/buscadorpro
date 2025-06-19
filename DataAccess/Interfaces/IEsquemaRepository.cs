using DataAccess.Models;

namespace DataAccess.Interfaces
{
  public interface IEsquemaRepository
  {
        /// <summary>
        /// WebApp/Update: Actualiza un registro de Esquema en la base de datos.
        /// Este m�todo permite modificar un registro existente de Esquema con la informaci�n proporcionada.
        /// </summary>
        /// <param name="data">Objeto Esquema con los datos actualizados.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.
        /// </returns>
        bool Update(Esquema data);

        /// <summary>
        /// WebApp/Create: Crea un nuevo registro de Esquema en la base de datos.
        /// Este m�todo permite insertar un nuevo registro de Esquema en la base de datos.
        /// </summary>
        /// <param name="data">Objeto Esquema con los datos a registrar.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la creaci�n fue exitosa.
        /// </returns>
        bool Create(Esquema data);

        /// <summary>
        /// WebApp/FindById: Busca un registro de Esquema en la base de datos por su identificador �nico.
        /// Este m�todo permite recuperar un registro de Esquema en funci�n de su ID.
        /// </summary>
        /// <param name="Id">Identificador �nico del registro a buscar.</param>
        /// <returns>
        /// Devuelve un objeto Esquema con la informaci�n del registro encontrado.
        /// Si no se encuentra el registro, devuelve un valor nulo.
        /// </returns>
        Esquema? FindById(int Id);

        /// <summary>
        /// WebApp/FindByViewName: Busca un esquema en la base de datos utilizando el nombre de la vista.
        /// Este m�todo permite obtener informaci�n de un esquema en funci�n del nombre de la vista asociada.
        /// </summary>
        /// <param name="esquemaVista">Nombre de la vista asociada al esquema.</param>
        /// <returns>
        /// Devuelve un objeto Esquema con la informaci�n del esquema encontrado.
        /// Si no se encuentra el esquema, devuelve un valor nulo.
        /// </returns>
        Esquema? FindByViewName(string esquemaVista);

        /// <summary>
        /// WebApp/FindByViewNameAsync: Busca un esquema en la base de datos de forma as�ncrona utilizando el nombre de la vista.
        /// Este m�todo permite obtener de manera as�ncrona informaci�n de un esquema en funci�n del nombre de la vista asociada.
        /// </summary>
        /// <param name="esquemaVista">Nombre de la vista asociada al esquema.</param>
        /// <returns>
        /// Devuelve una tarea (`Task<Esquema?>`) con el objeto Esquema del esquema encontrado.
        /// Si no se encuentra el esquema, devuelve un valor nulo.
        /// </returns>
        Task<Esquema?> FindByViewNameAsync(string esquemaVista);

        /// <summary>
        /// WebApp/FindAll: Obtiene la lista completa de esquemas almacenados en la base de datos.
        /// Este m�todo permite recuperar todos los registros de Esquema almacenados en la base de datos.
        /// </summary>
        /// <returns>
        /// Devuelve una lista de objetos Esquema con todos los esquemas registrados.
        /// </returns>
        List<Esquema> FindAll();

        /// <summary>
        /// WebApp/FindAllWithViews: Obtiene la lista completa de esquemas junto con sus vistas asociadas.
        /// Este m�todo permite recuperar todos los registros de Esquema junto con la informaci�n de las vistas relacionadas.
        /// </summary>
        /// <returns>
        /// Devuelve una lista de objetos Esquema con sus vistas asociadas.
        /// </returns>
        List<Esquema> FindAllWithViews();

        /// <summary>
        /// WebApp/GetListaEsquemaByOna: Obtiene la lista de esquemas asociados a un ONA espec�fico.
        /// Este m�todo permite recuperar todos los esquemas relacionados con un Organismo Nacional de Acreditaci�n (ONA).
        /// </summary>
        /// <param name="idONA">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve una lista de objetos Esquema con los esquemas asociados al ONA.
        /// </returns>
        List<Esquema> GetListaEsquemaByOna(int idONA);

        /// <summary>
        /// WebApp/UpdateEsquemaValidacion: Actualiza la validaci�n de un esquema en la base de datos.
        /// Este m�todo permite modificar la informaci�n de validaci�n de un esquema existente.
        /// </summary>
        /// <param name="data">Objeto EsquemaVista con la informaci�n actualizada de la validaci�n.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.
        /// </returns>
        bool UpdateEsquemaValidacion(EsquemaVista data);

        /// <summary>
        /// WebApp/CreateEsquemaValidacion: Crea una nueva validaci�n de esquema en la base de datos.
        /// Este m�todo permite registrar una validaci�n de esquema en la base de datos.
        /// </summary>
        /// <param name="data">Objeto EsquemaVista con la informaci�n de la validaci�n a registrar.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la creaci�n fue exitosa.
        /// </returns>
        bool CreateEsquemaValidacion(EsquemaVista data);

        /// <summary>
        /// WebApp/EliminarEsquemaVistaColumnaByIdEquemaVistaAsync: Elimina de manera as�ncrona una columna de un esquema vista por su identificador.
        /// Este m�todo permite eliminar una columna de un esquema vista de forma as�ncrona en la base de datos.
        /// </summary>
        /// <param name="id">Identificador �nico de la columna dentro del esquema vista.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la eliminaci�n fue exitosa.
        /// </returns>
        bool EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(int id);

        /// <summary>
        /// WebApp/GetEsquemaVistaColumnaByIdEquemaVistaAsync: Obtiene una columna de un esquema vista de manera as�ncrona en base al ONA y esquema.
        /// Este m�todo permite recuperar informaci�n de una columna espec�fica dentro de un esquema vista para un ONA determinado.
        /// </summary>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <param name="idEsquema">Identificador del esquema vista.</param>
        /// <returns>
        /// Devuelve un objeto EsquemaVistaColumna con la informaci�n de la columna encontrada.
        /// Si no se encuentra la columna, devuelve un valor nulo.
        /// </returns>
        EsquemaVistaColumna? GetEsquemaVistaColumnaByIdEquemaVistaAsync(int idOna, int idEsquema);

        /// <summary>
        /// WebApp/GuardarListaEsquemaVistaColumna: Guarda una lista de columnas para un esquema vista espec�fico.
        /// Este m�todo permite registrar m�ltiples columnas dentro de un esquema vista para un ONA determinado.
        /// </summary>
        /// <param name="listaEsquemaVistaColumna">Lista de objetos EsquemaVistaColumna con los datos a registrar.</param>
        /// <param name="idOna">Identificador opcional del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <param name="intidEsquema">Identificador opcional del esquema al que pertenecen las columnas.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si la operaci�n de guardado fue exitosa.
        /// </returns>
        bool GuardarListaEsquemaVistaColumna(List<EsquemaVistaColumna> listaEsquemaVistaColumna, int? idOna, int? intidEsquema);



    }
}