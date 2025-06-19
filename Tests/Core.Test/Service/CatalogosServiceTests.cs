using AutoMapper;
using Core.Service;
using DataAccess.Interfaces;
using DataAccess.Models;
using Moq;
using SharedApp.Dtos;
using System.Collections;

namespace Core.Test.Service
{
    public class CatalogosServiceTests
    {
        private readonly CatalogosService _service;
        private readonly Mock<ICatalogosRepository> _repositoryMock;
        private readonly Mock<IMapper> _mapperMock;

        public CatalogosServiceTests()
        {
            _repositoryMock = new Mock<ICatalogosRepository>();
            _mapperMock = new Mock<IMapper>();
            _service = new CatalogosService(_repositoryMock.Object, _mapperMock.Object);
        }

        [Fact]
        public void FindVwHGByCode_ReturnsMappedDto()
        {
            var entity = new VwHomologacionGrupo();
            var dto = new VwHomologacionGrupoDto();

            _repositoryMock.Setup(r => r.FindVwHGByCode("code")).Returns(entity);
            _mapperMock.Setup(m => m.Map<VwHomologacionGrupoDto>(entity)).Returns(dto);

            var result = _service.FindVwHGByCode("code");

            Assert.Equal(dto, result);
        }

        [Fact]
        public void FindVwRolByHId_ReturnsMappedDto()
        {
            var entity = new VwRol();
            var dto = new VwRolDto();

            _repositoryMock.Setup(r => r.FindVwRolByHId(1)).Returns(entity);
            _mapperMock.Setup(m => m.Map<VwRolDto>(entity)).Returns(dto);

            var result = _service.FindVwRolByHId(1);

            Assert.Equal(dto, result);
        }

        [Fact]
        public void ObtenerFiltroDetalles_ReturnsMappedList()
        {
            var entities = new List<vwFiltroDetalle> { new vwFiltroDetalle() };
            var dtos = new List<vwFiltroDetalleDto> { new vwFiltroDetalleDto() };

            _repositoryMock.Setup(r => r.ObtenerFiltroDetalles("code")).Returns(entities);
            _mapperMock.Setup(m => m.Map<List<vwFiltroDetalleDto>>(entities)).Returns(dtos);

            var result = _service.ObtenerFiltroDetalles("code");

            Assert.Equal(dtos, result);
        }

        [Fact]
        public void ObtenerFiltrosAnidados_ReturnsGroupedDictionary()
        {
            var filters = new List<FiltrosBusquedaSeleccionDto>();
            var entities = new List<vw_FiltrosAnidados> { new vw_FiltrosAnidados { KEY_FIL_ONA = "ONA1" } };
            var dtos = new List<vw_FiltrosAnidadosDto> { new vw_FiltrosAnidadosDto { KEY_FIL_ONA = "ONA1" } };

            _repositoryMock.Setup(r => r.ObtenerFiltrosAnidados(filters)).Returns(entities);
            _mapperMock.Setup(m => m.Map<List<vw_FiltrosAnidadosDto>>(entities)).Returns(dtos);

            var result = _service.ObtenerFiltrosAnidados(filters);

            Assert.Contains("KEY_FIL_ONA", result.Keys);
            Assert.Contains(result["KEY_FIL_ONA"], x => x.KEY_FIL_ONA == "ONA1");
        }

        [Fact]
        public void ObtenerFiltrosAnidadosAll_ReturnsMappedList()
        {
            var entities = new List<vw_FiltrosAnidados> { new vw_FiltrosAnidados() };
            var dtos = new List<vw_FiltrosAnidadosDto> { new vw_FiltrosAnidadosDto() };

            _repositoryMock.Setup(r => r.ObtenerFiltrosAnidadosAll()).Returns(entities);
            _mapperMock.Setup(m => m.Map<List<vw_FiltrosAnidadosDto>>(entities)).Returns(dtos);

            var result = _service.ObtenerFiltrosAnidadosAll();

            Assert.Equal(dtos, result);
        }

