<%@ page import="org.manage.model.APPUSER" %>
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
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet" />
</head>

<body>
<div class="btn-primary change"  align="center" >
    <span id="btnChange" style="cursor:pointer;" >高级搜索 <i class="Hui-iconfont"></i></span>
</div>
<div class="pd-20">
    <div id="search" class="text-c pd">
        <form id="webform">
            <%int typeid = ((APPUSER)session.getAttribute("Appuser")).getUSERTYPEID();
                if (typeid == 2){%>
            <select id="sassessorId" name="assessorId" class="select-box" style="width: 150px"></select>
            <%}else {%>
            <select id="sassessorId" name="assessorId" class="select-box" style="width: 150px" disabled="disabled"></select>
            <%}%>
            &nbsp;&nbsp;开始日期：<input type="text" class="input-text" style="width: 90px" placeholder="请输入日期" onclick="laydate()" datatype="*" nullmsg="必须填写开始日期！" id="txtstartDate" name="startDate" />
            -&nbsp;<input type="text" class="input-text" style="width: 90px" placeholder="请输入日期" onclick="laydate()" datatype="*" nullmsg="必须填写结束日期！" id="txtendDate" name="endDate" />
            &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
            &nbsp;&nbsp;
            <button type="button" class="btn btn-primary radius" id="btnRemove" ><i class="Hui-iconfont">&#xe68f;</i> 清空</button>
        </form>
    </div>
    <div class="cl">
        <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5"style="width: 100%;">
            <thead>
            <tr>
                <th>审核员</th>
                <th>放款总额(元)</th>
                <th>回款总额(元)</th>
                <th>毛利(元)</th>
                <th>审核费</th>
                <th>逾期总额(元)</th>
                <th>纯利(元)</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.defaults.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/laydate/laydate.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script>
    var oTable = null;
    var webform= $("#webform").Validform();
    $(function () {
        /*$("#search").hide();*/
        $("#btnChange").click(function () { $("#search").slideToggle();});
        $("#btnSearch").click(function () {
            if(webform.check()){
                bindData();
            }
        });
        $("#btnRemove").click(function () {
            $("#webform :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
        });
        load(ld());
    });
    function load(fnCallBack) {
        ajaxPost("${ctx}/tassessor/userName", {}, function (d) {
            $('<option value="">选择审核员</option>').appendTo($("#sassessorId"));
            $.each(d.data, function (i, v) {
                $('<option value="' + v.USERID + '">' + v.LOGINNAME + '</option>').appendTo($("#sassessorId"));
            });
            fnCallBack();
        });
    }
    function load1(fnCallBack) {
        ajaxPost("${ctx}/tassessor/userName1", {}, function (d) {
            $('<option value="">选择审核员</option>').appendTo($("#sassessorId1"));
            $.each(d.data, function (i, v) {
                $('<option value="' + v.USERID + '">' + v.LOGINNAME + '</option>').appendTo($("#sassessorId1"));
            });
            fnCallBack();
        });
    }
    function ld() {
    }
    function bindData() {
        if (oTable){
            oTable.fnDraw();
        }else {
            oTable = $("#datalist").dataTable({
                "sAjaxSource": "${ctx}/tassessor/totalInfo",
                "columns": [
                    { "data": "LOGINNAME"},
                    { "data": "BOR"},
                    { "data": "ACU"},
                    { "data": null, "sClass": "text-c", "sWidth": "150px", "mRender": function (data, type, full) { return Profit(data); } },
                    { "data": "REV" ,"sWidth": "150px"},
                    { "data": null, "sClass": "text-c", "sWidth": "150px", "mRender": function (data, type, full) { return Yq(data); } },
                    { "data": null, "sClass": "text-c", "sWidth": "100px", "mRender": function (data, type, full) { return GAIN(data); } }
                ]
            });
        }

    }
    function Profit(data) {
        var a3=parseFloat(data.ACU)- parseFloat(data.BOR);
        return a3.toFixed(2);
    }
    function Yq(data) {
        var a1=parseFloat(data.REP)-parseFloat(data.ACU);
        return a1.toFixed(2);
    }
    function GAIN(data) {
        var a3=parseFloat(data.ACU)- parseFloat(data.BOR)-data.REV;
        return a3.toFixed(2);
    }
</script>
</body>
</html>

