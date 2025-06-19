/// Copyright � SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/EsquemaController: Controlador para formularios de esquemas en aplicativo
using AutoMapper;
using Core.Interfaces;
using Core.Service;
using DataAccess.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Route(Routes.ESQUEMA)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class EsquemaController : BaseController
    {
        private readonly IEsquemaService _iEsquemaService;
        private readonly IMapper _mapper;
        private readonly IUtilitiesService _utilitiesService;

        public EsquemaController(IEsquemaService iEsquemaService,
                                 IMapper mapper, ILogger<BaseController> logger,
                                 IUtilitiesService utilitiesService) : base(logger)
        {
            this._iEsquemaService = iEsquemaService;
            this._mapper = mapper;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// FindAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de EsquemaDto que representa todos los registros disponibles.
        /// En caso de error, maneja la excepci�n y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [HttpGet]
        public IActionResult FindAll()
        {
            try
            {
                return Ok(new RespuestasAPI<List<EsquemaDto>>
                {
                    Result = _iEsquemaService.FindAll().Select(item => _mapper.Map<EsquemaDto>(item)).ToList()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindAll));
            }
        }

        /// <summary>
        /// FindById
        /// </summary>
        /// <param name="id">Identificador del registro a buscar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con un EsquemaDto correspondiente al registro encontrado.
        /// En caso de que el registro no exista, devuelve un mensaje de error adecuado.
        /// </returns>
        [Authorize]
        [HttpGet("{id:int}")]
        public IActionResult FindById(int id)
        {
            try
            {
                var record = _iEsquemaService.FindById(id);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                return Ok(new RespuestasAPI<EsquemaDto>
                {
                    Result = _mapper.Map<EsquemaDto>(record)
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
        /// <param name="id">Identificador del registro a actualizar.</param>
        /// <param name="dto">Objeto EsquemaDto con la informaci�n actualizada.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la actualizaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPut("{id:int}")]
        public IActionResult Update(int id, [FromBody] EsquemaDto dto)
        {
            try
            {
                dto.IdEsquema = id;
                var record = _mapper.Map<Esquema>(dto);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iEsquemaService.Update(record)
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
        /// <param name="dto">Objeto EsquemaDto con la informaci�n del nuevo registro.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la creaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPost]
        public IActionResult Create([FromBody] EsquemaDto dto)
        {
            try
            {
                var record = _mapper.Map<Esquema>(dto);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iEsquemaService.Create(record)
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
        /// <param name="id">Identificador del registro a desactivar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la operaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpDelete("{id:int}")]
        public IActionResult Deactive(int id)
        {
            try
            {
                var record = _iEsquemaService.FindById(id);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                record.Estado = Constantes.ESTADO_USUARIO_X;

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iEsquemaService.Update(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Deactive));
            }
        }

        /// <summary>
        /// EliminarEsquemaVistaColumnaByIdEquemaVistaAsync
        /// </summary>
        /// <param name="esquemaRegistro">Objeto EsquemaVistaValidacionDto con la informaci�n del esquema a eliminar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la eliminaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [HttpDelete(Routes.VALIDACION)]
        public IActionResult EliminarEsquemaVistaColumnaByIdEquemaVistaAsync([FromBody] EsquemaVistaValidacionDto esquemaRegistro)
        {
            try
            {
                var record = _iEsquemaService.GetEsquemaVistaColumnaByIdEquemaVistaAsync(esquemaRegistro.IdOna, esquemaRegistro.IdEsquema);

                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                record.Estado = Constantes.ESTADO_USUARIO_X;

                var isDeleted = _iEsquemaService.EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(record.IdEsquemaVista);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = isDeleted
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(EliminarEsquemaVistaColumnaByIdEquemaVistaAsync));
            }
        }

        /// <summary>
        /// UpdateEsquemaValidacion
        /// </summary>
        /// <param name="dto">Objeto EsquemaVistaValidacionDto con la informaci�n actualizada.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la actualizaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [Route(Routes.VALIDACION_ACTUALIZACION)]
        [HttpPut]
        public IActionResult UpdateEsquemaValidacion([FromBody] EsquemaVistaValidacionDto dto)
        {
            try
            {
                var record = _mapper.Map<EsquemaVista>(dto);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iEsquemaService.UpdateEsquemaValidacion(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(UpdateEsquemaValidacion));
            }
        }

        /// <summary>
        /// CreateEsquemaValidacion
        /// </summary>
        /// <param name="dto">Objeto EsquemaVistaValidacionDto con la informaci�n de la validaci�n a crear.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la creaci�n fue exitosa.
        /// </returns>
        [Authorize]
        [Route(Routes.VALIDACION)]
        [HttpPost]
        public IActionResult CreateEsquemaValidacion([FromBody] EsquemaVistaValidacionDto dto)
        {
            try
            {
                var record = _mapper.Map<EsquemaVista>(dto);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iEsquemaService.CreateEsquemaValidacion(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(CreateEsquemaValidacion));
            }
        }

        /// <summary>
        /// GuardarListaEsquemaVistaColumna
        /// </summary>
        /// <param name="listaEsquemaVistaColumna">Lista de objetos EsquemaVistaColumnaDto que representan las columnas a guardar.</param>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditaci�n (ONA) al que pertenece el esquema.</param>
        /// <param name="idEsquema">Identificador del esquema donde se almacenar�n las columnas.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la operaci�n de guardado fue exitosa.
        /// En caso de error, maneja la excepci�n y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [Route(Routes.VISTA_COLUMNA)]
        [HttpPost]
        public IActionResult GuardarListaEsquemaVistaColumna(
            [FromBody] List<EsquemaVistaColumnaDto> listaEsquemaVistaColumna,
            [FromQuery] int idOna,
            [FromQuery] int idEsquema)
        {
            try
            {
                var record = _mapper.Map<List<EsquemaVistaColumna>>(listaEsquemaVistaColumna);

                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _iEsquemaService.GuardarListaEsquemaVistaColumna(record, idOna, idEsquema)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GuardarListaEsquemaVistaColumna));
            }
        }

        /// <summary>
        /// GetListaEsquemaByOna
        /// </summary>
        /// <param name="idOna">Identificador del Organismo Nacional de Acreditaci�n (ONA).</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de esquemas asociados al ONA especificado.
        /// En caso de error, maneja la excepci�n y devuelve un mensaje adecuado.
        /// </returns>
        [Authorize]
        [HttpGet(Routes.ESQUEMA_ID, Name = "GetListaEsquemaByOna")]
        public IActionResult GetListaEsquemaByOna(int idOna)
        {
            try
            {
                var result = _iEsquemaService.GetListaEsquemaByOna(idOna);
                return Ok(new RespuestasAPI<List<Esquema>> { Result = result });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(GetListaEsquemaByOna));
            }
        }

        [Authorize]
        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcel()
        {
            try
            {
                var data = _iEsquemaService.FindAll();

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
                var data = _iEsquemaService.FindAll();

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

