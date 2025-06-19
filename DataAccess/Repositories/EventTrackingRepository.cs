using DataAccess.Interfaces;
using DataAccess.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SharedApp.Dtos;
using System.Text.RegularExpressions;

namespace DataAccess.Repositories
{
    public class EventTrackingRepository : BaseRepository, IEventTrackingRepository
    {
        public EventTrackingRepository(
          ILogger<EventTrackingRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {

        }
        /// <inheritdoc />
        public bool Create(paAddEventTrackingDto data)
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    return context.Database.SqlQueryRaw<bool>(
                        "exec paAddEventTracking @CodigoHomologacionRol, @NombreUsuario, @CodigoHomologacionMenu, @NombreControl, @NombreAccion, @UbicacionJson, @ParametroJson",
                        new SqlParameter("@CodigoHomologacionRol", data.CodigoHomologacionRol),
                        new SqlParameter("@NombreUsuario", data.NombreUsuario),
                        new SqlParameter("@CodigoHomologacionMenu", data.CodigoHomologacionMenu),
                        new SqlParameter("@NombreControl", data.NombreControl),
                        new SqlParameter("@NombreAccion", data.NombreAccion),
                        new SqlParameter("@UbicacionJson", data.UbicacionJson),
                        new SqlParameter("@ParametroJson", data.ParametroJson)
                    ).AsEnumerable().FirstOrDefault();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing stored procedure paAddEventTracking");
                    return false;
                }
            });
        }
        /// <inheritdoc />
        public string GetCodeByUser(string nombreUsuario, string codigoHomologacionRol, string codigoHomologacionMenu)
        {
            try
            {
                return ExecuteDbOperation(context =>
                {
                    var result = context.EventTracking.AsNoTracking()
                        .Where(u => u.CodigoHomologacionRol == codigoHomologacionRol && u.CodigoHomologacionMenu == codigoHomologacionMenu)
                        .OrderByDescending(o => o.FechaCreacion)
                        .FirstOrDefault();

                    return result != null ? JsonConvert.DeserializeObject<JObject>(result.ParametroJson)?["Code"]?.ToString() : null;
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error executing query EventTracking");
                return string.Empty;
            }
        }
        public List<EventUser> GetEventAll(string report, DateOnly fini, DateOnly ffin)
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    // Validar el nombre de la tabla (evita inyecci�n SQL)
                    if (!Regex.IsMatch(report, "^[a-zA-Z0-9_]+$"))
                    {
                        throw new ArgumentException("Nombre de tabla inv�lido.");
                    }

                    // Construir SQL din�mico
                    string sql = $"SELECT * FROM {report} WHERE CAST(fechaCreacion AS DATE) BETWEEN @fini AND @ffin";

                    return context.EventUser
                       .FromSqlRaw(sql,
                           new SqlParameter("@fini", fini),
                           new SqlParameter("@ffin", ffin))
                       .ToList();

                    ;
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing query GetEventAll");
                    return [];
                }
            });
        }

        public List<VwEventUserAll> GetEventUserAll()
        {
            return ExecuteDbOperation(context => context.VwEventUserAll.AsNoTracking().ToList());
        }


        public bool DeleteEventAll(DateOnly fini, DateOnly ffin)
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    string sql = $"DELETE FROM EventTracking WHERE CAST(fechaCreacion AS DATE) BETWEEN @fini AND @ffin";

                    int rowsAffected = context.Database.ExecuteSqlRaw(
                                 sql,
                                  new SqlParameter("@fini", fini),
                                  new SqlParameter("@ffin", ffin)
                              );

                    return rowsAffected > 0; // Devuelve true si se elimin� al menos una fila
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing query DeleteEventAll");
                    return false;
                }
            });
        }

        public bool DeleteEventById(int id)
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    string sql = "DELETE FROM EventTracking WHERE IdEventTracking = @id";

                    int rowsAffected = context.Database.ExecuteSqlRaw(
                        sql,
                        new SqlParameter("@id", id)
                    );

                    return rowsAffected > 0; // Devuelve true si se elimin� al menos una fila
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing query DeleteEventById");
                    return false;
                }
            });

        }

        public Menus? FindDataById(int idHRol, int idHMenu)
        {
            throw new NotImplementedException();
        }

        public List<VwEventTrackingSessionDto> GetEventSession()
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    string sql = "exec GetTiempoEnSession";
                    return context.EventSession
                       .FromSqlRaw(sql)
                       .ToList();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing query GetEventSession");
                    return [];
                }
            });
        }

        public List<PaginasMasVisitadaDto> GetEventPagMasVisit()
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    string sql = "exec getPaginasMasVisitada";
                    return context.EventPagMasVisit
                       .FromSqlRaw(sql)
                       .ToList();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing query GetEventPagMasVisit");
                    return [];
                }
            });
        }

        public List<FiltrosMasUsadoDto> GetEventFiltroMasUsa()
        {
            return ExecuteDbOperation(context =>
            {
                try
                {
                    string sql = "Exec GetFiltroMasUsado";
                    return context.EventFiltroMasUsado
                       .FromSqlRaw(sql)
                       .ToList();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error executing query GetEventFiltroMasUsa");
                    return [];
                }
            });
        }
    }
}