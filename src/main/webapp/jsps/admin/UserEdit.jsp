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
<div class="pd-20 deform2">
    <form id="webform" action="${ctx}/tuser/UserSave" class="form form-horizontal">
        <input type="hidden" id="hUSERID" name="USERID" value="${param.get("USERID")}" />
        <div class="row cl border-tg  border-rg">
            <label class="form-label col-xs-2"><span class="c-red">*</span>帐户名：</label>
            <div class="formControls col-xs-10">
                <input type="text" id="txtLOGINNAME" name="LOGINNAME" class="input-text" datatype="*6-20" nullmsg="请填写帐户名！" disabled="disabled" />
            </div>
        </div>
        <div class="row cl  border-rg">
            <label class="form-label col-xs-2"><span class="c-red">*</span>姓名：</label>
            <div class="formControls col-xs-10">
                <input type="text" id="txtREALNAME" name="REALNAME" class="input-text" datatype="*2-30" nullmsg="请填写姓名！" disabled="disabled" />
            </div>
        </div>
        <div class="row cl  border-rg">
            <label class="form-label col-xs-2"><span class="c-red">*</span>用户类别：</label>
            <div class="formControls col-xs-10">
                <select id="sUSERTYPEID" name="USERTYPEID" class="select-box"></select>
            </div>
        </div>
        <div class="row cl border-rg">
            <label class="form-label col-xs-2"><span class="c-red">*</span>状态：</label>
            <div class="formControls col-xs-10">
                <div class="radio-box">
                    <input type="radio" id="radio-USERSTATUS0" name="USERSTATUS" value="0" checked="checked" />
                    <label for="radio-USERSTATUS0">&nbsp;可用</label>
                    <input type="radio" id="radio-USERSTATUS1" name="USERSTATUS" value="1" />
                    <label for="radio-USERSTATUS1">&nbsp;停用</label>
                </div>
            </div>
        </div>
        <div class="text-c mt-10">
            <div>
                <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存 </button>
                &emsp;
                <button type="button" class="btn btn-warning radius" id="btnClose"><i class="Hui-iconfont">&#xe66b;</i> 关闭 </button>
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
                    if (r.code > 0) {
                        layer.msg("保存成功！", { time: 500 }, function () {
                            parent.oTable.fnDraw();
                            closeLayerWindow();
                        });
                    } else { layer.alert("保存失败！" + r.msg); }
                });
            } else { wForm.ajaxPost(); }
        });
        ajaxPost("${ctx}/tuser/AppUserTypeList", {}, function (uts) {
            $.each(uts.data, function (i, v) {
                $('<option value="' + v.USERTYPEID + '">' + v.USERTYPENAME + '</option>').appendTo($("#sUSERTYPEID"));
            });
            ajaxPost("${ctx}/tuser/GetUser", { USERID: $("#hUSERID").val() }, function (d) {
                formAssign(d);
            });
        });
    });
</script>
</body>
</html>

