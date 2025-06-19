using AutoMapper;
using Core.Interfaces;
using DataAccess.Interfaces;
using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Service
{
    public class MenuService: IMenuService
    {
        private readonly IMenuRepository _menuRepository;
        private readonly IMapper mapper;
        public MenuService(IMenuRepository menuRepository, IMapper mapper)
        {
            this._menuRepository = menuRepository;
            this.mapper = mapper;
        }

        public bool Create(MenuRolDto data)
        {
            MenuRol menuRol = mapper.Map<MenuRol>(data);
            return _menuRepository.Create(menuRol);
        }

        public List<MenuRolDto> FindAll()
        {
            List<Menus> menus = _menuRepository.FindAll();
            return mapper.Map<List<MenuRolDto>>(menus);
        }

        public MenuRolDto? FindById(int idHRol, int idHMenu)
        {
           MenuRol? menuRol = _menuRepository.FindById(idHRol, idHMenu);
            return mapper.Map<MenuRolDto>(menuRol);
        }

        public MenuRolDto? FindDataById(int idHRol, int idHMenu)
        {
            Menus? menuRol = _menuRepository.FindDataById(idHRol, idHMenu);
            return mapper.Map<MenuRolDto>(menuRol);
        }

        public List<MenuRolDto> GetListByMenusAsync(int idHRol, int idHMenu)
        {
           List<Menus> menus = _menuRepository.GetListByMenusAsync(idHRol, idHMenu);
            return mapper.Map<List<MenuRolDto>>(menus);
        }

        public List<MenuPaginaDto> ObtenerMenusPendingConfig(int idHomologacionRol)
        {
           List<MenuPagina> menuPaginas = _menuRepository.ObtenerMenusPendingConfig(idHomologacionRol);
            return mapper.Map<List<MenuPaginaDto>>(menuPaginas);
        }

        public bool Update(MenuRolDto data)
        {
            MenuRol menuRol = mapper.Map<MenuRol>(data);
           return _menuRepository.Update(menuRol);
        }
    }
}
