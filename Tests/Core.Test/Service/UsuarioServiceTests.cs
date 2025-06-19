using AutoMapper;
using Core.Service;
using Core.Services;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class UsuarioServiceTests
    {
        private readonly Mock<IUsuarioRepository> _usuarioRepositoryMock;
        private readonly Mock<IHashService> _hashServiceMock;
        private readonly Mock<IJwtService> _jwtServiceMock;
        private readonly Mock<IMapper> _mapperMock;
        private readonly UsuarioService _usuarioService;

        public UsuarioServiceTests()
        {
            _usuarioRepositoryMock = new Mock<IUsuarioRepository>();
            _hashServiceMock = new Mock<IHashService>();
            _jwtServiceMock = new Mock<IJwtService>();
            _mapperMock = new Mock<IMapper>();

            _usuarioService = new UsuarioService(
                _usuarioRepositoryMock.Object,
                _hashServiceMock.Object,
                _jwtServiceMock.Object,
                _mapperMock.Object
            );
        }

        [Fact]
        public void Create_ShouldCreateUser_WhenValidData()
        {
            // Arrange
            var usuarioDto = new UsuarioDto { Clave = "1234" };
            var usuarioEntity = new Usuario();

            _mapperMock.Setup(m => m.Map<Usuario>(usuarioDto)).Returns(usuarioEntity);
            _hashServiceMock.Setup(h => h.GenerateHash("1234")).Returns("hashed1234");
            _jwtServiceMock.Setup(j => j.GetTokenFromHeader()).Returns("token");
            _jwtServiceMock.Setup(j => j.GetUserIdFromToken("token")).Returns(1);
            _usuarioRepositoryMock.Setup(r => r.Create(usuarioEntity)).Returns(true);

            // Act
            var result = _usuarioService.Create(usuarioDto);

            // Assert
            Assert.True(result);
            Assert.Equal("hashed1234", usuarioEntity.Clave);
        }

        [Fact]
        public void ChangePasswd_ShouldReturnResult_WhenValidData()
        {
            // Arrange
            _hashServiceMock.Setup(h => h.GenerateHash("old")).Returns("hashOld");
            _hashServiceMock.Setup(h => h.GenerateHash("new")).Returns("hashNew");
            _jwtServiceMock.Setup(j => j.GetTokenFromHeader()).Returns("token");
            _jwtServiceMock.Setup(j => j.GetUserIdFromToken("token")).Returns(1);

            _usuarioRepositoryMock
                .Setup(r => r.ChangePasswd("old", "new", 1, "hashNew"))
                .Returns(Result<bool>.Success(true));

            // Act
            var result = _usuarioService.ChangePasswd("old", "new");

            // Assert
            Assert.True(result.IsSuccess);
        }

        [Fact]
        public void FindById_ShouldReturnDto_WhenUserExists()
        {
            // Arrange
            var user = new Usuario();
            var userDto = new UsuarioDto();

            _usuarioRepositoryMock.Setup(r => r.FindById(1)).Returns(user);
            _mapperMock.Setup(m => m.Map<UsuarioDto>(user)).Returns(userDto);

            // Act
            var result = _usuarioService.FindById(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(userDto, result);
        }

        [Fact]
        public void Deactivate_ShouldReturnTrue_WhenUserExists()
        {
            // Arrange
            var userDto = new UsuarioDto { Estado = Constantes.ESTADO_USUARIO_A };
            _usuarioRepositoryMock.Setup(r => r.FindById(1)).Returns(new Usuario());
            _mapperMock.Setup(m => m.Map<UsuarioDto>(It.IsAny<Usuario>())).Returns(userDto);
            _usuarioRepositoryMock.Setup(r => r.Update(It.IsAny<Usuario>())).Returns(true);

            // Act
            var result = _usuarioService.Deactivate(1);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void Deactivate_ShouldReturnFalse_WhenUserNotExists()
        {
            // Arrange
            _usuarioRepositoryMock.Setup(r => r.FindById(1)).Returns((Usuario?)null);

            // Act
            var result = _usuarioService.Deactivate(1);

            // Assert
            Assert.False(result);
        }
    }
}
