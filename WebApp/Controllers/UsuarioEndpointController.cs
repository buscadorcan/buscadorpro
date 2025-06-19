﻿/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/UsuarioEndpointController: Controlador para funcionalidad en usuarios
using AutoMapper;
using Core.Interfaces;
using DataAccess.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SharedApp;
using SharedApp.Dtos;
using SharedApp.Response;

namespace WebApp.Controllers
{
    [Route("api/permiso")]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class UsuarioEndpointController : BaseController
    {
        private readonly IUsuarioEndpontService _usuarioEndpontService;
        private readonly IMapper _mapper;

        public UsuarioEndpointController(IUsuarioEndpontService usuarioEndpontService, IMapper mapper, ILogger<UsuarioEndpointController> logger) : base(logger)
        {
            this._usuarioEndpontService = usuarioEndpontService;
            this._mapper = mapper;
        }
        /// <summary>
        /// Create
        /// </summary>
        /// <param name="data">Objeto que contiene la información del usuario y sus permisos.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult indicando si la operación de creación fue exitosa.
        /// </returns>
        [Authorize]
        [HttpPost]
        public IActionResult Create([FromBody] UsuarioEndpointPermisoRegistroDto data)
        {
            try
            {
                return Ok(new RespuestasAPI<bool>
                {
                    IsSuccess = _usuarioEndpontService.Create(_mapper.Map<UsuarioEndpoint>(data))
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(Create));
            }
        }

        /// <summary>
        /// FindAll
        /// </summary>
        /// <returns>
        /// Devuelve un objeto IActionResult con la lista de usuarios y sus respectivos permisos de endpoint.
        /// </returns>
        [Authorize]
        [HttpGet]
        public IActionResult FindAll()
        {
            try
            {
                return Ok(new RespuestasAPI<List<UsuarioEndpointPermisoDto>>
                {
                    Result = _mapper.Map<List<UsuarioEndpointPermisoDto>>(_usuarioEndpontService.FindAll())
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindAll));
            }
        }

        /// <summary>
        /// FindByEndpointId
        /// </summary>
        /// <param name="endpointId">Identificador único del endpoint a consultar.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con la información del usuario asociado al endpoint indicado.
        /// En caso de que no exista un usuario asociado, se devuelve un mensaje de error.
        /// </returns>
        [Authorize]
        [HttpGet("{endpointId:int}", Name = "FindByEndpointId")]
        public IActionResult FindByEndpointId(int endpointId)
        {
            try
            {
                var itemUsuario = _usuarioEndpontService.FindByEndpointId(endpointId);

                if (itemUsuario == null)
                {
                    return NotFoundResponse(Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO);
                }

                return Ok(new RespuestasAPI<UsuarioDto>
                {
                    Result = _mapper.Map<UsuarioDto>(itemUsuario)
                });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(FindByEndpointId));
            }
        }

    }
}
