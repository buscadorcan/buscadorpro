using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Service
{
    public class HomologacionService : IHomologacionService
    {
        private readonly IHomologacionRepository _homologacionRepository;
        private readonly IMapper mapper;
        public HomologacionService(IHomologacionRepository homologacionRepository, IMapper mapper)
        {
            this._homologacionRepository = homologacionRepository;
            this.mapper = mapper;
        }

        public bool Create(HomologacionDto data)
        {
            Homologacion homologacion = mapper.Map<Homologacion>(data);
            return _homologacionRepository.Create(homologacion);
        }

        public List<HomologacionDto> FindByAll()
        {
            List<Homologacion> homologacions = _homologacionRepository.FindByAll();
            return mapper.Map<List<HomologacionDto>>(homologacions);
        }

        public HomologacionDto? FindById(int id)
        {
            Homologacion homologacion = _homologacionRepository.FindById(id);
            return mapper.Map<HomologacionDto>(homologacion);
        }

        public List<HomologacionDto> FindByIds(int[] ids)
        {
            List<Homologacion> homologacions = _homologacionRepository.FindByIds(ids);
            return mapper.Map<List<HomologacionDto>>(homologacions);
        }

        public List<HomologacionDto> FindByParent()
        {
            List<Homologacion> homologacions = _homologacionRepository.FindByParent().ToList();
            return mapper.Map<List<HomologacionDto>>(homologacions);
        }

        public ResultadoPaginadoDto<List<VwHomologacionDto>> ObtenerVwHomologacionPorCodigo(string codigoHomologacion, int PageNumber, int RowsPerPage, bool pagination = true)
        {
            PageNumber = PageNumber <= 0 ? 1 : PageNumber;
            RowsPerPage = RowsPerPage <= 0 ? 5 : RowsPerPage;

            (List<VwHomologacion> homologacions, int TotalCount) = _homologacionRepository.ObtenerVwHomologacionPorCodigo(codigoHomologacion, PageNumber, RowsPerPage);

            return new ResultadoPaginadoDto<List<VwHomologacionDto>>
            {
                Data = mapper.Map<List<VwHomologacionDto>>(homologacions),
                PageNumber = PageNumber,
                RowsPerPage = RowsPerPage,
                TotalCount = TotalCount,
                TotalPages = (int)Math.Ceiling(TotalCount / (double)RowsPerPage),
                HasNextPage = PageNumber < (int)Math.Ceiling(TotalCount / (double)RowsPerPage),
                HasPreviousPage = PageNumber >= 1
            };
        }

        public bool Update(HomologacionDto data)
        {
            Homologacion homologacion = mapper.Map<Homologacion>(data);
            return _homologacionRepository.Update(homologacion);
        }
    }
}
