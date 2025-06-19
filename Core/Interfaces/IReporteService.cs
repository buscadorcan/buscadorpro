using DataAccess.Models;
using SharedApp.Dtos;

namespace Core.Interfaces
{
    public interface IReporteService
    {
        /// <summary>
        /// Obtiene una homologación específica en base a su código de homologación.
        /// </summary>
        /// <param name="codigoHomologacion">Código de homologación para la búsqueda.</param>
        /// <returns>Devuelve un objeto <see cref="VwHomologacion"/> con la información de la homologación encontrada.</returns>
        VwHomologacionDto findByVista(string codigoHomologacion);

        /// <summary>
        /// Obtiene la lista de acreditaciones de ONAs registradas en el sistema.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwAcreditacionOna"/> con los datos de las acreditaciones.</returns>
        List<VwAcreditacionOnaDto> ObtenerVwAcreditacionOna();

        /// <summary>
        /// Obtiene la lista de acreditaciones de esquemas almacenadas en el sistema.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwAcreditacionEsquema"/> con los datos de las acreditaciones de esquemas.</returns>
        List<VwAcreditacionEsquemaDto> ObtenerVwAcreditacionEsquema();

        /// <summary>
        /// Obtiene el estado de los esquemas registrados en el sistema.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwEstadoEsquema"/> con los estados de los esquemas.</returns>
        List<VwEstadoEsquemaDto> ObtenerVwEstadoEsquema();

        /// <summary>
        /// Obtiene información sobre Organismos de Evaluación de la Conformidad (OECs) por país.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwOecPais"/> con los datos de OECs organizados por país.</returns>
        List<VwOecPaisDto> ObtenerVwOecPais();

        /// <summary>
        /// Obtiene información sobre esquemas registrados por país.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwEsquemaPais"/> con los datos de los esquemas registrados en cada país.</returns>
        List<VwEsquemaPaisDto> ObtenerVwEsquemaPais();

        /// <summary>
        /// Obtiene información sobre Organismos de Evaluación de la Conformidad (OECs) organizados por fecha.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwOecFecha"/> con los datos de los OECs según la fecha de registro.</returns>
        List<VwOecFechaDto> ObtenerVwOecFecha();

        /// <summary>
        /// Obtiene información sobre profesionales calificados registrados en el sistema.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwProfesionalCalificado"/> con los datos de los profesionales calificados.</returns>
        List<VwProfesionalCalificadoDto> ObtenerVwProfesionalCalificado();

        /// <summary>
        /// Obtiene información sobre profesionales asociados a Organismos Nacionales de Acreditación (ONAs).
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwProfesionalOna"/> con los datos de los profesionales en ONAs.</returns>
        List<VwProfesionalOnaDto> ObtenerVwProfesionalOna();

        /// <summary>
        /// Obtiene información sobre profesionales vinculados a esquemas de homologación.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwProfesionalEsquema"/> con los datos de los profesionales en esquemas.</returns>
        List<VwProfesionalEsquemaDto> ObtenerVwProfesionalEsquema();

        /// <summary>
        /// Obtiene información sobre profesionales organizados por fecha de registro.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwProfesionalFecha"/> con los datos de los profesionales según su fecha de inclusión en el sistema.</returns>
        List<VwProfesionalFechaDto> ObtenerVwProfesionalFecha();

        /// <summary>
        /// Obtiene información sobre calificaciones organizadas por ubicación geográfica.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwCalificaUbicacion"/> con los datos de calificaciones por ubicación.</returns>
        List<VwCalificaUbicacionDto> ObtenerVwCalificaUbicacion();


        /// <summary>
        /// Obtiene información sobre búsquedas realizadas organizadas por fecha.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwBusquedaFecha"/> con los datos de las búsquedas según la fecha en que fueron realizadas.</returns>
        List<VwBusquedaFechaDto> ObtenerVwBusquedaFecha();

        /// <summary>
        /// Obtiene información sobre búsquedas realizadas aplicando filtros específicos.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwBusquedaFiltro"/> con los datos de las búsquedas filtradas por criterios predefinidos.</returns>
        List<VwBusquedaFiltroDto> ObtenerVwBusquedaFiltro();

        /// <summary>
        /// Obtiene información sobre búsquedas realizadas organizadas por ubicación geográfica.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwBusquedaUbicacion"/> con los datos de las búsquedas realizadas en distintas ubicaciones.</returns>
        List<VwBusquedaUbicacionDto> ObtenerVwBusquedaUbicacion();

        /// <summary>
        /// Obtiene información sobre las actualizaciones realizadas en los Organismos Nacionales de Acreditación (ONAs).
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwActualizacionONA"/> con los datos de las actualizaciones realizadas en ONAs.</returns>
        List<VwActualizacionONADto> ObtenerVwActualizacionONA();

        /// <summary>
        /// Obtiene información sobre los organismos registrados en el sistema.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwOrganismoRegistrado"/> con los datos de los organismos registrados.</returns>
        List<VwOrganismoRegistradoDto> ObtenerVwOrganismoRegistrado();

        /// <summary>
        /// Obtiene información sobre la relación entre organizaciones y esquemas de homologación.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwOrganizacionEsquema"/> con los datos de las organizaciones y su vinculación con esquemas.</returns>
        List<VwOrganizacionEsquemaDto> ObtenerVwOrganizacionEsquema();

        /// <summary>
        /// Obtiene información sobre las actividades realizadas por organismos en el sistema.
        /// </summary>
        /// <returns>Devuelve una lista de <see cref="VwOrganismoActividad"/> con los datos de actividades organizadas por organismos.</returns>
        List<VwOrganismoActividadDto> ObtenerVwOrganismoActividad();
    }
}
