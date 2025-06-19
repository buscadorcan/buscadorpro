using Microsoft.AspNetCore.Http.Features;
using Serilog;
using SharedApp.Helpers;
using System.Threading.RateLimiting;
using WebApp.Extensions;

var builder = WebApplication.CreateBuilder(args);



builder.Configuration
    .AddJsonFile("appsettings.json", optional: false)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true)
    .AddEnvironmentVariables();

Inicializar.Configurar(builder.Configuration);

// ← Crea el logger ANTES de construir el host
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .CreateLogger();


builder.Host.UseSerilog();

/// <summary>
/// Configura las opciones para el manejo de formularios multipart, 
/// estableciendo un límite de tamaño máximo de 10 MB para los archivos subidos.
/// </summary>
builder.Services.Configure<FormOptions>(options => {
  options.MultipartBodyLengthLimit = 10485760; // 10 MB
});

/// <summary>
/// Configura los contextos de base de datos utilizando los métodos de extensión personalizados.
/// </summary>
builder.Services.ConfigureDbContexts(builder.Configuration);

/// <summary>
/// Configura los servicios de la aplicación a través de métodos de extensión personalizados.
/// </summary>
builder.Services.ConfigureServices();

/// <summary>
/// Configura la autenticación de la aplicación utilizando los métodos de extensión personalizados.
/// </summary>
builder.Services.ConfigureAuthentication(builder.Configuration);

/// <summary>
/// Configura la integración de Swagger para la documentación de la API.
/// </summary>
builder.Services.ConfigureSwagger();

builder.Services.ConfigureRoutes(builder.Configuration);

/// <summary>
/// Agrega el soporte para controladores con la configuración de Newtonsoft.Json 
/// para la serialización/deserialización de JSON.
/// </summary>
builder.Services.AddControllers().AddNewtonsoftJson();


builder.Services.AddCors(options =>
{
    options.AddPolicy("corsConfig",
        builder =>
        {
            string[] domainsAllowed = [
                Inicializar.UrlAdminLocal,
                Inicializar.UrlAdminRemoto,
                Inicializar.UrlServ,
                Inicializar.UrlBuscador,
                Inicializar.UrlPublicServ
            ];

            builder.WithOrigins(domainsAllowed)
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});


///<summary>
///Aplicar rate limiting usando AddRateLimiter
/// </summary>
builder.Services.AddRateLimiter(options =>
{
    options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(httpContext =>
        RateLimitPartition.GetFixedWindowLimiter(
            partitionKey: httpContext.Connection.RemoteIpAddress?.ToString() ?? "unknown",
            factory: _ => new FixedWindowRateLimiterOptions
            {
                PermitLimit = Inicializar.PermitLimit, // por IP
                Window = TimeSpan.FromMinutes(1),
                QueueProcessingOrder = QueueProcessingOrder.OldestFirst,
                QueueLimit = 0
            }));
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
});

var app = builder.Build();

app.UseRateLimiter();

/// <summary>
/// Configura las políticas CORS (Cross-Origin Resource Sharing) para permitir cualquier origen,
/// cualquier método HTTP y cualquier encabezado en las solicitudes.
/// </summary>
/// 

app.UseCors("corsConfig");


/// <summary>
/// Habilita el middleware de archivos estáticos para que se sirvan archivos desde la carpeta wwwroot.
/// </summary>
app.UseStaticFiles();

/// <summary>
/// Habilita Swagger y la interfaz de usuario Swagger UI cuando el entorno sea de desarrollo.
/// </summary>
if (app.Environment.IsDevelopment() || app.Environment.IsProduction())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UsePathBase("/swagger/index.html");
}


/// <summary>
/// Habilita el middleware de autenticación de la aplicación.
/// </summary>
app.UseAuthentication();

/// <summary>
/// Habilita el middleware de autorización de la aplicación.
/// </summary>
app.UseAuthorization();

/// <summary>
/// Mapea los controladores definidos en la aplicación para manejar las rutas de la API.
/// </summary>
app.MapControllers();

/// <summary>
/// Inicia la aplicación y comienza a escuchar las solicitudes entrantes.
/// </summary>
app.Run();
