using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Service
{
    public class MigracionExcelService: IMigracionExcelService
    {
        private readonly IMigracionExcelRepository _migracionExcelRepository;
        private readonly IMapper mapper;

        public MigracionExcelService(IMigracionExcelRepository migracionExcelRepository, IMapper mapper)
        {
            this._migracionExcelRepository = migracionExcelRepository;
            this.mapper = mapper;
        }

        public LogMigracion Create(LogMigracion data)
        {
            return _migracionExcelRepository.Create(data);
        }

        public Task<LogMigracion> CreateAsync(LogMigracion data)
        {
            return _migracionExcelRepository.CreateAsync(data);
        }

        public ResultadoPaginadoDto<List<MigracionExcelDto>> FindAll(int PageNumber, int RowsPerPage, bool pagination = true)
        {
            (List<MigracionExcel> migracionExcels, int TotalCount) = _migracionExcelRepository.FindAll(PageNumber, RowsPerPage, pagination);

            return new ResultadoPaginadoDto<List<MigracionExcelDto>>
            {
                Data = mapper.Map<List<MigracionExcelDto>>(migracionExcels),
                PageNumber = PageNumber,
                RowsPerPage = RowsPerPage,
                TotalCount = TotalCount,
                TotalPages = (int)Math.Ceiling(TotalCount / (double)RowsPerPage),
                HasNextPage = PageNumber < (int)Math.Ceiling(TotalCount / (double)RowsPerPage),
                HasPreviousPage = PageNumber >= 1
            };
        }

        public MigracionExcel? FindById(int Id)
        {
            return _migracionExcelRepository.FindById(Id);
        }

        public bool Update(LogMigracion data)
        {
            return _migracionExcelRepository.Update(data);
        }

        public Task<bool> UpdateAsync(LogMigracion data)
        {
            return _migracionExcelRepository.UpdateAsync(data);
        }
    }
}
