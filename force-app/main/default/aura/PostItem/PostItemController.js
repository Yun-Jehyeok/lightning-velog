({
    myInit : function(component, event, helper) {
        component.set("v.title", component.get("v.post.Name"));
        component.set("v.contents", String(component.get("v.post.Contents__c")).replace(
            /<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/gi,
            ''
        ).slice(0, 80));
        component.set("v.date", String(component.get("v.post.CurrentDate__c")));
        component.set("v.creator", component.get("v.post.CreatorName__c"));
        component.set("v.postId", component.get("v.post.Id"));
    }
})
