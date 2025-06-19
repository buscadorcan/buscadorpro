using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Service
{
    public class LogMigracionService : ILogMigracionService
    {
        private readonly ILogMigracionRepository _logMigracionRepository;
        private readonly IMapper mapper;

        public LogMigracionService(ILogMigracionRepository logMigracionRepository, IMapper mapper)
        {
            this._logMigracionRepository = logMigracionRepository;
            this.mapper = mapper;
        }

        public LogMigracionDto Create(LogMigracionDto data)
        {
            LogMigracion entity = mapper.Map<LogMigracion>(data);
            LogMigracion logMigracion = _logMigracionRepository.Create(entity);
            return mapper.Map<LogMigracionDto>(logMigracion);
        }

        public async Task<LogMigracionDto> CreateAsync(LogMigracionDto data)
        {
            LogMigracion entity = mapper.Map<LogMigracion>(data);
            LogMigracion logMigracionDto = await _logMigracionRepository.CreateAsync(entity);
            return mapper.Map<LogMigracionDto>(logMigracionDto);
        }

        public LogMigracionDetalle CreateDetalle(LogMigracionDetalle data)
        {
            return _logMigracionRepository.CreateDetalle(data);
        }

        public Task<LogMigracionDetalle> CreateDetalleAsync(LogMigracionDetalle data)
        {
            return _logMigracionRepository.CreateDetalleAsync(data);
        }

        public ResultadoPaginadoDto<List<LogMigracionDto>> FindAll(int PageNumber, int RowsPerPage)
        {
            (List<LogMigracion> logMigracions, int TotalCount) = _logMigracionRepository.FindAll(PageNumber, RowsPerPage);

            return new ResultadoPaginadoDto<List<LogMigracionDto>>
            {
                Data = mapper.Map<List<LogMigracionDto>>(logMigracions),
                PageNumber = PageNumber,
                RowsPerPage = RowsPerPage,
                TotalCount = TotalCount,
                TotalPages = (int)Math.Ceiling(TotalCount / (double)RowsPerPage),
                HasNextPage = PageNumber < (int)Math.Ceiling(TotalCount / (double)RowsPerPage),
                HasPreviousPage = PageNumber >= 1
            };
        }

        public List<LogMigracionDetalle> FindAllDetalle()
        {
            return _logMigracionRepository.FindAllDetalle();
        }

        public LogMigracionDto? FindById(int Id)
        {
            LogMigracion logMigracion = _logMigracionRepository.FindById(Id);
            return mapper.Map<LogMigracionDto>(logMigracion);
        }

        public List<LogMigracionDetalle> FindDetalleById(int Id)
        {
            return _logMigracionRepository.FindDetalleById(Id);
        }

        public bool Update(LogMigracionDto data)
        {
            LogMigracion entity = mapper.Map<LogMigracion>(data);
            return _logMigracionRepository.Update(entity);
        }

        public Task<bool> UpdateAsync(LogMigracionDto data)
        {
            LogMigracion entity = mapper.Map<LogMigracion>(data);
            return _logMigracionRepository.UpdateAsync(entity);
        }

        public bool UpdateDetalle(LogMigracionDetalle data)
        {
            return _logMigracionRepository.UpdateDetalle(data);
        }
    }
}
