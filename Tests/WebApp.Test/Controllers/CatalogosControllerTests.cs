using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using SharedApp.Dtos;
using SharedApp.Response;
using WebApp.Controllers;

namespace WebApp.Test.Controllers
{
    public class CatalogosControllerTests
    {
        private readonly Mock<ICatalogosService> _serviceMock;
        private readonly Mock<ILogger<CatalogosController>> _loggerMock;
        private readonly CatalogosController _controller;

        public CatalogosControllerTests()
        {
            _serviceMock = new Mock<ICatalogosService>();
            _loggerMock = new Mock<ILogger<CatalogosController>>();
            _controller = new CatalogosController(_serviceMock.Object, _loggerMock.Object);
        }

        [Fact]
        public void ObtenerVwGrilla_ReturnsOk_WithData()
        {
            // Arrange
            var expected = new List<VwGrillaDto> { new VwGrillaDto() };
            _serviceMock.Setup(s => s.ObtenerVwGrilla()).Returns(expected);

            // Act
            var result = _controller.ObtenerVwGrilla();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<List<VwGrillaDto>>>(okResult.Value);
            Assert.Equal(expected, response.Result);
        }

        [Fact]
        public void ObtenerVwFiltro_ReturnsOk_WithData()
        {
            var expected = new List<VwFiltroDto> { new VwFiltroDto() };
            _serviceMock.Setup(s => s.ObtenerVwFiltro()).Returns(expected);

            var result = _controller.ObtenerVwFiltro();

            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<List<VwFiltroDto>>>(okResult.Value);
            Assert.Equal(expected, response.Result);
        }

        [Fact]
        public void ObtenerFiltroDetalles_ReturnsOk_WithData()
        {
            var codigo = "test";
            var expected = new List<vwFiltroDetalleDto> { new vwFiltroDetalleDto() };
            _serviceMock.Setup(s => s.ObtenerFiltroDetalles(codigo)).Returns(expected);

            var result = _controller.ObtenerFiltroDetalles(codigo);

            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<List<vwFiltroDetalleDto>>>(okResult.Value);
            Assert.Equal(expected, response.Result);
        }

        [Fact]
        public void ObtenerVwDimension_ReturnsOk_WithData()
        {
            var expected = new List<VwDimensionDto> { new VwDimensionDto() };
            _serviceMock.Setup(s => s.ObtenerVwDimension()).Returns(expected);

            var result = _controller.ObtenerVwDimension();

            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<List<VwDimensionDto>>>(okResult.Value);
            Assert.Equal(expected, response.Result);
        }

        [Fact]
        public void ObtenerGrupos_ReturnsOk_WithData()
        {
            var expected = new List<VwHomologacionGrupoDto> { new VwHomologacionGrupoDto() };
            _serviceMock.Setup(s => s.ObtenerVwHomologacionGrupo()).Returns(expected);

            var result = _controller.ObtenerGrupos();

            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<List<VwHomologacionGrupoDto>>>(okResult.Value);
            Assert.Equal(expected, response.Result);
        }

        [Fact]
        public void ObtenerFiltrosAnidados_ReturnsOk_WithData()
        {
            var filtros = new List<FiltrosBusquedaSeleccionDto> { new FiltrosBusquedaSeleccionDto() };
            var expected = new Dictionary<string, List<vw_FiltrosAnidadosDto>>();
            _serviceMock.Setup(s => s.ObtenerFiltrosAnidados(filtros)).Returns(expected);

            var result = _controller.ObtenerFiltrosAnidados(filtros);

            var okResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expected, okResult.Value);
        }

        [Fact]
        public void ObtenerFiltrosAnidadosAll_ReturnsOk_WithData()
        {
            var expected = new List<vw_FiltrosAnidadosDto>();
            _serviceMock.Setup(s => s.ObtenerFiltrosAnidadosAll()).Returns(expected);

            var result = _controller.ObtenerFiltrosAnidadosAll();

            var okResult = Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expected, okResult.Value);
        }
    }
}
