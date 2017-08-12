<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-7-26
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<link>
<meta http-equiv="Content-Type" content="text/html;"/>
<title>欢迎登录管理系统</title>
<link href="${ctx}/include/Css/login.css" rel="stylesheet" type="text/css"/>
<script src="${ctx}/include/Scripts/jquery.js"></script>
<script src="${ctx}/include/Scripts/cloud.js" type="text/javascript"></script>

<script>
    $(function () {
        $('.loginbox').css({'position': 'absolute', 'left': ($(window).width() - 692) / 2});
        $(window).resize(function () {
            $('.loginbox').css({'position': 'absolute', 'left': ($(window).width() - 692) / 2});
        });
    });
</script>

</head>

<body style="background-color:#1c77ac; background-image:url(${ctx}/include/images/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
<div id="mainBody">
    <div id="cloud1" class="cloud"></div>
    <div id="cloud2" class="cloud"></div>
</div>
<form id="webform">
    <div class="logintop">
        <span>欢迎登录管理系统</span>
    </div>
    <div class="loginbody">
        <span class="systemlogo"></span>
        <div class="loginbox">
            <ul>
                <li>
                    <div class="loginuser">
                        <input id="txtLOGINNAME" name="LOGINNAME" type="text" placeholder="用户名"
                               datatype="*" nullmsg="请填写您的用户名！" onclick="JavaScript:this.value='superman'"/>
                    </div>
                </li>
                <li>
                    <div class="loginpwd">
                        <input id="txtPASSWORD" name="PASSWORD" type="password" placeholder="密码"
                               datatype="*" nullmsg="请填写密码！" onclick="JavaScript:this.value='hyjk@2017'"/>
                    </div>
                </li>
                <li>
                    <div class="yzm">
                        <input id="txtCheckCode" name="CheckCode" type="text" placeholder="验证码"
                               onclick="JavaScript:this.value=''" maxlength="4"/></div>
                    <img id="imgCode" src="${ctx}/tlogin/code" onclick="this.src='${ctx}/tlogin/code?x='+Math.random()"
                         alt="验证码" title="点击刷新" style="vertical-align: top; height:48px"/></li>
                <li><input id="btnLogin" name="" type="button" class="loginbtn" value="登录"/>
                    <%--<label><a href="${ctx}/tpage/registBefore?pindex=regist" target="_blank">注册</a></label>--%>
                    <label><a href="${ctx}/tlogin/forget" id="txtForgetPwd" target="_blank">忘记密码？</a></label></li>
            </ul>
        </div>
        <div style="position: absolute;bottom: 30px;width: 100%;text-align: center;color: #fff;">建议使用Internet
            Explorer11浏览器使用本系统。 技术支持：0311-83720199
        </div>
    </div>
    <%--<div class="loginbm">版权所有 河北华烨冀科信息技术有限责任公司</div>--%>
</form>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script>
    $(function () {
        if (location != top.location) top.location.href = location.href;
        $("#txtCheckCode").on('keypress', function (e) {
            if (e.keyCode == 13) {
                $('#btnLogin').click();
                return false;
            }
        });
        $("#btnLogin").click(function () {
            var wForm = $("#webform").Validform();
            if (wForm.check()) {
                $.post("${ctx}/tlogin/login", $("#webform").serializeArray(), function (d) {
                    if (d.code == 1) {
                        location.href = "/";
                    } else if (d.code == 2) {
                        location.href = "${ctx}/tpage/registBefore?pindex=regist";
                    }
                    else {
                        layer.alert(d.msg);
                        $("#txtCheckCode").val('');
                        $("#imgCode").attr('src', '${ctx}/tlogin/code?x=' + Math.random());
                    }
                });
            }
            else {
                wForm.ajaxPost();
            }
        });
        $("#btnRegist").click(function () {
            $.post("${ctx}/tpage?pindex=regist");
        });
    });
</script>

</body>

</html>
