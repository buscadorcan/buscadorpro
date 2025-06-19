using SharedApp.Dtos;

namespace DataAccess.Interfaces
{
    public interface IBuscadorRepository
    {
        /// <summary>
        /// WebApp/PsBuscarPalabra: Realiza una b�squeda de palabras clave en la base de datos y devuelve los resultados paginados.
        /// Este m�todo permite buscar t�rminos espec�ficos dentro del sistema y obtener una lista de resultados con paginaci�n.
        /// </summary>
        /// <param name="paramJSON">Par�metros en formato JSON para personalizar la b�squeda.</param>
        /// <param name="PageNumber">N�mero de p�gina para la paginaci�n de resultados.</param>
        /// <param name="RowsPerPage">Cantidad de resultados por p�gina.</param>
        /// <returns>
        /// Devuelve un objeto de tipo BuscadorDto con los resultados paginados de la b�squeda.
        /// </returns>
        BuscadorDto PsBuscarPalabra(string paramJSON, int PageNumber, int RowsPerPage);

        BuscadorDtoExpo PsBuscarPalabraExpor(string paramJSON);

        /// <summary>
        /// WebApp/FnHomologacionEsquemaTodo: Obtiene el esquema completo de homologaci�n basado en la vista y el ONA.
        /// Este m�todo permite recuperar la estructura completa de homologaci�n asociada a una vista espec�fica y un Organismo Nacional de Acreditaci�n (ONA).
        /// </summary>
        /// <param name="VistaFK">Nombre de la vista de homologaci�n a consultar.</param>
        /// <param name="idOna">Identificador del ONA asociado a la vista de homologaci�n.</param>
        /// <returns>
        /// Devuelve una lista de objetos EsquemaDto con la informaci�n del esquema de homologaci�n.
        /// </returns>
        List<EsquemaDto> FnHomologacionEsquemaTodo(string VistaFK, int idOna);

        /// <summary>
        /// WebApp/FnHomologacionEsquema: Obtiene los detalles de homologaci�n de un esquema espec�fico.
        /// Este m�todo permite consultar informaci�n detallada sobre un esquema de homologaci�n a partir de su identificador �nico.
        /// </summary>
        /// <param name="idHomologacionEsquema">ID �nico del esquema de homologaci�n.</param>
        /// <returns>
        /// Devuelve un objeto de tipo FnEsquemaDto con la informaci�n detallada del esquema de homologaci�n.
        /// </returns>
        FnEsquemaDto? FnHomologacionEsquema(int idHomologacionEsquema);

        /// <summary>
        /// WebApp/FnHomologacionEsquemaDato: Recupera los datos de homologaci�n de un esquema en base a la vista y el ONA.
        /// Este m�todo permite obtener los datos asociados a un esquema de homologaci�n en funci�n de su vista de referencia y ONA.
        /// </summary>
        /// <param name="idEsquema">Identificador del esquema a consultar.</param>
        /// <param name="VistaFK">Nombre de la vista asociada al esquema de homologaci�n.</param>
        /// <param name="idOna">Identificador del ONA correspondiente.</param>
        /// <returns>
        /// Devuelve una lista de objetos FnHomologacionEsquemaDataDto con los datos de homologaci�n recuperados.
        /// </returns>
        List<FnHomologacionEsquemaDataDto> FnHomologacionEsquemaDato(int idEsquema, string VistaFK, int idOna);

        /// <summary>
        /// WebApp/FnEsquemaDatoBuscar: Realiza una b�squeda de datos dentro de un esquema espec�fico.
        /// Este m�todo permite buscar informaci�n dentro de un esquema determinado utilizando un t�rmino de b�squeda.
        /// </summary>
        /// <param name="IdEsquemaData">Identificador del esquema en el que se realizar� la b�squeda.</param>
        /// <param name="TextoBuscar">T�rmino de b�squeda para filtrar los resultados.</param>
        /// <returns>
        /// Devuelve una lista de objetos FnEsquemaDataBuscadoDto con los datos que coinciden con la b�squeda realizada.
        /// </returns>
        List<FnEsquemaDataBuscadoDto> FnEsquemaDatoBuscar(int IdEsquemaData, string TextoBuscar);

        /// <summary>
        /// WebApp/FnPredictWords: Genera predicciones de palabras relacionadas con la consulta ingresada.
        /// Este m�todo permite obtener sugerencias de palabras a partir de un prefijo o t�rmino parcial ingresado.
        /// </summary>
        /// <param name="word">Palabra o t�rmino parcial para generar las predicciones.</param>
        /// <returns>
        /// Devuelve una lista de objetos FnPredictWordsDto con las palabras sugeridas basadas en la entrada proporcionada.
        /// </returns>
        List<FnPredictWordsDto> FnPredictWords(string word);

        /// <summary>
        /// WebApp/ValidateWords: Valida una lista de palabras en base a las reglas establecidas en el sistema.
        /// Este m�todo permite verificar si una serie de palabras cumplen con las normas y restricciones del sistema.
        /// </summary>
        /// <param name="words">Lista de palabras a validar.</param>
        /// <returns>
        /// Devuelve un valor booleano indicando si todas las palabras cumplen con las reglas establecidas.
        /// </returns>
        bool ValidateWords(List<string> words);

        /// <summary>
        /// WebApp/FnEsquemaCabecera: Obtiene la informaci�n de la cabecera de un esquema espec�fico.
        /// Este m�todo permite recuperar datos generales sobre un esquema a partir de su identificador �nico.
        /// </summary>
        /// <param name="IdEsquemadata">ID �nico del esquema cuya cabecera se desea consultar.</param>
        /// <returns>
        /// Devuelve un objeto fnEsquemaCabeceraDto con la informaci�n de la cabecera del esquema solicitado.
        /// Si el esquema no existe, devuelve un valor nulo.
        /// </returns>
        fnEsquemaCabeceraDto? FnEsquemaCabecera(int IdEsquemadata);

        /// <summary>
        /// WebApp/AddEventTracking: Registra un evento de seguimiento en el sistema.
        /// Este m�todo permite almacenar un evento en la base de datos para su posterior an�lisis.
        /// </summary>
        /// <param name="eventTracking">Objeto que contiene la informaci�n del evento de seguimiento a registrar.</param>
        int AddEventTracking(EventTrackingDto eventTracking);


    }
}
