<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-7-26
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>管理系统</title>
    <link href="${ctx}/include/Scripts/zui/css/zui.min.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/zui/css/zui-theme.min.css" id="mytheme" rel="stylesheet" />
    <link href="${ctx}/include/Css/main.css" rel="stylesheet" />
    <!--[if lt IE 9]>
    <script src="${ctx}/include/Scripts/zui/lib/ieonly/html5shiv.js"></script>
    <script src="${ctx}/include/Scripts/zui/lib/ieonly/respond.js"></script>
    <script src="${ctx}/include/Scripts/zui/lib/ieonly/excanvas.js"></script>
    <![endif]-->
</head>
<body>
<header id="header" class="bg-primary" >
    <div id="headerlogo">
        <i class="icon icon-cubes icon-2x"></i>
        <%-- <%=ConfigurationManager.AppSettings["SiteTitle"] %>--%>
        管理系统
    </div>
    <div class="collapse navbar-collapse" style="padding-right: 50px;">
        <ul class="nav navbar-nav navbar-right navbar-dark" style="margin-top: 29px;">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-user"></i>&nbsp;<span>${Appuser.REALNAME}</span><b class="caret"></b></a>
                <ul class="dropdown-menu" role="menu">
                    <li><a id="loginuserinfo" href="${ctx}/tlogin/personInfo"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
                    <li><a id="pwdchange" href="${ctx}/tlogin/changePassword"><i class="icon-edit"></i>&nbsp; 修改密码</a></li>
                    <li class="divider"></li>
                    <li><a id="logout" href="${ctx}/tlogin/logout"><i class="icon-off"></i>&nbsp; 退出</a></li>
                </ul>
            </li>
        </ul>
    </div>
</header>
<div id="content"><div class="btn_l"></div>
    <aside class="Hui-aside">
        <div class="leftcontent">
            <nav class="menu" data-ride="menu" style="font-size: 16px">
                <ul id="treeMenu" class="tree tree-menu" data-ride="tree">
                    ${sbPage}
                </ul>
                <br/><br/><br/>
            </nav>
        </div>
    </aside>
    <div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
    <div class="maincontent">
        <div id="main" style="overflow: hidden;">
            <ul class="nav nav-tabs">
                <li class="active"><a data-tab href="#Console">首页</a></li>
            </ul>
            <div class="tab-content">
                <div id="Console" class="tab-pane active">
                    <iframe src="${ctx}/consoleShow"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/zui/js/zui.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    var basePath = '${ctx}';
    $(function () {
        $("#pwdchange").click(function () {
            layer.open({
                type: 2,
                title: '修改密码',
                shadeClose: true,
                shade: 0.8,
                area: ['380px', '300px'],
                content: "${ctx}/tlogin/setShowPwd?" + Math.random()
            });
        });
    });
    $(function () {
        $("#loginuserinfo").click(function () {
            layer.open({
                type: 2,
                title: '个人信息',
                shadeClose: true,
                shade: 0.8,
                area: ['700px', '400px'],
                content: "${ctx}/tlogin/peopleinfor"
            });
        });
    });
    function changecolor(color) {
        document.getElementById("header").style.backgroundColor=color;
        document.getElementById("menu").style.backgroundColor=color;
        document.getElementById("menu").style.borderColor=color;
        /*var tags = document.body.getElementsByTagName ('*');所有标签
         for ( var i = 0; i < tags.length; i++)
         {
         tags[i].style.backgroundColor=color;
         }*/
    }
</script>
<script src="${ctx}/include/Scripts/index.js"></script>
</body>
</html>
