window.initDetectMobile = function(dotNetHelper) {
    dotNetHelper.invokeMethodAsync('UpdateIsMobile', window.innerWidth <= 768);

    window.addEventListener('resize', () => {
        dotNetHelper.invokeMethodAsync('UpdateIsMobile', window.innerWidth <= 768);
    });
};

$(window).on('resize', function () {
    if ($(window).width() >= 991) {
        $('.dashboard-sidebar').removeClass('translate-hide');
    } else {
        $('.dashboard-sidebar').addClass('translate-hide');
    }
});
