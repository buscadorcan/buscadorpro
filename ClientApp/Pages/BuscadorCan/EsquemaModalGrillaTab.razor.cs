﻿using BlazorBootstrap;
using Infractruture.Models;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Newtonsoft.Json;
using Microsoft.JSInterop;
using SharedApp.Dtos; // Para invocar funciones de JavaScript

namespace ClientApp.Pages.BuscadorCan
{
    /// <summary>
    /// Componente parcial para el modal de grilla de esquema.
    /// </summary>
    public partial class EsquemaModalGrillaTab : ComponentBase
    {
        /// <summary>
        /// Servicio de búsqueda.
        /// </summary>
        [Inject] private IBusquedaService? servicio { get; set; }

        /// <summary>
        /// Servicio de JavaScript.
        /// </summary>
        [Inject] private IJSRuntime JS { get; set; } = default!;

        /// <summary>
        /// Identificador de esquema.
        /// </summary>
        [Parameter] public int IdEsquema { get; set; }

        /// <summary>
        /// Identificador de ONA.
        /// </summary>
        [Parameter] public int? idONA { get; set; }

        /// <summary>
        /// Identificador de vista secundario
        /// </summary>
        [Parameter] public string? VistaFK { get; set; }

        /// <summary>
        /// Identificador de vista primario
        /// </summary>
        [Parameter] public string? VistaPK { get; set; }

        /// <summary>
        /// Texto de búsqueda.
        /// </summary>
        [Parameter] public string? Texto { get; set; }

        /// <summary>
        /// Homologación de esquema.
        /// </summary>
        private HomologacionEsquemaDto? homologacionEsquema;

        /// <summary>
        /// Columnas de la grilla.
        /// </summary>
        private List<HomologacionDto>? Columnas;

        /// <summary>
        /// Resultados de esquemas.
        /// </summary>
        private List<DataHomologacionEsquema>? resultados;

        /// <summary>
        /// Método de inicialización de datos.
        /// </summary>

        private Dictionary<int, string> filtros = new();
        private Dictionary<int, string> operadores = new();

        private Grid<DataHomologacionEsquema>? gridRef;
        private bool datosListos = false;

        //protected override async Task OnInitializedAsync()
        //{
        //    try
        //    {
        //        if (servicio != null)
        //        {
        //            homologacionEsquema = await servicio.FnHomologacionEsquemaAsync(IdEsquema);
        //            Columnas = JsonConvert.DeserializeObject<List<HomologacionDto>>(homologacionEsquema?.EsquemaJson ?? "[]")?.OrderBy(c => c.MostrarWebOrden).ToList();
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine(e);
        //    }
        //}

        /// <summary>
        /// Método para obtener los datos de la grilla.
        /// </summary>
        /// <param name="request">Solicitud de datos.</param>
        /// <returns>Resultado de la solicitud.</returns>

        private async Task<GridDataProviderResult<DataHomologacionEsquema>> HomologacionEsquemasDataProvider(GridDataProviderRequest<DataHomologacionEsquema> request)
        {
            if (resultados is null && servicio != null)
            {
                resultados = await servicio.FnHomologacionEsquemaDatoAsync(IdEsquema, VistaFK, idONA ?? 0);
            }

            IEnumerable<DataHomologacionEsquema> query = resultados ?? new List<DataHomologacionEsquema>();

            // Aplicar filtros manuales (personalizados)
            foreach (var filtro in filtros)
            {
                int idHomologacionFiltro = filtro.Key;
                string valorFiltro = filtro.Value;

                if (!string.IsNullOrEmpty(valorFiltro))
                {
                    string operador = operadores.ContainsKey(idHomologacionFiltro) ? operadores[idHomologacionFiltro] : "contains";

                    query = query.Where(r =>
                        r.DataEsquemaJson != null &&
                        r.DataEsquemaJson.Any(d =>
                            d.IdHomologacion == idHomologacionFiltro &&
                            d.Data != null &&
                            AplicaFiltro(d.Data, valorFiltro, operador)));
                }
            }

            // Aplicar ordenamiento (si existe)
            if (request.Sorting?.Any() == true)
            {
                foreach (var sort in request.Sorting)
                {
                    query = sort.SortDirection == SortDirection.Descending
                        ? query.OrderByDescending(sort.SortKeySelector.Compile())
                        : query.OrderBy(sort.SortKeySelector.Compile());
                }
            }

            var resultadoFinal = query.ToList();

            return new GridDataProviderResult<DataHomologacionEsquema>
            {
                Data = resultadoFinal,
                TotalCount = resultadoFinal.Count
            };
        }


