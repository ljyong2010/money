<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.min.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/lib/Hui-iconfont/iconfont.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet" />
</head>
<body>
<div class="pd-30 deform">
    <form id="webform" action="${ctx}/tcust/saveCustomInfo" class="form form-horizontal" method="post">
        <input type="hidden" id="hID" NAME="ID" value="${param.get("USERID")}">
            <div class="row cl border-tg">
                <label class="form-label col-2">客户姓名：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtcustomName" name="customName" class="input-text" datatype="*" nullmsg="必须填写客户姓名！" >
                </div>
                <label class="form-label col-2">身份证号：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtcard" name="card" class="input-text" />
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">家庭住址：</label>
                <div class="formControls col-10">
                    <textarea type="text" id="txtaddress" name="address" class="textarea" cols="6"></textarea>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">手机号：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtphone" name="phone" class="input-text" datatype="*" nullmsg="必须填写手机号！" >
                </div>
                <label class="form-label col-2">平台：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtplatform" name="platform" class="input-text" />
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">QQ号：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtqq" name="qq" class="input-text" />
                </div>
                <label class="form-label col-2">微信号：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtwebcart" name="webcart" class="input-text"/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">借款金额：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtborrowbalan" name="borrowbalan" class="input-text" />
                </div>
                <label class="form-label col-2">借款日期：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtborrowdate" name="borrowdate" class="input-text Wdate" datatype="*" nullmsg="必须填写借款日期！" onfocus="WdatePicker()"/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">还款金额：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtreplymoney" name="replymoney" class="input-text" />
                </div>
                <label class="form-label col-2">还款日期：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtreplydate" name="replydate" class="input-text Wdate" datatype="*" nullmsg="必须填写借款日期！" onfocus="WdatePicker()"/>
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">押金：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtdeposit" name="deposit" class="input-text" />
                </div>
                <label class="form-label col-2">中介：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtagency" name="agency" class="input-text" />
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">备注：</label>
                <div class="formControls col-10">
                    <textarea type="text" id="txtremark" name="remark" class="textarea" cols="6" />
                </div>
            </div>

            <%if (((org.manage.model.APPUSER)session.getAttribute("Appuser")).getUSERTYPEID()==2){%>
            <div class="row cl border-tg">
                <label class="form-label col-2">利润：</label>
                <div class="formControls col-10">
                    <input type="text" id="txtprofit" name="profit" class="input-text" />
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">实际还款金额：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtacualmoney" name="acualmoney" class="input-text" />
                </div>
                <label class="form-label col-2">实际还款日期：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtactualdate" name="actualdate" class="input-text Wdate" onfocus="WdatePicker()"/>
                </div>
            </div>
            <%}else {%>
            <div class="row cl border-tg">
                <label class="form-label col-2">利润：</label>
                <div class="formControls col-10">
                    <input type="text" readonly="readonly" id="txtprofit" name="profit" class="input-text" />
                </div>
            </div>
            <div class="row cl border-tg">
                <label class="form-label col-2">实际还款金额：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtacualmoney" readonly="readonly" name="acualmoney" class="input-text" />
                </div>
                <label class="form-label col-2">实际还款日期：</label>
                <div class="formControls col-4">
                    <input type="text" id="txtactualdate" readonly="readonly" name="actualdate" class="input-text Wdate" onfocus="WdatePicker()"/>
                </div>
            </div>
        <%}%>
    </form>
    <div class="row cl">
        <div class="text-c">
            <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
            <button id="btnClose" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe66b;</i> 返回</button>
        </div>
    </div>
</div>
<script src="${ctx}/include/Scripts/zui/js/zui.min.js"></script>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<%--<script src="${ctx}/include/Scripts/laydate/laydate.js"></script>--%>
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
