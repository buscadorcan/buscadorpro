using Core.Interfaces;
using Microsoft.AspNetCore.Http;
using OfficeOpenXml;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Mvc;
using SharedApp.Helpers;

namespace Core.Service
{
    public class UtilitiesService : IUtilitiesService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UtilitiesService(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<string> ExportExcel(List<Dictionary<string, string>> data)
        {
            if (data == null || !data.Any())
                throw new ArgumentException("No hay datos para exportar.");

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using var package = new ExcelPackage();
            var worksheet = package.Workbook.Worksheets.Add("Datos");

            var headers = data[0].Keys.ToList();
            for (int i = 0; i < headers.Count; i++)
                worksheet.Cells[1, i + 1].Value = headers[i];

            for (int i = 0; i < data.Count; i++)
            {
                for (int j = 0; j < headers.Count; j++)
                {
                    worksheet.Cells[i + 2, j + 1].Value = data[i][headers[j]];
                }
            }
            var excelBytes = package.GetAsByteArray();
            string base64String = Convert.ToBase64String(excelBytes);
            return base64String;
        }

        public async Task<string> ExportPdf(List<Dictionary<string, string>> data)
        {
            if (data == null || !data.Any())
                throw new ArgumentException("No hay datos para exportar.");

            var pdfBytes = GeneratePdf(data);
            string base64String = Convert.ToBase64String(pdfBytes);

            return base64String;
        }

        private byte[] GeneratePdf(List<Dictionary<string, string>> data)
        {
            using var stream = new MemoryStream();
            using var document = new Document(PageSize.A4, 25, 25, 30, 30);
            var writer = PdfWriter.GetInstance(document, stream);

            document.Open();

            var headers = data[0].Keys.ToList();
            var table = new PdfPTable(headers.Count)
            {
                WidthPercentage = 100
            };

            // Agregar encabezados
            foreach (var header in headers)
            {
                var cell = new PdfPCell(new Phrase(header))
                {
                    BackgroundColor = BaseColor.LIGHT_GRAY,
                    HorizontalAlignment = Element.ALIGN_CENTER
                };
                table.AddCell(cell);
            }

            // Agregar contenido
            foreach (var row in data)
            {
                foreach (var header in headers)
                {
                    var value = row.TryGetValue(header, out var v) ? v : string.Empty;
                    var cell = new PdfPCell(new Phrase(value ?? ""))
                    {
                        HorizontalAlignment = Element.ALIGN_LEFT
                    };
                    table.AddCell(cell);
                }
            }

            document.Add(table);
            document.Close();
            writer.Close();

            return stream.ToArray();
        }

        private string BuildPublicUrl(string relativePath)
        {
            var request = _httpContextAccessor.HttpContext?.Request
                          ?? throw new InvalidOperationException("No se puede acceder al HttpContext.");

            var host = request.Host.ToString();

            if (request.Host.ToString() != Inicializar.UrlBaseApi)
            {
                host = Inicializar.UrlBaseApi;
            }

            return $"{request.Scheme}://{host}/{relativePath.Replace("\\", "/")}";
        }

        public async Task<List<Dictionary<string, string>>> ExportDocumentAsync<T>(List<T> data)
        {
            return data
                .Select(d =>
                {
                    var props = d.GetType().GetProperties();
                    var dict = new Dictionary<string, string>();
                    foreach (var p in props)
                    {
                        var key = p.Name;
                        if (!dict.ContainsKey(key))
                        {
                            dict[key] = p.GetValue(d)?.ToString() ?? "";
                        }
                    }
                    return dict;
                })
                .ToList();
        }

    }
}
