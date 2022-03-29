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
            "creator": localStorage.getItem("userId"),
            "creatorName": localStorage.getItem("userName"),
            "currentDate": dt
        });

        action.setCallback(this, function(response) {
            var res = response.getReturnValue();

            if(res.msg) {
                alert(res.msg)
                window.location.assign("/c/MainPage.app");
            } else {
                alert("게시글 업로드에 실패했습니다")
            }
        })

        $A.enqueueAction(action);
    }
})
