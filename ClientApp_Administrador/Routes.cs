﻿namespace ClientAppAdministrador
{
    public static class Routes
    {
        public const string ADMINISTRADOR = "/administracion";

        public const string ACCEDER = "/";

        public const string BITACORA = "/bitacora";
        public const string CAMBIAR_CLAVE = "cambiar_clave";

        public const string CAMPO_HOMOLOGACION = "/campos-homologacion";
        public const string NUEVO_CAMPO_HOMOLOGACION = $"/nuevo-campos-homologacion/{{IdPadre:int}}";
        public const string EDITAR_CAMPO_HOMOLOGACION = $"/editar-campos-homologacion/{{IdPadre:int}}/{{Id:int}}";
        
        public const string CONEXION = "/conexion";
        public const string NUEVO_CONEXION = "/nuevo-conexion";
        public const string EDITAR_CONEXION = $"/editar-conexion/{{Id:int}}";

        public const string MENU_ROL = "/menu-config-lista";
        public const string NUEVO_MENU_ROL = "/nuevo-config-menu";

        public const string ESQUEMA = "/esquemas";
        public const string NUEVO_ESQUEMA = "/nuevo-esquema";
        public const string EDITAR_ESQUEMA = $"/editar-esquema/{{Id:int}}";

        public const string EVENTOS = "/eventos";
        public const string REPORTE_EVENTOS = $"/reporte-event/{{selectUser}}/{{dateStart}}/{{dateEnd}}";
        public const string REPORTE_FECHA_EVENTOS = "/reporte-event";

        public const string GRUPO = "/grupos";
        public const string EDITAR_GRUPO = $"/editar-grupos/";

        public const string LOG_MIGRACION = "/log-migracion";

        public const string MIGRACION_EXCEL = "/migracion-excel";
        public const string MIGRACION = "/log-migracion";
        public const string NUEVO_MIGRACION_EXCEL = "/nueva-migarcion-excel";

        public const string PAGE_NO_DISPONIBLE = "/page-nodisponible";

        public const string ONA = "/onas";
        public const string NUEVO_ONA = "/nuevo-ona";
        public const string EDITAR_ONA = "/editar-ona/";

        public const string SINONIMOS = "/sinonimos";

        public const string USUARIO = "/usuarios";
        public const string NUEVO_USUARIO = "/nuevo-usuario";
        public const string EDITAR_USAURIO = $"/editar-usuario/{{Id:int}}";

        public const string vALIDACION = "/validacion";

        public const string SALIR = "/salir";

        public const string REPORTE1 = "/reporte1";
        public const string REPORTE_CAN = "/reportecan";
        public const string REPORTE_ONA = "/reporteona";
        public const string REPORTE_REAL = "/reporteread";
    }
}
