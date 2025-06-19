using DataAccess.Models;

namespace DataAccess.Interfaces
{
  public interface ILogMigracionRepository
  {
        /// <summary>
        /// Actualiza un registro de LogMigraci�n en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracion"/> con los datos actualizados.</param>
        /// <returns>Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.</returns>
        bool Update(LogMigracion data);

        /// <summary>
        /// Actualiza un registro de LogMigraci�n de forma as�ncrona en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracion"/> con los datos actualizados.</param>
        /// <returns>Devuelve un <see cref="Task{bool}"/> con el resultado de la operaci�n.</returns>
        Task<bool> UpdateAsync(LogMigracion data);

        /// <summary>
        /// Crea un nuevo registro de LogMigraci�n en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracion"/> con los datos a insertar.</param>
        /// <returns>Devuelve el objeto <see cref="LogMigracion"/> creado.</returns>
        LogMigracion Create(LogMigracion data);

        /// <summary>
        /// Crea un nuevo registro de LogMigraci�n de forma as�ncrona en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracion"/> con los datos a insertar.</param>
        /// <returns>Devuelve un <see cref="Task{LogMigracion}"/> con el objeto creado.</returns>
        Task<LogMigracion> CreateAsync(LogMigracion data);

        /// <summary>
        /// Busca un registro de LogMigraci�n en la base de datos por su identificador �nico.
        /// </summary>
        /// <param name="Id">Identificador �nico del registro de LogMigraci�n.</param>
        /// <returns>Devuelve un objeto <see cref="LogMigracion"/> si se encuentra el registro; de lo contrario, devuelve null.</returns>
        LogMigracion? FindById(int Id);

        /// <summary>
        /// Obtiene la lista completa de registros de LogMigraci�n almacenados en la base de datos.
        /// </summary>
        /// <returns>Devuelve una lista de objetos <see cref="LogMigracion"/>.</returns>
        (List<LogMigracion>, int) FindAll(int PageNumber, int RowsPerPage);

        /// <summary>
        /// Actualiza un registro de detalle de LogMigraci�n en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracionDetalle"/> con los datos actualizados.</param>
        /// <returns>Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.</returns>
        bool UpdateDetalle(LogMigracionDetalle data);


        /// <summary>
        /// Crea un nuevo registro de detalle de LogMigraci�n en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracionDetalle"/> con los datos a insertar.</param>
        /// <returns>Devuelve el objeto <see cref="LogMigracionDetalle"/> creado.</returns>
        LogMigracionDetalle CreateDetalle(LogMigracionDetalle data);

        /// <summary>
        /// Crea un nuevo registro de detalle de LogMigraci�n de forma as�ncrona en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="LogMigracionDetalle"/> con los datos a insertar.</param>
        /// <returns>Devuelve un <see cref="Task{LogMigracionDetalle}"/> con el objeto creado.</returns>
        Task<LogMigracionDetalle> CreateDetalleAsync(LogMigracionDetalle data);

        /// <summary>
        /// Obtiene la lista completa de registros de detalles de LogMigraci�n almacenados en la base de datos.
        /// </summary>
        /// <returns>Devuelve una lista de objetos <see cref="LogMigracionDetalle"/>.</returns>
        List<LogMigracionDetalle> FindAllDetalle();

        /// <summary>
        /// Busca los detalles de un registro de LogMigraci�n en la base de datos por su identificador.
        /// </summary>
        /// <param name="Id">Identificador �nico del registro de LogMigraci�n.</param>
        /// <returns>Devuelve una lista de objetos <see cref="LogMigracionDetalle"/> correspondientes al registro especificado.</returns>
        List<LogMigracionDetalle> FindDetalleById(int Id);


    }
}
