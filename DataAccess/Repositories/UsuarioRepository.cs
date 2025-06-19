using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using DataAccess.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SharedApp.Dtos;
using DataAccess.Models;
using SharedApp;

namespace DataAccess.Repositories
{
    public class UsuarioRepository : BaseRepository, IUsuarioRepository
    {
        private readonly IEventTrackingRepository _eventTrackingRepository;
        private readonly IConfiguration _configuration;
        public UsuarioRepository (
            ILogger<UsuarioRepository> logger,
            ISqlServerDbContextFactory sqlServerDbContextFactory,
            IEventTrackingRepository eventTrackingRepository,
            IConfiguration configuration
        ) : base(sqlServerDbContextFactory, logger)
        {
            _eventTrackingRepository = eventTrackingRepository;
            _configuration = configuration;
        }
        public Usuario? FindById(int idUsuario)
        {
            // return ExecuteDbOperation(context => context.Usuario.AsNoTracking().FirstOrDefault(c => c.IdUsuario == idUsuario));
            return ExecuteDbOperation(context =>
            {
                // Realizamos el join entre Usuario, Homologacion y ONA
                var query = from usuario in context.Usuario.AsNoTracking()
                            join homologacion in context.VwRol.AsNoTracking()
                            on usuario.IdHomologacionRol equals homologacion.IdHomologacionRol into homologacionJoin
                            from homologacion in homologacionJoin.DefaultIfEmpty()
                            join ona in context.ONA.AsNoTracking()
                            on usuario.IdONA equals ona.IdONA
                            where usuario.IdUsuario == idUsuario // Filtramos por idUsuario
                            orderby usuario.IdUsuario
                            select new Usuario
                            {
                                IdUsuario = usuario.IdUsuario,
                                IdONA = usuario.IdONA,
                                Nombre = usuario.Nombre,
                                Apellido = usuario.Apellido,
                                Telefono = usuario.Telefono,
                                Email = usuario.Email,
                                IdHomologacionRol = usuario.IdHomologacionRol,
                                Estado = usuario.Estado
                                //,RazonSocial = ona.RazonSocial
                            };

                // Devolvemos el primer resultado o null si no se encuentra
                return query.FirstOrDefault();
            });
        }
        public ICollection<UsuarioDto> FindAll()
        {
            return ExecuteDbOperation(context =>
            {
                var query = from usuario in context.Usuario.AsNoTracking()
                            join homologacion in context.VwRol.AsNoTracking()
                            on usuario.IdHomologacionRol equals homologacion.IdHomologacionRol into homologacionJoin
                            from homologacion in homologacionJoin.DefaultIfEmpty()
                            join ona in context.ONA.AsNoTracking()
                            on usuario.IdONA equals ona.IdONA
                            where usuario.Estado == Constantes.ESTADO_USUARIO_A
                            orderby usuario.IdUsuario
                            select new UsuarioDto
                            {
                                IdUsuario = usuario.IdUsuario,
                                IdONA = usuario.IdONA,
                                Nombre = usuario.Nombre,
                                Apellido = usuario.Apellido,
                                Telefono = usuario.Telefono,
                                Email = usuario.Email,
                                Rol = homologacion.Rol,
                                Estado = usuario.Estado,
                                RazonSocial = ona.RazonSocial,
                                IdHomologacionRol = usuario.IdHomologacionRol
                            };

                return query.ToList();
            });
        }

        /// Finds a user by their email address.
        public Usuario? FindByEmail(string email) {
            return ExecuteDbOperation(context => 
                context.Usuario.AsNoTracking().FirstOrDefault(u => u.Email != null && u.Email.ToLower() == email.ToLower()));
        }

