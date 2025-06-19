using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using OfficeOpenXml;
using SharedApp.Dtos;

namespace ClientAppAdministrador.Pages.Administracion.Eventos
{
    public partial class Form_Graf_Event
    {

        [Inject] private IUtilitiesService iUtilitiesService { get; set; }

        [Parameter] public string? selectUser { get; set; }
        [Parameter] public DateOnly? dateStart { get; set; }
        [Parameter] public DateOnly? dateEnd { get; set; }

        [Inject] public IEventService? EventService { get; set; }
        [Inject] IJSRuntime JS { get; set; }
        [Inject] public IJSRuntime JSRuntime { get; set; }

        private enum reporteView
        {
            TiempoSession = 1,
            PaginasMasVisitadas = 2,
            FiltroMasUsado = 3
        }

        private bool isLoading = false;
        private reporteView selectView;

        private List<HeatmapPoint> heatmapData = new();
        private List<VwEventTrackingSessionDto> listasEventSession = new();
        private List<PaginasMasVisitadaDto> listasEventPagMasVist = new();
        private List<FiltrosMasUsadoDto> listasEventFiltrMasUsad = new();

        private bool IsModalOpen = false;
        private int ProgressValue { get; set; } = 0;
        private int PageSize = 5; // Cantidad de registros por página
        private int CurrentPage = 1;
        private IEnumerable<VwEventTrackingSessionDto> PaginatedItems => listasEventSession
               .Skip((CurrentPage - 1) * PageSize)
               .Take(PageSize);
        private int TotalPages => listasEventSession.Count > 0 ? (int)Math.Ceiling((double)listasEventSession.Count / PageSize) : 1;
        private bool CanGoPrevious => CurrentPage > 1;
        private bool CanGoNext => CurrentPage < TotalPages;

        private void PreviousPage()
        {
            if (CanGoPrevious)
            {
                CurrentPage--;
            }
        }

        private void NextPage()
        {
            if (CanGoNext)
            {
                CurrentPage++;
            }
        }

        private string sortColumn = nameof(EventUserDto.Nombre);
        private bool sortAscending = true;

        private void OrdenarPor(string column)
        {
            if (sortColumn == column)
            {
                sortAscending = !sortAscending;
            }
            else
            {
                sortColumn = column;
                sortAscending = true;
            }

            //listasEventSession = sortAscending
            //    ? listasEventSession.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
            //    : listasEventSession.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }

        protected override void OnParametersSet()
        {
            Console.WriteLine($"Usuario seleccionado: {selectUser}");
            Console.WriteLine($"Fecha inicio: {dateStart}");
            Console.WriteLine($"Fecha fin: {dateEnd}");
        }


        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await JS.InvokeVoidAsync("initMap");
            }
        }

        private async Task verReport(reporteView report)
        {
            isLoading = true;

            selectView = report;

            try
            {
                switch (report)
                {
                    case reporteView.TiempoSession:
                        listasEventSession = await EventService.GetEventSessionAsync();
                        break;
                    case reporteView.PaginasMasVisitadas:
                        listasEventPagMasVist = await EventService.GetEventPagMasVistAsync();
                        break;
                    case reporteView.FiltroMasUsado:
                        listasEventFiltrMasUsad = await EventService.GetEventFiltroMasUsadAsync();
                        break;
                }
            }
            finally
            {
                isLoading = false;
            }
        }

        private async Task verGrafica(reporteView report)
        {
            IsModalOpen = true;

            switch (report)
            {
                case reporteView.TiempoSession:
                    await CargarDatos();
                    break;
                case reporteView.PaginasMasVisitadas:
                    await CargarDatosPagMasVisit();
                    break;
                case reporteView.FiltroMasUsado:
                    await CargarDatosFiltrMasUsad();
                    break;
            }
            await Task.Delay(500);
            await JS.InvokeVoidAsync("invalidateSize");
        }

        private void CloseModal()
        {
            IsModalOpen = false;
        }

