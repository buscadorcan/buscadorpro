using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using DataAccess.Models;

namespace WebApp.WorkerService
{
    public class BackgroundWorkerOnaService : BackgroundService
    {
        private readonly ILogger<BackgroundWorkerService> _logger;
        private readonly IServiceProvider _serviceProvider;
        private readonly TimeSpan _intervaloEjecucion = TimeSpan.FromMinutes(1);

        public BackgroundWorkerOnaService(ILogger<BackgroundWorkerService> logger, IServiceProvider serviceProvider)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("BackgroundWorkerService iniciado.");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    using var scope = _serviceProvider.CreateScope();
                    var dbContext = scope.ServiceProvider.GetRequiredService<DataAccess.Data.SqlServerDbContext>();
                    var iDynamicService = scope.ServiceProvider.GetRequiredService<Core.Interfaces.IDynamicService>();

                    var ahora = DateTime.Now.ToString("HH:mm");

                    var conexiones = await dbContext.ONAConexion
                        .Where(c => c.HoraMigracion1 != null || c.HoraMigracion2 != null || c.HoraMigracion3 != null)
                        .ToListAsync(stoppingToken);

                    foreach (var conexion in conexiones)
                    {
                        if (CoincideHora(conexion, ahora))
                        {
                            _logger.LogInformation($"Ejecutando migración para ONA Id: {conexion.IdONA}");
                            await iDynamicService.MigrarConexionAsync(conexion.IdONA);
                        }
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error en BackgroundWorkerOnaService");
                }

                await Task.Delay(_intervaloEjecucion, stoppingToken);
            }
        }

        private bool CoincideHora(ONAConexion conexion, string horaActual)
        {
            return (conexion.HoraMigracion1?.ToString(@"hh\:mm") == horaActual ||
                    conexion.HoraMigracion2?.ToString(@"hh\:mm") == horaActual ||
                    conexion.HoraMigracion3?.ToString(@"hh\:mm") == horaActual);
        }
    }
}
