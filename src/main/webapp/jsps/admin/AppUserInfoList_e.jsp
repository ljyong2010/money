<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>监管用户List</title>
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
            用户名：<input type="text" class="input-text" style="width: 250px" placeholder="请输入用户名进行搜索" id="txtNAME" name="CNAME" />
            &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
            &nbsp;&nbsp;
            <button type="button" class="btn btn-primary radius" id="btnRemove" ><i class="Hui-iconfont">&#xe68f;</i> 清空</button>
        </form>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-10">
        <span class="l"></span>
        <span class="r"><a id="btnNew" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加</a></span>
    </div>
    <div class="cl">
        <table id="datalist" class="table table-border table-bordered table-bg table-hover mt-5" style="width: 100%;">
            <thead>
            <tr>
                <th>登录名</th>
                <th>用户名</th>
                <th>单位名称</th>
                <th>所属单位</th>
                <th>状态</th>
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
        $("#btnChange").click(function () {
            $("#search").slideToggle();
        });
        $("#btnSearch").click(function () {
            oTable.fnDraw();
        });
        $("#btnNew").click(function () {
            openWin('${ctx}/tuser?pindex=AppUserInfoJgAdd', '新增用户', 640, 450);
        });
        $("#btnRemove").click(function () {
            $("#webform :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
        });
        bindData();
    });

    function bindData() {
        oTable = $("#datalist").dataTable({
            "sAjaxSource": "${ctx}/tuser/APPUSERINFOList_e",
            "columns": [
                { "data": "LOGINNAME" },
                { "data": "REALNAME" },
                { "data": "ENTITYNAME" },
                { "data": "ENTITYDESCRIPTION" },
                { "data":  null, "sClass": "text-c", "sWidth": "80px", "mRender": function (data, type, full) { return data.USERSTATUS == 0 ? "<span class='label label-success radius'>可用</span>" : "<span class='label radius'>停用</span>"; } },
                { "data": null, "sClass": "text-c", "sWidth": "100px", "mRender": function (data, type, full) { return Btns(data); } }
            ]
        });
    }
    function Btns(data) {
        if(data.USERSTATUS==0){
            var btns = ['<a onclick="openWin(\'${ctx}/tuser?pindex=APPUSERINFOEdit_e&USERID=' + data.USERID + '\',\'修改用户信息\',640, 320);\" class="btn-link">修改</a>', '<a href="javascript:stopUse(\'' + data.USERID + '\',\'' + data.REALNAME + '\');" class="btn-link">停用</a>'];
        }else {
            var btns = ['<a onclick="openWin(\'${ctx}/tuser?pindex=APPUSERINFOEdit_e&USERID=' + data.USERID + '\',\'修改用户信息\',640, 320);\" class="btn-link">修改</a>', '<a href="javascript:startUse(\'' + data.USERID + '\',\'' + data.REALNAME + '\');" class="btn-link">启用</a>'];
        }
        return btns.join('&nbsp; ');
    }
    function startUse(USERID, REALNAME) {
        layer.confirm("确认启用[" + REALNAME + "]吗？", function () {
            ajaxPost("${ctx}/tuser/AppuserStopUse", { USERID: USERID }, function (d) {
                if (d.code > 0) {
                    layer.msg("启用成功", { time: 300 }, function () {
                        oTable.fnDraw();
                    });
                } else {
                    layer.alert("启用失败！" + d.msg);
                } })
        });
    }
    function stopUse(USERID, REALNAME) {
        layer.confirm("确认停用[" + REALNAME + "]吗？", function () {
            ajaxPost("${ctx}/tuser/AppuserStopUse", { USERID: USERID }, function (d) {
                if (d.code > 0) {
                    layer.msg("停用成功", { time: 300 }, function () {
                        oTable.fnDraw();
                    });
                } else {
                    layer.alert("停用失败！" + d.msg);
                } })
        });
    }
</script>
</body>
</html>