        [Theory]
        [InlineData("KEY_FIL_ONA")]
        [InlineData("KEY_FIL_PAI")]
        [InlineData("KEY_FIL_EST")]
        [InlineData("KEY_FIL_ESQ")]
        [InlineData("KEY_FIL_NOR")]
        [InlineData("KEY_FIL_REC")]
        public void ObtenerValorPorClave_ReturnsCorrectValue(string key)
        {
            var dto = new vw_FiltrosAnidadosDto
            {
                KEY_FIL_ONA = "ONA",
                KEY_FIL_PAI = "PAI",
                KEY_FIL_EST = "EST",
                KEY_FIL_ESQ = "ESQ",
                KEY_FIL_NOR = "NOR",
                KEY_FIL_REC = "REC"
            };

            var method = typeof(CatalogosService).GetMethod("ObtenerValorPorClave", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
            var value = method.Invoke(_service, new object[] { dto, key });

            Assert.False(string.IsNullOrWhiteSpace((string)value));
        }

        [Theory]
        [InlineData("ObtenerGrupos", typeof(Homologacion), typeof(HomologacionDto))]
        [InlineData("ObtenerOna", typeof(ONA), typeof(OnaDto))]
        [InlineData("ObtenerVwDimension", typeof(VwDimension), typeof(VwDimensionDto))]
        [InlineData("ObtenervwEsquemaOrganiza", typeof(vwEsquemaOrganiza), typeof(vwEsquemaOrganizaDto))]
        [InlineData("ObtenerVwFiltro", typeof(VwFiltro), typeof(VwFiltroDto))]
        [InlineData("ObtenerVwGrilla", typeof(VwGrilla), typeof(VwGrillaDto))]
        [InlineData("ObtenerVwHomologacionGrupo", typeof(VwHomologacionGrupo), typeof(VwHomologacionGrupoDto))]
        [InlineData("ObtenerVwMenu", typeof(VwMenu), typeof(VwMenuDto))]
        [InlineData("ObtenervwOna", typeof(vwONA), typeof(vwONADto))]
        [InlineData("ObtenerVwPanelOna", typeof(vwPanelONA), typeof(vwPanelONADto))]
        [InlineData("ObtenerVwRol", typeof(VwRol), typeof(VwRolDto))]
        public void ObtenerMethods_ReturnsMappedList(string methodName, System.Type entityType, System.Type dtoType)
        {
            // Crear listas genéricas
            var entityListType = typeof(List<>).MakeGenericType(entityType);
            var dtoListType = typeof(List<>).MakeGenericType(dtoType);

            var entityList = (IList)Activator.CreateInstance(entityListType)!;
            entityList.Add(Activator.CreateInstance(entityType)!);

            var dtoList = (IList)Activator.CreateInstance(dtoListType)!;
            dtoList.Add(Activator.CreateInstance(dtoType)!);

            // Setup manual por nombre de método
            switch (methodName)
            {
                case "ObtenerGrupos":
                    _repositoryMock.Setup(r => r.ObtenerGrupos()).Returns((List<Homologacion>)entityList);
                    _mapperMock.Setup(m => m.Map<List<HomologacionDto>>(It.IsAny<List<Homologacion>>())).Returns((List<HomologacionDto>)dtoList);
                    break;

                case "ObtenerOna":
                    _repositoryMock.Setup(r => r.ObtenerOna()).Returns((List<ONA>)entityList);
                    _mapperMock.Setup(m => m.Map<List<OnaDto>>(It.IsAny<List<ONA>>())).Returns((List<OnaDto>)dtoList);
                    break;

                case "ObtenerVwDimension":
                    _repositoryMock.Setup(r => r.ObtenerVwDimension()).Returns((List<VwDimension>)entityList);
                    _mapperMock.Setup(m => m.Map<List<VwDimensionDto>>(It.IsAny<List<VwDimension>>())).Returns((List<VwDimensionDto>)dtoList);
                    break;

                case "ObtenervwEsquemaOrganiza":
                    _repositoryMock.Setup(r => r.ObtenervwEsquemaOrganiza()).Returns((List<vwEsquemaOrganiza>)entityList);
                    _mapperMock.Setup(m => m.Map<List<vwEsquemaOrganizaDto>>(It.IsAny<List<vwEsquemaOrganiza>>())).Returns((List<vwEsquemaOrganizaDto>)dtoList);
                    break;

                case "ObtenerVwFiltro":
                    _repositoryMock.Setup(r => r.ObtenerVwFiltro()).Returns((List<VwFiltro>)entityList);
                    _mapperMock.Setup(m => m.Map<List<VwFiltroDto>>(It.IsAny<List<VwFiltro>>())).Returns((List<VwFiltroDto>)dtoList);
                    break;

                case "ObtenerVwGrilla":
                    _repositoryMock.Setup(r => r.ObtenerVwGrilla()).Returns((List<VwGrilla>)entityList);
                    _mapperMock.Setup(m => m.Map<List<VwGrillaDto>>(It.IsAny<List<VwGrilla>>())).Returns((List<VwGrillaDto>)dtoList);
                    break;

                case "ObtenerVwHomologacionGrupo":
                    _repositoryMock.Setup(r => r.ObtenerVwHomologacionGrupo()).Returns((List<VwHomologacionGrupo>)entityList);
                    _mapperMock.Setup(m => m.Map<List<VwHomologacionGrupoDto>>(It.IsAny<List<VwHomologacionGrupo>>())).Returns((List<VwHomologacionGrupoDto>)dtoList);
                    break;

                case "ObtenerVwMenu":
                    _repositoryMock.Setup(r => r.ObtenerVwMenu()).Returns((List<VwMenu>)entityList);
                    _mapperMock.Setup(m => m.Map<List<VwMenuDto>>(It.IsAny<List<VwMenu>>())).Returns((List<VwMenuDto>)dtoList);
                    break;

                case "ObtenervwOna":
                    _repositoryMock.Setup(r => r.ObtenervwOna()).Returns((List<vwONA>)entityList);
                    _mapperMock.Setup(m => m.Map<List<vwONADto>>(It.IsAny<List<vwONA>>())).Returns((List<vwONADto>)dtoList);
                    break;

                case "ObtenerVwPanelOna":
                    _repositoryMock.Setup(r => r.ObtenerVwPanelOna()).Returns((List<vwPanelONA>)entityList);
                    _mapperMock.Setup(m => m.Map<List<vwPanelONADto>>(It.IsAny<List<vwPanelONA>>())).Returns((List<vwPanelONADto>)dtoList);
                    break;

                case "ObtenerVwRol":
                    _repositoryMock.Setup(r => r.ObtenerVwRol()).Returns((List<VwRol>)entityList);
                    _mapperMock.Setup(m => m.Map<List<VwRolDto>>(It.IsAny<List<VwRol>>())).Returns((List<VwRolDto>)dtoList);
                    break;

                default:
                    throw new NotImplementedException($"No se implementó el caso para {methodName}");
            }

            // Invocar método del servicio por reflexión
            var result = typeof(CatalogosService).GetMethod(methodName)!.Invoke(_service, null);

            // Verificar que el resultado es igual a dtoList
            Assert.Equal(dtoList, result);
        }
    }
}
