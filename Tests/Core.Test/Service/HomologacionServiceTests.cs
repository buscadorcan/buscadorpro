using AutoMapper;
using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;

namespace Core.Test.Service
{
    public class HomologacionServiceTests
    {
        private readonly Mock<IHomologacionRepository> _mockRepository;
        private readonly Mock<IMapper> _mockMapper;
        private readonly HomologacionService _service;

        public HomologacionServiceTests()
        {
            _mockRepository = new Mock<IHomologacionRepository>();
            _mockMapper = new Mock<IMapper>();
            _service = new HomologacionService(_mockRepository.Object, _mockMapper.Object);
        }

        [Fact]
        public void Create_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var dto = new HomologacionDto();
            var entity = new Homologacion();
            _mockMapper.Setup(m => m.Map<Homologacion>(dto)).Returns(entity);
            _mockRepository.Setup(r => r.Create(entity)).Returns(true);

            var result = _service.Create(dto);

            Assert.True(result);
            _mockMapper.Verify(m => m.Map<Homologacion>(dto), Times.Once);
            _mockRepository.Verify(r => r.Create(entity), Times.Once);
        }

        [Fact]
        public void FindByAll_ShouldReturnMappedList()
        {
            var entities = new List<Homologacion> { new Homologacion() };
            var dtos = new List<HomologacionDto> { new HomologacionDto() };
            _mockRepository.Setup(r => r.FindByAll()).Returns(entities);
            _mockMapper.Setup(m => m.Map<List<HomologacionDto>>(entities)).Returns(dtos);

            var result = _service.FindByAll();

            Assert.Equal(dtos, result);
            _mockRepository.Verify(r => r.FindByAll(), Times.Once);
            _mockMapper.Verify(m => m.Map<List<HomologacionDto>>(entities), Times.Once);
        }

        [Fact]
        public void FindById_ShouldReturnMappedDto()
        {
            var entity = new Homologacion();
            var dto = new HomologacionDto();
            int id = 1;

            _mockRepository.Setup(r => r.FindById(id)).Returns(entity);
            _mockMapper.Setup(m => m.Map<HomologacionDto>(entity)).Returns(dto);

            var result = _service.FindById(id);

            Assert.Equal(dto, result);
            _mockRepository.Verify(r => r.FindById(id), Times.Once);
            _mockMapper.Verify(m => m.Map<HomologacionDto>(entity), Times.Once);
        }

        [Fact]
        public void FindByIds_ShouldReturnMappedList()
        {
            int[] ids = { 1, 2 };
            var entities = new List<Homologacion> { new Homologacion() };
            var dtos = new List<HomologacionDto> { new HomologacionDto() };
            _mockRepository.Setup(r => r.FindByIds(ids)).Returns(entities);
            _mockMapper.Setup(m => m.Map<List<HomologacionDto>>(entities)).Returns(dtos);

            var result = _service.FindByIds(ids);

            Assert.Equal(dtos, result);
            _mockRepository.Verify(r => r.FindByIds(ids), Times.Once);
            _mockMapper.Verify(m => m.Map<List<HomologacionDto>>(entities), Times.Once);
        }

        [Fact]
        public void FindByParent_ShouldReturnMappedList()
        {
            var entities = new List<Homologacion> { new Homologacion() };
            var dtos = new List<HomologacionDto> { new HomologacionDto() };
            _mockRepository.Setup(r => r.FindByParent()).Returns(entities);
            _mockMapper.Setup(m => m.Map<List<HomologacionDto>>(entities)).Returns(dtos);

            var result = _service.FindByParent();

            Assert.Equal(dtos, result);
            _mockRepository.Verify(r => r.FindByParent(), Times.Once);
            _mockMapper.Verify(m => m.Map<List<HomologacionDto>>(entities), Times.Once);
        }

        [Fact]
        public void ObtenerVwHomologacionPorCodigo_ShouldReturnMappedList()
        {
            string codigo = "CODE123";
            var entities = new List<VwHomologacion> { new VwHomologacion() };
            var response = (entities, 1);
            var dtos = new ResultadoPaginadoDto<List<VwHomologacionDto>>
            {
                Data = new List<VwHomologacionDto> { new VwHomologacionDto() },
                HasNextPage = false,
                HasPreviousPage = true,
                RowsPerPage = 5,
                PageNumber = 1,
                TotalCount  = 1,
                TotalPages = 1
            };

            _mockRepository.Setup(r => r.ObtenerVwHomologacionPorCodigo(codigo, 1, 5, true)).Returns(response);
            _mockMapper.Setup(m => m.Map<List<VwHomologacionDto>>(entities)).Returns(dtos.Data);

            var result = _service.ObtenerVwHomologacionPorCodigo(codigo, 1, 5);

            Assert.Equal(dtos.Data, result.Data);
            _mockRepository.Verify(r => r.ObtenerVwHomologacionPorCodigo(codigo, 1, 5, true), Times.Once);
            _mockMapper.Verify(m => m.Map<List<VwHomologacionDto>>(entities), Times.Once);
        }

        [Fact]
        public void Update_ShouldReturnTrue_WhenRepositoryReturnsTrue()
        {
            var dto = new HomologacionDto();
            var entity = new Homologacion();
            _mockMapper.Setup(m => m.Map<Homologacion>(dto)).Returns(entity);
            _mockRepository.Setup(r => r.Update(entity)).Returns(true);

            var result = _service.Update(dto);

            Assert.True(result);
            _mockMapper.Verify(m => m.Map<Homologacion>(dto), Times.Once);
            _mockRepository.Verify(r => r.Update(entity), Times.Once);
        }
    }
}