        private void CambiarOperadorFiltro(int idHomologacion, string operador)
        {
            operadores[idHomologacion] = operador;
        }

        private async void FiltrarTabla(int idHomologacion, string valor)
        {
            filtros[idHomologacion] = valor;
            if (gridRef is not null)
                await gridRef.RefreshDataAsync();
        }

        private bool AplicaFiltro(string valor, string filtro, string operador)
        {
            return operador switch
            {
                "starts" => valor.StartsWith(filtro, StringComparison.OrdinalIgnoreCase),
                "ends" => valor.EndsWith(filtro, StringComparison.OrdinalIgnoreCase),
                _ => valor.Contains(filtro, StringComparison.OrdinalIgnoreCase),
            };
        }
        /// <summary>
        /// Método para extraer la fórmula de un texto.
        /// </summary>
        /// <param name="input">Texto de entrada.</param>
        /// <returns>Fórmula extraída.</returns>
        private string ExtraerFormula(string input)
        {
            // Busca la parte dentro de $$ ... $$ y extrae solo la fórmula
            int start = input.IndexOf("$$") + 2;
            int end = input.LastIndexOf("$$");

            if (start >= 2 && end > start)
            {
                return input.Substring(start, end - start).Trim();
            }

            return input; // Si no encuentra, devuelve el mismo dato
        }

        /// <summary>
        /// Método para ejecutar despues del renderizado.
        /// </summary>
        /// <param name="firstRender">Indicador de primer renderizado.</param>
        protected override async Task OnAfterRenderAsync(bool firstRender)
        {

            if (firstRender)
            {
                try
                {
                    await JS.InvokeVoidAsync("forzarRefrescoEsquema", DotNetObjectReference.Create(this), IdEsquema);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"❌ JS Error: {ex.Message}");
                }
            }

            try
            {
                await JS.InvokeVoidAsync("renderMathJax");
            }
            catch (Exception e)
            {
                Console.WriteLine($"❌ MathJax Error: {e.Message}");
            }
        }

        protected override async Task OnParametersSetAsync()
        {
            try
            {
                datosListos = false; // Limpieza para evitar render previo

                if (servicio != null)
                {
                    homologacionEsquema = await servicio.FnHomologacionEsquemaAsync(IdEsquema);
                    Columnas = JsonConvert.DeserializeObject<List<HomologacionDto>>(homologacionEsquema?.EsquemaJson ?? "[]")
                                    ?.OrderBy(c => c.MostrarWebOrden).ToList();

                    resultados = await servicio.FnHomologacionEsquemaDatoAsync(IdEsquema, VistaFK, idONA ?? 0);

                    datosListos = true;
                    await InvokeAsync(StateHasChanged);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"❌ Error al cargar esquema {IdEsquema}: {e.Message}");
            }
        }

        private async Task TryRefrescarGrilla()
        {
            if (gridRef is not null && resultados is not null && resultados.Any())
            {
                await gridRef.RefreshDataAsync();
                Console.WriteLine("✅ Grilla actualizada correctamente.");
            }
            else
            {
                Console.WriteLine("⚠️ No se pudo refrescar la grilla porque aún no está lista.");
            }
        }

        [JSInvokable]
        public async Task RefrescarGrillaDesdeJS()
        {
            if (gridRef is not null)
            {
                await gridRef.RefreshDataAsync();
                Console.WriteLine($"✅ Refrescada la grilla desde JS para esquema {IdEsquema}");
            }
        }

    }
}