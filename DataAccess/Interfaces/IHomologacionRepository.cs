using DataAccess.Models;

namespace DataAccess.Interfaces
{
    public interface IHomologacionRepository
    {
        /// <summary>
        /// Actualiza un registro de homologaci�n en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="Homologacion"/> con los datos actualizados.</param>
        /// <returns>Devuelve un valor booleano indicando si la actualizaci�n fue exitosa.</returns>
        bool Update(Homologacion data);

        /// <summary>
        /// Crea un nuevo registro de homologaci�n en la base de datos.
        /// </summary>
        /// <param name="data">Objeto <see cref="Homologacion"/> con los datos a insertar.</param>
        /// <returns>Devuelve un valor booleano indicando si la creaci�n fue exitosa.</returns>
        bool Create(Homologacion data);

        /// <summary>
        /// Busca un registro de homologaci�n en la base de datos por su identificador �nico.
        /// </summary>
        /// <param name="id">Identificador �nico de la homologaci�n.</param>
        /// <returns>Devuelve un objeto <see cref="Homologacion"/> si se encuentra el registro; de lo contrario, devuelve null.</returns>
        Homologacion? FindById(int id);

        /// <summary>
        /// Obtiene una colecci�n de registros de homologaci�n asociados a un elemento superior.
        /// </summary>
        /// <returns>Devuelve una colecci�n de objetos <see cref="Homologacion"/> relacionados con un elemento padre.</returns>
        ICollection<Homologacion> FindByParent();

        /// <summary>
        /// Busca una lista de registros de homologaci�n en la base de datos utilizando m�ltiples identificadores.
        /// </summary>
        /// <param name="ids">Array de identificadores �nicos de homologaciones.</param>
        /// <returns>Devuelve una lista de objetos <see cref="Homologacion"/> encontrados en la base de datos.</returns>
        List<Homologacion> FindByIds(int[] ids);

        /// <summary>
        /// Obtiene la homologaci�n en base a un c�digo de homologaci�n espec�fico.
        /// </summary>
        /// <param name="codigoHomologacion">C�digo �nico de homologaci�n.</param>
        /// <returns>Devuelve una lista de objetos <see cref="VwHomologacion"/> con la informaci�n correspondiente al c�digo ingresado.</returns>
        (List<VwHomologacion>, int TotalCount) ObtenerVwHomologacionPorCodigo(string codigoHomologacion, int PageNumber, int RowsPerPage, bool pagination = true);

        /// <summary>
        /// Obtiene la lista completa de registros de homologaci�n almacenados en la base de datos.
        /// </summary>
        /// <returns>Devuelve una lista de todos los registros de <see cref="Homologacion"/> en la base de datos.</returns>
        List<Homologacion> FindByAll();
    }
}
