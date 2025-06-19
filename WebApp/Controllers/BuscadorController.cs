using Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp.Dtos;
using SharedApp.Response;


namespace WebApp.Controllers
{
    /// <summary>
    /// Controlador para las operaciones de búsqueda y utilidades de exportación.
    /// </summary>
    [AllowAnonymous]
    [ApiController]
    [Route(Routes.BUSCADOR)]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class BuscadorController : BaseController
    {
        private readonly IBuscadorService buscadorService;
        private readonly IUtilitiesService _utilitiesService;

        /// <summary>
        /// Injectar el servicio de Buscador y el Logguer
        /// </summary>
        /// <param name="buscadorService"></param>
        /// <param name="logger"></param>
        public BuscadorController(IBuscadorService buscadorService, ILogger<BuscadorController> logger, IUtilitiesService utilitiesService) : base(logger)
        {
            this.buscadorService = buscadorService;
            this._utilitiesService = utilitiesService;
        }

        // ---------------------------- MÉTODOS ----------------------------

        [HttpGet(Routes.SEARCH_PHRASE)]
        public IActionResult PsBuscarPalabra(string paramJSON, int PageNumber, int RowsPerPage)
        {
            try
            {
                return Ok(new RespuestasAPI<BuscadorDto>
                {
                    Result = buscadorService.PsBuscarPalabra(paramJSON, PageNumber, RowsPerPage)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(PsBuscarPalabra));
            }
        }

        [HttpGet(Routes.HOMOLOGACION_ESQUEMA_TODO)]
        public IActionResult FnHomologacionEsquemaTodo(string VistaFk, int idOna)
        {
            try
            {
                return Ok(new RespuestasAPI<List<EsquemaDto>>
                {
                    Result = buscadorService.FnHomologacionEsquemaTodo(VistaFk, idOna)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FnHomologacionEsquemaTodo));
            }
        }

        [HttpGet($"{Routes.HOMOLOGACION_ESQUEMA_ID}/{{idEsquema:int}}")]
        public IActionResult FnHomologacionEsquema(int idEsquema)
        {
            try
            {
                return Ok(new RespuestasAPI<FnEsquemaDto>
                {
                    Result = buscadorService.FnHomologacionEsquema(idEsquema)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FnHomologacionEsquema));
            }
        }

        [HttpGet($"{Routes.FN_ESQUEMA_CABECERA_ID}/{{IdEsquemadata:int}}")]
        public IActionResult FnEsquemaCabecera(int IdEsquemadata)
        {
            try
            {
                return Ok(new RespuestasAPI<fnEsquemaCabeceraDto>
                {
                    Result = buscadorService.FnEsquemaCabecera(IdEsquemadata)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FnEsquemaCabecera));
            }
        }

        [HttpGet($"{Routes.HOMOLOGACION_ESQUEMA_DATO}/{{idEsquema:int}}/{{VistaFK}}/{{idOna:int}}")]
        public IActionResult FnHomologacionEsquemaDato(int idEsquema, string VistaFK, int idOna)
        {
            try
            {
                return Ok(new RespuestasAPI<List<FnHomologacionEsquemaDataDto>>
                {
                    Result = buscadorService.FnHomologacionEsquemaDato(idEsquema, VistaFK, idOna)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FnHomologacionEsquemaDato));
            }
        }

        [HttpGet(Routes.ESQUEMA_DATO_BUSCADO)]
        public IActionResult FnEsquemaDato(int idEsquemaData, string TextoBuscar)
        {
            try
            {
                var result = buscadorService.FnEsquemaDatoBuscar(idEsquemaData, TextoBuscar);
                return Ok(new RespuestasAPI<List<FnEsquemaDataBuscadoDto>> { Result = result });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FnEsquemaDato));
            }
        }

        [HttpGet(Routes.PREDIC_WORDS)]
        public IActionResult FnPredictWords(string word)
        {
            try
            {
                return Ok(new RespuestasAPI<List<FnPredictWordsDto>>
                {
                    Result = buscadorService.FnPredictWords(word)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FnPredictWords));
            }
        }

        [HttpPost(Routes.VALIDATE_WORDS)]
        public IActionResult ValidateWords([FromBody] List<string> words)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    Result = buscadorService.ValidateWords(words)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ValidateWords));
            }
        }

        [HttpPost(Routes.EVENTTRACKING)]
        public IActionResult AddEventTracking([FromBody] EventTrackingDto eventTracking)
        {
            try
            {
                var ipAddress = HttpContext.Connection.RemoteIpAddress?.ToString();
                buscadorService.AddEventTracking(eventTracking, ipAddress);
                return Ok(new RespuestasAPI<string> { Result = "Evento registrado con éxito." });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(AddEventTracking));
            }
        }

        [HttpGet(Routes.GEO_CODE)]
        public async Task<IActionResult> GetCoordinates([FromQuery] string address)
        {
            try
            {
                var response = await buscadorService.GetCoordinates(address);

                return Ok(response);
            }
            catch (Exception e) { return HandleException(e, nameof(GetCoordinates)); }
        }

        [Authorize]
        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcel([FromBody] ExportBuscadorDto exportBuscadorDto)
        {
            try
            {
 
                string base64 = await buscadorService.ExportExcel(exportBuscadorDto.paramJSON);

                if (base64 == null)
                {
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });
                }

                return Ok(new { success = true, base64 });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(ExportExcel));
            }
        }

        [Authorize]
        [HttpPost(Routes.PDF)]
        public async Task<IActionResult> ExportPdf([FromBody] ExportBuscadorDto exportBuscadorDto)
        {
            try
            {
                string base64 = await buscadorService.ExportPdf(exportBuscadorDto.paramJSON);

                if (base64 == null)
                {
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });
                }

                return Ok(new { success = true, base64 });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(ExportPdf));
            }
        }

        [HttpGet(Routes.DOWNLOAD_PDF)]
        public async Task<IActionResult> DescargarPDF(string url)
        {
            var content = await buscadorService.DescargarPDF(url);

            if (content == null)
            {
                return NotFound();
            }

            return File(content, "application/pdf", "documento.pdf");
        }
    }
}
