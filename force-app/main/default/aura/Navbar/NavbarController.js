({
    initValue: function(component, event) {
        component.set("v.userName", event.getParam("userName"));

        // 서로 다른 Application이라 안되는듯...
    },
    openDropdown: function(component) {
        var item = component.get("v.isDropdownOpen");

        component.set("v.isDropdownOpen", !item);
    },
    openDropdownForHide: function(component) {
        var item = component.get("v.isDropdownOpenForHide");

        component.set("v.isDropdownOpenForHide", !item);
    },
    onLogout: function(component) {
        component.set("v.isLogin", false);

        localStorage.removeItem(localStorage.key(2));
    }
})
