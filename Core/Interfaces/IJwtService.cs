namespace Core.Services;

public interface IJwtService
{
    /// <summary>
    /// Genera un token JWT para el usuario especificado utilizando su identificador �nico.
    /// </summary>
    /// <param name="userId">El identificador �nico del usuario.</param>
    /// <returns>
    /// Un <see cref="string"/> que representa el token JWT generado.
    /// </returns>
    /// <exception cref="SecurityTokenException">
    /// Se lanza si ocurre un error durante la generaci�n del token.
    /// </exception>
    /// <remarks>
    /// El token JWT generado incluir� informaci�n relevante sobre el usuario y su rol, 
    /// adem�s de una fecha de expiraci�n seg�n las pol�ticas de autenticaci�n definidas.
    /// </remarks>
    string GenerateJwtToken(int userId);


    /// <summary>
    /// Extrae y devuelve el identificador del usuario desde un token JWT proporcionado.
    /// </summary>
    /// <param name="token">El token JWT del cual se extraer� el identificador de usuario.</param>
    /// <returns>
    /// Un <see cref="int"/> que representa el identificador del usuario contenido en el token.
    /// </returns>
    /// <exception cref="SecurityTokenException">
    /// Se lanza si el token es inv�lido, ha expirado o no contiene el identificador de usuario.
    /// </exception>
    /// <exception cref="ArgumentNullException">
    /// Se lanza si el par�metro <paramref name="token"/> es nulo o vac�o.
    /// </exception>
    /// <remarks>
    /// Este m�todo valida y decodifica el token JWT, extrayendo la informaci�n del usuario almacenada en �l.
    /// </remarks>
    int GetUserIdFromToken(string token);


    /// <summary>
    /// Obtiene el token JWT desde el encabezado de autorizaci�n de la solicitud HTTP.
    /// </summary>
    /// <returns>
    /// Un <see cref="string"/> que contiene el token JWT si est� presente en la solicitud, o <c>null</c> si no se encuentra.
    /// </returns>
    /// <remarks>
    /// Este m�todo busca el token en el encabezado HTTP "Authorization" con el esquema "Bearer".
    /// Si el encabezado no est� presente o no contiene un token v�lido, se devuelve <c>null</c>.
    /// </remarks>
    string? GetTokenFromHeader();


}