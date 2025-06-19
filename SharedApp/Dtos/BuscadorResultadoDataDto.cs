namespace SharedApp.Dtos
{
    public class BuscadorResultadoData
    {
        public int? IdONA { get; set; }
        public string? Siglas { get; set; }
        public string? Texto { get; set; }
        public string? VistaPK { get; set; }
        public string? VistaFK { get; set; }
        public int? IdEsquema { get; set; }
        public int? IdEsquemaVista { get; set; }
        public int? IdEsquemaData { get; set; }           
        public string? DataEsquemaJson { get; set; }
    }

    public class BuscadorResultadoDataDto
    {
        public int? IdONA { get; set; }
        public string? Siglas { get; set; }
        public string? Texto { get; set; }
        public string? VistaPK { get; set; }
        public string? VistaFK { get; set; }
        public int? IdEsquema { get; set; }
        public int? IdEsquemaVista { get; set; }
        public int? IdEsquemaData { get; set; }
        public List<ColumnaEsquema>? DataEsquemaJson { get; set; }

    }

    public class BuscadorResultadoExpor
    {
        public int? IdONA { get; set; }
        public string? Siglas { get; set; }
        public string? Texto { get; set; }
        public string? VistaPK { get; set; }
        public string? VistaFK { get; set; }
        public int? IdEsquema { get; set; }
        public int? IdEsquemaVista { get; set; }
        public int? IdEsquemaData { get; set; }
        public string? DataEsquemaJson { get; set; }
        public DateTime FechaExportacion { get; set; }
    }
}
