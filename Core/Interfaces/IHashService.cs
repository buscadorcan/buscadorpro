namespace Core.Services
{
    public interface IHashService
    {
        /// <summary>
        /// Genera un hash �nico basado en la cadena de entrada proporcionada.
        /// </summary>
        /// <param name="input">La cadena de texto de la cual se generar� el hash. Puede ser nula.</param>
        /// <returns>
        /// Un string con el hash generado. Si la entrada es nula o vac�a, se devolver� un hash predeterminado.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si el par�metro <paramref name="input"/> es nulo y la implementaci�n no admite valores nulos.
        /// </exception>
        /// <remarks>
        /// Este m�todo utiliza un algoritmo de hashing seguro como SHA-256 o SHA-512.
        /// El resultado puede variar dependiendo de la implementaci�n.
        /// </remarks>
        string GenerateHash(string? input);

    }
}
