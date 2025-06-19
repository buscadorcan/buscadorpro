﻿/// Copyright © SIDESOFT | BuscadorAndino | 2025.Feb.18
/// WebApp/UtilitiesController: Controlador para utilities
using Core.Interfaces;
using Core.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Policy;
using System.Threading.Tasks;

namespace WebApp.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UtilitiesController : ControllerBase
    {
        private readonly IWebHostEnvironment _environment;
        private readonly IUtilitiesService _utilitiesService;

        public UtilitiesController(IWebHostEnvironment environment, IUtilitiesService utilitiesService)
        {
            _environment = environment;
            this._utilitiesService = utilitiesService;
        }

        /// <summary>
        /// UploadIcon
        /// </summary>
        /// <param name="file">Archivo de imagen a subir. Solo se permiten formatos .png y .svg.</param>
        /// <param name="idONA">Identificador del ONA al que se asociará el icono.</param>
        /// <returns>
        /// Devuelve un objeto IActionResult con la ruta relativa del archivo almacenado en el servidor.
        /// En caso de error, devuelve un mensaje de error específico.
        /// </returns>
        [HttpPost(Routes.UPLOAD_ICON)]
        public async Task<IActionResult> UploadIcon([FromForm] IFormFile file, [FromForm] int idONA)
        {
            try
            {
                if (file == null || file.Length == 0)
                    return BadRequest("No se ha enviado un archivo válido.");

                // Confirmar que el idONA se recibe correctamente
                Console.WriteLine($"ID ONA recibido: {idONA}");

                // Procesar el archivo normalmente...
                var extension = Path.GetExtension(file.FileName)?.ToLowerInvariant();
                var allowedExtensions = new[] { ".png", ".svg" };

                if (string.IsNullOrEmpty(extension) || !allowedExtensions.Contains(extension))
                    return BadRequest("Formato de archivo no permitido.");

                var uniqueFileName = $"{idONA}{extension}"; // Guardar con el ID como nombre
                var folderPath = Path.Combine(_environment.ContentRootPath, "wwwroot", "Icono");

                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                var filePath = Path.Combine(folderPath, uniqueFileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(stream);
                }

                var relativePath = $"Icono/{uniqueFileName}";
                return Ok(new { FilePath = relativePath });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error interno al procesar el archivo. {ex.Message}");
            }
        }
    }

}
