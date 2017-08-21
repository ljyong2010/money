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
                <th>全部放款总额(元)</th>
                <th>全部回款总额(元)</th>
                <th>全部毛利(元)</th>
                <th>全部审核费</th>
                <th>全部逾期总额(元)</th>
                <th>全部纯利(元)</th>
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
    });
    function bindData() {
        if (oTable){
            oTable.fnDraw();
        }else {
            oTable = $("#datalist").dataTable({
                "sAjaxSource":"${ctx}/tassessor/total",
                "columns":[
                    { "data": "ZBOR"},
                    { "data": "ZACU"},
                    { "data": null, "sClass": "text-c", "sWidth": "150px", "mRender": function (data, type, full) { return Profit(data); } },
                    { "data": "ZREV" ,"sWidth": "150px"},
                    { "data": null, "sClass": "text-c", "sWidth": "150px", "mRender": function (data, type, full) { return Yq(data); } },
                    { "data": null, "sClass": "text-c", "sWidth": "100px", "mRender": function (data, type, full) { return GAIN(data); } }
                ]
            });
        }

    }
    function Profit(data) {
        var a3=parseFloat(data.ZACU)- parseFloat(data.ZBOR);
        return a3.toFixed(2);
    }
    function Yq(data) {
        var a1=parseFloat(data.ZREP)-parseFloat(data.ZACU);
        return a1.toFixed(2);
    }
    function GAIN(data) {
        var a3=parseFloat(data.ZACU)- parseFloat(data.ZBOR)-data.ZREV;
        return a3.toFixed(2);
    }
</script>
</body>
</html>
