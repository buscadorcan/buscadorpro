using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using SharedApp.Dtos;
using SharedApp.Response;
using WebApp.Controllers;

namespace WebApp.Test.Controllers
{
    public class UsuariosControllerTests
    {
        private readonly Mock<IUsuarioService> _mockUsuarioService;
        private readonly Mock<IAuthenticateService> _mockAuthService;
        private readonly Mock<IRecoverUserService> _mockRecoverService;
        private readonly Mock<ILogger<UsuariosController>> _mockLogger;
        private readonly Mock<IUtilitiesService> _utilitiesService = new();
        private readonly UsuariosController _controller;

        public UsuariosControllerTests()
        {
            _mockUsuarioService = new Mock<IUsuarioService>();
            _mockAuthService = new Mock<IAuthenticateService>();
            _mockRecoverService = new Mock<IRecoverUserService>();
            _mockLogger = new Mock<ILogger<UsuariosController>>();

            _controller = new UsuariosController(
                _mockUsuarioService.Object,
                _mockAuthService.Object,
                _mockRecoverService.Object,
                _mockLogger.Object,
                _utilitiesService.Object
            );
        }

        [Fact]
        public void Login_ReturnsOk_WhenAuthenticationSucceeds()
        {
            // Arrange
            var dto = new UsuarioAutenticacionDto { Email = "test@example.com", Clave = "1234" };
            var expectedResponse = new AuthenticateResponseDto { IdUsuario = 1, IdHomologacionRol = 1 };

            _mockAuthService
                .Setup(s => s.Authenticate(dto))
                .Returns(Result<AuthenticateResponseDto>.Success(expectedResponse));

            // Act
            var result = _controller.Login(dto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<AuthenticateResponseDto>>(okResult.Value);
            Assert.Equal(1, response.Result.IdUsuario);
        }

        [Fact]
        public void Login_ReturnsBadRequest_WhenAuthenticationFails()
        {
            // Arrange
            var dto = new UsuarioAutenticacionDto { Email = "test@example.com", Clave = "wrongpassword" };

            _mockAuthService
                .Setup(s => s.Authenticate(dto))
                .Returns(Result<AuthenticateResponseDto>.Failure("Credenciales inválidas"));

            // Act
            var result = _controller.Login(dto);

            // Assert
            var badRequest = Assert.IsType<BadRequestObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<object>>(badRequest.Value);
            Assert.Equal("Credenciales inválidas", response.ErrorMessages.First());
        }
    }
}