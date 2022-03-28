({
    myInit : function(component, event, helper) {
        component.set("v.title", component.get("v.post.Name"));
        component.set("v.contents", String(component.get("v.post.Contents__c")).replace(
            /<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/gi,
            ''
        ));
        component.set("v.date", String(component.get("v.post.CurrentDate__c")));

        console.log(component.get("v.post.Name"));
    }
})
