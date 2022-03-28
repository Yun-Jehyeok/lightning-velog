({
    myInit: function(component, event, handler) {
        var action = component.get("c.getAllPosts");

        action.setParams({
            creatorId: "0015j00000aqcf4AAA"
        })

        action.setCallback(this, function(data) {
            var res = data.getReturnValue();

            component.set("v.posts", res);
        })

        $A.enqueueAction(action);
    }
})
