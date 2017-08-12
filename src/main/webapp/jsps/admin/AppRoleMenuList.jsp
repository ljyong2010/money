<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title></title>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.min.css" rel="stylesheet" />

    <link href="${ctx}/include/Scripts/H-ui/lib/Hui-iconfont/iconfont.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet" />
</head>
<body>
<div class="pd-5">
    <form id="webform" action="${ctx}/trole/APPMENUList">
        <div class="text-c pd">
            <input type="hidden" id="hROLEID" name="ROLEID" value="${param.get("ROLEID")}" />
            <input type="hidden" id="hMENUID" name="MENUID" />
        </div>
        <div class="cl pd-5 bg-1 bk-gray">
                <span class="r">
                    <button type="button" class="btn btn-primary radius" id="btnSave"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
                </span>
        </div>
        <div class="cl">
            <ul id="menutree" class="ztree text-c"></ul>
        </div>
    </form>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.defaults.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>

<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    function loadmenu() {
        bindTree("menutree", {
            idKey: "MENUID", pIdKey: "PARENTID", title: "MENUNAME", showCheck: true, selectedMulti: false, setCheckUrl: "${ctx}/trole/AppRoleMenuList" });
    }

    $(function () {
        loadmenu();
        $("#btnSave").click(function () {
            saveTree("menutree", { inputId: "hMENUID", idKey: "MENUID", saveUrl: "${ctx}/trole/AppRoleMenuSave" }, function (d) {
                if (d.code > 0)
                    layer.msg("已保存", { time: 500 });
                else
                    layer.alert(d.msg);
            });
        });
    });
</script>
</body>
</html>
