using Bogus;
using Core.Interfaces;
using Core.Service;
using DataAccess.Interfaces;
using Microsoft.Extensions.Configuration;
using Moq;
using Moq.Protected;
using SharedApp.Dtos;
using SharedApp.TestDataFake;
using System.Net;
using System.Text.Json;

namespace Core.Test.Service
{
    public class BuscadorServiceTests
    {
        private readonly Mock<IBuscadorRepository> _mockRepo;
        private readonly BuscadorService _service;
        private readonly Mock<IHttpClientFactory> _mockHttpClientFactory;
        private readonly Mock<IConfiguration> _mockConfig;
        private readonly Mock<IUtilitiesService> _mockUtilities;

        public BuscadorServiceTests()
        {
            _mockRepo = new Mock<IBuscadorRepository>();
            _mockConfig = new Mock<IConfiguration>();
            _mockHttpClientFactory = new Mock<IHttpClientFactory>();
            _mockUtilities = new Mock<IUtilitiesService>();

            _mockConfig.Setup(c => c["GoogleOAuth:ApiKeyGoogleMaps"])
           .Returns("FAKE_API_KEY");

            _mockConfig.Setup(c => c["GoogleOAuth:getcode"])
                       .Returns("https://maps.googleapis.com/maps/api/geocode/json?address=");


            _service = new BuscadorService(_mockRepo.Object, _mockConfig.Object, _mockHttpClientFactory.Object, _mockUtilities.Object);
        }

        [Fact]
        public void AddEventTracking_ShouldSerializeIpLocationAndCallRepository()
        {
            // Arrange
            var ipAddress = "::1";
            var trackingDto = new EventTrackingDto();

            _mockRepo.Setup(x => x.AddEventTracking(It.IsAny<EventTrackingDto>())).Returns(1);

            // Act
            var result = _service.AddEventTracking(trackingDto, ipAddress);

            // Assert
            Assert.Equal(1, result);
            Assert.NotNull(trackingDto.UbicacionJson);

            var json = JsonSerializer.Deserialize<JsonElement>(trackingDto.UbicacionJson);
            Assert.Equal("Local", json.GetProperty("Country").GetString());

            _mockRepo.Verify(r => r.AddEventTracking(It.IsAny<EventTrackingDto>()), Times.Once);
        }

        [Fact]
        public void FnPredictWords_ShouldReturnList()
        {
            // Arrange
            var expected = new List<FnPredictWordsDto> { new() { Word = "test" } };
            _mockRepo.Setup(x => x.FnPredictWords("te")).Returns(expected);

            // Act
            var result = _service.FnPredictWords("te");

            // Assert
            Assert.Single(result);
            Assert.Equal("test", result[0].Word);
        }

        [Fact]
        public async void ExportExcel_ShouldReturnNonEmptyByteArray()
        {
            // Arrange
            var sampleParamJson = "{\"filter\":\"test\"}";

            var sampleData = new List<BuscadorResultadoExpor>
            {
                new BuscadorResultadoExpor { }
            };

            var dictData = new List<Dictionary<string, string>>
            {
                new Dictionary<string, string>
                {
                    { "Palabra", "Casa" },
                    { "Significado", "Lugar para vivir" }
                }
            };

            var expectedUrl = "https://localhost/descargas/export_123.xlsx";

            _mockRepo
                .Setup(r => r.PsBuscarPalabraExpor(sampleParamJson))
                .Returns(new BuscadorDtoExpo { Data = sampleData });

            _mockUtilities
                .Setup(s => s.ExportDocumentAsync(sampleData))
                .ReturnsAsync(dictData);

            _mockUtilities
                .Setup(s => s.ExportExcel(dictData))
                .ReturnsAsync(expectedUrl);

            // Act
            var result = await _service.ExportExcel(sampleParamJson);

            // Assert
            Assert.Equal(expectedUrl, result);

            _mockRepo.Verify(r => r.PsBuscarPalabraExpor(sampleParamJson), Times.Once);
            _mockUtilities.Verify(s => s.ExportDocumentAsync(sampleData), Times.Once);
            _mockUtilities.Verify(s => s.ExportExcel(dictData), Times.Once);
        }

        [Fact]
        public async void ExportPdf_ShouldReturnNonEmptyByteArray()
        {
            // Arrange
            var sampleParamJson = "{\"filter\":\"test\"}";

            var sampleData = new List<BuscadorResultadoExpor>
            {
                new BuscadorResultadoExpor { }
            };

            var dictData = new List<Dictionary<string, string>>
            {
                new Dictionary<string, string>
                {
                    { "Palabra", "Casa" },
                    { "Significado", "Lugar para vivir" }
                }
            };

            var expectedUrl = "https://localhost/descargas/export_123.xlsx";

            _mockRepo
                .Setup(r => r.PsBuscarPalabraExpor(sampleParamJson))
                .Returns(new BuscadorDtoExpo { Data = sampleData });

            _mockUtilities
                .Setup(s => s.ExportDocumentAsync(sampleData))
                .ReturnsAsync(dictData);

            _mockUtilities
                .Setup(s => s.ExportPdf(dictData))
                .ReturnsAsync(expectedUrl);

            // Act
            var result = await _service.ExportPdf(sampleParamJson);

            // Assert
            Assert.Equal(expectedUrl, result);

            _mockRepo.Verify(r => r.PsBuscarPalabraExpor(sampleParamJson), Times.Once);
            _mockUtilities.Verify(s => s.ExportDocumentAsync(sampleData), Times.Once);
            _mockUtilities.Verify(s => s.ExportPdf(dictData), Times.Once);
        }

