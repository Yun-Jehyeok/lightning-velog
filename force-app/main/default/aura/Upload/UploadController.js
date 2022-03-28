({
    initValue: function(component, event) {
        component.set("v.userId", event.getParam("userId"));
    },
    onSubmit : function(component, event) {
        event.preventDefault();

        var title = component.get("v.title");
        var contents = component.get("v.contents");
        // var userId = component.get("v.userId");

        var action = component.get("c.uploadPost");

        var dt = new Date();

        action.setParams({
            "title": title,
            "contents": contents,
            "creator": "0015j00000aqcf4AAA",
            "currentDate": dt
        });

        action.setCallback(this, function(response) {
            var res = response.getReturnValue();

            console.log(res);
            // if(res.msg) {
            //     window.location.href("/c/MainPage.app");
            // } else {
            //     alert("실패!")
            // }
        })

        $A.enqueueAction(action);
    }
})
