﻿using System.Data;
using DataAccess.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using DataAccess.Models;

namespace DataAccess.Repositories
{
    public class MigracionExcelRepository : BaseRepository, IMigracionExcelRepository
    {
        public MigracionExcelRepository(
          ILogger<MigracionExcelRepository> logger,
          ISqlServerDbContextFactory sqlServerDbContextFactory
        ) : base(sqlServerDbContextFactory, logger)
        {
        }

        public int FindAllCount()
        {
            return ExecuteDbOperation(context =>
                  context.MigracionExcel
                    .AsQueryable()
                    .AsNoTracking()
                    .Count()
              );
        }

        public LogMigracion Create(LogMigracion data)
        {
            return ExecuteDbOperation(context =>
            {
                context.LogMigracion.Add(data);
                context.SaveChanges();
                return data;
            });
        }
        public async Task<LogMigracion> CreateAsync(LogMigracion data)
        {
            try
            {
                return await ExecuteDbOperation(async context =>
                {
                    context.LogMigracion.Add(data);
                    await context.SaveChangesAsync();
                    return data;
                });
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        public MigracionExcel? FindById(int id)
        {
            return ExecuteDbOperation(context => context.MigracionExcel.AsNoTracking().FirstOrDefault(u => u.IdMigracionExcel == id));
        }
        public (List<MigracionExcel>, int) FindAll(int PageNumber, int RowsPerPage, bool pagination = true)
        {
            List<MigracionExcel> migracionExcels = new();
            int TotalCount = 0;

            if (pagination)
            {
                migracionExcels = ExecuteDbOperation(context =>
                   context.MigracionExcel
                     .AsNoTracking()
                     .OrderByDescending(c => c.FechaCreacion)
                     .Skip((PageNumber - 1) * RowsPerPage)
                     .Take(RowsPerPage)
                     .ToList()
               );

                TotalCount = FindAllCount();
            }
            else
            {
                migracionExcels = ExecuteDbOperation(context =>
                  context.MigracionExcel
                    .AsNoTracking()
                    .OrderByDescending(c => c.FechaCreacion)
                    .ToList());
            }

            return (migracionExcels, TotalCount);
        }

        public bool Update(LogMigracion newRecord)
        {
            return ExecuteDbOperation(context =>
            {
                var _exits = MergeEntityProperties(context, newRecord, u => u.IdLogMigracion == newRecord.IdLogMigracion);

                context.LogMigracion.Update(_exits);
                return context.SaveChanges() >= 0;
            });
        }
        public async Task<bool> UpdateAsync(LogMigracion newRecord)
        {
            return await ExecuteDbOperation(async context =>
            {
                // Encuentra la entidad existente y mezcla las propiedades
                var existingRecord = MergeEntityProperties(context, newRecord, u => u.IdLogMigracion == newRecord.IdLogMigracion);

                if (existingRecord == null)
                {
                    // No existe el registro, no se puede actualizar
                    return false;
                }

                // Actualiza la entidad en el contexto
                context.LogMigracion.Update(existingRecord);

                // Guarda los cambios de forma asíncrona
                var rowsAffected = await context.SaveChangesAsync();
                return rowsAffected > 0;
            });
        }

    }
}
