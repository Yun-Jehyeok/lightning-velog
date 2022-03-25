({
    sendMail: function(component, event) {
        event.preventDefault();

        var authNum = Math.random().toString().substr(2, 6);

        var action = component.get("c.sendEmail");

        action.setParams({
            body: authNum,
            toSend: component.get("v.email")
        });

        action.setCallback(this, function(data) {
            if(data.getReturnValue()) {
                alert("이메일 발송에 성공했습니다");

                component.set("v.isSend", true);
            } else {
                alert("이메일 발송에 실패했습니다");
            }

            component.set("v.authNum", authNum);
        })
        
        $A.enqueueAction(action);
    },
    checkAuthNumber: function(component, event) {
        event.preventDefault();

        var inputNum = component.get("v.inputAuthNum");
        var authNum = component.get("v.authNum");

        if(inputNum === authNum) {
            component.set("v.isAuthSuccess", true);

            alert("이메일 인증에 성공했습니다")
        } else {
            alert("인증번호를 확인해주세요")
        }
    },
    onSubmit: function(component, event) {
        event.preventDefault();

        var name = component.get("v.name");
        var email = component.get("v.email");
        var password = component.get("v.password");
        var passwordCheck = component.get("v.passwordCheck");
        var isAuth = component.get("v.isAuthSuccess");

        if(password !== passwordCheck) {
            alert("비밀번호와 비밀번호 확인을 동일하게 작성해주세요")
        } else if(!isAuth) {
            alert("이메일 인증을 완료해주세요")
        } else {
            var action = component.get("c.registerUser");
            
            action.setParams({
                name: name,
                email: email,
                password: password,
            })

            action.setCallback(this, function(data) {
                var response = data.getReturnValue();

                alert(response.msg);

                if(response.isAuth === 'success') {
                    component.set("v.isRegisterSuccess", true);
                } else {
                    // component.find().focus();
                }
            })
    
            $A.enqueueAction(action);
        }
    }
})
