namespace Core.Services
{
    public interface IHashStrategy
    {
        /// <summary>
        /// Calcula un hash seguro basado en la cadena de entrada proporcionada.
        /// </summary>
        /// <param name="input">La cadena de texto de la cual se calcular� el hash. Puede ser nula.</param>
        /// <returns>
        /// Un string que representa el hash generado.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si el par�metro <paramref name="input"/> es nulo y la implementaci�n no admite valores nulos.
        /// </exception>
        /// <remarks>
        /// Este m�todo utiliza un algoritmo criptogr�fico seguro, como SHA-256 o SHA-512,
        /// para generar un hash �nico de la entrada.
        /// </remarks>
        string ComputeHash(string? input);

    }
}
