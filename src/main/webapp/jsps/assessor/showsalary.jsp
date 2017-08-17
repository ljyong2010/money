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
<div class="pd-20">
    <div class="text-c pd">
        <form id="webform">
            <input type="hidden" NAME="USERID" value="${param.get("USERID")}"/>
            <input type="hidden" name="SDATE" value="${param.get("sdate")}"/>
            <input type="hidden" name="EDATE" value="${param.get("edate")}"/>
        </form>
    </div>

    <div class="cl">
        <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5"style="width: 100%;">
            <thead>
            <tr>
                <th>审核员</th>
                <th>利润(元)</th>
                <th>审核费(元)</th>
                <th>工资(元)</th>
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
<script>
    var oTable = null;
    $(function () {
        bindData();
    })

    function bindData() {
        if(oTable){
            oTable.fnDraw();
        }else {
            oTable = $("#datalist").dataTable({
                "sAjaxSource": "${ctx}/tassessor/salaryShowMenoy",
                "columns": [
                    { "data": "LOGINNAME"},
                    { "data": null, "sClass": "text-c", "sWidth": "200px", "mRender": function (data, type, full) { return Profit(data); } },
                    { "data": "revfee" },
                    { "data": null, "sClass": "text-c", "sWidth": "200px", "mRender": function (data, type, full) { return GAIN(data); } }
                    ]
            });
        }

    }
    function Profit(data) {

        var a3=(parseFloat(data.acualmoney)-parseFloat(data.borrowbalan))*0.2;
        return a3.toFixed(2);
    }
    function GAIN(data) {
        var a3 = (parseFloat(data.acualmoney)-parseFloat(data.borrowbalan))*0.2+data.revfee;
        return a3.toFixed(2);
    }
</script>

</body>
</html>


