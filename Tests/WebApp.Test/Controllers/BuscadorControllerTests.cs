using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using SharedApp.Dtos;
using SharedApp.Response;
using SharedApp.TestDataFake;
using WebApp.Controllers;

namespace WebApp.Test.Controllers;
public class BuscadorControllerTests
{
    private readonly Mock<IBuscadorService> _buscadorServiceMock;
    private readonly Mock<ILogger<BuscadorController>> _loggerMock;
    private readonly Mock<IUtilitiesService> _utilitiesService;
    private readonly BuscadorController _controller;

    public BuscadorControllerTests()
    {
        _buscadorServiceMock = new Mock<IBuscadorService>();
        _loggerMock = new Mock<ILogger<BuscadorController>>();
        _utilitiesService = new Mock<IUtilitiesService>();
        _controller = new BuscadorController(_buscadorServiceMock.Object, _loggerMock.Object, _utilitiesService.Object);
    }

    [Fact]
    public void PsBuscarPalabra_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        string paramJSON = "{\"term\":\"ejemplo\"}";
        int pageNumber = 1;
        int rowsPerPage = 10;
        var expectedResult = TestDataFakeDto.GetBuscadorDto();

        _buscadorServiceMock.Setup(service => service.PsBuscarPalabra(paramJSON, pageNumber, rowsPerPage))
                            .Returns(expectedResult);

        // Act
        var result = _controller.PsBuscarPalabra(paramJSON, pageNumber, rowsPerPage);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<BuscadorDto>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }

    [Fact]
    public void FnHomologacionEsquemaTodo_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        string vistaFk = "vista1";
        int idOna = 123;
        var expectedResult = TestDataFakeDto.GetListEsquemaDto();
        _buscadorServiceMock.Setup(service => service.FnHomologacionEsquemaTodo(vistaFk, idOna))
                            .Returns(expectedResult);

        // Act
        var result = _controller.FnHomologacionEsquemaTodo(vistaFk, idOna);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<List<EsquemaDto>>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }

    [Fact]
    public void FnHomologacionEsquema_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        int idEsquema = 1;
        var expectedResult = TestDataFakeDto.GetFnEsquemaDto();
        _buscadorServiceMock.Setup(service => service.FnHomologacionEsquema(idEsquema))
                            .Returns(expectedResult);

        // Act
        var result = _controller.FnHomologacionEsquema(idEsquema);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<FnEsquemaDto>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }

    [Fact]
    public void FnEsquemaCabecera_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        int idEsquemadata = 1;
        var expectedResult = new fnEsquemaCabeceraDto();
        _buscadorServiceMock.Setup(service => service.FnEsquemaCabecera(idEsquemadata))
                            .Returns(expectedResult);

        // Act
        var result = _controller.FnEsquemaCabecera(idEsquemadata);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<fnEsquemaCabeceraDto>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }

    [Fact]
    public void FnHomologacionEsquemaDato_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        int idEsquema = 1;
        string vistaFK = "vista1";
        int idOna = 123;
        var expectedResult = new List<FnHomologacionEsquemaDataDto> { new FnHomologacionEsquemaDataDto() };
        _buscadorServiceMock.Setup(service => service.FnHomologacionEsquemaDato(idEsquema, vistaFK, idOna))
                            .Returns(expectedResult);

        // Act
        var result = _controller.FnHomologacionEsquemaDato(idEsquema, vistaFK, idOna);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<List<FnHomologacionEsquemaDataDto>>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }

    [Fact]
    public void FnEsquemaDato_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        int idEsquemaData = 1;
        string textoBuscar = "dato";
        var expectedResult = new List<FnEsquemaDataBuscadoDto> { new FnEsquemaDataBuscadoDto() };
        _buscadorServiceMock.Setup(service => service.FnEsquemaDatoBuscar(idEsquemaData, textoBuscar))
                            .Returns(expectedResult);

        // Act
        var result = _controller.FnEsquemaDato(idEsquemaData, textoBuscar);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<List<FnEsquemaDataBuscadoDto>>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }

    [Fact]
    public void FnPredictWords_ReturnsOkResult_WithExpectedData()
    {
        // Arrange
        string word = "prediccion";
        var expectedResult = new List<FnPredictWordsDto> { new FnPredictWordsDto() };
        _buscadorServiceMock.Setup(service => service.FnPredictWords(word))
                            .Returns(expectedResult);

        // Act
        var result = _controller.FnPredictWords(word);

        // Assert
        var okResult = Assert.IsType<OkObjectResult>(result);
        var apiResponse = Assert.IsType<RespuestasAPI<List<FnPredictWordsDto>>>(okResult.Value);
        Assert.Equal(expectedResult, apiResponse.Result);
    }
}
