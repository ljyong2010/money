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
<div class="btn-primary change"  align="center" >
    <span id="btnChange" style="cursor:pointer;" >高级搜索 <i class="Hui-iconfont"></i></span>
</div>
<div class="pd-20">
    <div id="search" class="text-c pd">
        <form id="webform">
            角色名称：<input type="text" class="input-text radius" style="width: 250px" placeholder="输入角色名称搜索" id="txtRoleName" name="RoleName" />
            &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
            &nbsp;&nbsp;
            <button type="button" class="btn btn-primary radius" id="btnRemove" ><i class="Hui-iconfont">&#xe68f;</i> 清空</button>
        </form>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-10">
        <span class="l"></span>
        <span class="r"><a onclick="openWin('${ctx}/trole?pindex=AppRoleEdit','新增角色',400,240);" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加</a></span>
    </div>
    <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5" style="width: 100%;">
        <thead>
        <tr>
            <th>角色名称</th>
            <th>授权管理</th>
            <th>操作</th>
        </tr>
        </thead>
    </table>
</div>
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
        $("#btnChange").click(function () {
            $("#search").slideToggle();
        });
        $("#btnSearch").click(function () {
            oTable.fnDraw();
        });
        $("#btnRemove").click(function () {
            $("#webform :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
        });
        load(bindData);
    });
    function load(fnCallBack) {
        fnCallBack();
    }
    function bindData() {
        oTable = $("#datalist").dataTable({
            "sAjaxSource": "${ctx}/trole/APPROLEList",
            "columns": [
                { "data": "ROLENAME" },
                { "data": null, "sClass": "text-c", "sWidth": "80px", "mRender": function (data, type, full) { return '<a onclick="openWin(\'${ctx}/trole?pindex=AppRoleMenuList&ROLEID=' + data.ROLEID + '\',\'设置角色权限\',500,600);" class="btn-link">设置</a>'; } },
                { "data": null, "sClass": "text-c", "sWidth": "120px", "mRender": function (data, type, full) { return Btns(data); } }
            ]
        });
    }
    function Btns(data) {
        var btns = ['<a onclick="openWin(\'${ctx}/trole?pindex=AppRoleEdit&ROLEID=' + data.ROLEID + '\',\'修改角色\',400,240);" class="btn-link">修改</a>',
            '<a href="javascript:delAsk(' + data.ROLEID + ',\'' + data.ROLENAME + '\');" class="btn-link">删除</a>'];
        return btns.join('&nbsp; ');
    }
    function delAsk(ROLEID, ROLENAME) {
        layer.confirm("确认删除[" + ROLENAME + "]吗？", function () {
            ajaxPost("${ctx}/trole/AppRoleDelete", { ROLEID: ROLEID.toString() }, function (d) {
                if (d.code > -1) {
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