public with sharing class postController {
    @AuraEnabled
    public static Post__c[] getAllPosts(String creatorId){
        try {
            Post__c[] posts = [SELECT Name, Contents__c, CreatorId__c, CurrentDate__c, Id FROM Post__c WHERE CreatorId=:creatorId];

            return posts;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static map<string, Object> uploadPost(String title, String contents, String creator, Date currentDate) {
        try {
            map<string, Object> result = new map<string, Object>();

            Post__c newPost = new Post__c(Name=title, Contents__c=contents, CreatorId__c=creator, CurrentDate__c=currentDate);

            insert newPost;

            result.put('success', true);
            result.put('msg', 'success');

            return result;
        } catch (Exception e) {
            map<string, Object> result = new map<string, Object>();

            result.put('success', false);
            result.put('msg', e.getMessage());
            
            return result;
        }
    }
}
