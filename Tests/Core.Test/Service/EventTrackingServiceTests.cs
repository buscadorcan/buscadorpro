using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class EventTrackingServiceTests
    {
        private readonly Mock<IEventTrackingRepository> _mockRepository;
        private readonly EventTrackingService _service;

        public EventTrackingServiceTests()
        {
            _mockRepository = new Mock<IEventTrackingRepository>();
            _service = new EventTrackingService(_mockRepository.Object);
        }

        [Fact]
        public void Create_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var dto = new paAddEventTrackingDto();
            _mockRepository.Setup(r => r.Create(dto)).Returns(true);

            var result = _service.Create(dto);

            Assert.True(result);
            _mockRepository.Verify(r => r.Create(dto), Times.Once);
        }

        [Fact]
        public void DeleteEventAll_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var fini = new DateOnly(2024, 1, 1);
            var ffin = new DateOnly(2024, 12, 31);
            _mockRepository.Setup(r => r.DeleteEventAll(fini, ffin)).Returns(true);

            var result = _service.DeleteEventAll(fini, ffin);

            Assert.True(result);
            _mockRepository.Verify(r => r.DeleteEventAll(fini, ffin), Times.Once);
        }

        [Fact]
        public void DeleteEventById_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            int id = 1;
            _mockRepository.Setup(r => r.DeleteEventById(id)).Returns(true);

            var result = _service.DeleteEventById(id);

            Assert.True(result);
            _mockRepository.Verify(r => r.DeleteEventById(id), Times.Once);
        }

        [Fact]
        public void FindDataById_ShouldReturnMenu_WhenRepositoryReturnsMenu()
        {
            int idRol = 1, idMenu = 2;
            var expected = new Menus();
            _mockRepository.Setup(r => r.FindDataById(idRol, idMenu)).Returns(expected);

            var result = _service.FindDataById(idRol, idMenu);

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.FindDataById(idRol, idMenu), Times.Once);
        }

        [Fact]
        public void GetCodeByUser_ShouldReturnCode_WhenRepositoryReturnsCode()
        {
            var user = "john";
            var rolCode = "ROL1";
            var menuCode = "MENU1";
            var expected = "CODE123";
            _mockRepository.Setup(r => r.GetCodeByUser(user, rolCode, menuCode)).Returns(expected);

            var result = _service.GetCodeByUser(user, rolCode, menuCode);

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.GetCodeByUser(user, rolCode, menuCode), Times.Once);
        }

        [Fact]
        public void GetEventAll_ShouldReturnList_WhenRepositoryReturnsList()
        {
            string report = "report";
            var fini = new DateOnly(2024, 1, 1);
            var ffin = new DateOnly(2024, 12, 31);
            var expected = new List<EventUser> { new EventUser() };
            _mockRepository.Setup(r => r.GetEventAll(report, fini, ffin)).Returns(expected);

            var result = _service.GetEventAll(report, fini, ffin);

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.GetEventAll(report, fini, ffin), Times.Once);
        }

        [Fact]
        public void GetEventFiltroMasUsa_ShouldReturnList_WhenRepositoryReturnsList()
        {
            var expected = new List<FiltrosMasUsadoDto> { new FiltrosMasUsadoDto() };
            _mockRepository.Setup(r => r.GetEventFiltroMasUsa()).Returns(expected);

            var result = _service.GetEventFiltroMasUsa();

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.GetEventFiltroMasUsa(), Times.Once);
        }

        [Fact]
        public void GetEventPagMasVisit_ShouldReturnList_WhenRepositoryReturnsList()
        {
            var expected = new List<PaginasMasVisitadaDto> { new PaginasMasVisitadaDto() };
            _mockRepository.Setup(r => r.GetEventPagMasVisit()).Returns(expected);

            var result = _service.GetEventPagMasVisit();

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.GetEventPagMasVisit(), Times.Once);
        }

        [Fact]
        public void GetEventSession_ShouldReturnList_WhenRepositoryReturnsList()
        {
            var expected = new List<VwEventTrackingSessionDto> { new VwEventTrackingSessionDto() };
            _mockRepository.Setup(r => r.GetEventSession()).Returns(expected);

            var result = _service.GetEventSession();

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.GetEventSession(), Times.Once);
        }

        [Fact]
        public void GetEventUserAll_ShouldReturnList_WhenRepositoryReturnsList()
        {
            var expected = new List<VwEventUserAll> { new VwEventUserAll() };
            _mockRepository.Setup(r => r.GetEventUserAll()).Returns(expected);

            var result = _service.GetEventUserAll();

            Assert.Equal(expected, result);
            _mockRepository.Verify(r => r.GetEventUserAll(), Times.Once);
        }
    }
}
