using Bogus;
using SharedApp.Dtos;
using System.Reflection.Metadata.Ecma335;

namespace SharedApp.TestDataFake
{
    public static class TestDataFakeDto
    {
        public static BuscadorDto GetBuscadorDto() =>
            new Faker<BuscadorDto>()
                .RuleFor(x => x.Data, w => GetListBuscadorResultadoDataDto())
                .RuleFor(x => x.TotalCount, w => w.Random.Int(0, 100))
                .RuleFor(x => x.PanelONA, GetListvwPanelONADto());

        public static BuscadorResultadoDataDto GetBuscadorResultadoDataDto() =>
            new Faker<BuscadorResultadoDataDto>()
                .RuleFor(x => x.Siglas, w => w.Lorem.Word())
            .Generate();

        public static List<BuscadorResultadoDataDto> GetListBuscadorResultadoDataDto() =>
            new Faker<BuscadorResultadoDataDto>()
                .RuleFor(x => x.Siglas, w => w.Lorem.Word())
            .Generate(100);

        public static List<vwPanelONADto> GetListvwPanelONADto() =>
            new Faker<vwPanelONADto>()
                .RuleFor(x => x.Sigla, w => w.Lorem.Word())
                .RuleFor(x => x.Pais, w => w.Lorem.Sentence())
                .RuleFor(x => x.Icono, w => w.Lorem.Paragraph())
                .RuleFor(x => x.NroOrg, w => w.Random.Int(0, 100))
            .Generate(100);

        public static List<EsquemaDto> GetListEsquemaDto(int quantity = 100) =>
            new Faker<EsquemaDto>()
                .RuleFor(x => x.IdEsquema, w => w.Random.Int())
                .RuleFor(x => x.MostrarWebOrden, w => w.Random.Int())
                .RuleFor(x => x.MostrarWeb, w => w.Lorem.Sentence())
                .RuleFor(x => x.TooltipWeb, w => w.Lorem.Sentence())
                .RuleFor(x => x.EsquemaVista, w => w.Lorem.Sentence())
                .RuleFor(x => x.Estado, w => w.Lorem.Sentence())
            .Generate(quantity);
        
        public static FnEsquemaDto GetFnEsquemaDto() =>
            new Faker<FnEsquemaDto>()
                .RuleFor(x => x.IdEsquema, w => w.Random.Int())
                .RuleFor(x => x.MostrarWebOrden, w => w.Random.Int())
                .RuleFor(x => x.MostrarWeb, w => w.Lorem.Sentence())
                .RuleFor(x => x.TooltipWeb, w => w.Lorem.Sentence())
                .RuleFor(x => x.EsquemaVista, w => w.Lorem.Sentence())
                .RuleFor(x => x.EsquemaJson, w => w.Lorem.Text())
            .Generate();

        public static byte[] arrByte()
        {
            var faker = new Faker();
            return faker.Random.Bytes(256);
        }
    }
}
