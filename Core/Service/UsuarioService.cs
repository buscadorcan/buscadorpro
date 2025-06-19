using AutoMapper;
using Core.Interfaces;
using Core.Services;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp;
using SharedApp.Dtos;

namespace Core.Service
{
    public class UsuarioService : IUsuarioService
    {
        private readonly IUsuarioRepository _usuarioRepository;
        private readonly IHashService _hashService;
        private readonly IJwtService _jwtService;
        private readonly IMapper mapper;

        public UsuarioService(IUsuarioRepository usuarioRepository,
                              IHashService hashService,
                              IJwtService jwtService,
                              IMapper mapper)
        {
            this._usuarioRepository = usuarioRepository;
            this._hashService = hashService;
            this._jwtService = jwtService;
            this.mapper = mapper;
        }

        public Result<bool> ChangePasswd(string clave, string claveNueva)
        {
            var actual = _hashService.GenerateHash(clave);
            var nueva = _hashService.GenerateHash(claveNueva);
            var idUsuario = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "0");

            return _usuarioRepository.ChangePasswd(clave, claveNueva, idUsuario, nueva);
        }

        public bool Create(UsuarioDto usuario)
        {
            Usuario entity = mapper.Map<Usuario>(usuario);
            var clave = usuario.Clave;
            entity.Clave = _hashService.GenerateHash(clave);
            entity.IdUserCreacion = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "");
            entity.IdUserModifica = entity.IdUserCreacion;
            entity.Estado = Constantes.ESTADO_USUARIO_A;

            return _usuarioRepository.Create(entity);
        }

        public List<UsuarioDto> FindAll()
        {
            return _usuarioRepository.FindAll().ToList();
        }

        public Usuario? FindByEmail(string email)
        {
            return _usuarioRepository.FindByEmail(email);
        }

        public UsuarioDto? FindById(int idUsuario)
        {
            Usuario? usuario = _usuarioRepository.FindById(idUsuario);
            return mapper.Map<UsuarioDto>(usuario);
        }

        public bool IsUniqueUser(string usuario)
        {
            return _usuarioRepository.IsUniqueUser(usuario);
        }

        public bool Update(UsuarioDto usuario)
        {
            Usuario entity = mapper.Map<Usuario>(usuario);
            return _usuarioRepository.Update(entity);
        }

        public bool Deactivate(int idUsuario)
        {
            var usuario = FindById(idUsuario);

            if (usuario == null)
            {
                return false;
            }

            usuario.Estado = Constantes.ESTADO_USUARIO_X;
            Update(usuario);
            return true;
        }
    }
}
