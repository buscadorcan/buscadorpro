using DataAccess.Models;

namespace Core.Interfaces
{
    public interface IExcelService
    {
        /// <summary>
        /// Importa un archivo de Excel desde la ruta especificada y registra la migraci�n en el sistema para un ONA determinado.
        /// </summary>
        /// <param name="path">Ruta del archivo de Excel a importar.</param>
        /// <param name="migracion">Registro de la migraci�n asociado al proceso de importaci�n.</param>
        /// <param name="idOna">Identificador del ONA al que pertenece la migraci�n.</param>
        /// <returns>
        /// Devuelve un <see cref="Task{Boolean}"/> que representa el resultado de la importaci�n:
        /// <c>true</c> si la importaci�n fue exitosa, <c>false</c> si ocurri� un error.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si <paramref name="path"/> o <paramref name="migracion"/> son nulos o vac�os.
        /// </exception>
        /// <exception cref="FileNotFoundException">
        /// Se lanza si el archivo especificado en <paramref name="path"/> no existe.
        /// </exception>
        /// <exception cref="FormatException">
        /// Se lanza si el archivo de Excel no tiene el formato esperado.
        /// </exception>
        /// <exception cref="IOException">
        /// Se lanza si hay un error al leer el archivo, como problemas de acceso o corrupci�n del archivo.
        /// </exception>
        /// <exception cref="DbUpdateException">
        /// Se lanza si hay un error al registrar la migraci�n en la base de datos.
        /// </exception>
        Task<bool> ImportarExcel(string path, LogMigracion migracion, int idOna);

    }
}