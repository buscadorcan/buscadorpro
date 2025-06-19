using AutoMapper;
using Core.Interfaces;
using Core.Services;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp;
using SharedApp.Dtos;

namespace Core.Service
{
    public class ONAConexionService : IONAConexionService
    {
        private readonly IONAConexionRepository _oNAConexionRepository;
        private readonly IJwtService _jwtService;
        private readonly IMapper mapper;

        public ONAConexionService(IONAConexionRepository oNAConexionRepository, IJwtService jwtService, IMapper mapper)
        {
            this._oNAConexionRepository = oNAConexionRepository;
            this._jwtService = jwtService;
            this.mapper = mapper;
        }

        public bool Create(ONAConexionDto data)
        {
            ONAConexion oNA = mapper.Map<ONAConexion>(data);
            oNA.IdUserCreacion = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "");
            oNA.IdUserModifica = oNA.IdUserCreacion;
            oNA.FechaCreacion = DateTime.Now;
            oNA.FechaModifica = oNA.FechaCreacion;
            oNA.Estado = Constantes.ESTADO_USUARIO_A;
            return _oNAConexionRepository.Create(oNA);
        }

        public List<ONAConexionDto> FindAll()
        {
            List<ONAConexionDto> oNAConexions = _oNAConexionRepository.FindAll();
            return oNAConexions;
        }

        public ONAConexionDto? FindById(int Id)
        {
            ONAConexion? oNA = _oNAConexionRepository.FindById(Id);
            return mapper.Map<ONAConexionDto>(oNA);
        }

        public ONAConexionDto? FindByIdONA(int IdONA)
        {
            ONAConexion oNA = _oNAConexionRepository.FindByIdONA(IdONA);
            return mapper.Map<ONAConexionDto>(oNA);
        }

        public async Task<ONAConexionDto?> FindByIdONAAsync(int IdONA)
        {
            ONAConexion? oNAConexions = await _oNAConexionRepository.FindByIdONAAsync(IdONA);
            return mapper.Map<ONAConexionDto>(oNAConexions);
        }
        public List<ONAConexionDto> GetONAConexionByOnaListAsync(int IdONA)
        {
            List<ONAConexion> oNAConexions = _oNAConexionRepository.GetOnaConexionByOnaListAsync(IdONA);
            return mapper.Map<List<ONAConexionDto>>(oNAConexions);
        }
        public bool Update(ONAConexionDto data)
        {
            var userToken = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "");
            ONAConexion oNA = mapper.Map<ONAConexion>(data);
            return _oNAConexionRepository.Update(oNA, userToken);
        }

        public bool updateCrono(int IdOna, OnaConexionCronDto dto)
        {
            var userToken = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "");
            return _oNAConexionRepository.updateCrono(IdOna,
                                                      dto,
                                                      userToken);
        }
    }
}
