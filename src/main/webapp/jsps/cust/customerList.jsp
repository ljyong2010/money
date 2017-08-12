<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>客户信息</title>
    <link href="${ctx}/include/Scripts/H-ui/css/H-ui.min.css" rel="stylesheet" />

    <link href="${ctx}/include/Scripts/H-ui/lib/Hui-iconfont/iconfont.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet" />
    <style>
        .table tr td:nth-child(2){
            text-align: center;
            padding-left: 10px;
        }
        .table tr td:nth-child(5){
            text-align: left;
            padding-left: 10px;
        }
        .table tr td:nth-child(6){
            width:8%;
        }
    </style>
</head>
<body>
<div class="btn-primary change"  align="center" >
    <span id="btnChange" style="cursor:pointer;" >高级搜索 <i class="Hui-iconfont"></i></span>
</div>
<div class="pd-20">
    <div id="search" class="text-c pd">
        <form id="webform">
            客户姓名：<input type="text" class="input-text" style="width: 200px" placeholder="关键字" id="txtcustomName" name="customName" />
            &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
            &nbsp;&nbsp;
            <button type="button" class="btn btn-primary radius" id="btnRemove" ><i class="Hui-iconfont">&#xe68f;</i> 清空</button>

        </form>
    </div>
    <%
        int roleid=((org.manage.model.AppuserRole)session.getAttribute("Role")).getROLEID().intValue();
        if(roleid==1 || roleid==2||roleid==6){ %>
    <div class="cl pd-5 bg-1 bk-gray mt-10">
        <span class="l"></span>
        <span class="r"><a id="btnNew" onclick="openWinFull('${ctx}/tcust?pindex=addcustomer','新增',640, 600);" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加</a></span>
    </div>
    <%}else{%>
    <%}%>
    <div class="cl">
        <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5"style="width: 100%;">
            <thead>
            <tr>
                <th>客户姓名</th>
                <th>手机号</th>
                <th>借款金额</th>
                <th>借款日期</th>
                <th>还款金额</th>
                <th>还款日期</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
<br/><br/><br/><br/>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.defaults.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>

<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    var oTable = null;
    $(function () {
        $("#search").hide();
        $("#btnChange").click(function () { $("#search").slideToggle();});
        $("#btnSearch").click(function () { oTable.fnDraw(); });
        $("#btnRemove").click(function () {
            $("#webform :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
        });
        bindData();
    });
    function bindData() {
        oTable = $("#datalist").dataTable({
            "sAjaxSource": "${ctx}/tcust/customList",
            "columns": [
                { "data": "customName" },
                { "data": "phone" },
                { "data": "borrowbalan" },
                { "data": null, "sClass": "text-c","mRender": function (data) { return data.borrowdate==null?"-":data.borrowdate.substring(0,10);} },
                { "data": "replymoney" },
                { "data": null, "sClass": "text-c","mRender": function (data) { return data.replydate==null?"-":data.replydate.substring(0,10);} },
                { "data": null, "sClass": "text-c", "sWidth": "80px", "mRender": function (data, type, full) { return Btns(data); } }
            ]
        });
    }
    function Btns(data) {
        var btns = ['<a onclick="openWin(\'${ctx}/tcust?pindex=showCustom&id=' + data.ID + '\',\'查看\',640, 500);\" class="btn-link">查看</a>'];
        return btns.join('&nbsp; ');
    }
    function delAsk(FLID) {
        layer.confirm("确认删除吗？", function () { ajaxPost("${ctx}/tcust/delete", { id:ID}, function (d) {
            if (d.code > 0) {
                layer.msg("删除成功", { time: 300 }, function () {
                    oTable.fnDraw();
                });
            } else {
                layer.alert("删除失败！" + d.msg);
            }
        })
        });
    }
</script>
</body>
</html>