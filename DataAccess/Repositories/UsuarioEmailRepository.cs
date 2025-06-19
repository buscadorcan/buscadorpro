using Dapper;
using DataAccess.Interfaces;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using SharedApp.Dtos;
using System.Data;

namespace DataAccess.Repositories
{
    public class UsuarioEmailRepository(IConfiguration configuration) : IUsuarioEmailRepository
    {
        private readonly string _connectionString = configuration.GetConnectionString("Mssql-CanDb");


        public UserEmailDto ObtenerUsuario(string User)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@usuario", User);

                    var result = connection.QueryFirst<UserEmailDto>("sp_obtenerUsuario", parameters, commandType: CommandType.StoredProcedure);

                    return result;
                }
            }
            catch
            {
                throw;
            }
        }

        public List<UserEmailDto> ObtenerUsuarios(int IdOna)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@IdONA", IdOna);

                    var result = connection.Query<UserEmailDto>("sp_obtenerUsuariosOna", parameters, commandType: CommandType.StoredProcedure);

                    return result.ToList();
                }
            }
            catch
            {
                throw;
            }
        }
    }
}