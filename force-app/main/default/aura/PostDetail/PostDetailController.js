({
    myInit : function(component, event, helper) {
        var postId = window.location.href.split('postId=')[1];

        var action = component.get("c.getPost");
        action.setParams({ "Id": postId });

        action.setCallback(this, function(data) {
            var res = data.getReturnValue();

            component.set("v.post", res);
        })

        $A.enqueueAction(action);
    },
    onDeletePost: function(component, event, helper) {
        event.preventDefault();

        var postId = window.location.href.split('postId=')[1];
        
        var action = component.get("c.deletePost");
        action.setParams({ "postId": postId });

        action.setCallback(this, function(data) {
            var res = data.getReturnValue();

            console.log(res);

            if(res) {
                alert("게시글이 삭제되었습니다");
                window.location.assign("/c/MainPage.app");
            } else {
                alert("게시글 삭제에 실패했습니다");
            }
        })

        $A.enqueueAction(action);
    }
})
