using BlazorBootstrap;
using Blazored.LocalStorage;
using SharedApp.Helpers;
using Infractruture.Interfaces;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using SharedApp.Dtos;
using Infractruture.Services;


namespace ClientAppAdministrador.Pages.Administracion.Grupo
{
    /// <summary>
    /// Página de listado de homologaciones dentro de un grupo.
    /// Permite visualizar, paginar, eliminar y reordenar los registros de homologaciones.
    /// </summary>
    public partial class Listado
    {
        private bool isLoading = false;
        // Componente de la grilla para mostrar los registros
        private Grid<HomologacionDto>? grid;
        // Lista de homologaciones obtenidas desde el servicio
        private List<HomologacionDto>? listaHomologacions = new List<HomologacionDto>();
        /// <summary>
        /// Servicio de catálogos, utilizado para obtener la lista de homologaciones.
        /// </summary>
        [Inject]
        private ICatalogosService? iCatalogosService { get; set; }
        /// <summary>
        /// Servicio de homologación, utilizado para gestionar eliminaciones y actualizaciones.
        /// </summary>
        [Inject]
        private IHomologacionService? iHomologacionService { get; set; }
        /// <summary>
        /// Evento que se dispara cuando los datos han sido cargados.
        /// </summary>
        public event Action? DataLoaded;
        /// <summary>
        /// Servicio de búsqueda y registro de eventos.
        /// </summary>
        [Inject]
        private IBusquedaService iBusquedaService { get; set; }
        // Objeto para el seguimiento de eventos
        private EventTrackingDto objEventTracking { get; set; } = new();
        /// <summary>
        /// Servicio de almacenamiento local en el navegador.
        /// </summary>
        [Inject]
        ILocalStorageService iLocalStorageService { get; set; }

        // 🆕 Paginación
        private int DisplayPages = 10;
        private int ActivePageNumber = 1;
        private int TotalItems => listaHomologacions?.Count ?? 0;
        private int TotalPages => TotalItems > 0 ? (int)Math.Ceiling((double)TotalItems / DisplayPages) : 1;

        private IEnumerable<HomologacionDto> PaginatedItems => listaHomologacions?
            .Skip((ActivePageNumber - 1) * DisplayPages)
            .Take(DisplayPages)
            .ToList() ?? new List<HomologacionDto>();

        private async Task OnDisplayPagesChanged(int newDisplayPages)
        {
            DisplayPages = newDisplayPages;
            ActivePageNumber = 1;
            await LoadGrupo();
        }

        private async Task OnActivePageNumberChanged(int newPage)
        {
            ActivePageNumber = newPage;
            await LoadGrupo();
        }


        /// <summary>
        /// Método asincrónico que se ejecuta al inicializar el componente.
        /// Carga la lista de homologaciones desde el servicio de catálogos.
        /// </summary>
        protected override async Task OnInitializedAsync()
        {
            isLoading = true;
            objEventTracking.CodigoHomologacionMenu = Routes.GRUPO;
            objEventTracking.NombreAccion = Constantes.ON_INITIALIZED;
            objEventTracking.NombreControl = "grupos";
            objEventTracking.idUsuario = await iLocalStorageService.GetItemAsync<int>(Inicializar.Datos_Usuario_Local);
            objEventTracking.CodigoHomologacionRol = await iLocalStorageService.GetItemAsync<string>(Inicializar.Datos_Usuario_Codigo_Rol_Local);
            objEventTracking.ParametroJson =  Constantes.JSON_VACIO;
            objEventTracking.UbicacionJson =  Constantes.VACIO;
            await iBusquedaService.AddEventTrackingAsync(objEventTracking);

            if (iCatalogosService != null)
            {
                listaHomologacions = await iCatalogosService.GetHomologacionAsync<List<HomologacionDto>>("grupos");
            }
            // Ajusta la paginación si la lista está vacía o cambia
            isLoading = false;
        }

        /// <summary>
        /// Método invocable desde JavaScript para actualizar el orden de las homologaciones.
        /// </summary>
        /// <param name="sortedIds">Lista ordenada de IDs de homologaciones.</param>
        [JSInvokable]
        public async Task OnDragEnd(string[] sortedIds)
        {
            if (listaHomologacions != null)
            {
                // Actualiza el orden en la lista local
                var ordenados = new List<HomologacionDto>();
                for (int i = 0; i < sortedIds.Length; i++)
                {
                    HomologacionDto? homo = listaHomologacions.FirstOrDefault(h => h.IdHomologacion == int.Parse(sortedIds[i]));
                    if (homo != null)
                    {
                        homo.MostrarWebOrden = i + 1; // Actualiza el orden en memoria
                        ordenados.Add(homo);
                        if (iHomologacionService != null)
                        {
                            if (homo.IdHomologacion == 0)
                            {
                                await iHomologacionService.Registrar(homo);
                            }
                            else
                            {
                                await iHomologacionService.Actualizar(homo);
                            }
                        }
                    }
                }

                // Reemplaza la lista original con la lista ordenada
                listaHomologacions = ordenados;

                // Refresca el grid
                if (grid != null)
                {
                    await grid.RefreshDataAsync();
                }
            }
        }

        private string sortColumn = nameof(HomologacionDto.MostrarWeb);
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

            listaHomologacions = sortAscending
                ? listaHomologacions.OrderBy(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList()
                : listaHomologacions.OrderByDescending(x => x.GetType().GetProperty(sortColumn)?.GetValue(x, null)).ToList();
        }

        private async Task LoadGrupo()
        {
            if (iCatalogosService != null)
            {
                listaHomologacions = await iCatalogosService.GetHomologacionAsync<List<HomologacionDto>>("grupos");
            }
        }

        private async Task ExportarExcel()
        {
            if (listaHomologacions == null || !listaHomologacions.Any())
            {
                return;
            }

            try
            {
                var base64 = await iHomologacionService.ExportarExcelAsync();
                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.xlsx";
                await JSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }

        private async Task ExportarPDF()
        {
            if (listaHomologacions == null || !listaHomologacions.Any())
            {
                return;
            }

            try
            {
                var base64 = await iHomologacionService.ExportarPdfAsync();
                var fileName = $"export_{DateTime.Now:yyyy-MM-dd_HHmmss}.pdf";
                await JSRuntime.InvokeVoidAsync("descargarArchivoExcel", base64, fileName);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }
    }
}