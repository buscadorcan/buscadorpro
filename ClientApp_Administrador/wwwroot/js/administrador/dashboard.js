window.initDashboardMenu = function () {
        function isMobile() {
            return /Mobi|Android/i.test(navigator.userAgent);
        }

        $(".ds-dropdown-toggle").click(function(){
            $(".ds-dropdown-menu").toggle();
        });

        $('.ds-nav-toggle').click(function () {
            $('.dashboard-sidebar, .ds-wrap, .ds-menu-item, .ds-menu-heading, .ds-wrap-header').addClass('ds-small');
            $('.dashboard-sidebar-brand, .ds-nav-toggle').hide();
            $('.ds-nav-compact').show();
        });

        $('.ds-nav-compact').click(function () {
            $('.dashboard-sidebar, .ds-wrap, .ds-menu-item, .ds-menu-heading, .ds-wrap-header').removeClass('ds-small');
            $('.dashboard-sidebar-brand, .ds-nav-toggle').show();
            $('.ds-nav-compact').hide();
        });

        $('.ds-nav-toogle-responsive').click(function () {
           $('.overlay-responsive-menu').show();
           $('.dashboard-sidebar').fadeIn();
            $('.dashboard-sidebar').removeClass('translate-hide');
        });

        $('.ds-nav-back, .overlay-responsive-menu').click(function () {
            $('.overlay-responsive-menu').fadeOut();
            $('.dashboard-sidebar').addClass('translate-hide');
        });
};
