using BlazorBootstrap;
using Infractruture.Interfaces;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using OfficeOpenXml;
using SharedApp.Dtos;
using System.Text.Json;


namespace ClientAppAdministrador.Pages.Administracion.Eventos
{
    public partial class List_Event
    {
        [Inject] NavigationManager NavigationManager { get; set; }
        private DateOnly fini { get; set; } = DateOnly.FromDateTime(DateTime.Now);
        private DateOnly ffin { get; set; } = DateOnly.FromDateTime(DateTime.Now);
        [Inject]
        public IEventService? iEventService { get; set; }
        [Inject]
        public IJSRuntime JSRuntime { get; set; }
        private List<VwEventUserAllDto>? listaRep;
        private string sortColumn = nameof(EventUserDto.Nombre);
        private bool sortAscending = true;
        private bool isLoading;
        private string selectReport;
        private List<EventUserDto> listasEvent = new();
        private int ProgressValue { get; set; } = 0;
        private int PageSize = 10; // Cantidad de registros por página
        private int CurrentPage = 1;
        private IEnumerable<EventUserDto> PaginatedItems => listasEvent
              .Skip((CurrentPage - 1) * PageSize)
              .Take(PageSize);
        private int TotalPages => listasEvent.Count > 0 ? (int)Math.Ceiling((double)listasEvent.Count / PageSize) : 1;
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
        protected override async Task OnInitializedAsync()
        {
            listaRep = await iEventService.GetListEventUserAllAsync();
        }
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

            listasEvent = sortAscending
                ? listasEvent.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
                : listasEvent.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }
        private void SelectValue(ChangeEventArgs e)
        {
            selectReport = e.Value.ToString();
            clearData();
        }

        private async Task SearchEvent()
        {
            try
            {
                if (selectReport != null)
                {
                    isLoading = true;
                    listasEvent = await iEventService.GetEventAsync(selectReport, fini, ffin) ?? new List<EventUserDto>();
                }
  
            }
            finally
            {
                isLoading = false;
               
            }

            StateHasChanged();
        }
        private async Task ExportarExcel()
        {
            if (listasEvent == null || !listasEvent.Any())
            {
                return;
            }
            try
            {
                var url = await iEventService.ExportarExcelAsync();

                await JSRuntime.InvokeVoidAsync("open", url, "_blank");

            }
            catch (Exception ex)
            {
                 Console.WriteLine(ex.ToString());
            }
        }

        private async Task ExportarPDF()
        {
            if (listasEvent == null || !listasEvent.Any())
            {
                return;
            }
            try
            {
                var url = await iEventService.ExportarPdfAsync();

                await JSRuntime.InvokeVoidAsync("open", url, "_blank");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
        private async Task DeleteEventAll()
        {
            var result = await JSRuntime.InvokeAsync<JsonElement>("Swal.fire", new
            {
                title = "¿Estás seguro?",
                text = "Esta acción eliminará todo y no podrá ser consultado nuevamente.",
                icon = "warning",
                showCancelButton = true,
                confirmButtonColor = "#d33",
                cancelButtonColor = "#3085d6",
                confirmButtonText = "Sí, eliminar",
                cancelButtonText = "Cancelar"
            });

            bool isConfirmed = result.TryGetProperty("isConfirmed", out JsonElement isConfirmedElement) && isConfirmedElement.GetBoolean();

            if (isConfirmed)
            {

                var success = await iEventService.DeleteEventAllAsync(selectReport, fini, ffin);

                if (success)
                {
                    await JSRuntime.InvokeVoidAsync("Swal.fire", "Eliminado", "Los registros han sido eliminados correctamente.", "success");
                    await SearchEvent();
                }
                else
                {
                    await JSRuntime.InvokeVoidAsync("Swal.fire", "Error", "No se pudieron eliminar los registro.", "error");
                }
            }
        }

        private async Task DeleteByIdAsync(int codigoEvento)
        {

            var result = await JSRuntime.InvokeAsync<JsonElement>("Swal.fire", new
            {
                title = "¿Estás seguro?",
                text = "Esta acción eliminará el registro y no podrá ser consultado nuevamente.",
                icon = "warning",
                showCancelButton = true,
                confirmButtonColor = "#d33",
                cancelButtonColor = "#3085d6",
                confirmButtonText = "Sí, eliminar",
                cancelButtonText = "Cancelar"
            });

            // Extraer isConfirmed del JsonElement
            bool isConfirmed = result.TryGetProperty("isConfirmed", out JsonElement isConfirmedElement) && isConfirmedElement.GetBoolean();

            if (isConfirmed)
            {
                var success = await iEventService.DeleteEventByIdAsync(selectReport, codigoEvento);

                if (success)
                {
                    await JSRuntime.InvokeVoidAsync("Swal.fire", "Eliminado", "El registro ha sido eliminado correctamente.", "success");
                    await SearchEvent();
                }
                else
                {
                    await JSRuntime.InvokeVoidAsync("Swal.fire", "Error", "No se pudo eliminar el registro.", "error");
                }
            }
        }

        private void verReport()
        {
            NavigationManager.NavigateTo(Routes.REPORTE_FECHA_EVENTOS);
        }

        private void clearData()
        {
            listasEvent.Clear();
        }
    }
}