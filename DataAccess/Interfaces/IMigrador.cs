using DataAccess.Models;

namespace DataAccess.Interfaces
{
    public interface IMigrador
    {
        /// <summary>
        /// Realiza la migraci�n de datos de manera as�ncrona utilizando la conexi�n ONA especificada.
        /// </summary>
        /// <param name="conexion">Objeto <see cref="ONAConexion"/> que contiene los detalles de la conexi�n ONA.</param>
        /// <returns>
        /// Una tarea que representa la operaci�n asincr�nica, con un valor booleano que indica si la migraci�n fue exitosa.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si el par�metro <paramref name="conexion"/> es nulo.
        /// </exception>
        /// <exception cref="DatabaseException">
        /// Se lanza si ocurre un error durante la migraci�n de datos en la base de datos.
        /// </exception>
        /// <remarks>
        /// Este m�todo establece una conexi�n con la base de datos ONA y ejecuta la l�gica de migraci�n de datos.
        /// La migraci�n puede incluir transferencia de datos, validaciones y transformaciones.
        /// </remarks>
        Task<bool> MigrarAsync(ONAConexion conexion);

    }
}
