﻿using Microsoft.AspNetCore.Mvc;
using SharedApp.Dtos;
using SharedApp.Response;
using Core.Services;
using Microsoft.AspNetCore.Authorization;


namespace WebApp.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class EmailController : BaseController 
    {
        private readonly IEmailService _emailService;

        public EmailController(IEmailService emailService, 
                               ILogger<BaseController> logger): base(logger)
        {
            this._emailService = emailService;
        }

        [HttpPost(Routes.ENVIAR)]
        public async Task<IActionResult> EnviarCorreoRol([FromBody] EmailDto email) {
            try
            {
                var result = await _emailService.SendEmailAsync("", "", "");
                return Ok(new RespuestasAPI<bool>() { Result = result });
            }
            catch (Exception e)
            {
                return HandleException(e, nameof(EnviarCorreoRol));
            }
        }

        
    }
}
