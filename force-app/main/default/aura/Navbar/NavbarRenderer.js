({
    afterRender: function(component) {
        this.superAfterRender();

        var beforePosition = document.documentElement.scrollTop;

        document.addEventListener('scroll', function() {
            var afterPosition = document.documentElement.scrollTop;

            if(afterPosition > 80) {
                if(beforePosition > afterPosition) {
                    // 스크롤 위로
                    component.set("v.isScrollUp", true);
                } else {
                    component.set("v.isScrollUp", false);
                }
            } else {
                // 평상시
                component.set("v.isScrollUp", false);
            }

            beforePosition = afterPosition;
        })

        var token = window.localStorage.getItem(localStorage.key(2));

        if(token) {
            component.set("v.isLogin", true);
        }
    }
})
