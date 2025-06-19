/// Copyright � SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/LogMigracionController: Controlador para log de migraci�n
using AutoMapper;
using Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Route(Routes.LOG_MIGRACION)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class LogMigracionController : BaseController
    {
        private readonly ILogMigracionService _logMigracionService;
        private readonly IMapper _mapper;

        public LogMigracionController(ILogMigracionService logMigracionService,
            IMapper mapper,
            ILogger<BaseController> logger)
            : base(logger)
        {
            this._logMigracionService = logMigracionService;
            this._mapper = mapper;
        }

        /// <summary>
        /// FindAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de LogMigracionDto representando los registros del log de migraci�n.
        /// En caso de error, maneja la excepci�n y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [HttpGet]
        public IActionResult FindAll(int PageNumber, int RowsPerPage)
        {
            try
            {
                return Ok(new RespuestasAPI<ResultadoPaginadoDto<List<LogMigracionDto>>>
                {
                    Result = _logMigracionService.FindAll(PageNumber, RowsPerPage)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindAll));
            }
        }
    }
}
