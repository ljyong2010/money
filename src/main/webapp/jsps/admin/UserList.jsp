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
            <input type="text" class="input-text radius" style="width: 150px" placeholder="输入用户名或姓名" id="txtLoginName" name="LoginName" />
            <select id="sUSERTYPEID" name="USERTYPEID" class="select-box" style="width: 150px"></select>
            &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
            &nbsp;&nbsp;
            <button type="button" class="btn btn-primary radius" id="btnRemove" ><i class="Hui-iconfont">&#xe68f;</i> 清空</button>
        </form>
    </div>
    <div class="cl mt-10">
        <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5" style="width: 100%;">
            <thead>
            <tr>
                <th>登录用户名</th>
                <th>姓名</th>
                <th>用户类别</th>
                <th>状态</th>
                <th>授权管理</th>
                <th>操作</th>
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
        load(bindData);
    });
    function load(fnCallBack) {
        ajaxPost("${ctx}/tuser/AppUserTypeList", {}, function (d) {
            $('<option value="">选择用户类别</option>').appendTo($("#sUSERTYPEID"));
            $.each(d.data, function (i, v) {
                $('<option value="' + v.USERTYPEID + '">' + v.USERTYPENAME + '</option>').appendTo($("#sUSERTYPEID"));
            });
            fnCallBack();
        });
    }
    function bindData() {
        oTable = $("#datalist").dataTable({
            "sAjaxSource": "${ctx}/tuser/UserList",
            "columns": [
                { "data": null, "mRender": function (data, type, full) { return "<a href='#?USERID=" + data.USERID + "'>" + data.LOGINNAME + "</a>"; } },
                /*{ "data": "LOGINNAME + " },*/
                { "data": "REALNAME" },
                { "data": "USERTYPENAME" },
                { "data": null, "sClass": "text-c", "sWidth": "80px", "mRender": function (data, type, full) { return data.USERSTATUS == 0 ? "<span class='label label-success radius'>可用</span>" : "<span class='label radius'>停用</span>"; } },
                { "data": null, "sClass": "text-c", "sWidth": "80px", "mRender": function (data, type, full) { return SQ(data); } },
                { "data": null, "sClass": "text-c", "sWidth": "100px", "mRender": function (data, type, full) { return Btns(data); } }
            ]
        });
    }
    function SQ(data) {
        var btns = ['<a onclick="openWin(\'${ctx}/tuser?pindex=UserMapList&USERID=' + data.USERID + '\',\'设置角色【' + data.REALNAME + '】\',500,300);" class="btn-link">角色设置</a> '];
        return btns.join('&nbsp; ');
    }
    function Btns(data) {
        var btns = ['<a onclick="openWin(\'${ctx}/tuser?pindex=UserEdit&USERID=' + data.USERID + '\',\'修改用户类型\',640,340);" class="btn-link">修改</a>', '<a href="javascript:delAsk(' + data.USERID + ',\'' + data.REALNAME + '\');" class="btn-link">删除</a>'];
        return btns.join('&nbsp; ');
    }
    function delAsk(USERID, username) {
        layer.confirm("确认删除[" + username + "]吗？", function () { ajaxPost("${ctx}/tuser/UserDelete", { USERID: USERID }, function (d) {
            if (d.code > -1) {
                layer.msg("删除成功", { time: 300 }, function () {
                    oTable.fnDraw();
                });
            } else {
                layer.alert("删除失败！" + d.msg);
            }
        }) });
    }
</script>
</body>
</html>