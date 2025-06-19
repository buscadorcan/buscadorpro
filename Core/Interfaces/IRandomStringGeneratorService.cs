namespace Core.Interfaces
{
    public interface IRandomStringGeneratorService
    {
        /// <summary>
        /// Genera una contrase�a temporal aleatoria utilizando una combinaci�n de caracteres alfanum�ricos.
        /// </summary>
        /// <param name="length">Longitud de la contrase�a generada.</param>
        /// <returns>Devuelve una cadena de caracteres que representa la contrase�a generada.</returns>
        string GenerateTemporaryPassword(int length);

        /// <summary>
        /// Genera un c�digo temporal aleatorio compuesto �nicamente de d�gitos.
        /// </summary>
        /// <param name="length">Longitud del c�digo generado.</param>
        /// <returns>Devuelve una cadena de caracteres num�ricos que representa el c�digo generado.</returns>
        string GenerateTemporaryCode(int length);

    }
}