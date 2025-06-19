using Microsoft.Playwright;

namespace BlazorE2ETests
{
    public static class MSTestSettings
    {
        public static IPlaywright PlaywrightInstance { get; private set; } = null!;
        public static IBrowser Browser { get; private set; } = null!;

        public static async Task InitializeAsync()
        {
            PlaywrightInstance = await Playwright.CreateAsync();
            Browser = await PlaywrightInstance.Chromium.LaunchAsync(new BrowserTypeLaunchOptions
            {
                Headless = true
            });
        }

        public static async Task CleanupAsync()
        {
            await Browser.CloseAsync();
            PlaywrightInstance.Dispose();
        }
    }
}
