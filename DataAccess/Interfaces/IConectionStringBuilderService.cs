using DataAccess.Models;

namespace DataAccess.Interfaces
{
  public interface IConectionStringBuilderService
  {
        /// <summary>
        /// Construye una cadena de conexi�n a la base de datos en base a los datos de una conexi�n ONA proporcionada.
        /// </summary>
        /// <param name="conexion">Objeto <see cref="ONAConexion"/> que contiene los par�metros de conexi�n como servidor, base de datos, usuario y contrase�a.</param>
        /// <returns>
        /// Devuelve un <see cref="string"/> con la cadena de conexi�n generada.
        /// </returns>
        /// <exception cref="ArgumentNullException">Lanzado si el objeto <paramref name="conexion"/> es nulo.</exception>
        /// <exception cref="InvalidOperationException">Lanzado si los datos de conexi�n son inv�lidos o incompletos.</exception>
        string BuildConnectionString(ONAConexion conexion);

    }
}
