using System.Data;
using DataAccess.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using DataAccess.Models;
using SharedApp;


namespace DataAccess.Repositories
{
    public class EsquemaVistaRepository : BaseRepository, IEsquemaVistaRepository
    {

        public EsquemaVistaRepository(
          ILogger<EsquemaVistaRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {

        }
        public bool Create(EsquemaVista data)
        {
            data.IdUserModifica = data.IdUserCreacion;

            return ExecuteDbOperation(context =>
            {
                context.EsquemaVista.Add(data);
                return context.SaveChanges() >= 0;
            });
        }
        public EsquemaVista? FindById(int id)
        {
            return ExecuteDbOperation(context => context.EsquemaVista.AsNoTracking().FirstOrDefault(u => u.IdEsquemaVista == id));
        }
        public EsquemaVista? FindByIdEsquema(int idEsquema)
        {
            return ExecuteDbOperation(context => context.EsquemaVista.AsNoTracking().FirstOrDefault(u => u.IdEsquema == idEsquema));
        }
        public EsquemaVista? _FindByIdEsquema(int idEsquema, int idOna)
        {
            return ExecuteDbOperation(context =>
                context.EsquemaVista
                    .AsNoTracking()
                    .FirstOrDefault(u => u.IdEsquema == idEsquema && u.IdONA == idOna && u.Estado == Constantes.ESTADO_USUARIO_A));
        }
        public async Task<EsquemaVista?> _FindByIdEsquemaAsync(int idEsquema, int idOna)
        {
            return await ExecuteDbOperation(async context =>
                await context.EsquemaVista
                    .AsNoTracking()
                    .FirstOrDefaultAsync(u => u.IdEsquema == idEsquema && u.IdONA == idOna && u.Estado == Constantes.ESTADO_USUARIO_A)
            );
        }

        public List<EsquemaVista> FindAll()
        {
            try
            {
                return ExecuteDbOperation(context => context.EsquemaVista.AsNoTracking().Where(c => c.Estado.Equals(Constantes.ESTADO_USUARIO_A)).ToList());
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }
        public bool Update(EsquemaVista newRecord)
        {
            return ExecuteDbOperation(context =>
            {
                var _exits = MergeEntityProperties(context, newRecord, u => u.IdEsquemaVista == newRecord.IdEsquemaVista);
                _exits.FechaModifica = DateTime.Now;
                context.EsquemaVista.Update(_exits);
                return context.SaveChanges() >= 0;
            });
        }

    }
}
