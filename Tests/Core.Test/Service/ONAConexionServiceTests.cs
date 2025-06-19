using AutoMapper;
using Core.Service;
using Core.Services;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class ONAConexionServiceTests
    {
        private readonly Mock<IONAConexionRepository> _repositoryMock;
        private readonly Mock<IJwtService> _jwtServiceMock;
        private readonly Mock<IMapper> _mapperMock;
        private readonly ONAConexionService _service;

        public ONAConexionServiceTests()
        {
            _repositoryMock = new Mock<IONAConexionRepository>();
            _jwtServiceMock = new Mock<IJwtService>();
            _mapperMock = new Mock<IMapper>();

            _service = new ONAConexionService(
                _repositoryMock.Object,
                _jwtServiceMock.Object,
                _mapperMock.Object
            );
        }

        [Fact]
        public void Create_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            // Arrange
            var dto = new ONAConexionDto();
            var entity = new ONAConexion();
            _mapperMock.Setup(m => m.Map<ONAConexion>(dto)).Returns(entity);
            _jwtServiceMock.Setup(j => j.GetTokenFromHeader()).Returns("token");
            _jwtServiceMock.Setup(j => j.GetUserIdFromToken("token")).Returns(1);
            _repositoryMock.Setup(r => r.Create(It.IsAny<ONAConexion>())).Returns(true);

            // Act
            var result = _service.Create(dto);

            // Assert
            Assert.True(result);
            _repositoryMock.Verify(r => r.Create(It.IsAny<ONAConexion>()), Times.Once);
        }

        [Fact]
        public void FindAll_ShouldReturnListOfDtos()
        {
            // Arrange
            var entities = new List<ONAConexionDto> { new ONAConexionDto(), new ONAConexionDto() };
            var dtos = new List<ONAConexionDto> { new ONAConexionDto(), new ONAConexionDto() };
            _repositoryMock.Setup(r => r.FindAll()).Returns(entities);
            _mapperMock.Setup(m => m.Map<List<ONAConexionDto>>(entities)).Returns(dtos);

            // Act
            var result = _service.FindAll();

            // Assert
            Assert.Equal(2, result.Count);
        }

        [Fact]
        public void FindById_ShouldReturnDto_WhenFound()
        {
            var entity = new ONAConexion();
            var dto = new ONAConexionDto();
            _repositoryMock.Setup(r => r.FindById(1)).Returns(entity);
            _mapperMock.Setup(m => m.Map<ONAConexionDto>(entity)).Returns(dto);

            var result = _service.FindById(1);

            Assert.NotNull(result);
        }

        [Fact]
        public void FindByIdONA_ShouldReturnDto_WhenFound()
        {
            var entity = new ONAConexion();
            var dto = new ONAConexionDto();
            _repositoryMock.Setup(r => r.FindByIdONA(2)).Returns(entity);
            _mapperMock.Setup(m => m.Map<ONAConexionDto>(entity)).Returns(dto);

            var result = _service.FindByIdONA(2);

            Assert.NotNull(result);
        }

        [Fact]
        public async Task FindByIdONAAsync_ShouldReturnDto_WhenFound()
        {
            var entity = new ONAConexion();
            var dto = new ONAConexionDto();
            _repositoryMock.Setup(r => r.FindByIdONAAsync(3)).ReturnsAsync(entity);
            _mapperMock.Setup(m => m.Map<ONAConexionDto>(entity)).Returns(dto);

            var result = await _service.FindByIdONAAsync(3);

            Assert.NotNull(result);
        }

        [Fact]
        public void GetONAConexionByOnaListAsync_ShouldReturnDtos()
        {
            var entities = new List<ONAConexion> { new ONAConexion() };
            var dtos = new List<ONAConexionDto> { new ONAConexionDto() };
            _repositoryMock.Setup(r => r.GetOnaConexionByOnaListAsync(4)).Returns(entities);
            _mapperMock.Setup(m => m.Map<List<ONAConexionDto>>(entities)).Returns(dtos);

            var result = _service.GetONAConexionByOnaListAsync(4);

            Assert.Single(result);
        }

        [Fact]
        public void Update_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var dto = new ONAConexionDto();
            var entity = new ONAConexion();
            _jwtServiceMock.Setup(j => j.GetTokenFromHeader()).Returns("token");
            _jwtServiceMock.Setup(j => j.GetUserIdFromToken("token")).Returns(1);
            _mapperMock.Setup(m => m.Map<ONAConexion>(dto)).Returns(entity);
            _repositoryMock.Setup(r => r.Update(entity, 1)).Returns(true);

            var result = _service.Update(dto);

            Assert.True(result);
        }
    }
}
