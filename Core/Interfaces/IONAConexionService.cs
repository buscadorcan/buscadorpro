using SharedApp.Dtos;

namespace Core.Interfaces
{
    public interface IONAConexionService
    {
        /// <summary>
        /// Actualiza un registro de <see cref="ONAConexionDto"/> en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="ONAConexionDto"/> con los datos actualizados.</param>
        /// <returns>Devuelve <c>true</c> si la actualización fue exitosa, de lo contrario <c>false</c>.</returns>
        bool Update(ONAConexionDto data);

        bool updateCrono(int IdOna, OnaConexionCronDto data);

        /// <summary>
        /// Crea un nuevo registro de <see cref="ONAConexionDto"/> en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="ONAConexionDto"/> con los datos a insertar.</param>
        /// <returns>Devuelve <c>true</c> si la operación fue exitosa, de lo contrario <c>false</c>.</returns>
        bool Create(ONAConexionDto data);

        /// <summary>
        /// Busca un registro de <see cref="ONAConexionDto"/> en la base de datos por su identificador único.
        /// </summary>
        /// <param name="Id">Identificador único del registro.</param>
        /// <returns>Devuelve un objeto <see cref="ONAConexionDto"/> si se encuentra, de lo contrario <c>null</c>.</returns>
        ONAConexionDto? FindById(int Id);

        /// <summary>
        /// Busca un registro de <see cref="ONAConexionDto"/> en la base de datos por el identificador de ONA.
        /// </summary>
        /// <param name="IdONA">Identificador del ONA asociado.</param>
        /// <returns>Devuelve un objeto <see cref="ONAConexionDto"/> si se encuentra, de lo contrario <c>null</c>.</returns>
        ONAConexionDto? FindByIdONA(int IdONA);

        /// <summary>
        /// Busca de forma asíncrona un registro de <see cref="ONAConexionDto"/> en la base de datos por el identificador de ONA.
        /// </summary>
        /// <param name="IdONA">Identificador del ONA asociado.</param>
        /// <returns>Devuelve un <see cref="Task{ONAConexionDto}"/> con el objeto encontrado o <c>null</c> si no existe.</returns>
        Task<ONAConexionDto?> FindByIdONAAsync(int IdONA);

        /// <summary>
        /// Obtiene la lista completa de registros de <see cref="ONAConexionDto"/> almacenados en la base de datos.
        /// </summary>
        /// <returns>Devuelve una lista de objetos <see cref="ONAConexionDto"/>.</returns>
        List<ONAConexionDto> FindAll();

        /// <summary>
        /// Obtiene de forma asíncrona una lista de conexiones de <see cref="ONAConexionDto"/> por su identificador de ONA.
        /// </summary>
        /// <param name="IdONA">Identificador del ONA.</param>
        /// <returns>Devuelve una lista de objetos <see cref="ONAConexionDto"/> relacionados con el ONA especificado.</returns>
        List<ONAConexionDto> GetONAConexionByOnaListAsync(int IdONA);
    }
}
