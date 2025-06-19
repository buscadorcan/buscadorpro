using Blazored.LocalStorage;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.AspNetCore.Components.Authorization;
using ClientAppAdministrador;
using Infractruture.Services;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

// Configuraci�n general
builder.Services.AddSingleton(builder.Configuration);

builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddBlazorBootstrap();

builder.Services.AddScoped(sp => new HttpClient
{
    BaseAddress = new Uri(builder.Configuration["UrlBases:UrlBaseApi"])
});


builder.Services.Scan(scan => scan
    .FromAssemblyOf<BusquedaService>() // cualquier clase dentro de Infractruture
    .AddClasses(classes => classes.InNamespaces("Infractruture.Services"))
    .AsImplementedInterfaces()
    .WithScopedLifetime()
);

// Servicios adicionales que no siguen la convenci�n o no tienen interfaz
builder.Services.AddSingleton<Infractruture.Services.ToastService>();

// Blazored LocalStorage
builder.Services.AddBlazoredLocalStorage();

// Autenticaci�n y autorizaci�n
builder.Services.AddAuthorizationCore();
builder.Services.AddScoped<AuthStateProvider>();
builder.Services.AddScoped<AuthenticationStateProvider>(
    s => s.GetRequiredService<AuthStateProvider>());

await builder.Build().RunAsync();
