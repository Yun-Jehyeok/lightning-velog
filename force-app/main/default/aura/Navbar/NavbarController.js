({
    openDropdown: function(component) {
        var item = component.get("v.isDropdownOpen");

        component.set("v.isDropdownOpen", !item);
    },
    onLogout: function(component) {
        component.set("v.isLogin", false);

        // 원래는 이거...
        // localStorage.removeItem("access-token");
    }
})
