public with sharing class authController {
    @AuraEnabled
    public static Boolean sendEmail(String body, String toSend) {
        try {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            String[] toAddresses = new String[] { toSend };

            mail.setToAddresses(toAddresses);
            mail.setSubject('Y Blog 회원가입 인증번호입니다.');
            mail.setPlainTextBody('인증번호: ' + body);

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            return true;
        } catch(Exception e) {
            System.debug(e);

            return false;
        }
    }

    // 우선 다른 기능을 위해 암호화 없이...
    @AuraEnabled
    public static map<string, object> loginUser(String email, String password){
        try {
            map<string, Object> result = new map<string, Object>();

            Account[] user = [SELECT Email__c, Password__c, Name FROM Account WHERE Email__c=:email];

            if(user.size() <= 0) {
                result.put('isLogin', 'fail');
                result.put('msg', '이메일을 확인해주세요');

                return result;
            } else {
                String passwordData = user[0].Password__c;
            
                if(passwordData == password) {
                    result.put('isLogin', 'success');
                    result.put('msg', '로그인 되었습니다');
                    result.put('name', user[0].Name);
                    result.put('email', user[0].Email__c);
                    
                    return result;
                } else {
                    result.put('isLogin', 'fail');
                    result.put('msg', '비밀번호를 확인해주세요');
                    
                    return result;
                }
            }
        } catch (Exception e) {
            map<string, Object> result = new map<string, Object>();

            result.put('isLogin', 'fail');
            result.put('msg', e.getMessage());

            return result;
        }
    }
    @AuraEnabled
    public static map<string, object> registerUser(String name, String email, String password){
        try {
            map<string, Object> result = new map<string, Object>();

            if(name == '') {
                result.put('isAuth', 'fail');
                result.put('msg', '이름을 작성해주세요.');

                return result;
            } else if(email == '') {
                result.put('isAuth', 'fail');
                result.put('msg', '이메일을 작성해주세요.');

                return result;
            } else if(password == '') {
                result.put('isAuth', 'fail');
                result.put('msg', '비밀번호를 작성해주세요.');

                return result;
            }

            Account[] user = [SELECT Email__c FROM Account WHERE Email__c=:email];

            if(user.size() > 0) {
                result.put('isAuth', 'fail');
                result.put('msg', '이미 존재하는 이메일입니다.');

                return result;
            } else {
                Account newUser = new Account(Name=name, Email__c=email, Password__c=password);

                insert newUser;

                result.put('isAuth', 'success');
                result.put('msg', '회원가입에 성공했습니다.');

                return result;
            }
        } catch (Exception e) {
            map<string, Object> result = new map<string, Object>();

            result.put('isAuth', 'fail');
            result.put('msg', e.getMessage());

            return result;
        }
    }





    // 비밀번호 암호화 용
    // @AuraEnabled
    // public static map<string, object> loginUser(String email, String password){
    //     try {
    //         map<string, Object> result = new map<string, Object>();

    //         Account[] user = [SELECT Email__c FROM Account WHERE Email__c=:email];

    //         if(user.size() <= 0) {
    //             result.put('isLogin', 'fail');
    //             result.put('msg', '이메일을 확인해주세요');

    //             return result;
    //         } else {
    //             Account[] user2 = [SELECT Password__c FROM Account WHERE Email__c=:email];

    //             String passwordData = user2[0].Password__c;
            
    //             Blob data = Blob.valueOf(password);
    //             Blob encryptionKey = crypto.generateAesKey(128);
    //             Blob initVector = Blob.valueOf('bPmSgVkYp4s6v9t$');

    //             Blob encryptedPassword = Crypto.encrypt('AES128', encryptionKey, initVector, data);

    //             if(passwordData == EncodingUtil.base64Encode(encryptedPassword)) {
    //                 result.put('isLogin', 'success');
    //                 result.put('msg', '로그인 되었습니다');
                    
    //                 return result;
    //             } else {
    //                 result.put('isLogin', 'fail');
    //                 result.put('msg', '비밀번호를 확인해주세요');
                    
    //                 return result;
    //             }
    //         }
    //     } catch (Exception e) {
    //         map<string, Object> result = new map<string, Object>();

    //         result.put('isLogin', 'fail');
    //         result.put('msg', e.getMessage());

    //         return result;
    //     }
    // }
    // @AuraEnabled
    // public static map<string, object> registerUser(String name, String email, String password){
    //     try {
    //         map<string, Object> result = new map<string, Object>();

    //         if(name == '') {
    //             result.put('isAuth', 'fail');
    //             result.put('msg', '이름을 작성해주세요.');

    //             return result;
    //         } else if(email == '') {
    //             result.put('isAuth', 'fail');
    //             result.put('msg', '이메일을 작성해주세요.');

    //             return result;
    //         } else if(password == '') {
    //             result.put('isAuth', 'fail');
    //             result.put('msg', '비밀번호를 작성해주세요.');

    //             return result;
    //         }

    //         Account[] user = [SELECT Email__c FROM Account WHERE Email__c=:email];

    //         if(user.size() > 0) {
    //             result.put('isAuth', 'fail');
    //             result.put('msg', '이미 존재하는 이메일입니다.');

    //             return result;
    //         } else {
    //             Blob data = Blob.valueOf(password);
    //             Blob encryptionKey = crypto.generateAesKey(128);
    //             Blob initVector = Blob.valueOf('bPmSgVkYp4s6v9t$');
    //             Blob encryptedPassword = Crypto.encrypt('AES128', encryptionKey, initVector, data);
                
    //             String savePassword = EncodingUtil.base64Encode(encryptedPassword);

    //             Account newUser = new Account(Name=name, Email__c=email, Password__c=savePassword);

    //             insert newUser;

    //             result.put('isAuth', 'success');
    //             result.put('msg', '회원가입에 성공했습니다.');

    //             return result;
    //         }
    //     } catch (Exception e) {
    //         map<string, Object> result = new map<string, Object>();

    //         result.put('isAuth', 'fail');
    //         result.put('msg', e.getMessage());

    //         return result;
    //     }
    // }
}