        public bool IsUniqueUser(string email)
        {
            return ExecuteDbOperation(context => 
                context.Usuario.AsNoTracking().FirstOrDefault(u => u.Email == email) == null);
        }
        public bool Create(Usuario usuario)
        {
            return ExecuteDbOperation(context =>
            {
                context.Usuario.Add(usuario);
                if ( context.SaveChanges() >= 0 )
                {
                    SendConfirmationEmail(usuario, usuario.Clave);
                    return true;
                }
                return false;
            });
        }
        public void SendConfirmationEmail(Usuario usuario, string clave)
        {
            string templatePath = _configuration["EmailTemplates:Confirmation"] ?? "";

            if (File.Exists(templatePath))
            {
                string htmlBody = File.ReadAllText(templatePath);

                _ = Task.Run(async () =>
                {
                    try
                    {
                        htmlBody = string.Format(htmlBody, usuario.Nombre, usuario.Email, clave);
                        //await _emailService.SendEmailAsync(usuario.Email ?? "", "Confirmación de Recepción de Clave de Acceso al Sistema", htmlBody);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error al enviar correo: {ex.Message}");
                    }
                });
            }
            else
            {
                throw new FileNotFoundException("La plantilla de correo no se encuentra en la ubicación especificada.");
            }
        }
        //public bool Update(Usuario usuario)
        //{
        //    return ExecuteDbOperation(context =>
        //    {
        //        var _exits = MergeEntityProperties(context, usuario, u => u.IdUsuario == usuario.IdUsuario);

        //        _exits.FechaModifica = DateTime.Now;
        //        _exits.IdUserModifica = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "");
        //        _exits.Clave = _hashService.GenerateHash(usuario.Clave);
        //        context.Usuario.Update(_exits);
        //        return context.SaveChanges() >= 0;
        //    });
        //}
        public bool Update(Usuario usuario)
        {
            return ExecuteDbOperation(context =>
            {
                var _exits = MergeEntityProperties(context, usuario, u => u.IdUsuario == usuario.IdUsuario);

                if (_exits == null)
                {
                    return false; // Si el usuario no existe, no continuamos
                }

                _exits.FechaModifica = DateTime.Now;
                //_exits.IdUserModifica = _jwtService.GetUserIdFromToken(_jwtService.GetTokenFromHeader() ?? "");

                // Consultamos la clave actual del usuario en la base de datos
                var claveActual = context.Usuario
                    .Where(u => u.IdUsuario == usuario.IdUsuario)
                    .Select(u => u.Clave)
                    .FirstOrDefault();

                // Si la clave entrante es nula o vacía, mantenemos la clave actual
                if (string.IsNullOrEmpty(usuario.Clave))
                {
                    _exits.Clave = claveActual;
                }
                else
                {
                    //_exits.Clave = _hashService.GenerateHash(usuario.Clave);
                }

                context.Usuario.Update(_exits);
                return context.SaveChanges() > 0; // Si se guardaron cambios, retornará true
            });
        }

        public Result<bool> ChangePasswd(string clave, 
                                         string claveNueva, 
                                         int idUsuario, 
                                         string nueva)
        {
            var eventTrackingDto = new paAddEventTrackingDto
            {
                CodigoHomologacionMenu = "cambiar_clave",
                NombreControl = "btnCambiar",
                NombreAccion = "OnCambiarClave()",
                ParametroJson = JsonConvert.SerializeObject(new
                {
                    IdUsuario = idUsuario,
                    Clave = clave,
                    ClaveNueva = claveNueva
                })
            };

            return ExecuteDbOperation(context => {
                var usuario = context.Usuario.AsNoTracking().Where((c) => c.IdUsuario == 0).FirstOrDefault();

                if (usuario == null)
                {
                    _eventTrackingRepository.Create(eventTrackingDto);
                    return Result<bool>.Failure("Usuario no encontrado");
                }

                var rol = context.VwRol.AsNoTracking().FirstOrDefault(c => c.IdHomologacionRol == usuario.IdHomologacionRol);
                eventTrackingDto.CodigoHomologacionRol = rol.CodigoHomologacion;
                eventTrackingDto.NombreUsuario = usuario.Nombre;
                _eventTrackingRepository.Create(eventTrackingDto);

                if (usuario.Clave != clave) //clave
                {
                    return Result<bool>.Failure("Clave incorrecta");
                }

                usuario.Clave = nueva;

                context.Usuario.Update(usuario);
                if (context.SaveChanges() > 0)
                {
                    return Result<bool>.Success(true);
                }

                return Result<bool>.Failure("Error al cambiar la clave. Intente de Nuevo");
            });
        }

    
    }
}