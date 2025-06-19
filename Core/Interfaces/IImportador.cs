namespace Core.Interfaces
{
    public interface IImportador
    {
        /// <summary>
        /// Importa datos desde los archivos especificados en las rutas proporcionadas.
        /// </summary>
        /// <param name="path">Un array de strings que contiene las rutas de los archivos a importar.</param>
        /// <returns>
        /// Un valor booleano que indica si la importaci�n se realiz� con �xito.
        /// Devuelve <c>true</c> si la importaci�n fue exitosa, de lo contrario <c>false</c>.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si el par�metro <paramref name="path"/> es nulo o est� vac�o.
        /// </exception>
        /// <exception cref="FileNotFoundException">
        /// Se lanza si uno o m�s archivos especificados en <paramref name="path"/> no existen.
        /// </exception>
        /// <exception cref="IOException">
        /// Se lanza si ocurre un error de entrada/salida durante la lectura de los archivos.
        /// </exception>
        /// <remarks>
        /// Este m�todo se encarga de procesar los archivos en las rutas proporcionadas,
        /// validando su existencia y manejando posibles errores de importaci�n.
        /// </remarks>
        bool Importar(string[] path);

    }
}