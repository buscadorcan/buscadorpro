using AutoMapper;
using Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Authorize]
    [Route(Routes.EVENT_TRACKING)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class EventTrackingController : BaseController
    {
        private readonly IEventTrackingService _iEventTrackingService;
        private readonly IMapper _mapper;
        private readonly IIpCoordinatesService _iIpCoordinatesService;
        private readonly IUtilitiesService _utilitiesService;

        public EventTrackingController(IEventTrackingService iEventTrackingService,
                                       IMapper mapper,
                                       IIpCoordinatesService iIpCoordinatesService,
                                       ILogger<BaseController> logger, IUtilitiesService utilitiesService) : base(logger)
        {
            this._iEventTrackingService = iEventTrackingService;
            this._mapper = mapper;
            this._iIpCoordinatesService = iIpCoordinatesService;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// FindById
        /// </summary>
        /// <param name="idHRol">Identificador del rol asociado al menú.</param>
        /// <param name="idHMenu">Identificador del menú.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con un MenuDto correspondiente al registro encontrado.
        /// En caso de que el registro no exista, devuelve un mensaje de error adecuado.
        /// </returns>
        /// 
        [Authorize]
        [HttpGet("{idHRol:int}/{idHMenu:int}")]
        public IActionResult FindById(int idHRol, int idHMenu)
        {
            try
            {
                var record = _iEventTrackingService.FindDataById(idHRol, idHMenu);
                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }
                return Ok(new RespuestasAPI<MenuRolDto>
                {
                    Result = _mapper.Map<MenuRolDto>(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindById));
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        /// 
        [Authorize]
        [HttpGet(Routes.EVENT_USER_ALL)]
        public IActionResult GetEventUserAll()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwEventUserAllDto>>
                {
                    Result = _iEventTrackingService.GetEventUserAll().Select(item => _mapper.Map<VwEventUserAllDto>(item)).ToList()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventUserAll));
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="report"></param>
        /// <param name="fini"></param>
        /// <param name="ffin"></param>
        /// <returns></returns>
        /// 
        [Authorize]
        [HttpGet(Routes.EVENT)]
        public IActionResult GetEventAll([FromQuery] string report, [FromQuery] DateOnly fini, [FromQuery] DateOnly ffin)
        {
            try
            {
                return Ok(new RespuestasAPI<List<EventUserDto>>
                {
                    Result = _iEventTrackingService.GetEventAll(report, fini, ffin).Select(item => _mapper.Map<EventUserDto>(item)).ToList()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventUserAll));
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="fini"></param>
        /// <param name="ffin"></param>
        /// <returns></returns>
        /// 
        [Authorize]
        [HttpDelete(Routes.EVENT_DELETE)]
        public IActionResult DeleteEventAll(DateOnly fini, DateOnly ffin)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    Result = _iEventTrackingService.DeleteEventAll(fini, ffin)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventUserAll));
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="codigoEvento"></param>
        /// <returns></returns>
        /// 
        [Authorize]
        [HttpDelete(Routes.EVENT_DELETE_ID)]
        public IActionResult DeleteEventById(int codigoEvento)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    Result = _iEventTrackingService.DeleteEventById(codigoEvento)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventUserAll));
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        /// 
        [Authorize]
        [HttpGet(Routes.EVENT_SESSION)]
        public IActionResult GetEventSession()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwEventTrackingSessionDto>>
                {
                    Result = _iEventTrackingService.GetEventSession().ToList()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventSession));
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ip"></param>
        /// <returns></returns>
        /// 
        [Authorize]
        [HttpGet(Routes.COORDINATES)]
        public async Task<IActionResult> GetCoordinates(string ip)
        {
            try
            {
                var result = await _iIpCoordinatesService.GetCoordinates(ip);

                if (result == null)
                    return NotFound(new RespuestasAPI<string>
                    {
                        Result = null
                    });

                return Ok(result);
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetCoordinates));
            }
        }

        /// <summary>
        /// consulta las paginas mas visitadas por pais
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpGet(Routes.EVENT_PAG_MAS_VISIT)]
        public IActionResult GetEventPagMasVisit()
        {
            try
            {
                return Ok(new RespuestasAPI<List<PaginasMasVisitadaDto>>
                {
                    Result = _iEventTrackingService.GetEventPagMasVisit().ToList()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventPagMasVisit));
            }
        }

        [Authorize]
        [HttpGet(Routes.EVENT_FILTRO_MAS_USADO)]
        public IActionResult GetEventFiltroMasUsado()
        {
            try
            {
                return Ok(new RespuestasAPI<List<FiltrosMasUsadoDto>>
                {
                    Result = _iEventTrackingService.GetEventFiltroMasUsa().ToList()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetEventFiltroMasUsado));
            }
        }

        [Authorize]
        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcel()
        {
            try
            {
                var data = _iEventTrackingService.GetEventUserAll().Select(item => _mapper.Map<VwEventUserAllDto>(item)).ToList();

                if (data == null || !data.Any())
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });

                var dictData = await _utilitiesService.ExportDocumentAsync(data);

                var url = await _utilitiesService.ExportExcel(dictData);

                return Ok(new { success = true, url });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(GetEventFiltroMasUsado));
            }
        }

        [Authorize]
        [HttpPost(Routes.PDF)]
        public async Task<IActionResult> ExportPdf()
        {
            try
            {
                var data = _iEventTrackingService.GetEventUserAll().Select(item => _mapper.Map<VwEventUserAllDto>(item)).ToList();

                if (data == null || !data.Any())
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });

                var dictData = await _utilitiesService.ExportDocumentAsync(data);

                var url = await _utilitiesService.ExportPdf(dictData);

                return Ok(new { success = true, url });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(GetEventFiltroMasUsado));
        }

        } 
    }
}
