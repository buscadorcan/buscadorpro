using Core.Interfaces;
using Core.Service;

/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/MenuController: Controlador para menú
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Route(Routes.MENU)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class MenuController : BaseController
    {
        private readonly IMenuService _menuService;
        private readonly IUtilitiesService _utilitiesService;

        public MenuController(IMenuService menuService, ILogger<MenuController> logger, IUtilitiesService utilitiesService) : base(logger)
        {
            this._menuService = menuService;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// FindAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de MenuDto representando los registros del menú.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet]
        public IActionResult FindAll()
        {
            try
            {
                return Ok(new RespuestasAPI<List<MenuRolDto>>
                {
                    Result = _menuService.FindAll()
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
        /// <param name="idHRol">Identificador del rol asociado al menú.</param>
        /// <param name="idHMenu">Identificador del menú.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con un MenuDto correspondiente al registro encontrado.
        /// En caso de que el registro no exista, devuelve un mensaje de error adecuado.
        /// </returns>
        [HttpGet("{idHRol:int}/{idHMenu:int}")]
        public IActionResult FindById(int idHRol, int idHMenu)
        {
            try
            {
                var record = _menuService.FindDataById(idHRol, idHMenu);
                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }
                return Ok(new RespuestasAPI<MenuRolDto>
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
        /// <param name="idHRol">Identificador del rol asociado al menú.</param>
        /// <param name="idHMenu">Identificador del menú a actualizar.</param>
        /// <param name="dto">Objeto MenuDto con la información actualizada.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la actualización fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPut("{idHRol:int}/{idHMenu:int}")]
        public IActionResult Update(int idHRol, int idHMenu, [FromBody] MenuRolDto dto)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _menuService.Update(dto)
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
        /// <param name="dto">Objeto MenuDto con la información del nuevo registro del menú.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la creación fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPost]
        public IActionResult Create([FromBody] MenuRolDto dto)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _menuService.Create(dto)
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
        /// <param name="idHRol">Identificador del rol asociado al menú.</param>
        /// <param name="idHMenu">Identificador del menú a desactivar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la operación fue exitosa.
        /// </returns>
        [Authorize]
        [HttpDelete("{idHRol:int}/{idHMenu:int}")]
        public IActionResult Deactive(int idHRol, int idHMenu)
        {
            try
            {
                var record = _menuService.FindById(idHRol, idHMenu);
                record.Estado = record.Estado == Constantes.ESTADO_USUARIO_A ? Constantes.ESTADO_USUARIO_X : Constantes.ESTADO_USUARIO_A;
                if (record == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _menuService.Update(record)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Deactive));
            }
        }
        /// <summary>
        /// Deactive
        /// </summary>
        /// <param name="idHomologacionRol">Identificador del rol en homologación.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con un MenuPaginaDto correspondiente al registro encontrado.
        /// En caso de que el registro no exista, devuelve un mensaje de error adecuado.
        /// </returns>
        [HttpGet("{idHomologacionRol:int}", Name = "menus")]
        public IActionResult ObtenerMenusPendingConfig(int idHomologacionRol)
        {
            try
            {
                return Ok(new RespuestasAPI<List<MenuPaginaDto>>
                {
                    Result = _menuService.ObtenerMenusPendingConfig(idHomologacionRol)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerMenusPendingConfig));
            }
        }

        [Authorize]
        [HttpPost(Routes.EXCEL)]
        public async Task<IActionResult> ExportExcel()
        {
            try
            {
                var data = _menuService.FindAll();

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
                var data = _menuService.FindAll();

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
