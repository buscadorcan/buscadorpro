/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/ReporteController: Controlador para funcionalidad en reportes
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp.Response;
using SharedApp.Dtos;
using Core.Interfaces;

namespace WebApp.Controllers
{
    [Route(Routes.REPORTES_VISTA)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class ReporteController : BaseController
    {
        private readonly IReporteService _reporteService;
        public ReporteController(IReporteService reporteService, ILogger<ReporteController> logger) : base(logger) 
        {
            this._reporteService = reporteService;
        }

        /// <summary>
        /// findByVista
        /// </summary>
        /// <param name="codigoHomologacion">Código de homologación a buscar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con la homologación correspondiente al código proporcionado.
        /// En caso de que no exista, devuelve un objeto vacío.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.FIND_BY_VISTA)]
        public IActionResult findByVista(string codigoHomologacion)
        {
            try
            {
                var homologacion = _reporteService.findByVista(codigoHomologacion);

                if (homologacion == null)
                {
                    return NotFound(new RespuestasAPI<VwHomologacionDto>
                    {
                        Result = new VwHomologacionDto()
                    });
                }

                var homologacionDto = homologacion;

                return Ok(new RespuestasAPI<VwHomologacionDto>
                {
                    Result = homologacionDto
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(findByVista));
            }
        }

        /// <summary>
        /// ObtenerAcreditacionOna
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de acreditaciones de ONAs disponibles.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ACREDITACION_ONA)]
        public IActionResult ObtenerAcreditacionOna()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwAcreditacionOnaDto>>
                {
                    Result = _reporteService.ObtenerVwAcreditacionOna()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerAcreditacionOna));
            }
        }

        /// <summary>
        /// ObtenerAcreditacionEsquema
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de esquemas acreditados.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ACREDITACION_ESQUEMA)]
        public IActionResult ObtenerAcreditacionEsquema()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwAcreditacionEsquemaDto>>
                {
                    Result = _reporteService.ObtenerVwAcreditacionEsquema()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerAcreditacionEsquema));
            }
        }

        /// <summary>
        /// ObtenerEstadoEsquema
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de estados de los esquemas.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ESTADO_ESQUEMA)]
        public IActionResult ObtenerEstadoEsquema()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwEstadoEsquemaDto>>
                {
                    Result = _reporteService.ObtenerVwEstadoEsquema()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerEstadoEsquema));
            }
        }

        /// <summary>
        /// ObtenerOecPais
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de OECs asociados a cada país.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.OEC_PAIS)]
        public IActionResult ObtenerOecPais()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwOecPaisDto>>
                {
                    Result = _reporteService.ObtenerVwOecPais()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerOecPais));
            }
        }

        /// <summary>
        /// ObtenerEsquemaPais
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de esquemas disponibles en cada país.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ESQUEMA_PAIS)]
        public IActionResult ObtenerEsquemaPais()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwEsquemaPaisDto>>
                {
                    Result = _reporteService.ObtenerVwEsquemaPais()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerEsquemaPais));
            }
        }

        /// <summary>
        /// ObtenerOecFecha
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de OECs filtrados por fecha.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.OEC_FECHA)]
        public IActionResult ObtenerOecFecha()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwOecFechaDto>>
                {
                    Result = _reporteService.ObtenerVwOecFecha()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerOecFecha));
            }
        }


        /// <summary>
        /// ObtenerProfesionalCalificado
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de profesionales calificados.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.PROFESIONAL_CALIFICADO)]
        public IActionResult ObtenerProfesionalCalificado()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwProfesionalCalificadoDto>>
                {
                    Result = _reporteService.ObtenerVwProfesionalCalificado()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerProfesionalCalificado));
            }
        }

        /// <summary>
        /// ObtenerProfesionalOna
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de profesionales en ONAs.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.PROFESIONAL_ONA)]
        public IActionResult ObtenerProfesionalOna()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwProfesionalOnaDto>>
                {
                    Result = _reporteService.ObtenerVwProfesionalOna()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerProfesionalOna));
            }
        }

        /// <summary>
        /// ObtenerProfesionalEsquema
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de profesionales organizados por esquema.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.PROFESIONAL_ESQUEMA)]
        public IActionResult ObtenerProfesionalEsquema()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwProfesionalEsquemaDto>>
                {
                    Result = _reporteService.ObtenerVwProfesionalEsquema()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerProfesionalEsquema));
            }
        }

        /// <summary>
        /// ObtenerProfesionalFecha
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de profesionales filtrados por fecha.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.PROFESIONAL_FECHA)]
        public IActionResult ObtenerProfesionalFecha()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwProfesionalFechaDto>>
                {
                    Result = _reporteService.ObtenerVwProfesionalFecha()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerProfesionalFecha));
            }
        }

        /// <summary>
        /// ObtenerCalificaUbicacion
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de calificaciones organizadas por ubicación.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.CALIFICA_UBICACION)]
        public IActionResult ObtenerCalificaUbicacion()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwCalificaUbicacionDto>>
                {
                    Result = _reporteService.ObtenerVwCalificaUbicacion()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerCalificaUbicacion));
            }
        }

        /// <summary>
        /// ObtenerBusquedaFecha
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de búsquedas filtradas por fecha.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.BUSQUEDA_FECHA)]
        public IActionResult ObtenerBusquedaFecha()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwBusquedaFechaDto>>
                {
                    Result = _reporteService.ObtenerVwBusquedaFecha()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerBusquedaFecha));
            }
        }

        /// <summary>
        /// ObtenerBusquedaFiltro
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de búsquedas filtradas según los criterios aplicados.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.BUSQUEDA_FILTRO)]
        public IActionResult ObtenerBusquedaFiltro()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwBusquedaFiltroDto>>
                {
                    Result = _reporteService.ObtenerVwBusquedaFiltro()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerBusquedaFiltro));
            }
        }

        /// <summary>
        /// ObtenerBusquedaUbicacion
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de búsquedas organizadas por ubicación.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.BUSQUEDA_UBICACION)]
        public IActionResult ObtenerBusquedaUbicacion()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwBusquedaUbicacionDto>>
                {
                    Result = _reporteService.ObtenerVwBusquedaUbicacion()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerBusquedaUbicacion));
            }
        }

        /// <summary>
        /// ObtenerActualizacionONA
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de actualizaciones registradas en los ONAs.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ACTUALIZACION_ONA)]
        public IActionResult ObtenerActualizacionONA()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwActualizacionONADto>>
                {
                    Result = _reporteService.ObtenerVwActualizacionONA()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerActualizacionONA));
            }
        }

        /// <summary>
        /// ObtenerOrganismoRegistrado
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de organismos registrados.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ORGANISMO_REGISTRADO)]
        public IActionResult ObtenerOrganismoRegistrado()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwOrganismoRegistradoDto>>
                {
                    Result = _reporteService.ObtenerVwOrganismoRegistrado()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerOrganismoRegistrado));
            }
        }

        /// <summary>
        /// ObtenerOrganizacionEsquema
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de organizaciones y sus esquemas asociados.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ORGANISMO_ESQUEMA)]
        public IActionResult ObtenerOrganizacionEsquema()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwOrganizacionEsquemaDto>>
                {
                    Result = _reporteService.ObtenerVwOrganizacionEsquema()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerOrganizacionEsquema));
            }
        }

        /// <summary>
        /// ObtenerOrganismoActividad
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de organismos y las actividades que realizan.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ORGANISMO_ACTIVIDAD)]
        public IActionResult ObtenerOrganismoActividad()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwOrganismoActividadDto>>
                {
                    Result = _reporteService.ObtenerVwOrganismoActividad()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerOrganismoActividad));
            }
        }
    }
}
