/// Copyright � SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/ONAConexionController: Controlador para funcionalidad de Ona conexi�n
using Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Route(Routes.CONEXION)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class ONAConexionController : BaseController
    {
        private readonly IONAConexionService _oNAConexionService;
        private readonly IUtilitiesService _utilitiesService;

        public ONAConexionController(IONAConexionService oNAConexionService, ILogger<ONAConexionController> logger, IUtilitiesService utilitiesService) : base(logger)
        {
            this._oNAConexionService = oNAConexionService;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// FindAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de ONAConexionDto representando las conexiones registradas.
        /// En caso de error, maneja la excepci�n y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [HttpGet]
        public IActionResult FindAll()
        {
            try
            {
                return Ok(new RespuestasAPI<List<ONAConexionDto>>
                {
                    Result = _oNAConexionService.FindAll()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindAll));
            }
        }

        /// <summary>
        /// GetOnaConexionByOnaListAsync
        /// </summary>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de ONAConexionDto representando las conexiones encontradas.
        /// En caso de error, maneja la excepci�n y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.LISTA_ONA)]
        public IActionResult GetOnaConexionByOnaListAsync(int idOna)
        {
            try
            {
                return Ok(new RespuestasAPI<List<ONAConexionDto>>
                {
                    Result = _oNAConexionService.GetONAConexionByOnaListAsync(idOna)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetOnaConexionByOnaListAsync));
            }
        }

        /// <summary>
        /// FindById
        /// </summary>
        /// <param name="id">Identificador �nico de la conexi�n ONA.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con un ONAConexionDto correspondiente al registro encontrado.
        /// En caso de que el registro no exista, devuelve un mensaje de error adecuado.
        /// </returns>
        [Authorize]
        [HttpGet("{id:int}")]
        public IActionResult FindById(int id)
        {
            try
            {
                var record = _oNAConexionService.FindById(id);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                return Ok(new RespuestasAPI<ONAConexionDto>
                {
                    Result = record
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindById));
            }
        }

        /// <summary>
        /// Update
        /// </summary>
        /// <param name="id">Identificador �nico de la conexi�n ONA a actualizar.</param>
        /// <param name="dto">Objeto ONAConexionDto con la informaci�n actualizada.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la actualizaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPut("{id:int}")]
        public IActionResult Update(int id, [FromBody] ONAConexionDto dto)
        {
            try
            {
                dto.IdONA = id;
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _oNAConexionService.Update(dto)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Update));
            }
        }

        [Authorize]
        [HttpPut("cronograma/{id:int}", Name = "updateCronograma")]
        public IActionResult UpdateCronpgrama(int id, [FromBody] OnaConexionCronDto dto)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _oNAConexionService.updateCrono(id, dto)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Update));
            }
        }

        /// <summary>
        /// Create
        /// </summary>
        /// <param name="dto">Objeto ONAConexionDto con la informaci�n de la nueva conexi�n ONA.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la creaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPost]
        public IActionResult Create([FromBody] ONAConexionDto dto)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _oNAConexionService.Create(dto)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Create));
            }
        }

        /// <summary>
        /// Deactive
        /// </summary>
        /// <param name="id">Identificador �nico de la conexi�n ONA a desactivar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la operaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpDelete("{id:int}")]
        public IActionResult Deactive(int id)
        {
            try
            {
                var record = _oNAConexionService.FindById(id);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                record.Estado = Constantes.ESTADO_USUARIO_X;

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _oNAConexionService.Update(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Deactive));
            }
        }

        [Authorize]
        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcel()
        {
            try
            {
                var data = _oNAConexionService.FindAll();

                if (data == null || !data.Any())
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });

                var dictData = await _utilitiesService.ExportDocumentAsync(data);

                var url = await _utilitiesService.ExportExcel(dictData);

                return Ok(new { success = true, url });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(Deactive));
            }
        }

        [Authorize]
        [HttpPost(Routes.PDF)]
        public async Task<IActionResult> ExportPdf()
        {
            try
            {
                var data = _oNAConexionService.FindAll();

                if (data == null || !data.Any())
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });

                var dictData = await _utilitiesService.ExportDocumentAsync(data);

                var url = await _utilitiesService.ExportPdf(dictData);

                return Ok(new { success = true, url });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(Deactive));
            }
        }
    }
}
