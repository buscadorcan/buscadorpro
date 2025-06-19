using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using FluentAssertions;
using Moq;

namespace Core.Test.Service
{
    public class EsquemaServiceTests
    {
        private readonly Mock<IEsquemaRepository> _esquemaRepositoryMock;
        private readonly EsquemaService _service;

        public EsquemaServiceTests()
        {
            _esquemaRepositoryMock = new Mock<IEsquemaRepository>();
            _service = new EsquemaService(_esquemaRepositoryMock.Object);
        }

        [Fact]
        public void Create_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var esquema = new Esquema();
            _esquemaRepositoryMock.Setup(r => r.Create(esquema)).Returns(true);

            var result = _service.Create(esquema);

            result.Should().BeTrue();
        }

        [Fact]
        public void CreateEsquemaValidacion_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var esquemaVista = new EsquemaVista();
            _esquemaRepositoryMock.Setup(r => r.CreateEsquemaValidacion(esquemaVista)).Returns(true);

            var result = _service.CreateEsquemaValidacion(esquemaVista);

            result.Should().BeTrue();
        }

        [Fact]
        public void EliminarEsquemaVistaColumnaByIdEquemaVistaAsync_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            int id = 1;
            _esquemaRepositoryMock.Setup(r => r.EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(id)).Returns(true);

            var result = _service.EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(id);

            result.Should().BeTrue();
        }

        [Fact]
        public void FindAll_ShouldReturnListOfEsquema()
        {
            var expected = new List<Esquema> { new Esquema(), new Esquema() };
            _esquemaRepositoryMock.Setup(r => r.FindAll()).Returns(expected);

            var result = _service.FindAll();

            result.Should().BeEquivalentTo(expected);
        }

        [Fact]
        public void FindById_ShouldReturnEsquema_WhenExists()
        {
            var expected = new Esquema { };
            _esquemaRepositoryMock.Setup(r => r.FindById(1)).Returns(expected);

            var result = _service.FindById(1);

            result.Should().Be(expected);
        }

        [Fact]
        public void FindByViewName_ShouldReturnEsquema_WhenExists()
        {
            var expected = new Esquema { };
            _esquemaRepositoryMock.Setup(r => r.FindByViewName("Vista1")).Returns(expected);

            var result = _service.FindByViewName("Vista1");

            result.Should().Be(expected);
        }

        [Fact]
        public async Task FindByViewNameAsync_ShouldReturnEsquema_WhenExists()
        {
            var expected = new Esquema { };
            _esquemaRepositoryMock.Setup(r => r.FindByViewNameAsync("VistaAsync")).ReturnsAsync(expected);

            var result = await _service.FindByViewNameAsync("VistaAsync");

            result.Should().Be(expected);
        }

        [Fact]
        public void GetEsquemaVistaColumnaByIdEquemaVistaAsync_ShouldReturnExpectedResult()
        {
            var expected = new EsquemaVistaColumna();
            _esquemaRepositoryMock.Setup(r => r.GetEsquemaVistaColumnaByIdEquemaVistaAsync(1, 2)).Returns(expected);

            var result = _service.GetEsquemaVistaColumnaByIdEquemaVistaAsync(1, 2);

            result.Should().Be(expected);
        }

        [Fact]
        public void GetListaEsquemaByOna_ShouldReturnList()
        {
            var expected = new List<Esquema> { new Esquema(), new Esquema() };
            _esquemaRepositoryMock.Setup(r => r.GetListaEsquemaByOna(5)).Returns(expected);

            var result = _service.GetListaEsquemaByOna(5);

            result.Should().BeEquivalentTo(expected);
        }

        [Fact]
        public void GuardarListaEsquemaVistaColumna_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var lista = new List<EsquemaVistaColumna> { new EsquemaVistaColumna() };
            _esquemaRepositoryMock.Setup(r => r.GuardarListaEsquemaVistaColumna(lista, 1, 2)).Returns(true);

            var result = _service.GuardarListaEsquemaVistaColumna(lista, 1, 2);

            result.Should().BeTrue();
        }

        [Fact]
        public void Update_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var esquema = new Esquema();
            _esquemaRepositoryMock.Setup(r => r.Update(esquema)).Returns(true);

            var result = _service.Update(esquema);

            result.Should().BeTrue();
        }

        [Fact]
        public void UpdateEsquemaValidacion_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var esquemaVista = new EsquemaVista();
            _esquemaRepositoryMock.Setup(r => r.UpdateEsquemaValidacion(esquemaVista)).Returns(true);

            var result = _service.UpdateEsquemaValidacion(esquemaVista);

            result.Should().BeTrue();
        }
    }
}
