using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using Newtonsoft.Json.Linq;
using SharedApp;
using SharedApp.Dtos;

namespace Core.Service.IService
{
    public class ImportadorService : IImportador
    {
        private readonly IHomologacionRepository _repositoryH;
        private readonly IEsquemaRepository _repositoryHE;
        private readonly IONAConexionService _serviceC;
        private readonly IMapper mapper;
        private readonly IImportarRepository importarRepository;
        private int executionIndex = 0;
        private string[] views = [];
        private string[] schemas = [];
        private string connectionString;

        public ImportadorService(
            IHomologacionRepository homologacionRepository,
            IEsquemaRepository homologacionEsquemaRepository,
            IONAConexionService conexionService,
            IMapper mapper,
            IImportarRepository importarRepository
        )
        {
            _repositoryH = homologacionRepository;
            _repositoryHE = homologacionEsquemaRepository;
            _serviceC = conexionService;
            this.mapper = mapper;
            this.importarRepository = importarRepository;
        }
        public Boolean Importar(string[] vistas)
        {
            try
            {
                // Agregar obtensión de vistas de base de datos
                List<ONAConexionDto> conexiones = _serviceC.FindAll()
                    .Where(w => !w.Migrar.Equals(Constantes.CONEXION_MIGRAR_S))
                    .ToList();

                ConectionStringBuilderService conectionStringBuilderService = new ConectionStringBuilderService();
                List<Esquema> homologacionEsquemas = _repositoryHE.FindAllWithViews();
                HashSet<string> DBSchemas = homologacionEsquemas.Select(he => he.EsquemaJson).Where(v => v != null).Select(v => v!).ToHashSet();

                if (DBSchemas.Count > 0)
                {
                    schemas = DBSchemas.ToArray();
                }

                foreach (ONAConexionDto conexion in conexiones)
                {
                    ONAConexion currentConexion = mapper.Map<ONAConexion>(conexion);
                    connectionString = conectionStringBuilderService.BuildConnectionString(currentConexion);
                    ImportarSistema(views, connectionString);
                    conexion.Migrar = Constantes.CONEXION_MIGRAR_N;
                    _serviceC.Update(conexion);
                }

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

        public bool ImportarSistema(string[] vistas, string connectionString)
        {
            if (connectionString != null)
            {
                this.connectionString = connectionString;
            }

            bool result = true;

            if (vistas != null && vistas.Length > 0)
            {
                views = vistas;
            }

            foreach (string view in views)
            {
                executionIndex = Array.IndexOf(views, view);
                result = result && Leer(view);
            }
            return result;
        }

        public bool Leer(string viewName)
        {
            string currentSchema = schemas[executionIndex];
            JArray schemaArray = JArray.Parse(currentSchema);
            int[] homologacionIds = Array.Empty<int>();

            foreach (JObject item in schemaArray)
            {
                int idHomologacion = item.Value<int>("IdHomologacion");
                homologacionIds = homologacionIds.Append(idHomologacion).ToArray();
            }

            List<Homologacion> homologaciones = _repositoryH.FindByIds(homologacionIds);
            int[] newHomologacionIds = homologaciones.Select(h => h.IdHomologacion).ToArray();
            string[] newSelectFields = homologaciones.Select(h => h.NombreHomologado ?? "").ToArray();

            string selectQuery = importarRepository.buildSelectViewQuery(newHomologacionIds, newSelectFields, viewName);

            if (selectQuery == "")
            {
                return false;
            }

            return importarRepository.executeQueryView(selectQuery);
        }
    }
}