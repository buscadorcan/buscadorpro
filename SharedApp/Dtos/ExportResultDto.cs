using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedApp.Dtos
{
    public class ExportResultDto
    {
        [JsonProperty("success")]
        public bool Success { get; set; }

        [JsonProperty("base64")]
        public string base64 { get; set; } = string.Empty;
    }
}
