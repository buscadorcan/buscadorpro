using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Service
{
    public class ReporteService : IReporteService
    {
        private readonly IReporteRepository reporteRepository;
        private readonly IMapper mapper;
        public ReporteService(IReporteRepository reporteRepository, IMapper mapper)
        {
            this.reporteRepository = reporteRepository;
            this.mapper = mapper;
        }
        public VwHomologacionDto findByVista(string codigoHomologacion)
        {
            VwHomologacion vwHomologacion = reporteRepository.findByVista(codigoHomologacion);
            return mapper.Map<VwHomologacionDto>(vwHomologacion);
        }

        public List<VwAcreditacionEsquemaDto> ObtenerVwAcreditacionEsquema()
        {
            List<VwAcreditacionEsquema> vwAcreditacionEsquemas = reporteRepository.ObtenerVwAcreditacionEsquema();
            return mapper.Map<List<VwAcreditacionEsquemaDto>>(vwAcreditacionEsquemas);
        }

        public List<VwAcreditacionOnaDto> ObtenerVwAcreditacionOna()
        {
            List<VwAcreditacionOna> vwAcreditacionOnas = reporteRepository.ObtenerVwAcreditacionOna();
            return mapper.Map<List<VwAcreditacionOnaDto>>(vwAcreditacionOnas);
        }

        public List<VwActualizacionONADto> ObtenerVwActualizacionONA()
        {
            List<VwActualizacionONA> vwActualizacionONAs = reporteRepository.ObtenerVwActualizacionONA();
            return mapper.Map<List<VwActualizacionONADto>>(vwActualizacionONAs);
        }

        public List<VwBusquedaFechaDto> ObtenerVwBusquedaFecha()
        {
            List<VwBusquedaFecha> vwBusquedaFechas = reporteRepository.ObtenerVwBusquedaFecha();
            return mapper.Map<List<VwBusquedaFechaDto>>(vwBusquedaFechas);
        }

        public List<VwBusquedaFiltroDto> ObtenerVwBusquedaFiltro()
        {
            List<VwBusquedaFiltro> vwBusquedaFiltros = reporteRepository.ObtenerVwBusquedaFiltro();
            return mapper.Map<List<VwBusquedaFiltroDto>>(vwBusquedaFiltros);
        }

        public List<VwBusquedaUbicacionDto> ObtenerVwBusquedaUbicacion()
        {
            List<VwBusquedaUbicacion> vwBusquedaUbicacions = reporteRepository.ObtenerVwBusquedaUbicacion();
            return mapper.Map<List<VwBusquedaUbicacionDto>>(vwBusquedaUbicacions);
        }

        public List<VwCalificaUbicacionDto> ObtenerVwCalificaUbicacion()
        {
            List<VwCalificaUbicacion> vwCalificaUbicacions = reporteRepository.ObtenerVwCalificaUbicacion();
            return mapper.Map<List<VwCalificaUbicacionDto>>(vwCalificaUbicacions);
        }

        public List<VwEsquemaPaisDto> ObtenerVwEsquemaPais()
        {
            List<VwEsquemaPais> vwEsquemaPais = reporteRepository.ObtenerVwEsquemaPais();
            return mapper.Map<List<VwEsquemaPaisDto>>(vwEsquemaPais);
        }

        public List<VwEstadoEsquemaDto> ObtenerVwEstadoEsquema()
        {
            List<VwEstadoEsquema> vwEstadoEsquemas = reporteRepository.ObtenerVwEstadoEsquema();
            return mapper.Map<List<VwEstadoEsquemaDto>>(vwEstadoEsquemas);
        }

        public List<VwOecFechaDto> ObtenerVwOecFecha()
        {
            List<VwOecFecha> vwOecFechas = reporteRepository.ObtenerVwOecFecha();
            return mapper.Map<List<VwOecFechaDto>>(vwOecFechas);
        }

        public List<VwOecPaisDto> ObtenerVwOecPais()
        {
            List<VwOecPais>vwOecPais = reporteRepository.ObtenerVwOecPais();
            return mapper.Map<List<VwOecPaisDto>>(vwOecPais);
        }

        public List<VwOrganismoActividadDto> ObtenerVwOrganismoActividad()
        {
            List<VwOrganismoActividad> vwOrganismoActividads = reporteRepository.ObtenerVwOrganismoActividad();
            return mapper.Map<List<VwOrganismoActividadDto>>(vwOrganismoActividads);
        }

        public List<VwOrganismoRegistradoDto> ObtenerVwOrganismoRegistrado()
        {
            List<VwOrganismoRegistrado> vwOrganismoRegistrados = reporteRepository.ObtenerVwOrganismoRegistrado();
            return mapper.Map<List<VwOrganismoRegistradoDto>>(vwOrganismoRegistrados);
        }

        public List<VwOrganizacionEsquemaDto> ObtenerVwOrganizacionEsquema()
        {
            List<VwOrganizacionEsquema> vwOrganizacionEsquemas = reporteRepository.ObtenerVwOrganizacionEsquema();
            return mapper.Map<List<VwOrganizacionEsquemaDto>>(vwOrganizacionEsquemas);
        }

        public List<VwProfesionalCalificadoDto> ObtenerVwProfesionalCalificado()
        {
            List<VwProfesionalCalificado> vwProfesionalCalificados = reporteRepository.ObtenerVwProfesionalCalificado();
            return mapper.Map<List<VwProfesionalCalificadoDto>>(vwProfesionalCalificados);
        }

        public List<VwProfesionalEsquemaDto> ObtenerVwProfesionalEsquema()
        {
            List<VwProfesionalEsquema>  vwProfesionalEsquemas = reporteRepository.ObtenerVwProfesionalEsquema();
            return mapper.Map<List<VwProfesionalEsquemaDto>>(vwProfesionalEsquemas);
        }

        public List<VwProfesionalFechaDto> ObtenerVwProfesionalFecha()
        {
            List<VwProfesionalFecha> vwProfesionalFechas = reporteRepository.ObtenerVwProfesionalFecha();
            return mapper.Map<List<VwProfesionalFechaDto>>(vwProfesionalFechas);
        }

        public List<VwProfesionalOnaDto> ObtenerVwProfesionalOna()
        {
            List<VwProfesionalOna> vwProfesionalOnas = reporteRepository.ObtenerVwProfesionalOna();
            return mapper.Map<List<VwProfesionalOnaDto>>(vwProfesionalOnas);
        }
    }
}
