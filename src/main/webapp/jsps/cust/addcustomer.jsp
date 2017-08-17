<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<div class="pd-20" deform>
    <form id="webform" action="${ctx}/tcust/saveCustomInfo" class="form form-horizontal" method="post">
        <input type="hidden" id="hID" NAME="ID" value="${param.get("USERID")}">
            <div class="row cl border-tg">
                <label class="form-label col-xs-3">客户姓名：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtcustomName" name="customName" class="input-text" style="width:100%" datatype="*" nullmsg="必须填写客户姓名！" >
                </div>
                <label class="form-label col-xs-3">身份证号：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtcard" name="card" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl  border-tg">
                <label class="form-label col-xs-3">家庭住址：</label>
                <div class="formControls col-xs-9">
                    <input type="text" id="txtaddress" name="address" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-xs-3">手机号：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtphone" name="phone" class="input-text" style="width:100%" datatype="*" nullmsg="必须填写手机号！" >
                </div>
                <label class="form-label col-xs-3">平台：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtplatform" name="platform" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-xs-3">QQ号：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtqq" name="qq" class="input-text" style="width:100%">
                </div>
                <label class="form-label col-xs-3">微信号：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtwebcart" name="webcart" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-xs-3">借款金额：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtborrowbalan" name="borrowbalan" class="input-text" style="width:100%">
                </div>
                <label class="form-label col-xs-3">借款日期：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtborrowdate" name="borrowdate" class="input-text " datatype="*" nullmsg="必须填写借款日期！" value="" onclick="laydate()"/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-xs-3">还款金额：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtreplymoney" name="replymoney" class="input-text" style="width:100%">
                </div>
                <label class="form-label col-xs-3">还款日期：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtreplydate" name="replydate" class="input-text " datatype="*" nullmsg="必须填写借款日期！" value="" onclick="laydate()"/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-xs-3">押金：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtdeposit" name="deposit" class="input-text" style="width:100%">
                </div>
                <label class="form-label col-xs-3">中介：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtagency" name="agency" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl  border-tg">
                <label class="form-label col-xs-3">备注：</label>
                <div class="formControls col-xs-9">
                    <input type="text" id="txtremark" name="remark" class="input-text " value=""/>
                </div>
            </div>

            <%if (((org.manage.model.APPUSER)session.getAttribute("Appuser")).getUSERTYPEID()==2){%>
            <div class="row cl  border-tg">
                <label class="form-label col-xs-3">利润：</label>
                <div class="formControls col-xs-9">
                    <input type="text" id="txtprofit" name="profit" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-3">实际还款金额：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtacualmoney" name="acualmoney" class="input-text" style="width:100%">
                </div>
                <label class="form-label col-xs-3">实际还款日期：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtactualdate" name="actualdate" class="input-text " value="" onclick="laydate()"/>
                </div>
            </div>
            <%}else {%>
            <div class="row cl  border-tg">
                <label class="form-label col-xs-3">利润：</label>
                <div class="formControls col-xs-9">
                    <input type="text" readonly="readonly" id="txtprofit" name="profit" class="input-text " value=""/>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-3">实际还款金额：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtacualmoney" readonly="readonly" name="acualmoney" class="input-text" style="width:100%">
                </div>
                <label class="form-label col-xs-3">实际还款日期：</label>
                <div class="formControls col-xs-3">
                    <input type="text" id="txtactualdate" readonly="readonly" name="actualdate" class="input-text " value="" onclick="laydate()"/>
                </div>
            </div>
        <%}%>
    </form>
    <div class="row cl text-c">
        <div class="mt-10 ">
            <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
            <button id="btnClose" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe66b;</i> 返回</button>
        </div>
    </div>
</div>

<br><br><br><br>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="${ctx}/include/Scripts/zui/js/zui.min.js"></script>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>

<script src="${ctx}/include/Scripts/Common.js"></script>
<script src="${ctx}/include/Scripts/Dic.js"></script>
<script src="${ctx}/include/Scripts/laydate/laydate.js"></script>
<script language="javascript" type="text/javascript">
    var wForm = null;
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
    });
</script>
</body>
</html>
