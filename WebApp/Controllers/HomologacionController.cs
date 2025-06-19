/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/HomologacionController: Controlador para funcionalidades de Homologación
using Core;
using Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Route(Routes.HOMOLOGACION)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class HomologacionController : BaseController
    {
        private readonly IHomologacionService _iHomologacionService;
        private readonly IUtilitiesService _utilitiesService;

        public HomologacionController(IHomologacionService iHomologacionService,
                                     ILogger<HomologacionController> logger,
                                     IUtilitiesService utilitiesService) : base(logger)
        {
            this._iHomologacionService = iHomologacionService;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// FindByParent
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de HomologacionDto que representa las homologaciones encontradas.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.FIND_BY_PARENT)]
        public IActionResult FindByParent()
        {
            try
            {
                return Ok(new RespuestasAPI<List<HomologacionDto>>
                {
                    Result = _iHomologacionService.FindByParent()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindByParent));
            }
        }

        /// <summary>
        /// FindById
        /// </summary>
        /// <param name="id">Identificador único de la homologación a buscar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con un HomologacionDto correspondiente al registro encontrado.
        /// En caso de que el registro no exista, devuelve un mensaje de error adecuado.
        /// </returns>
        [Authorize]
        [HttpGet("{id:int}")]
        public IActionResult FindById(int id)
        {
            try
            {
                var record = _iHomologacionService.FindById(id);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                return Ok(new RespuestasAPI<HomologacionDto>
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
        /// <param name="id">Identificador único de la homologación a actualizar.</param>
        /// <param name="dto">Objeto HomologacionDto con la información actualizada.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la actualización fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPut("{id:int}")]
        public IActionResult Update(int id, [FromBody] HomologacionDto dto)
        {
            try
            {
                dto.IdHomologacion = id;
                dto.Estado = Constantes.ESTADO_USUARIO_A;

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iHomologacionService.Update(dto)
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
        /// <param name="dto">Objeto HomologacionDto con la información de la nueva homologación.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la creación fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPost]
        public IActionResult Create([FromBody] HomologacionDto dto)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iHomologacionService.Create(dto)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Create));
            }
        }

        /// <summary>
        /// Create
        /// </summary>
        /// <param name="id">Identificador único de la homologación a desactivar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la operación fue exitosa.
        /// </returns>
        [Authorize]
        [HttpDelete("{id:int}")]
        public IActionResult Deactive(int id)
        {
            try
            {
                var record = _iHomologacionService.FindById(id);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                record.Estado = Constantes.ESTADO_USUARIO_X;

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iHomologacionService.Update(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Deactive));
            }
        }

        /// <summary>
        /// Devuelve el listado páginado de Homologación
        /// </summary>
        /// <param name="codigoHomologacion"></param>
        /// <param name="PageNumber"></param>
        /// <param name="RowsPerPage"></param>
        /// <returns></returns>
        [Authorize]
        [HttpGet(Routes.FIND_BY_CODIGO_HOMOLOGACION)]
        public IActionResult FindByCodigoHomologacion(string codigoHomologacion, int PageNumber, int RowsPerPage)
        {
            try
            {
                return Ok(new RespuestasAPI<ResultadoPaginadoDto<List<VwHomologacionDto>>>
                {
                    Result = _iHomologacionService.ObtenerVwHomologacionPorCodigo(codigoHomologacion, PageNumber, RowsPerPage)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindByCodigoHomologacion));
            }
        }

        /// <summary>
        /// FindByAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de HomologacionDto representando todas las homologaciones.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.FIND_BY_ALL_HOMOLOGACION)]
        public IActionResult FindByAll()
        {
            try
            {
                return Ok(new RespuestasAPI<List<HomologacionDto>>
                {
                    Result = _iHomologacionService.FindByAll()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindByAll));
            }
        }

        [Authorize]
        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcelConCodigo(string codigoHomologacion )
        {
            try
            {

                var data = _iHomologacionService.ObtenerVwHomologacionPorCodigo(codigoHomologacion, 0, 0, true).Data;

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
        public async Task<IActionResult> ExportPdfConCodigo(string codigoHomologacion)
        {
            try
            {
                var data = _iHomologacionService.ObtenerVwHomologacionPorCodigo(codigoHomologacion, 0, 0, true).Data;

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

        [Authorize]
        [HttpPost(Routes.HOMOLOGACION_EXCEL)]
        public async Task<IActionResult> ExportExcelSinCodigo()
        {
            try
            {

                var data = _iHomologacionService.FindByAll();

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
        [HttpPost(Routes.HOMOLOGACION_PDF)]
        public async Task<IActionResult> ExportPdfSinCodigo()
        {
            try
            {
                var data = _iHomologacionService.FindByAll();

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