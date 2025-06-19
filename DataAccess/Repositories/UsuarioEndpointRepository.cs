using DataAccess.Interfaces;
using DataAccess.Models;
using Microsoft.Extensions.Logging;
using System.Data;
namespace DataAccess.Repositories
{
    public class UsuarioEndpointRepository : BaseRepository, IUsuarioEndpointRepository
    {
        public UsuarioEndpointRepository(
          ILogger<UsuarioEndpointRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {
        }
        public UsuarioEndpoint? FindByEndpointId(int endpointId)
        {
            return ExecuteDbOperation(context => context.UsuarioEndpoint.FirstOrDefault(c => c.IdUsuarioEndPoint == endpointId));
        }
        public ICollection<UsuarioEndpoint> FindAll()
        {
            return ExecuteDbOperation(context => context.UsuarioEndpoint.OrderBy(c => c.IdUsuarioEndPoint).ToList());
        }
        public bool Create(UsuarioEndpoint usuarioEndpoint)
        {
            usuarioEndpoint.IdUserModifica = usuarioEndpoint.IdUserCreacion;

            return ExecuteDbOperation(context =>
            {
                context.UsuarioEndpoint.Add(usuarioEndpoint);
                return context.SaveChanges() >= 0;
            });
        }
    }
}
