using DataAccess.Interfaces;
using DataAccess.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SharedApp;
using SharedApp.Dtos;
using System.Data;

namespace DataAccess.Repositories
{
    public class ONAConexionRepository : BaseRepository, IONAConexionRepository
    {
        public ONAConexionRepository(
          ILogger<ONAConexionRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {

        }
        public bool Create(ONAConexion data)
        {
            return ExecuteDbOperation(context =>
            {
                context.ONAConexion.Add(data);
                return context.SaveChanges() >= 0;
            });
        }
        public ONAConexion? FindById(int id)
        {
            return ExecuteDbOperation(context => context.ONAConexion.AsNoTracking().FirstOrDefault(u => u.IdONA == id));
        }
        public ONAConexion? FindByIdONA(int IdONA)
        {
            return ExecuteDbOperation(context => context.ONAConexion.AsNoTracking().FirstOrDefault(u => u.IdONA == IdONA));
        }
        public async Task<ONAConexion?> FindByIdONAAsync(int IdONA)
        {
            return await ExecuteDbOperation(async context =>
                await context.ONAConexion.AsNoTracking().FirstOrDefaultAsync(u => u.IdONA == IdONA)
            );
        }

        public List<ONAConexionDto> FindAll()
        {
            return ExecuteDbOperation(context =>
          context.ONAConexion
              .AsNoTracking()
              .Where(c => c.Estado == Constantes.ESTADO_USUARIO_A)
              .Include(c => c.ONA)
              .Select(c => new ONAConexionDto
              {
                  IdONA = c.IdONA,
                  Host = c.Host,
                  Puerto = c.Puerto,
                  Usuario = c.Usuario,
                  Contrasenia = c.Contrasenia,
                  BaseDatos = c.BaseDatos,
                  OrigenDatos = c.OrigenDatos,
                  Migrar = c.Migrar,
                  Estado = c.Estado,
                  Siglas = c.ONA != null ? c.ONA.Siglas : null,
                  HoraMigracion1 = c.HoraMigracion1,
                  HoraMigracion2 = c.HoraMigracion2,
                  HoraMigracion3 = c.HoraMigracion3
              })
              .ToList());

        }
        public List<ONAConexion> GetOnaConexionByOnaListAsync(int idOna)
        {
            return ExecuteDbOperation(context =>
                context.ONAConexion
                    .AsNoTracking()
                    .Where(c => c.IdONA == idOna && c.Estado == Constantes.ESTADO_USUARIO_A)
                    .ToList()
            );
        }

        public bool Update(ONAConexion newRecord, int userToken)
        {
            return ExecuteDbOperation(context =>
            {
                var _exits = MergeEntityProperties(context, newRecord, u => u.IdONA == newRecord.IdONA);

                _exits.FechaModifica = DateTime.Now;
                _exits.IdUserModifica = userToken;

                context.ONAConexion.Update(_exits);
                return context.SaveChanges() >= 0;
            });
        }

        /// <summary>
        ///  Actualiza las columnas de las horas en onaconexion
        /// </summary>
        /// <param name="IdOna"></param>
        /// <param name="dto"></param>
        /// <param name="userToken"></param>
        /// <returns></returns>
        public bool updateCrono(int IdOna, OnaConexionCronDto dto , int userToken)
        {
            return ExecuteDbOperation(context =>
            {
                var conexion = context.ONAConexion.FirstOrDefault(c => c.IdONA == IdOna);

                if (conexion == null)
                    return false;

                conexion.HoraMigracion1 = dto.HoraMigracion1;
                conexion.HoraMigracion2 = dto.HoraMigracion2;
                conexion.HoraMigracion3 = dto.HoraMigracion3;

                conexion.FechaModifica = DateTime.Now;
                conexion.IdUserModifica = userToken;

                context.ONAConexion.Update(conexion);
                return context.SaveChanges() > 0;
            });
        }
    }
}
