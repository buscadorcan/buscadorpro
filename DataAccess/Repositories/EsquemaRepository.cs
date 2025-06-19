using System.Data;
using DataAccess.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using DataAccess.Models;
using SharedApp;

namespace DataAccess.Repositories
{
    public class EsquemaRepository : BaseRepository, IEsquemaRepository
    {
        public EsquemaRepository(
          ILogger<EsquemaRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {
        }
        public bool Create(Esquema data)
        {
            data.IdUserModifica = data.IdUserCreacion;
            data.FechaCreacion = DateTime.Now;
            data.FechaModifica = DateTime.Now;
            data.Estado = Constantes.ESTADO_USUARIO_A;

            return ExecuteDbOperation(context =>
            {
                context.Esquema.Add(data);
                return context.SaveChanges() >= 0;
            });
        }
        public bool CreateEsquemaValidacion(EsquemaVista data)
        {
            data.IdUserModifica = data.IdUserCreacion;
            data.FechaModifica = DateTime.Now;
            data.Estado = Constantes.ESTADO_USUARIO_A;

            return ExecuteDbOperation(context =>
            {
                context.EsquemaVista.Add(data);
                return context.SaveChanges() >= 0;
            });
        }
        public Esquema? FindById(int id)
        {
            return ExecuteDbOperation(context => context.Esquema.AsNoTracking().FirstOrDefault(u => u.IdEsquema == id));
        }
        public EsquemaVistaColumna? GetEsquemaVistaColumnaByIdEquemaVistaAsync(int idOna, int idEsquema)
        {
            return ExecuteDbOperation(context =>
            {
                // Obtener el idEsquemaVista basado en idOna e idEsquema
                var idEsquemaVista = context.EsquemaVista
                    .Where(v => v.IdONA == idOna && v.IdEsquema == idEsquema && v.Estado == Constantes.ESTADO_USUARIO_A)
                    .Select(v => v.IdEsquemaVista)
                    .FirstOrDefault();

                // Si no se encuentra un idEsquemaVista válido, retornar null
                if (idEsquemaVista == 0)
                {
                    return null;
                }

                // Buscar los datos de EsquemaVistaColumna con el idEsquemaVista obtenido
                return context.EsquemaVistaColumna
                    .AsNoTracking()
                    .FirstOrDefault(u => u.IdEsquemaVista == idEsquemaVista);
            });
        }

        public Esquema? FindByViewName(string esquemaVista)
        {
            return ExecuteDbOperation(context => context.Esquema.AsNoTracking().FirstOrDefault(u => u.EsquemaVista == esquemaVista));
        }
        public async Task<Esquema?> FindByViewNameAsync(string esquemaVista)
        {
            return await ExecuteDbOperation(async context =>
                await context.Esquema.AsNoTracking().FirstOrDefaultAsync(u => u.EsquemaVista == esquemaVista)
            );
        }

        public List<Esquema> FindAll()
        {
            return ExecuteDbOperation(context => context.Esquema.AsNoTracking().Where(c => c.Estado.Equals(Constantes.ESTADO_USUARIO_A)).OrderBy(c => c.MostrarWebOrden).ToList());
        }
        public List<Esquema> FindAllWithViews()
        {
            return ExecuteDbOperation(context => context.Esquema.AsNoTracking().Where(c => c.Estado == Constantes.ESTADO_USUARIO_A && c.EsquemaVista != null && !string.IsNullOrEmpty(c.EsquemaVista.Trim())).OrderBy(c => c.MostrarWebOrden).ToList());
        }
        public bool Update(Esquema newRecord)
        {
            return ExecuteDbOperation(context =>
            {
                var _exits = MergeEntityProperties(context, newRecord, u => u.IdEsquema == newRecord.IdEsquema);

                _exits.FechaModifica = DateTime.Now;

                context.Esquema.Update(_exits);
                return context.SaveChanges() >= 0;
            });
        }
        public bool EliminarEsquemaVistaColumnaByIdEquemaVistaAsync(int IdEsquemaVista)
        {
            return ExecuteDbOperation(context =>
            {
                // Obtener todos los registros que coincidan con el IdEsquemaVista
                var registros = context.EsquemaVistaColumna
                    .Where(e => e.IdEsquemaVista == IdEsquemaVista)
                    .ToList();

                if (registros.Any())
                {
                    foreach (var registro in registros)
                    {
                        registro.Estado = Constantes.MESAGGE_REGISTRO_NO_ENCOTRADO; // Actualizar el estado
                        registro.FechaModifica = DateTime.Now;
                    }

                    // Guardar los cambios en el contexto
                    context.EsquemaVistaColumna.UpdateRange(registros);
                }

                return context.SaveChanges() >= 0;
            });
        }

        public bool UpdateEsquemaValidacion(EsquemaVista newRecord)
        {
            return ExecuteDbOperation(context =>
            {
                // Buscar el registro existente
                var existingRecord = context.EsquemaVista
                    .FirstOrDefault(u => u.IdONA == newRecord.IdONA && u.IdEsquema == newRecord.IdEsquema);

                if (existingRecord != null)
                {
                    // Actualizar el registro existente
                    existingRecord = MergeEntityProperties(context, newRecord, u => u.IdONA == newRecord.IdONA &&
                                                                                     u.IdEsquema == newRecord.IdEsquema);
                    existingRecord.FechaModifica = DateTime.Now;
                    context.EsquemaVista.Update(existingRecord);
                }
                else
                {
                    // Crear un nuevo registro
                    newRecord.FechaCreacion = DateTime.Now;
                    newRecord.Estado = Constantes.ESTADO_USUARIO_A;

                    context.EsquemaVista.Add(newRecord);
                }

                // Guardar cambios en ambos casos
                return context.SaveChanges() >= 0;
            });
        }
        public List<Esquema> GetListaEsquemaByOna(int idONA)
        {
            return ExecuteDbOperation(context =>
                (from e in context.Esquema
                 where e.Estado == Constantes.ESTADO_USUARIO_A // Solo registros activos
                 select new Esquema
                 {
                     IdEsquema = e.IdEsquema,
                     EsquemaVista = e.EsquemaVista,
                     MostrarWeb = e.MostrarWeb,
                     MostrarWebOrden = e.MostrarWebOrden,
                     TooltipWeb = e.TooltipWeb,
                     EsquemaJson = e.EsquemaJson
                 }).ToList()
            );
        }

        public bool GuardarListaEsquemaVistaColumna(List<EsquemaVistaColumna> listaEsquemaVistaColumna, int? idOna, int? idEsquema)
        {
            // Validamos que la lista no esté vacía
            if (listaEsquemaVistaColumna == null || !listaEsquemaVistaColumna.Any())
            {
                return false;
            }

            return ExecuteDbOperation(context =>
            {
                // Obtenemos el idEsquemaVista
                var idEsquemaVista = context.EsquemaVista
                    .Where(v => v.IdONA == idOna && v.IdEsquema == idEsquema && v.Estado == Constantes.ESTADO_USUARIO_A)
                    .Select(v => v.IdEsquemaVista)
                    .FirstOrDefault();

                // Si no se encuentra idEsquemaVista, retornamos false
                if (idEsquemaVista == 0)
                {
                    return false;
                }

                // Asignamos valores comunes a cada elemento de la lista
                var fechaActual = DateTime.Now;

                foreach (var item in listaEsquemaVistaColumna)
                {
                    item.IdUserCreacion = 0; // userId
                    item.IdUserModifica = 0; // userId
                    item.FechaModifica = fechaActual;
                    item.Estado = Constantes.ESTADO_USUARIO_A;
                    item.IdEsquemaVista = idEsquemaVista; // Asignamos el idEsquemaVista
                }

                // Añadimos toda la lista al contexto
                context.EsquemaVistaColumna.AddRange(listaEsquemaVistaColumna);
                return context.SaveChanges() >= 0;
            });
        }

    }
}
