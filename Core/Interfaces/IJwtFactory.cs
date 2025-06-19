using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;

namespace Core.Services
{
    public interface IJwtFactory
    {
        /// <summary>
        /// Crea y devuelve una instancia de <see cref="JwtSecurityTokenHandler"/> para la generaci�n y validaci�n de tokens JWT.
        /// </summary>
        /// <returns>
        /// Una instancia de <see cref="JwtSecurityTokenHandler"/> que permite crear y validar tokens de autenticaci�n.
        /// </returns>
        /// <remarks>
        /// Este m�todo facilita la creaci�n de un manejador de tokens JWT, el cual es esencial para gestionar la autenticaci�n basada en tokens.
        /// </remarks>
        JwtSecurityTokenHandler CreateTokenHandler();


        /// <summary>
        /// Genera las credenciales de firma necesarias para la creaci�n de un token JWT utilizando una clave secreta.
        /// </summary>
        /// <param name="secret">La clave secreta utilizada para firmar el token.</param>
        /// <returns>
        /// Una instancia de <see cref="SigningCredentials"/> que contiene la clave de firma y el algoritmo utilizado.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si el par�metro <paramref name="secret"/> es nulo o est� vac�o.
        /// </exception>
        /// <remarks>
        /// Este m�todo convierte la clave secreta en una clave de seguridad v�lida para la firma de tokens JWT.
        /// Se recomienda utilizar una clave segura y almacenarla en un entorno seguro.
        /// </remarks>
        SigningCredentials CreateSigningCredentials(string secret);


        /// <summary>
        /// Configura los par�metros de validaci�n para la verificaci�n de tokens JWT utilizando una clave secreta.
        /// </summary>
        /// <param name="secret">La clave secreta utilizada para validar la firma del token.</param>
        /// <returns>
        /// Una instancia de <see cref="TokenValidationParameters"/> con los par�metros de validaci�n configurados.
        /// </returns>
        /// <exception cref="ArgumentNullException">
        /// Se lanza si el par�metro <paramref name="secret"/> es nulo o est� vac�o.
        /// </exception>
        /// <remarks>
        /// Este m�todo configura los par�metros que se utilizar�n para validar tokens JWT, incluyendo la clave de firma,
        /// la validaci�n de audiencia/emisor y la verificaci�n de la fecha de expiraci�n.
        /// </remarks>
        TokenValidationParameters CreateTokenValidationParameters(string secret);


    }
}