        [Fact]
        public void FnEsquemaCabecera_ShouldReturnDto()
        {
            // Arrange
            var expected = new fnEsquemaCabeceraDto { IdEsquema = 45 };
            _mockRepo.Setup(x => x.FnEsquemaCabecera(1)).Returns(expected);

            // Act
            var result = _service.FnEsquemaCabecera(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(45, result.IdEsquema);
        }

        [Fact]
        public void FnEsquemaDatoBuscar_ShouldReturnDataList()
        {
            // Arrange
            var expected = new List<FnEsquemaDataBuscadoDto> { new() { IdEsquema = 45 } };
            _mockRepo.Setup(x => x.FnEsquemaDatoBuscar(1, "test")).Returns(expected);

            // Act
            var result = _service.FnEsquemaDatoBuscar(1, "test");

            // Assert
            Assert.Single(result);
            Assert.Equal(45, result[0].IdEsquema);
        }

        [Fact]
        public void FnHomologacionEsquema_ShouldReturnDto()
        {
            // Arrange
            var expected = new FnEsquemaDto { IdEsquema = 45 };
            _mockRepo.Setup(x => x.FnHomologacionEsquema(5)).Returns(expected);

            // Act
            var result = _service.FnHomologacionEsquema(5);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(45, result.IdEsquema);
        }

        [Fact]
        public void FnHomologacionEsquemaDato_ShouldReturnList()
        {
            // Arrange
            var expected = new List<FnHomologacionEsquemaDataDto> { new() { IdEsquema = 45 } };
            _mockRepo.Setup(x => x.FnHomologacionEsquemaDato(1, "vista", 99)).Returns(expected);

            // Act
            var result = _service.FnHomologacionEsquemaDato(1, "vista", 99);

            // Assert
            Assert.Single(result);
            Assert.Equal(45, result[0].IdEsquema);
        }

        [Fact]
        public void FnHomologacionEsquemaTodo_ShouldReturnList()
        {
            // Arrange
            var expected = TestDataFakeDto.GetListEsquemaDto(1);
            expected[0].IdEsquema = 45;
            _mockRepo.Setup(x => x.FnHomologacionEsquemaTodo("vista", 55)).Returns(expected);

            // Act
            var result = _service.FnHomologacionEsquemaTodo("vista", 55);

            // Assert
            Assert.Single(result);
            Assert.Equal(45, result[0].IdEsquema);
        }

        [Fact]
        public void PsBuscarPalabra_ShouldReturnDto()
        {
            // Arrange
            var expected = TestDataFakeDto.GetBuscadorDto();
            expected.TotalCount = 3;
            _mockRepo.Setup(x => x.PsBuscarPalabra("{}", 1, 10)).Returns(expected);

            // Act
            var result = _service.PsBuscarPalabra("{}", 1, 10);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(3, result.TotalCount);
        }

        [Fact]
        public void ValidateWords_ShouldReturnTrue()
        {
            // Arrange
            var words = new List<string> { "hola", "test" };
            _mockRepo.Setup(x => x.ValidateWords(words)).Returns(true);

            // Act
            var result = _service.ValidateWords(words);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public async Task GetCoordinates_ShouldReturnMockedJson()
        {
            // Arrange
            var mockResponse = @"{ ""results"": [ { ""geometry"": {} } ] }";

            var handlerMock = new Mock<HttpMessageHandler>();
            handlerMock
                .Protected()
                .Setup<Task<HttpResponseMessage>>(
                    "SendAsync",
                    ItExpr.IsAny<HttpRequestMessage>(),
                    ItExpr.IsAny<CancellationToken>()
                )
                .ReturnsAsync(new HttpResponseMessage
                {
                    StatusCode = HttpStatusCode.OK,
                    Content = new StringContent(mockResponse),
                });

            var httpClient = new HttpClient(handlerMock.Object);

            _mockHttpClientFactory.Setup(f => f.CreateClient(It.IsAny<string>()))
                                  .Returns(httpClient);

            var service = new BuscadorService(
                _mockRepo.Object,
                _mockConfig.Object,
                _mockHttpClientFactory.Object,
                _mockUtilities.Object
            );

            // Act
            var result = await service.GetCoordinates("Bogotá");

            // Assert
            Assert.Contains("results", result);
        }
    }
}