        public async Task CargarDatos()
        {

            if (listasEventSession != null)
            {

                heatmapData.Clear();
                var markers = new List<object>();

                var zoomLevel = await JS.InvokeAsync<int>("getMapZoom");

                foreach (var session in listasEventSession)
                {
                    if (session.Latitud != null && session.Longitud != null)
                    {

                        double zoomFactor = Math.Pow(2, (15 - zoomLevel));
                        double adjustedIntensity = session.TiempoDeConeccionEnMin / zoomFactor;

                        heatmapData.Add(new HeatmapPoint
                        {
                            Lat = session.Latitud,
                            Lng = session.Longitud,
                            Intensity = adjustedIntensity
                        });

                        var display = $"{session.CodigoHomologacionRol}, {session.TiempoDeConeccionEnMin}Min";
                        await JS.InvokeVoidAsync("addMarker", session.Latitud, session.Longitud, display);
                    }
                }

                await JS.InvokeVoidAsync("addHeatmapData", heatmapData);
            }
        }

        public async Task CargarDatosPagMasVisit()
        {

            if (listasEventPagMasVist != null)
            {
                foreach (var session in listasEventPagMasVist)
                {
                    if (session.Latitud != null && session.Longitud != null)
                    {
                        heatmapData.Add(new HeatmapPoint
                        {
                            Lat = session.Latitud,
                            Lng = session.Longitud,
                            Intensity = session.uso
                        });

                        var display = $"{session.CodigoHomologacionRol}, {session.uso}";

                        await JS.InvokeVoidAsync("addMarker", session.Latitud, session.Longitud, display);
                    }

                }
            }

            await JS.InvokeVoidAsync("addHeatmapData", heatmapData);
        }

        public async Task CargarDatosFiltrMasUsad()
        {

            if (listasEventFiltrMasUsad != null)
            {
                foreach (var session in listasEventFiltrMasUsad)
                {
                    if (session.Latitud != null && session.Longitud != null)
                    {
                        heatmapData.Add(new HeatmapPoint
                        {
                            Lat = session.Latitud,
                            Lng = session.Longitud,
                            Intensity = session.Uso
                        });

                        var display = $"{session.CodigoHomologacionRol}, {session.Uso}";

                        await JS.InvokeVoidAsync("addMarker", session.Latitud, session.Longitud, display);
                    }

                }
            }

            await JS.InvokeVoidAsync("addHeatmapData", heatmapData);
        }

        private void GoBack()
        {
            Navigation.NavigateTo(Routes.EVENTOS, forceLoad: false);
        }

        private async Task ExportarExcel(reporteView typeReport)
        {
            try
            {
                string url = null;

                switch (typeReport)
                {
                    case reporteView.TiempoSession:
                        //if (listasEventSession.Any())
                        //    url = await iUtilitiesService.ExportarExcelAsync(listasEventSession.ToList());
                        break;

                    case reporteView.PaginasMasVisitadas:
                        //if (listasEventPagMasVist.Any())
                        //    url = await iUtilitiesService.ExportarExcelAsync(listasEventPagMasVist.ToList());
                        break;

                    case reporteView.FiltroMasUsado:
                        //if (listasEventFiltrMasUsad.Any())
                        //    url = await iUtilitiesService.ExportarExcelAsync(listasEventFiltrMasUsad.ToList());
                        break;

                    default:
                        Console.WriteLine("Tipo de reporte no soportado.");
                        return;
                }

                if (!string.IsNullOrEmpty(url))
                {
                    await JSRuntime.InvokeVoidAsync("open", url, "_blank");
                }
                else
                {
                    Console.WriteLine("No se pudo generar el archivo Excel o no había datos.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al exportar Excel: {ex.Message}");
            }
        }


        public class HeatmapPoint
        {
            public double? Lat { get; set; }
            public double? Lng { get; set; }
            public double Intensity { get; set; }
        }
    }
}
