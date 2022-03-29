public with sharing class postController {
    @AuraEnabled
    public static Post__c[] getAllPosts(){
        try {
            Post__c[] posts = [SELECT Name, Contents__c, CreatorId__c, CurrentDate__c, Id, CreatorName__c FROM Post__c ORDER BY CurrentDate__c DESC];

            return posts;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Post__c getPost(String Id){
        try {
            Post__c post = [SELECT Name, Contents__c, CreatorId__c, CurrentDate__c, CreatorName__c FROM Post__c WHERE Id =: Id];

            return post;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static map<string, Object> uploadPost(String title, String contents, String creatorName, String creator, Date currentDate) {
        try {
            map<string, Object> result = new map<string, Object>();

            Post__c newPost = new Post__c(Name=title, Contents__c=contents, CreatorId__c=creator, CurrentDate__c=currentDate, CreatorName__c=creatorName);

            insert newPost;

            result.put('success', true);
            result.put('msg', '게시글 업로드에 성공했습니다');

            return result;
        } catch (Exception e) {
            map<string, Object> result = new map<string, Object>();

            result.put('success', false);
            result.put('msg', e.getMessage());
            
            return result;
        }
    }

    @AuraEnabled
    public static Boolean deletePost(String postId){
        try {
            Post__c post = [SELECT Name FROM Post__c WHERE Id=:postId];

            delete post;

            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
