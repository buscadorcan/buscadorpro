namespace SharedApp.Dtos
{
    public class ResultadoPaginadoDto<TDto>
    {
        public int PageNumber { get; set; }
        public int RowsPerPage { get; set; }
        public int TotalCount { get; set; }
        public TDto Data { get; set; }
        public int TotalPages { get; set; }
        public bool HasPreviousPage { get; set; }
        public bool HasNextPage { get; set; }
    }
}
