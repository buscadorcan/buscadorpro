using DataAccess.Interfaces;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Configuration;
using System.Data;

namespace DataAccess.Repositories
{
    public class ImportarRepository : IImportarRepository
    {
        private string connectionString = "";
        private readonly string idEnteName = "IdOrganizacion";
        private readonly int executionIndex = 0;
        private readonly int[] heids = [];
        private readonly string[] vids = [];
        private bool deleted = false;

        public ImportarRepository(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("Mssql-CanDb");
        }

        public string buildSelectViewQuery(int[] homologacionIds, string[] selectFields, string viewName)
        {
            using SqlConnection connection = new SqlConnection(connectionString);

            if (!viewExists(connection, viewName))
            {
                Console.WriteLine($"Vista {viewName} no existe");
                return "";
            }

            List<int> newHomologacionIds = new List<int>();
            List<string> newSelectFields = new List<string>();

            foreach (string field in selectFields)
            {
                if (fieldExists(connection, viewName, field))
                {
                    int homologacionId = homologacionIds[Array.IndexOf(selectFields, field)];
                    newHomologacionIds.Add(homologacionId);
                    newSelectFields.Add(field);
                }
                else
                {
                    Console.WriteLine($"Field {field} does not exist in view {viewName}");
                    continue;
                }
            }
            string newSelectFieldsStr = string.Join(", ", newSelectFields);

            if (fieldExists(connection, viewName, idEnteName))
            {
                newSelectFieldsStr += $", {idEnteName}";
            }
            else
            {
                Console.WriteLine($"Field {idEnteName} does not exist in view {viewName}");
            }
            if (fieldExists(connection, viewName, vids[executionIndex]))
            {
                newSelectFieldsStr += ", " + vids[executionIndex];
            }
            else
            {
                Console.WriteLine("Field " + vids[executionIndex] + " does not exist in view " + viewName);
            }

            return $"SELECT {newSelectFieldsStr} FROM {viewName}";
        }

        private static bool viewExists(SqlConnection connection, string viewName)
        {
            throw new NotImplementedException();
        }

        private static bool fieldExists(SqlConnection connection, string viewName, string fieldName)
        {
            // This shall be validated through the conexion data base, tihi only works for SQL SERVER, it shall work for all the supported data bases
            string query = $"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{viewName}' AND COLUMN_NAME = '{fieldName}'";
            SqlCommand command = new SqlCommand(query, connection);
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            return dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0;
        }
        private bool deleteOldRecords(int IdHomologacionEsquema)
        {
            if (deleted)
            {
                return true;
            }

            deleted = true;
            return false;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="selectQuery"></param>
        /// <returns></returns>
        public bool executeQueryView(string selectQuery)
        {
            using SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                SqlCommand command = new SqlCommand(selectQuery, connection);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                connection.Open();
                adapter.Fill(dataSet);
                if (dataSet.Tables.Count < 1 || dataSet.Tables[0].Rows.Count < 1)
                {
                    Console.WriteLine("No tables found");
                    return false;
                }
                DataColumnCollection columns = dataSet.Tables[0].Columns;

                foreach (DataRow row in dataSet.Tables[0].Rows)
                {
                    deleteOldRecords(heids[executionIndex]);
                }
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
            finally
            {
                connection.Close();
            }
        }
    }
}
