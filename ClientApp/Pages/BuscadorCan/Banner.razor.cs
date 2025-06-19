using Microsoft.JSInterop;

namespace ClientApp.Pages.BuscadorCan
{
    public partial class Banner
    {
        private bool isMobile;

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                try
                {
                    await JS.InvokeVoidAsync("initDetectMobile", DotNetObjectReference.Create(this));
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }

        [JSInvokable]
        public void UpdateIsMobile(bool isMobileStatus)
        {
            isMobile = isMobileStatus;
            StateHasChanged();
        }
    }
}
