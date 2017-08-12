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
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet" />
</head>
<body>
<div class="pd-20">
    <form id="webform" action="${ctx}/trole/AppRoleSave" class="form form-horizontal">
        <input type="hidden" id="hROLEID" name="ROLEID" value="${param.get("ROLEID")=="undefined"?"":param.get("ROLEID")}" />
        <div class="row cl">
            <label class="form-label col-xs-3"><span class="c-red">*</span>角色名称：</label>
            <div class="formControls col-xs-9">
                <input type="text" id="txtRoleName" name="ROlENAME" class="input-text radius" datatype="*" nullmsg="请填写角色名称！" />
            </div>
        </div>
        <div class="row cl">
            <div class="col-offset-3 mt-10">
                <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保 存</button>&emsp;
                <button type="button" class="btn btn-warning radius" id="btnClose"><i class="Hui-iconfont">&#xe66b;</i>关 闭</button>
            </div>
        </div>
    </form>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>

<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    var wForm = null;
    $(function () {
        wForm = $("#webform").Validform();
        $("#btnSave").click(function () {
            if (wForm.check()) {
                formPost(function (r) {
                    if (r.code >= -1) {
                        layer.msg("保存成功！", { time: 500 }, function () {
                            parent.oTable.fnDraw();
                            closeLayerWindow();
                        });
                    } else { layer.alert("保存失败！" + r.msg); }
                });
            } else {
                wForm.ajaxPost();
            }
        });
        if ($("#hROLEID").val() != "") {
            ajaxPost("${ctx}/trole/GetAPPROLE", { ROLEID: $("#hROLEID").val() }, function (d) {
                $("#txtRoleName").val(d.ROLENAME);
            });
        }
    })
</script>
</body>
</html>
