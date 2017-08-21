<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title></title>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.min.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.admin.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/lib/Hui-iconfont/iconfont.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet"/>
</head>
<body>
<div class="pd-20">
    <form id="webform" class="form form-horizontal" action="${ctx}/tcust/saveCustomInfo">
        <input type="hidden" id="hID" NAME="ID" value="${param.get("USERID")}">
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">客户姓名：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtcustomName" name="customName" class="input-text" datatype="*" nullmsg="必须填写客户姓名！" />
            </div>
            <label class="form-label col-xs-2">身份证号：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtcard" name="card" datatype="*" nullmsg="必须填写身份证号！" class="input-text" />
            </div>
            <div class="form-label col-xs-2">
                <button id="btnCheck" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i>
                    是否可用
                </button>
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">手机号：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtphone" name="phone" class="input-text" datatype="*" nullmsg="必须填写手机号！" />
            </div>
            <label class="form-label col-xs-2">平台：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtplatform" name="platform" class="input-text" datatype="*" nullmsg="必须填写平台！" />
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2"> 家庭住址：</label>
            <div class="formControls col-xs-8">
                <textarea type="text" id="txtaddress" name="address" class="textarea" cols="6"></textarea>
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2"> QQ号：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtqq" name="qq" datatype="*" nullmsg="必须填写qq！" class="input-text"  />
            </div>
            <label class="form-label col-xs-2">微信号：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtwebcart" name="webcart" datatype="*" nullmsg="必须填写微信号！" class="input-text"/>
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2"> 借款金额：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtborrowbalan" name="borrowbalan" datatype="*" nullmsg="必须填写借款金额！" class="input-text" />
            </div>
            <label class="form-label col-xs-2">借款日期：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtborrowdate" name="borrowdate" class="input-text " datatype="*" nullmsg="必须填写借款日期！" value="" onclick="laydate()" />
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">还款金额：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtreplymoney" name="replymoney" datatype="*" nullmsg="必须填写还款金额！" class="input-text" />
            </div>
            <label class="form-label col-xs-2">还款日期：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtreplydate" name="replydate" class="input-text " datatype="*" nullmsg="必须填写还款日期！" value="" onclick="laydate()" />
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">押金：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtdeposit" name="deposit" datatype="*" nullmsg="必须填写押金！" class="input-text" />
            </div>
            <label class="form-label col-xs-2">中介：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtagency" name="agency" datatype="*" nullmsg="必须填写中介！" class="input-text" />
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">备注：</label>
            <div class="formControls col-xs-8">
               <%-- <input type="text" id="txtremark" name="remark" />--%>
                   <textarea type="text" id="txtremark" name="remark" class="textarea" cols="6"></textarea>
            </div>
        </div>
        <%if (((org.manage.model.APPUSER)session.getAttribute("Appuser")).getUSERTYPEID()==2){%>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">利润：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtprofit" name="profit" class="input-text" />
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">实际还款金额：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtacualmoney" name="acualmoney" class="input-text" />
            </div>
            <label class="form-label col-xs-2">实际还款日期：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtactualdate" name="actualdate" class="input-text " value="" onclick="laydate()" />

                <%--<input type="text" id="txtactualdate" name="actualdate" class="input-text Wdate" onfocus="WdatePicker()"/>--%>
            </div>
        </div>
        <%}else {%>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">利润：</label>
            <div class="formControls col-xs-3">
                <input type="text" readonly="readonly" id="txtprofit" name="profit" class="input-text" />
            </div>
        </div>
        <div class="row cl border-tg">
            <label class="form-label col-xs-2">实际还款金额：</label>
            <div class="formControls col-xs-3">
                <input type="text" id="txtacualmoney" readonly="readonly" name="acualmoney" class="input-text" />
            </div>
            <label class="form-label col-xs-2">实际还款日期：</label>
            <div class="formControls col-xs-3">
                <%--<input type="text" id="txtactualdate" readonly="readonly" name="actualdate" class="input-text Wdate" onfocus="WdatePicker()"/>--%>
                <input type="text" id="txtactualdate" readonly="readonly" name="actualdate" class="input-text " value="" onclick="laydate()" />

            </div>
        </div>
        <%}%>
    </form>
</div>
<div class="row cl">
    <div class="text-c">
        <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i>
            保存
        </button>
        <button id="btnClose" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe66b;</i>关闭
        </button>
    </div>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/laydate/laydate.js"></script>
<script>
    var wForm = "";
    if ($("#hID").val()!=""){
        ajaxPost("${ctx}/tcust/GetCustomerInfo", {
            ID: $("#hID").val()
        }, function (d) {
            formAssign(d);
        });
    }
    $(function(){
        wForm = $("#webform").Validform();
        $("#btnSave").click(function () {
            if (wForm.check()) {
                formPost(function (r) {
                    if (r.code > 0) {
                        layer.msg("添加成功！", { time: 500 }, function () {
                            parent.oTable.fnDraw();
                            closeLayerWindow();
                        });
                    } else { layer.alert("添加失败！" + r.msg); }
                });
            } else {
                wForm.ajaxPost();
            }
        });
        $("#btnCheck").click(
            function () {
                ajaxPost("${ctx}/tcust/checkUserCard",{card:$("#txtcard").val()},function (d) {
                    if (d.code > 0){
                        layer.alert("客户已经存在！");
                    }else {
                        layer.alert("可以使用！");
                    }
                })
            }
        )
    });
</script>
</body>
</html>

