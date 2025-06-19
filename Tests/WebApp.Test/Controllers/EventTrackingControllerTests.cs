using AutoMapper;
using Core.Interfaces;
using DataAccess.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using SharedApp.Dtos;
using SharedApp.Response;
using WebApp.Controllers;

namespace WebApp.Test.Controllers
{
    public class EventTrackingControllerTests
    {
        private readonly Mock<IEventTrackingService> _mockEventTrackingService = new();
        private readonly Mock<IMapper> _mockMapper = new();
        private readonly Mock<IIpCoordinatesService> _mockIpService = new();
        private readonly Mock<ILogger<BaseController>> _mockLogger = new();
        private readonly Mock<IUtilitiesService> _utilitiesService = new();
        private EventTrackingController CreateController()
        {
            return new EventTrackingController(
                _mockEventTrackingService.Object,
                _mockMapper.Object,
                _mockIpService.Object,
                _mockLogger.Object,
                _utilitiesService.Object
            );
        }

        [Fact]
        public void GetEventUserAll_ReturnsOk_WithExpectedData()
        {
            // Arrange
            var fakeData = new List<VwEventUserAll> { new(), new() };

            _mockEventTrackingService.Setup(s => s.GetEventUserAll())
                                     .Returns(fakeData);

            _mockMapper.Setup(m => m.Map<VwEventUserAllDto>(It.IsAny<object>()))
                       .Returns(new VwEventUserAllDto());

            var controller = CreateController();

            // Act
            var result = controller.GetEventUserAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var response = Assert.IsType<RespuestasAPI<List<VwEventUserAllDto>>>(okResult.Value);
            Assert.NotNull(response.Result);
            Assert.Equal(2, response.Result.Count);
        }
    }
}
