using AutoMapper;
using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class ThesaurusServiceTests
    {
        private readonly Mock<IThesaurusRepository> _thesaurusRepoMock;
        private readonly Mock<IMapper> _mapperMock;
        private readonly ThesaurusService _service;

        public ThesaurusServiceTests()
        {
            _thesaurusRepoMock = new Mock<IThesaurusRepository>();
            _mapperMock = new Mock<IMapper>();
            _service = new ThesaurusService(_thesaurusRepoMock.Object, _mapperMock.Object);
        }

        [Fact]
        public void ObtenerThesaurus_ShouldReturnDto()
        {
            // Arrange
            var thesaurus = new Thesaurus();
            var thesaurusDto = new ThesaurusDto();

            _thesaurusRepoMock.Setup(r => r.ObtenerThesaurus()).Returns(thesaurus);
            _mapperMock.Setup(m => m.Map<ThesaurusDto>(thesaurus)).Returns(thesaurusDto);

            // Act
            var result = _service.ObtenerThesaurus();

            // Assert
            Assert.NotNull(result);
            Assert.Equal(thesaurusDto, result);
        }

        [Fact]
        public void AgregarExpansion_ShouldAddNewExpansionAndReturnOk()
        {
            // Arrange
            var thesaurus = new Thesaurus { Expansions = new List<Expansion>() };
            var sinonimos = new List<string> { "a", "b" };

            _thesaurusRepoMock.Setup(r => r.ObtenerThesaurus()).Returns(thesaurus);

            // Act
            var result = _service.AgregarExpansion(sinonimos);

            // Assert
            Assert.Equal("ok", result);
            Assert.Single(thesaurus.Expansions);
            Assert.Equal(sinonimos, thesaurus.Expansions.First().Substitutes);
            _thesaurusRepoMock.Verify(r => r.GuardarThesaurus(thesaurus), Times.Once);
        }

        [Fact]
        public void AgregarSubAExpansion_ShouldAddSynonymToExistingExpansion()
        {
            // Arrange
            var expansion = new Expansion { Substitutes = new List<string> { "existente" } };
            var thesaurus = new Thesaurus { Expansions = new List<Expansion> { expansion } };

            _thesaurusRepoMock.Setup(r => r.ObtenerThesaurus()).Returns(thesaurus);

            // Act
            var result = _service.AgregarSubAExpansion("existente", "nuevo");

            // Assert
            Assert.Equal("ok", result);
            Assert.Contains("nuevo", expansion.Substitutes);
            _thesaurusRepoMock.Verify(r => r.GuardarThesaurus(thesaurus), Times.Once);
        }

        [Fact]
        public void AgregarSubAExpansion_ShouldReturnErrorMessage_WhenExpansionNotFound()
        {
            // Arrange
            var thesaurus = new Thesaurus { Expansions = new List<Expansion>() };
            _thesaurusRepoMock.Setup(r => r.ObtenerThesaurus()).Returns(thesaurus);

            // Act
            var result = _service.AgregarSubAExpansion("inexistente", "nuevo");

            // Assert
            Assert.Equal("No se encontró la expansión especificada.", result);
            _thesaurusRepoMock.Verify(r => r.GuardarThesaurus(It.IsAny<Thesaurus>()), Times.Never);
        }

        [Fact]
        public void ActualizarExpansion_ShouldReplaceAllExpansions()
        {
            // Arrange
            var thesaurus = new Thesaurus { Expansions = new List<Expansion> { new Expansion { Substitutes = new List<string> { "x" } } } };
            var expansionsDto = new List<ExpansionDto>
            {
                new ExpansionDto { Substitutes = new List<string> { "a", "b" } },
                new ExpansionDto { Substitutes = new List<string> { "c", "d" } }
            };

            _thesaurusRepoMock.Setup(r => r.ObtenerThesaurus()).Returns(thesaurus);

            // Act
            var result = _service.ActualizarExpansion(expansionsDto);

            // Assert
            Assert.Equal("ok", result);
            Assert.Equal(2, thesaurus.Expansions.Count);
            _thesaurusRepoMock.Verify(r => r.GuardarThesaurus(thesaurus), Times.Once);
        }

        [Fact]
        public void EjecutarArchivoBat_ShouldCallRepositoryAndReturnOk()
        {
            // Arrange
            _thesaurusRepoMock.Setup(r => r.EjecutarArchivoBat());

            // Act
            var result = _service.EjecutarArchivoBat();

            // Assert
            Assert.Equal("ok", result);
            _thesaurusRepoMock.Verify(r => r.EjecutarArchivoBat(), Times.Once);
        }

        [Fact]
        public void ResetSQLServer_ShouldReturnRepositoryMessage()
        {
            // Arrange
            _thesaurusRepoMock.Setup(r => r.ResetSQLServer()).Returns("reiniciado");

            // Act
            var result = _service.ResetSQLServer();

            // Assert
            Assert.Equal("reiniciado", result);
        }
    }
}
