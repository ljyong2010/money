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
<body style="overflow: auto;">
<div class="pd-20">
    <form id="webform">
        <input type="hidden" id="hUSERID" name="USERID" value="${param.get("USERID")}" />
        <div id="approlelist" class="pd-5">
        </div>
        <div class="text-c mt-10">
            <div>
                <button id="btnSave" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存 </button>
                &emsp;
                <button type="button" class="btn btn-primary-outline radius" id="btnClose"><i class="Hui-iconfont">&#xe66b;</i> 关闭 </button>
            </div>
        </div>
    </form>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>

<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    $(function () {
        $("#btnSave").click(function () {
            ajaxPost("${ctx}/tuser/UserRoleSave", { USERID: $("#hUSERID").val(), MAP: concatId() }, function (d) {
                if (d.code > 0)
                    layer.msg("角色设置成功", { time: 500 }, function () {
                        closeLayerWindow();
                    });
                else
                    layer.alert(d.msg);
            });
        });
        var ul = $("#approlelist");
        ajaxPost("${ctx}/tuser/AppRoleList", {}, function (rs) {
            if (rs.data.length == 0) { $('<span>尚未创建角色</span>').appendTo(ul); }
            $.each(rs.data, function (s, r) {
                $('<input id="role' + r.ROLEID + '" type="checkbox" value="' + r.ROLEID + '" style="margin-left:15px;" /> <label for="r' + r.ROLEID + '">' + r.ROLENAME + '</label>').appendTo(ul);
            });
            ajaxPost("${ctx}/tuser/GetUserRole", { USERID: $("#hUSERID").val() }, function (ar) {
                $.each(ar.data.split(','), function () {
                    $('#role' + this + ':checkbox').prop("checked", true);
                });
            });
        });
    });
    function concatId() {
        var appid = [];
        $.each($("#approlelist").find(":checked"), function (i, v) {
            appid.push($(v).val());
        });
        return appid.join(',');
    }
</script>
</body>
</html>