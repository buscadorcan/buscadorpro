/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/CatalogosController: Controlador para catalogos
using Microsoft.AspNetCore.Mvc;
using SharedApp.Response;
using SharedApp.Dtos;
using Core.Interfaces;
using Microsoft.AspNetCore.Authorization;


namespace WebApp.Controllers
{
    /// <summary>
    /// Controlador para la gestión de catálogos, filtros, dimensiones y roles.
    /// </summary>
    [AllowAnonymous]
    [Route(Routes.CATALOGOS)]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public class CatalogosController : BaseController
    {
        private readonly ICatalogosService _iCatalogosService;

        public CatalogosController(ICatalogosService iCatalogosService, ILogger<CatalogosController> logger) : base(logger)
        {
            this._iCatalogosService = iCatalogosService;
        }

        /// <summary>
        /// ObtenerVwGrilla
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de VwGrillaDto que representa la estructura de la grilla.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.GRID_SCHEMA)]
        public IActionResult ObtenerVwGrilla()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwGrillaDto>>
                {
                    Result = _iCatalogosService.ObtenerVwGrilla()
                });
            }
            catch (Exception e)
            {
                return StatusCode(500, new { mensaje = "Error interno", detalle = e.Message });
            }
        }

        /// <summary>
        /// ObtenerVwFiltro
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de VwFiltroDto que representa la estructura de los filtros.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.FILTERS_SCHEMA)]
        public IActionResult ObtenerVwFiltro()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwFiltroDto>>
                {
                    Result = _iCatalogosService.ObtenerVwFiltro()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerVwFiltro));
            }
        }

        /// <summary>
        /// ObtenerFiltroDetalles
        /// </summary>
        /// <param name="codigo">Código del filtro para obtener sus detalles.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de vwFiltroDetalleDto que representa los detalles del filtro.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet($"{Routes.FILTERS_DATA}/{{codigo}}")]
        public IActionResult ObtenerFiltroDetalles(string codigo)
        {
            try
            {
                return Ok(new RespuestasAPI<List<vwFiltroDetalleDto>>
                {
                    Result = _iCatalogosService.ObtenerFiltroDetalles(codigo)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerFiltroDetalles));
            }
        }

        /// <summary>
        /// ObtenerVwDimension
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de VwDimensionDto que representa la estructura de las dimensiones.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.DIMENSION_SCHEMA)]
        public IActionResult ObtenerVwDimension()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwDimensionDto>>
                {
                    Result = _iCatalogosService.ObtenerVwDimension()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerVwDimension));
            }
        }

        /// <summary>
        /// ObtenerGrupos
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de VwHomologacionGrupoDto que representa los grupos en la aplicación.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.GRUPOS)]
        public IActionResult ObtenerGrupos()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwHomologacionGrupoDto>>
                {
                    Result = _iCatalogosService.ObtenerVwHomologacionGrupo()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerGrupos));
            }
        }


        /// <summary>
        /// ObtenerVwRol
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de VwRolDto que representa los roles.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.ROLES)]
        public IActionResult ObtenerVwRol()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwRolDto>>
                {
                    Result = _iCatalogosService.ObtenerVwRol()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerVwRol));
            }
        }

        /// <summary>
        /// ObtenerOna
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de OnaDto que representa los ONAs.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.ONAS)]
        public IActionResult ObtenerOna()
        {
            try
            {
                return Ok(new RespuestasAPI<List<OnaDto>>
                {
                    Result = _iCatalogosService.ObtenerOna()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerOna));
            }
        }

        /// <summary>
        /// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
        /// WebApp/ObtenerVwMenu: Obtiene los datos para el menú. Requiere autorización.
        /// Este método devuelve la estructura de datos utilizada para representar los elementos del menú de la aplicación.
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de VwMenuDto que representa los elementos del menú.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.MENU_CATALOGO)]
        public IActionResult ObtenerVwMenu()
        {
            try
            {
                return Ok(new RespuestasAPI<List<VwMenuDto>>
                {
                    Result = _iCatalogosService.ObtenerVwMenu()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerVwMenu));
            }
        }

        /// <summary>
        /// ObtenerPanelOna
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de vwPanelONA que representa la configuración del panel ONA.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.PANEL)]
        public IActionResult ObtenerPanelOna()
        {
            try
            {
                return Ok(new RespuestasAPI<List<vwPanelONADto>>
                {
                    Result = _iCatalogosService.ObtenerVwPanelOna()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerPanelOna));
            }
        }

        /// <summary>
        /// ObtenerEsquemaOrganiza
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de vwEsquemaOrganiza que representa la estructura organizacional.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.ESQUEMA_ORGANIZACION)]
        public IActionResult ObtenerEsquemaOrganiza()
        {
            try
            {
                return Ok(new RespuestasAPI<List<vwEsquemaOrganizaDto>>
                {
                    Result = _iCatalogosService.ObtenervwEsquemaOrganiza()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerEsquemaOrganiza));
            }
        }

        /// <summary>
        /// ObtenerVwOna
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de vwONADto que representa los ONAs registrados.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.VW_ONA)]
        public IActionResult ObtenerVwOna()
        {
            try
            {
                return Ok(new RespuestasAPI<List<vwONADto>>
                {
                    Result = _iCatalogosService.ObtenervwOna()
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerVwOna));
            }
        }

        /// <summary>
        /// filters/anidados
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de vwONADto que representa los ONAs registrados.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpPost(Routes.FILTERS_ANINADOS)]
        public IActionResult ObtenerFiltrosAnidados([FromBody] List<FiltrosBusquedaSeleccionDto> filtrosSeleccionados)
        {
            try
            {
                var resultado = _iCatalogosService.ObtenerFiltrosAnidados(filtrosSeleccionados);
                return Ok(resultado);
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(ObtenerFiltrosAnidados));
            }
        }

        /// <summary>
        /// filters/anidados
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con una lista de vwONADto que representa los ONAs registrados.
        /// En caso de error, maneja la excepción y devuelve un mensaje adecuado.
        /// </returns>
        [HttpGet(Routes.ANINADOS)]
        public IActionResult ObtenerFiltrosAnidadosAll()
        {
            try
            {
                var resultado = _iCatalogosService.ObtenerFiltrosAnidadosAll();
                return Ok(resultado);
            }
            catch (Exception e)
            {
                return StatusCode(500, $"Error al obtener filtros anidados: {e.Message}");
            }
        }
    }
}
