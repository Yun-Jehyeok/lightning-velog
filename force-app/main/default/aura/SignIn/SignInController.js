({
    onSubmit : function(component, event) {
        event.preventDefault();

        var email = component.get("v.email");
        var password = component.get("v.password");

        var action = component.get("c.loginUser");
        
        action.setParams({
            email: email,
            password: password,
        })

        action.setCallback(this, function(data) {
            var response = data.getReturnValue();

            alert(response.msg);
            
            if(response.isLogin === 'success') {
                component.set("v.isLogin", true);

                localStorage.setItem("access-token", "dummy-token")

                var appEvent = $A.get("e.c:store");
                appEvent.setParams({ userName: response.name, userEmail: response.email });
            } else {
                // component.find().focus();
            }
        })

        $A.enqueueAction(action);
    }
})
