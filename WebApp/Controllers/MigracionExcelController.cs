/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/MigacionExcelController: Controlador para funcionalidad de migración excel
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using SharedApp.Response;
using SharedApp.Dtos;
using Core.Interfaces;
using DataAccess.Models;
using SharedApp;

namespace WebApp.Controllers
{
  [Route(Routes.MIGRACION_EXCEL)]
  [ApiController]
  [ProducesResponseType(StatusCodes.Status200OK)]
  [ProducesResponseType(StatusCodes.Status400BadRequest)]
  [ProducesResponseType(StatusCodes.Status403Forbidden)]
  [ProducesResponseType(StatusCodes.Status401Unauthorized)]
  [ProducesResponseType(StatusCodes.Status500InternalServerError)]
  public class MigacionExcelController: BaseController
  {
        private readonly IMigracionExcelService _migracionExcelService;
        private readonly IMapper _mapper;
        private readonly IExcelService _importer;
        private readonly IUtilitiesService _utilitiesService;

        public MigacionExcelController(
                IMigracionExcelService migracionExcelService,
                IMapper mapper,
                IExcelService importer,
                ILogger<BaseController> logger,
                IUtilitiesService utilitiesService
                ) : base(logger)
        {
            this._migracionExcelService = migracionExcelService;
            this._mapper = mapper;
            this._importer = importer;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// FindAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de MigracionExcelDto representando los registros de migración.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        //[Authorize]
        [HttpGet]
        public IActionResult FindAll(int PageNumber, int RowsPerPage)
        {
            try
            {
                return Ok(new RespuestasAPI<ResultadoPaginadoDto<List<MigracionExcelDto>>>
                {
                    Result = _migracionExcelService.FindAll(PageNumber, RowsPerPage)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindAll));
            }
        }

        /// <summary>
        /// ImportarExcel
        /// </summary>
        /// <param name="file">Archivo Excel a importar.</param>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditación (ONA) al que se asocia la importación.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la importación fue exitosa.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [HttpPost(Routes.MIGRACION_UPLOAD)]
        public IActionResult ImportarExcel(IFormFile file, [FromQuery] int idOna)
        {
            try
            {
                if (file == null || file.Length == 0)
                {
                    return BadRequestResponse("Archivo no encontrado");
                }
                if (idOna <= 0)
                {
                    return BadRequestResponse("idOna no es válido");
                }

                string fileExtension = Path.GetExtension(file.FileName);
                if (fileExtension != ".xls" && fileExtension != ".xlsx")
                {
                    return BadRequestResponse("Archivo no válido");
                }

                // Obtener la ruta de `wwwroot/Files` correctamente en IIS
                string wwwrootPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot");
                string filesPath = Path.Combine(wwwrootPath, "Files");

                // Asegurar que la carpeta "Files" existe, si no, crearla
                if (!Directory.Exists(filesPath))
                {
                    Directory.CreateDirectory(filesPath);
                }

                // Construir la ruta final del archivo
                string filePath = Path.Combine(filesPath, file.FileName);

                // Guardar el archivo
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    file.CopyTo(stream);
                }

                // Guardar en base de datos
                LogMigracion migracion = _migracionExcelService.Create(new LogMigracion
                {
                    Estado = Constantes.ESTADO_USUARIO_PENDING,
                    ExcelFileName = file.FileName
                });

                _importer.ImportarExcel(filePath, migracion, idOna);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = true
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    statusCode = 500,
                    isSuccess = false,
                    errorMessages = new[] { ex.Message }
                });
            }
        }

        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcelConCodigo()
        {
            try
            {

                var data = _migracionExcelService.FindAll(0, 0, false).Data;

                if (data == null || !data.Any())
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });

                var dictData = await _utilitiesService.ExportDocumentAsync(data);

                var url = await _utilitiesService.ExportExcel(dictData);

                return Ok(new { success = true, url });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(ExportExcelConCodigo));
            }
        }

        [HttpPost(Routes.PDF)]
        public async Task<IActionResult> ExportPdfConCodigo()
        {
            try
            {
                var data = _migracionExcelService.FindAll(0, 0, false).Data;

                if (data == null || !data.Any())
                    return BadRequest(new { success = false, message = "No hay datos para exportar." });

                var dictData = await _utilitiesService.ExportDocumentAsync(data);

                var url = await _utilitiesService.ExportPdf(dictData);

                return Ok(new { success = true, url });

            }
            catch (Exception ex)
            {
                return HandleException(ex, nameof(ExportPdfConCodigo));
            }
        }

    }
}
