
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
<div class="pd-20 deform">
    <form id="webform" action="${ctx}/tcost/costSave" class="form form-horizontal">
        <input type="hidden" id="hID" NAME="ID" value="${param.get("id")}">
        <div class="row cl border-tg">
            <label class="form-label col-xs-3"><span class="c-red">*</span>支出明细：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtcostDetails" name="costDetails" class="input-text " datatype="*" nullmsg="必须填写姓名！" />
            </div>
            <label class="form-label col-xs-3">工资：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtmoney" name="money" class="input-text " datatype="*" nullmsg="必须填工资！" />
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3"><span class="c-red">*</span>支出人员：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtperson" name="person" class="input-text " datatype="*" nullmsg="必须填写姓名！" />
            </div>
            <label class="form-label col-xs-3">开始日期：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtdate" name="date" class="input-text " datatype="*" nullmsg="必须填写开始日期！" value="" onclick="laydate()" />
            </div>
        </div>
    </form>
</div>
<div class="row cl text-c">
    <div class="mt-10 ">
        <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保 存</button>&nbsp;&nbsp;&nbsp;
        <button id="btnClose" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe66b;</i> 取 消</button>
    </div>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script src="${ctx}/include/Scripts/laydate/laydate.js"></script>
<script>
    var wForm = null;
    $(function () {
        ajaxPost("${ctx}/tcost/getCost", {ID: $("#hID").val()}, function (d) {
            formAssign(d);
        });
        $("#btnSave").click(function () {
            wForm = $("#webform").Validform();
            if (wForm.check()) {
                formPost(function (r) {
                    if (r.code > 0) {
                        layer.msg("保存成功！", { time: 500 }, function () {
                            //parent.oTable.fnDraw();
                            closeLayerWindow();
                        });
                        parent.window.location.reload();
                    } else { layer.alert("保存失败！" + r.msg); }
                });
            } else {
                wForm.ajaxPost();
            }
        });
    });
</script>
</body>
</html>
