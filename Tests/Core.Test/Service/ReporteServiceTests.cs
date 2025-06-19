using AutoMapper;
using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class ReporteServiceTests
    {
        private readonly Mock<IReporteRepository> _reporteRepositoryMock;
        private readonly IMapper _mapper;
        private readonly ReporteService _reporteService;

        public ReporteServiceTests()
        {
            _reporteRepositoryMock = new Mock<IReporteRepository>();

            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<VwHomologacion, VwHomologacionDto>();
                cfg.CreateMap<VwAcreditacionEsquema, VwAcreditacionEsquemaDto>();
                // Agrega los demás mapeos necesarios aquí...
            });
            _mapper = config.CreateMapper();

            _reporteService = new ReporteService(_reporteRepositoryMock.Object, _mapper);
        }

        [Fact]
        public void FindByVista_ReturnsMappedDto_WhenVistaExists()
        {
            // Arrange
            string codigo = "ABC123";
            var vista = new VwHomologacion
            {
                CodigoHomologacion = codigo,
            };

            _reporteRepositoryMock.Setup(repo => repo.findByVista(codigo)).Returns(vista);

            // Act
            var result = _reporteService.findByVista(codigo);

            // Assert
            Assert.NotNull(result);
            Assert.IsType<VwHomologacionDto>(result);
            Assert.Equal(codigo, result.CodigoHomologacion);
        }

        [Fact]
        public void ObtenerVwAcreditacionEsquema_ReturnsMappedList()
        {
            // Arrange
            var esquemas = new List<VwAcreditacionEsquema>
            {
                new VwAcreditacionEsquema { Esquema = "ISO9001" },
                new VwAcreditacionEsquema { Esquema = "ISO27001" }
            };

            _reporteRepositoryMock.Setup(repo => repo.ObtenerVwAcreditacionEsquema()).Returns(esquemas);

            // Act
            var result = _reporteService.ObtenerVwAcreditacionEsquema();

            // Assert
            Assert.NotNull(result);
            Assert.Equal(2, result.Count);
            Assert.Contains(result, r => r.Esquema == "ISO9001");
            Assert.Contains(result, r => r.Esquema == "ISO27001");
        }
    }
}
