using DataAccess.Interfaces;
using DataAccess.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SharedApp;
using System.Data;
using System.Drawing.Printing;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public class HomologacionRepository : BaseRepository, IHomologacionRepository
    {
        public HomologacionRepository(
          ILogger<HomologacionRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {
        }

        private int ObtenerCantidadVwHomologacionPorCodigo(string codigoHomologacion)
        {
            return ExecuteDbOperation(context =>
             context.VwHomologacion
               .AsQueryable()
               .AsNoTracking()
               .Where(c => c.CodigoHomologacionKEY == codigoHomologacion)
               .Count()
            );
        }

        public bool Create(Homologacion data)
        {
            data.IdUserModifica = data.IdUserCreacion;
            data.Estado = Constantes.ESTADO_USUARIO_A;
            data.Mostrar = Constantes.ESTADO_USUARIO_S;
            data.Indexar = data.Indexar == null ? Constantes.INDEXAR_NO : data.Indexar.ToString();
            return ExecuteDbOperation(context =>
            {
                context.Homologacion.Add(data);
                return context.SaveChanges() >= 0;
            });
        }
        public Homologacion? FindById(int id)
        {
            return ExecuteDbOperation(context => context.Homologacion.AsNoTracking().FirstOrDefault(u => u.IdHomologacion == id));
        }
        public ICollection<Homologacion> FindByParent()
        {
            return ExecuteDbOperation(context =>
            {
                // Encuentra el IdHomologacion basado en el código en este caso KEY_DIM_ESQUEMA
                var parentId = context.Homologacion
                    .Where(h => h.CodigoHomologacion == "KEY_DIM_ESQUEMA")
                    .Select(h => h.IdHomologacion)
                    .FirstOrDefault();

                // Filtra por IdHomologacionGrupo y Estado
                return context.Homologacion
                    .Where(h => h.IdHomologacionGrupo == parentId && h.Estado == Constantes.ESTADO_USUARIO_A)
                    .OrderBy(h => h.MostrarWebOrden)
                    .AsNoTracking() // Similar a NOLOCK
                    .ToList();
            });
        }
        public List<Homologacion> FindByIds(int[] ids)
        {
            return ExecuteDbOperation(context => context.Homologacion.Where(c => ids.Contains(c.IdHomologacion)).OrderBy(c => c.MostrarWebOrden).ToList());
        }
        public bool Update(Homologacion newRecord)
        {
            return ExecuteDbOperation(context =>
            {
                var _exits = MergeEntityProperties(context, newRecord, u => u.IdHomologacion == newRecord.IdHomologacion);

                _exits.FechaModifica = DateTime.Now;
                context.Homologacion.Update(_exits);
                return context.SaveChanges() >= 0;
            });
        }
        /// <inheritdoc />
        public (List<VwHomologacion>, int TotalCount) ObtenerVwHomologacionPorCodigo(string codigoHomologacion, int PageNumber, int RowsPerPage, bool pagination = true)
        {
            List<VwHomologacion> vwHomologacions = new();
            int TotalCount = 0;

            if (pagination)
            {
                vwHomologacions = ExecuteDbOperation(context =>
                    context.VwHomologacion
                    .AsQueryable()
                    .AsNoTracking()
                    .Where(c => c.CodigoHomologacionKEY == codigoHomologacion)
                    .OrderBy(c => c.MostrarWeb)
                    .Skip((PageNumber - 1) * RowsPerPage)
                    .Take(RowsPerPage)
                    .ToList()
                );
                TotalCount = ObtenerCantidadVwHomologacionPorCodigo(codigoHomologacion);
            }
            else
            {
                vwHomologacions =  ExecuteDbOperation(context =>
                  context.VwHomologacion
                    .AsQueryable()
                    .AsNoTracking()
                    .Where(c => c.CodigoHomologacionKEY == codigoHomologacion)
                    .OrderBy(c => c.MostrarWeb)
                    .ToList()
                );
            }


                return (vwHomologacions, TotalCount);
        }

        public List<Homologacion> FindByAll()
        {
            return ExecuteDbOperation(context =>
            context.Homologacion
                    .Where(c => c.Estado == Constantes.ESTADO_USUARIO_A)
                    .ToList()
            );
        }
    }
}
