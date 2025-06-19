using SharedApp.Dtos;

namespace Core.Interfaces
{
    public interface IRecoverUserService
    {
        /// <summary>
        /// Recupera la contrase�a de un usuario generando una nueva contrase�a temporal 
        /// y envi�ndola al correo electr�nico asociado.
        /// </summary>
        /// <param name="usuarioRecuperacionDto">Objeto que contiene la informaci�n del usuario 
        /// para la recuperaci�n de contrase�a.</param>
        /// <returns>Devuelve un objeto <see cref="Result{bool}"/> indicando si la operaci�n fue exitosa o no.</returns>
        Result<bool> RecoverPassword(UsuarioRecuperacionDto usuarioRecuperacionDto);
    }
}
