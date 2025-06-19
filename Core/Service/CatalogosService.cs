using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Service
{
     public class CatalogosService : ICatalogosService
    {
        private readonly ICatalogosRepository _catalogosRepository;
        private readonly IMapper mapper;

        public CatalogosService(ICatalogosRepository catalogosRepository, IMapper mapper)
        {
            this._catalogosRepository = catalogosRepository;
            this.mapper = mapper;
        }
        private string ObtenerValorPorClave(vw_FiltrosAnidadosDto item, string clave)
        {
            return clave switch
            {
                "KEY_FIL_ONA" => item.KEY_FIL_ONA,
                "KEY_FIL_PAI" => item.KEY_FIL_PAI,
                "KEY_FIL_EST" => item.KEY_FIL_EST,
                "KEY_FIL_ESQ" => item.KEY_FIL_ESQ,
                "KEY_FIL_NOR" => item.KEY_FIL_NOR,
                "KEY_FIL_REC" => item.KEY_FIL_REC,
                _ => string.Empty
            };
        }
        public VwHomologacionGrupoDto? FindVwHGByCode(string codigoHomologacion)
        {
            VwHomologacionGrupo? vwHomologacionGrupo = _catalogosRepository.FindVwHGByCode(codigoHomologacion);
            return mapper.Map<VwHomologacionGrupoDto>(vwHomologacionGrupo);
        }

        public VwRolDto FindVwRolByHId(int idHomologacionRol)
        {
            VwRol vwRol = _catalogosRepository.FindVwRolByHId(idHomologacionRol);
            return mapper.Map<VwRolDto>(vwRol);
        }

        public List<vwFiltroDetalleDto> ObtenerFiltroDetalles(string codigo)
        {
            List<vwFiltroDetalle> vwFiltros = _catalogosRepository.ObtenerFiltroDetalles(codigo);
            return mapper.Map<List<vwFiltroDetalleDto>>(vwFiltros);
        }

        public Dictionary<string, List<vw_FiltrosAnidadosDto>> ObtenerFiltrosAnidados(List<FiltrosBusquedaSeleccionDto> filtrosSeleccionados)
        {
            List<vw_FiltrosAnidados> vw_FiltrosAnidadosDtos = _catalogosRepository.ObtenerFiltrosAnidados(filtrosSeleccionados);
            List<vw_FiltrosAnidadosDto> resultado = mapper.Map<List<vw_FiltrosAnidadosDto>>(vw_FiltrosAnidadosDtos);

            var dto = new Dictionary<string, List<vw_FiltrosAnidadosDto>>();

            // Agrupamos las opciones por tipo de filtro (KEY_FIL_ONA, KEY_FIL_PAI, etc.)
            foreach (var key in new[] { "KEY_FIL_ONA", "KEY_FIL_PAI", "KEY_FIL_EST", "KEY_FIL_ESQ", "KEY_FIL_NOR", "KEY_FIL_REC" })
            {
                var valores = resultado
                    .Select(r => ObtenerValorPorClave(r, key))
                    .Where(v => !string.IsNullOrWhiteSpace(v))
                    .Distinct()
                    .ToList();

                dto[key] = valores.Select(val => new vw_FiltrosAnidadosDto
                {
                    KEY_FIL_ONA = key == "KEY_FIL_ONA" ? val : null,
                    KEY_FIL_PAI = key == "KEY_FIL_PAI" ? val : null,
                    KEY_FIL_EST = key == "KEY_FIL_EST" ? val : null,
                    KEY_FIL_ESQ = key == "KEY_FIL_ESQ" ? val : null,
                    KEY_FIL_NOR = key == "KEY_FIL_NOR" ? val : null,
                    KEY_FIL_REC = key == "KEY_FIL_REC" ? val : null,
                }).ToList();
            }

            return dto;
        }
        public List<vw_FiltrosAnidadosDto> ObtenerFiltrosAnidadosAll()
        {
           List<vw_FiltrosAnidados> vw_FiltrosAnidados = _catalogosRepository.ObtenerFiltrosAnidadosAll();
            return mapper.Map<List<vw_FiltrosAnidadosDto>>(vw_FiltrosAnidados);
        }

        public List<HomologacionDto> ObtenerGrupos()
        {
            List<Homologacion> homologaciones = _catalogosRepository.ObtenerGrupos();
            return mapper.Map<List<HomologacionDto>>(homologaciones);
        }

        public List<OnaDto> ObtenerOna()
        {
           List<ONA> oNAs = _catalogosRepository.ObtenerOna();
            return mapper.Map<List<OnaDto>>(oNAs);
        }

        public List<VwDimensionDto> ObtenerVwDimension()
        {
           List<VwDimension> vwDimensions = _catalogosRepository.ObtenerVwDimension();
            return mapper.Map<List<VwDimensionDto>>(vwDimensions);
        }

        public List<vwEsquemaOrganizaDto> ObtenervwEsquemaOrganiza()
        {
            List<vwEsquemaOrganiza> vwEsquemaOrganizaDtos = _catalogosRepository.ObtenervwEsquemaOrganiza();
            return mapper.Map<List<vwEsquemaOrganizaDto>>(vwEsquemaOrganizaDtos);
        }

        public List<VwFiltroDto> ObtenerVwFiltro()
        {
           List<VwFiltro> vwFiltros = _catalogosRepository.ObtenerVwFiltro();
            return mapper.Map<List<VwFiltroDto>>(vwFiltros);
        }

        public List<VwGrillaDto> ObtenerVwGrilla()
        {
            List<VwGrilla> vwGrillas = _catalogosRepository.ObtenerVwGrilla();
            return mapper.Map<List<VwGrillaDto>>(vwGrillas);
        }

        public List<VwHomologacionGrupoDto> ObtenerVwHomologacionGrupo()
        {
           List<VwHomologacionGrupo> vwHomologacionGrupoDtos = _catalogosRepository.ObtenerVwHomologacionGrupo();
            return mapper.Map<List<VwHomologacionGrupoDto>>(vwHomologacionGrupoDtos);
        }

        public List<VwMenuDto> ObtenerVwMenu()
        {
           List<VwMenu> vwMenus = _catalogosRepository.ObtenerVwMenu();
            return mapper.Map<List<VwMenuDto>>(vwMenus);
        }

        public List<vwONADto> ObtenervwOna()
        {
            List<vwONA> vwONAs = _catalogosRepository.ObtenervwOna();
            return mapper.Map<List<vwONADto>>(vwONAs);
        }

        public List<vwPanelONADto> ObtenerVwPanelOna()
        {
           List<vwPanelONA> vwPanelONAs = _catalogosRepository.ObtenerVwPanelOna();
            return mapper.Map<List<vwPanelONADto>>(vwPanelONAs);
        }

        public List<VwRolDto> ObtenerVwRol()
        {
            List<VwRol> vwRols = _catalogosRepository.ObtenerVwRol();
            return mapper.Map<List<VwRolDto>>(vwRols);
        }
    }
}
