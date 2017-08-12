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
    <form id="webform" action="${ctx}/tuser/APPUSERINFOSave_add" class="form form-horizontal">
        <div class="row cl border-tg">
            <label class="form-label col-xs-3"><span class="c-red">*</span>姓名：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtNAME" name="NAME" class="input-text " datatype="*" nullmsg="必须填写姓名！" />
            </div>
            <label class="form-label col-xs-3">性别：</label>
            <div class="formControls col-xs-3">
                <select id="sSEX" name="SEX" class="select-box ">
                    <option value=""></option>
                    <option value="1">男</option>
                    <option value="2">女</option>
                </select>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3">电话：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtTEL" name="TEL" class="input-text " />
            </div>
            <label class="form-label col-xs-3">邮箱：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtEMAIL" name="EMAIL" class="input-text " />
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3">地址：</label>
            <div class="formControls col-xs-9">
                <input type="text" id="txtADDRESS" name="ADDRESS" class="input-text " />
            </div>
        </div>
        <h5 style="border-bottom: 1px solid #ccc;"></h5>
        <div id="userInfo" class="row cl border-tg">
            <label class="form-label col-xs-3"><span class="c-red">*</span>登录用户名：</label>
            <div id="divLogin" class="formControls col-xs-9">
                <input type="text" id="txtLOGINNAME" name="LOGINNAME" class="input-text" datatype="*" nullmsg="必须填写【登录用户名】！" onkeyup="loginCheck();" />
            </div>
            <div id="divMSG" style="color: #ff070e;display: none" >
                <h6 style="margin: 24px 0 0 0;">/*该登录名已存在！*/</h6>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-3"><span class="c-red">*</span>登录密码：</label>
            <div class="formControls col-xs-9">
                <input type="text" id="txtPASSWORD" name="PASSWORD" class="input-text" datatype="*" nullmsg="必须填写【登录密码】！" />
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
<script>
    var wForm = null;
    $(function () {
        wForm = $("#webform").Validform();
        $("#btnSave").click(function () {
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
            } else { wForm.ajaxPost(); }
        });
    });

    function loginCheck() {
        ajaxPost("${ctx}/tuser/loginCheck", {
            loginname: $("#txtLOGINNAME").val()
        }, function (d) {
            if (d!=0) {
                document.getElementById("txtLOGINNAME").style='background-color: #fbe2e2';
                document.getElementById("divLogin").className='formControls col-6';
                document.getElementById("divMSG").style.display='inline';
            }else {
                document.getElementById("txtLOGINNAME").style='';
                document.getElementById("divMSG").style.display='none';
                document.getElementById("divLogin").className='formControls col-xs-9';
            }
        });
    }
</script>
</body>
</html>
