({
    myInit: function(component, event, handler) {
        var action = component.get("c.getAllPosts");

        action.setCallback(this, function(data) {
            var res = data.getReturnValue();

            component.set("v.posts", res);
        })

        $A.enqueueAction(action);
    }
})
