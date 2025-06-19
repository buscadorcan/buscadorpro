using Core.Service;
using Core.Services;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;

namespace Core.Test.Service
{
    public class UsuarioEndpointServiceTests
    {
        private readonly Mock<IUsuarioEndpointRepository> _usuarioEndpointRepoMock;
        private readonly Mock<IJwtService> _jwtServiceMock;
        private readonly UsuarioEndpontService _usuarioEndpointService;

        public UsuarioEndpointServiceTests()
        {
            _usuarioEndpointRepoMock = new Mock<IUsuarioEndpointRepository>();
            _jwtServiceMock = new Mock<IJwtService>();

            _usuarioEndpointService = new UsuarioEndpontService(
                _usuarioEndpointRepoMock.Object,
                _jwtServiceMock.Object
            );
        }

        [Fact]
        public void Create_ShouldSetIdUserCreacionAndCallRepository()
        {
            // Arrange
            var token = "mockedToken";
            var userId = 123;
            var usuarioEndpoint = new UsuarioEndpoint();

            _jwtServiceMock.Setup(j => j.GetTokenFromHeader()).Returns(token);
            _jwtServiceMock.Setup(j => j.GetUserIdFromToken(token)).Returns(userId);
            _usuarioEndpointRepoMock.Setup(r => r.Create(usuarioEndpoint)).Returns(true);

            // Act
            var result = _usuarioEndpointService.Create(usuarioEndpoint);

            // Assert
            Assert.True(result);
            Assert.Equal(userId, usuarioEndpoint.IdUserCreacion);
        }

        [Fact]
        public void FindAll_ShouldReturnListOfUsuarioEndpoints()
        {
            // Arrange
            var endpoints = new List<UsuarioEndpoint> { new UsuarioEndpoint(), new UsuarioEndpoint() };
            _usuarioEndpointRepoMock.Setup(r => r.FindAll()).Returns(endpoints);

            // Act
            var result = _usuarioEndpointService.FindAll();

            // Assert
            Assert.Equal(2, result.Count);
        }

        [Fact]
        public void FindByEndpointId_ShouldReturnCorrectEndpoint()
        {
            // Arrange
            var endpoint = new UsuarioEndpoint { IdUsuario = 1 };
            _usuarioEndpointRepoMock.Setup(r => r.FindByEndpointId(1)).Returns(endpoint);

            // Act
            var result = _usuarioEndpointService.FindByEndpointId(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(1, result.IdUsuario);
        }

        [Fact]
        public void FindByEndpointId_ShouldReturnNull_WhenNotFound()
        {
            // Arrange
            _usuarioEndpointRepoMock.Setup(r => r.FindByEndpointId(1)).Returns((UsuarioEndpoint?)null);

            // Act
            var result = _usuarioEndpointService.FindByEndpointId(1);

            // Assert
            Assert.Null(result);
        }
    }
}
