﻿using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.Reportes
{
    public partial class Reporte1
    {
        [Inject]
        private IReporteService? iReporteService { get; set; }

        // Datos para los gráficos
        public List<ChartData> Chart1Data { get; set; } = new List<ChartData>();
        public List<ChartData> Chart2Data { get; set; } = new List<ChartData>();
        public List<LineChartData> Chart3Data { get; set; } = new List<LineChartData>();

        // Datos para los mapas de calor
        public List<MapData> Heatmap1Data { get; set; } = new List<MapData>();
        public List<MapData> Heatmap2Data { get; set; } = new List<MapData>();
        public List<MapData> Heatmap3Data { get; set; } = new List<MapData>();

        //titulos
        public string Titulo_vw_AcreditacionEsquema { get; set; } =  Constantes.VACIO;
        public string Titulo_vw_EstadoEsquema { get; set; } =  Constantes.VACIO;
        public string Titulo_vw_OecFecha { get; set; } =  Constantes.VACIO;
        public string Titulo_vw_OecPais { get; set; } =  Constantes.VACIO;
        public string Titulo_vw_AcreditacionOna { get; set; } =  Constantes.VACIO;
        public string Titulo_vw_EsquemaPais { get; set; } =  Constantes.VACIO;

        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }
        /// <summary>
        /// Servicio de búsqueda y registro de eventos.
        /// </summary>
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        private EventTrackingDto objEventTracking { get; set; } = new();

        private bool isLoading = false;

        // Método ejecutado después de renderizar el componente
        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
           
            objEventTracking.CodigoHomologacionMenu = "/reporte1";
            objEventTracking.NombreAccion = "OnAfterRenderAsync";
            objEventTracking.NombreControl = "reporte1";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (firstRender)
            {
                try
                {
                    isLoading = true;

                    var listaVwAcreditacionEsquema = await iReporteService.GetVwAcreditacionEsquemaAsync<List<VwAcreditacionEsquemaDto>>("acreditacion-esquema");
                    Titulo_vw_AcreditacionEsquema = (await iReporteService.findByVista("vw_AcreditacionEsquema"))?.MostrarWeb ??  Constantes.VACIO;
                    foreach (var item in listaVwAcreditacionEsquema)
                    {
                        Chart1Data.Add(new ChartData { Label = item.Esquema, Value = item.Organizacion });
                    }

                    var listaVwEstadoEsquema = await iReporteService.GetVwEstadoEsquemaAsync<List<VwEstadoEsquemaDto>>("estado-esquema");
                    Titulo_vw_EstadoEsquema = (await iReporteService.findByVista("vw_EstadoEsquema"))?.MostrarWeb ??  Constantes.VACIO;
                    foreach (var item in listaVwEstadoEsquema)
                    {
                        Chart2Data.Add(new ChartData { Label = item.Esquema + " " + item.Estado, Value = item.Organizacion });
                    }

                    var listaVwOecFecha = await iReporteService.GetVwOecFechaAsync<List<VwOecFechaDto>>("oec-fecha");
                    Titulo_vw_OecFecha = (await iReporteService.findByVista("vw_OecFecha"))?.MostrarWeb ??  Constantes.VACIO;
                    foreach (var item in listaVwOecFecha)
                    {
                        Chart3Data.Add(new LineChartData { Fecha = item.Fecha, Organizacion = item.Organizacion });
                    }

                    var listaVwOecPais = await iReporteService.GetVwOecPaisAsync<List<VwOecPaisDto>>("oec-pais");
                    Titulo_vw_OecPais = (await iReporteService.findByVista("vw_OecPais"))?.MostrarWeb ??  Constantes.VACIO;
                    foreach (var item in listaVwOecPais)
                    {
                        Heatmap1Data.Add(new MapData { Pais = item.Pais, Organizacion = item.Organizacion, Esquema =  Constantes.VACIO }); 
                    }

                    var listaVwAcreditacionOna = await iReporteService.GetVwAcreditacionOnaAsync<List<VwAcreditacionOnaDto>>("acreditacion-ona");
                    Titulo_vw_AcreditacionOna = (await iReporteService.findByVista("vw_AcreditacionOna"))?.MostrarWeb ??  Constantes.VACIO;
                    foreach (var item in listaVwAcreditacionOna)
                    {
                        //Heatmap2Data.Add(new MapData { Pais = item.Pais + "-" + item.ONA, Organizacion = item.Organizacion, Esquema = item.ONA }); 
                        Heatmap2Data.Add(new MapData { Pais = item.Pais, Organizacion = item.Organizacion, Esquema = item.ONA });
                    }

                    var listaVwEsquemaPais = await iReporteService.GetVwEsquemaPaisAsync<List<VwEsquemaPaisDto>>("esquema-pais");
                    Titulo_vw_EsquemaPais = (await iReporteService.findByVista("vw_EsquemaPais"))?.MostrarWeb ??  Constantes.VACIO;
                    foreach (var item in listaVwEsquemaPais)
                    {
                        Heatmap3Data.Add(new MapData { Pais = item.Pais, Organizacion = item.Organizacion, Esquema = item.Esquema }); 
                    }

                    isLoading = false;

                    StateHasChanged();
                    await JS.InvokeVoidAsync("initMap", new
                    {
                        chartsData = new[]
                        {
                            Chart1Data.Select(d => new { label = d.Label, value = d.Value }),
                            Chart2Data.Select(d => new { label = d.Label, value = d.Value }),
                            Chart3Data.Select(d => new { label = d.Fecha, value = d.Organizacion })
                        },
                        mapsData = new
                        {
                            heatmap1 = Heatmap1Data.Select(d => new { d.Pais, d.Organizacion, d.Esquema }),
                            heatmap2 = Heatmap2Data.Select(d => new { d.Pais, d.Organizacion, d.Esquema }),
                            heatmap3 = Heatmap3Data.Select(d => new { d.Pais, d.Organizacion, d.Esquema })
                        }
                    });
                }
                catch (JSException jsEx)
                {
                    Console.WriteLine($"Error al inicializar el mapa en JavaScript: {jsEx.Message}");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error inesperado: {ex.Message}");
                }
            }

     
        }

        // Modelos para datos
        public class ChartData
        {
            public string Label { get; set; }
            public int Value { get; set; }
        }

        public class LineChartData
        {
            public string Fecha { get; set; }
            public int Organizacion { get; set; }
        }

        public class MapData
        {
            public string Pais { get; set; }
            public int Organizacion { get; set; }
            public string Esquema { get; set; } // Nuevo campo
        }
    }
}
