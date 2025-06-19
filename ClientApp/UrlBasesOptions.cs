namespace ClientApp
{
    public static class UrlBasesOptions
    {
        public static string UrlBaseAdmin { get; set; }
        public static string UrlBaseBuscador { get; set; }

        public static void configuracion(IConfiguration config)
        {
            UrlBaseAdmin = config["UrlBasesCors:UrlAdmin"];
            UrlBaseBuscador = config["UrlBasesCors:UrlBuscador"];
        }

    }

}