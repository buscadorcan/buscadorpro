namespace Core.Interfaces
{
    public interface IPasswordGenerationStrategy
    {
        /// <summary>
        /// Genera una contrase�a aleatoria con la longitud especificada.
        /// </summary>
        /// <param name="length">
        /// La longitud deseada de la contrase�a. Debe ser un n�mero positivo mayor a 4 para garantizar seguridad.
        /// </param>
        /// <returns>
        /// Una cadena que representa la contrase�a generada aleatoriamente.
        /// </returns>
        /// <exception cref="ArgumentException">
        /// Se lanza si el par�metro <paramref name="length"/> es menor a 4.
        /// </exception>
        /// <remarks>
        /// La contrase�a generada incluir� una combinaci�n de letras may�sculas, min�sculas, n�meros y caracteres especiales.
        /// </remarks>
        string GeneratePassword(int length);

    }
}