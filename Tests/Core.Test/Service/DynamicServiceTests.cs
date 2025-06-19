using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class DynamicServiceTests
    {
        private readonly Mock<IDynamicRepository> _dynamicRepositoryMock;
        private readonly DynamicService _service;

        public DynamicServiceTests()
        {
            _dynamicRepositoryMock = new Mock<IDynamicRepository>();
            _service = new DynamicService(_dynamicRepositoryMock.Object);
        }

        [Fact]
        public void GetConexion_ReturnsCorrectConnection()
        {
            // Arrange
            int idONA = 1;
            var expectedConnection = new ONAConexion { IdONA = idONA };

            _dynamicRepositoryMock
                .Setup(r => r.GetConexion(idONA))
                .Returns(expectedConnection);

            // Act
            var result = _service.GetConexion(idONA);

            // Assert
            Assert.Equal(expectedConnection, result);
        }

        [Fact]
        public void GetListaValidacionEsquema_ReturnsExpectedList()
        {
            // Arrange
            int idONA = 1;
            int idEsquema = 2;
            var expectedList = new List<EsquemaVistaDto> { new EsquemaVistaDto(), new EsquemaVistaDto() };

            _dynamicRepositoryMock
                .Setup(r => r.GetListaValidacionEsquema(idONA, idEsquema))
                .Returns(expectedList);

            // Act
            var result = _service.GetListaValidacionEsquema(idONA, idEsquema);

            // Assert
            Assert.Equal(expectedList, result);
        }

        [Fact]
        public void GetProperties_ReturnsExpectedProperties()
        {
            // Arrange
            int idONA = 1;
            string viewName = "MiVista";
            var expectedProps = new List<PropiedadesTablaDto> { new PropiedadesTablaDto(), new PropiedadesTablaDto() };

            _dynamicRepositoryMock
                .Setup(r => r.GetProperties(idONA, viewName))
                .Returns(expectedProps);

            // Act
            var result = _service.GetProperties(idONA, viewName);

            // Assert
            Assert.Equal(expectedProps, result);
        }

        [Fact]
        public void GetValueColumna_ReturnsExpectedValues()
        {
            // Arrange
            int idONA = 1;
            string valueColumn = "columna";
            string viewName = "MiVista";
            var expectedValues = new List<PropiedadesTablaDto> { new PropiedadesTablaDto() };

            _dynamicRepositoryMock
                .Setup(r => r.GetValueColumna(idONA, valueColumn, viewName))
                .Returns(expectedValues);

            // Act
            var result = _service.GetValueColumna(idONA, valueColumn, viewName);

            // Assert
            Assert.Equal(expectedValues, result);
        }

        [Fact]
        public void GetViewNames_ReturnsExpectedViewNames()
        {
            // Arrange
            int idONA = 1;
            var expectedNames = new List<string> { "View1", "View2" };

            _dynamicRepositoryMock
                .Setup(r => r.GetViewNames(idONA))
                .Returns(expectedNames);

            // Act
            var result = _service.GetViewNames(idONA);

            // Assert
            Assert.Equal(expectedNames, result);
        }

        [Fact]
        public async Task MigrarConexionAsync_ReturnsTrue()
        {
            // Arrange
            int idONA = 1;
            _dynamicRepositoryMock
                .Setup(r => r.MigrarConexionAsync(idONA))
                .ReturnsAsync(true);

            // Act
            var result = await _service.MigrarConexionAsync(idONA);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void TestDatabaseConnection_ReturnsTrue()
        {
            // Arrange
            var conexion = new ONAConexion { IdONA = 1 };
            _dynamicRepositoryMock
                .Setup(r => r.TestDatabaseConnection(conexion))
                .Returns(true);

            // Act
            var result = _service.TestDatabaseConnection(conexion);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void TestDatabaseConnection_ReturnsFalse()
        {
            // Arrange
            var conexion = new ONAConexion { IdONA = 2 };
            _dynamicRepositoryMock
                .Setup(r => r.TestDatabaseConnection(conexion))
                .Returns(false);

            // Act
            var result = _service.TestDatabaseConnection(conexion);

            // Assert
            Assert.False(result);
        }
    }
}
