


function L(LoginUserName){

    if(LoginUserName.length==0||LoginUserName==''){
        $("#checkLoginUserName").html("请输入正确的用户名");
        $("#loginSub").attr("disabled","disabled")
    }else{
        $("#loginSub").removeAttr("disabled")
        $("#checkLoginUserName").html("");
    }


}

function checkLoginUserPass(LoginUserPass){

    if(LoginUserPass.length==0||LoginUserPass==''){
        $("#checkLoginUserPass").html("请输入正确的密码");
        $("#loginSub").attr("disabled","disabled")
    }else{
        $("#loginSub").removeAttr("disabled")
        $("#checkLoginUserPass").html("");
    }

}


function doLogin(){


    let LoginUserName=$("#LoginUserName") .val();
    let LoginUserPass=$("#LoginUserPass") .val();
    let autoLogin=$("#autoLogin") .val();
    $.post("/UserServlet?m=login",{
        userName:LoginUserName,
        userPass:LoginUserPass,
        autoLogin:autoLogin
    },function(jsonStr){
        let data=   JSON.parse(jsonStr);
        $("#LoginUserInfo").html(data.message);
        $('#ModalLogin').modal('hide');
        window.location.reload();
    });
}


function checkUserName(userName){

    $.get("/UserServlet?m=preRegister&userName="+userName,function (jsonStr) {
        let data = JSON.parse(jsonStr);
        console.log(jsonStr)
        if(data.status==0){
            $("#checkUserName").html(data.message);
            $("#sub").attr("disabled","disabled")

        }else{
            $("#checkUserName").html("");
            $("#sub").removeAttr("disabled")
        }
    })
}



function checkUserAge(userAge){

    if(userAge<=0||userAge>=120){
        $("#checkUserAge").html("请输入正确的年龄");
        $("#sub").attr("disabled","disabled")

    }else{
        $("#checkUserAge").html("");
        $("#sub").removeAttr("disabled")
    }


}

//提交注册的方法 使用ajax提交表单
function doSubmit(){



    $.post("/UserServlet?m=register",$("#registerForm").serialize(),function(jsonStr){
        let data = JSON.parse(jsonStr);
        if(data.status==0){
            //注册失败
            alert("注册失败")
        }else{
            //注册成功  关闭当前模态框 打开登录模态框
            $('#ModalUpdate').modal('hide');
            $('#ModalLogin').modal('show');
        }

    });
}





function checkMobile(phone) {
    var filter  = /^\d{5,11}$/;
    if (filter.test(phone))
        return true;
    else {
        return false;
    }
}
