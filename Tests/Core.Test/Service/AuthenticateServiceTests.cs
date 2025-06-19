using Core.Interfaces;
using Core.Service;
using Core.Services;
using DataAccess.Interfaces;
using DataAccess.Models;
using Microsoft.Extensions.Configuration;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class AuthenticateServiceTests
    {
        private readonly Mock<IUsuarioRepository> _usuarioRepositoryMock = new();
        private readonly Mock<IONAConexionRepository> _onaConexionRepositoryMock = new();
        private readonly Mock<IHashService> _hashServiceMock = new();
        private readonly Mock<IJwtService> _jwtServiceMock = new();
        private readonly Mock<ICatalogosRepository> _catalogosRepositoryMock = new();
        private readonly Mock<IEventTrackingRepository> _eventTrackingRepositoryMock = new();
        private readonly Mock<IEmailService> _emailServiceMock = new();
        private readonly Mock<IRandomStringGeneratorService> _randomGeneratorServiceMock = new();
        private readonly Mock<IConfiguration> _configurationMock = new();

        private AuthenticateService CreateService()
        {
            return new AuthenticateService(
                _usuarioRepositoryMock.Object,
                _onaConexionRepositoryMock.Object,
                _catalogosRepositoryMock.Object,
                _eventTrackingRepositoryMock.Object,
                _randomGeneratorServiceMock.Object,
                _emailServiceMock.Object,
                _hashServiceMock.Object,
                _jwtServiceMock.Object,
                _configurationMock.Object
            );
        }

        [Fact]
        public void Authenticate_ShouldReturnSuccess_WhenCredentialsAreCorrect()
        {
            // Arrange
            var service = CreateService();
            var usuarioDto = new UsuarioAutenticacionDto { Email = "test@example.com", Clave = "123456" };
            var hash = "hashed123456";
            var usuario = new Usuario { IdUsuario = 1, Email = "test@example.com", Clave = hash, IdHomologacionRol = 2, Nombre = "Test" };

            _usuarioRepositoryMock.Setup(r => r.FindByEmail(usuarioDto.Email)).Returns(usuario);
            _hashServiceMock.Setup(h => h.GenerateHash(usuarioDto.Clave.Trim())).Returns(hash);
            _catalogosRepositoryMock.Setup(r => r.FindVwRolByHId(usuario.IdHomologacionRol)).Returns(new VwRol { IdHomologacionRol = 2, Rol = "Admin", CodigoHomologacion = "ADM" });
            _randomGeneratorServiceMock.Setup(r => r.GenerateTemporaryCode(It.IsAny<int>())).Returns("ABC123");
            _emailServiceMock.Setup(e => e.SendEmailAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>())).Returns(Task.FromResult(true));

            // Act
            var result = service.Authenticate(usuarioDto);

            // Assert
            Assert.True(result.IsSuccess);
            Assert.Equal(1, result.Value.IdUsuario);
        }

        [Fact]
        public void Authenticate_ShouldReturnFailure_WhenUserNotFound()
        {
            // Arrange
            var service = CreateService();
            var dto = new UsuarioAutenticacionDto { Email = "notfound@example.com", Clave = "123456" };
            _usuarioRepositoryMock.Setup(r => r.FindByEmail(dto.Email)).Returns((Usuario)null);

            // Act
            var result = service.Authenticate(dto);

            // Assert
            Assert.False(result.IsSuccess);
            Assert.Equal("Usuario no encontrado.", result.ErrorMessage);
        }

        [Fact]
        public void ValidateCode_ShouldReturnSuccess_WhenCodeIsValid()
        {
            // Arrange
            var service = CreateService();
            var usuario = new Usuario
            {
                IdUsuario = 1,
                Email = "test@example.com",
                Nombre = "Test",
                Apellido = "User",
                Telefono = "123",
                IdONA = 10,
                IdHomologacionRol = 2
            };
            var dto = new AuthValidationDto { IdUsuario = 1, Codigo = "ABC123" };

            _usuarioRepositoryMock.Setup(r => r.FindById(dto.IdUsuario)).Returns(usuario);
            _catalogosRepositoryMock.Setup(r => r.FindVwRolByHId(usuario.IdHomologacionRol)).Returns(new VwRol { CodigoHomologacion = "ADM" });
            _eventTrackingRepositoryMock.Setup(r => r.GetCodeByUser(usuario.Nombre, "ADM", "Access")).Returns("ABC123");
            _onaConexionRepositoryMock.Setup(r => r.FindById(usuario.IdONA)).Returns(new ONAConexion { });
            _catalogosRepositoryMock.Setup(r => r.FindVwHGByCode("KEY_MENU")).Returns(new VwHomologacionGrupo { CodigoHomologacion = "HG", MostrarWeb = "true", TooltipWeb = "info" });
            _jwtServiceMock.Setup(j => j.GenerateJwtToken(usuario.IdUsuario)).Returns("token123");

            // Act
            var result = service.ValidateCode(dto);

            // Assert
            Assert.True(result.IsSuccess);
            Assert.Equal("token123", result.Value.Token);
            Assert.Equal("test@example.com", result.Value.Usuario.Email);
        }

        [Fact]
        public void ValidateCode_ShouldReturnFailure_WhenUserIdIsZero()
        {
            // Arrange
            var service = CreateService();
            var dto = new AuthValidationDto { IdUsuario = 0, Codigo = "123456" };

            // Act
            var result = service.ValidateCode(dto);

            // Assert
            Assert.False(result.IsSuccess);
            Assert.Equal("Usuario Incorrecto", result.ErrorMessage);
        }
    }
}
