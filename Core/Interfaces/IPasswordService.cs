namespace Core.Interfaces
{
    public interface IPasswordService
    {
        /// <summary>
        /// Genera una contrase�a temporal aleatoria con la longitud especificada.
        /// </summary>
        /// <param name="length">
        /// La longitud deseada de la contrase�a temporal. Debe ser un n�mero positivo mayor o igual a 6 para garantizar seguridad.
        /// </param>
        /// <returns>
        /// Una cadena de texto que representa la contrase�a temporal generada aleatoriamente.
        /// </returns>
        /// <exception cref="ArgumentException">
        /// Se lanza si el par�metro <paramref name="length"/> es menor a 6.
        /// </exception>
        /// <remarks>
        /// La contrase�a generada incluir� una combinaci�n de letras may�sculas, min�sculas, n�meros y caracteres especiales 
        /// para mejorar la seguridad. Est� dise�ada para ser usada como una clave temporal que el usuario debe cambiar posteriormente.
        /// </remarks>
        string GenerateTemporaryPassword(int length);

    }
}