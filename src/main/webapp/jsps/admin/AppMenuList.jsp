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
    <link href="${ctx}/include/Scripts/H-ui/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/skin/default/skin.css" rel="stylesheet" />
    <link href="${ctx}/include/Scripts/H-ui/css/style.css" rel="stylesheet" />
</head>
<body>
<div class="pd-5 deform">
    <form id="webform" class="form form-horizontal">
        <div class="text-c pd">
            <input type="hidden" id="hMENUID" name="MENUID" />
            <input type="hidden" id="hPARENTID" name="PARENTID" value="0" />
        </div>
        <div class="cl bg-1 hidden">
            <span class="l"></span>
            <span class="r">
                    <button type="button" class="btn btn-warning radius" id="btnBack"><i class="Hui-iconfont">&#xe66b;</i>返回</button>
                </span>
        </div>
        <div class="cl pd-5 bk-gray bg-1">
            <div class="col-xs-4">
                &nbsp; <a id="btnReset" title="点击可添加主菜单">功能菜单
            </a>
                <ul id="menutree" class="ztree"></ul>
            </div>
            <div class="col-xs-8 bg-fff  mt-20">
                <div class="row text-shadow Huialert-info ml-10">
                    &nbsp; 提示：不选中左侧菜单项时，默认添加为主菜单！
                </div>
                <div class="row cl border-tg">
                    <label class="form-label col-xs-3"><span class="c-red">*</span>菜单名称：</label>
                    <div class="formControls col-xs-9">
                        <input type="text" id="txtMENUNAME" name="MENUNAME" class="input-text" datatype="*" nullmsg="请填写菜单名称！" />
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-3"><span class="c-red">*</span>链接：</label>
                    <div class="formControls col-xs-9">
                        <input type="text" id="txtMENUURL" name="MENUURL" class="input-text" datatype="*" nullmsg="请填写链接！" />
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-3">图标：</label>
                    <div class="formControls col-xs-9">
                        <input type="text" id="txtMENUICON" name="MENUICON" class="input-text" />
                    </div>
                </div>
                <div class="row cl border-rg">
                    <label class="form-label col-xs-3"><span class="c-red">*</span>排序：</label>
                    <div class="formControls col-xs-3">
                        <input type="text" id="txtMENUSORT" name="MENUSORT" class="input-text" datatype="*" nullmsg="请填写排序！" value="1" />
                    </div>
                    <label class="col-6">正序排列</label>
                </div>
                <div class="row cl border-rg">
                    <label class="form-label col-xs-3"><span class="c-red">*</span>是否隐藏：</label>
                    <div class="formControls col-xs-9  border-lb">
                        <div class="radio-box">
                            <input type="radio" id="radio-ISHIDE0" name="ISHIDE" value="0" checked="checked" />
                            <label for="radio-ISHIDE0">&nbsp;显示</label>
                            <input type="radio" id="radio-ISHIDE1" name="ISHIDE" value="1" />
                            <label for="radio-ISHIDE1">&nbsp;隐藏</label>
                        </div>
                    </div>
                </div>
                <div class="row cl border-rg">
                    <label class="form-label col-xs-3">状态：</label>
                    <div class="formControls col-xs-9 border-lb">
                        <div class="radio-box">
                            <input type="radio" id="radio-DELFLAG0" name="DELFLAG" value="0" checked="checked" />
                            <label for="radio-DELFLAG0">&nbsp;可用</label>
                            <input type="radio" id="radio-DELFLAG1" name="DELFLAG" value="1" />
                            <label for="radio-DELFLAG1">&nbsp;停用</label>
                        </div>
                    </div>
                </div>
                <div class="row cl border-lb border-rg">
                    <div class="col-xs-12 col-xs-offset-3" style="margin-top: 5px;margin-bottom: 5px;">
                        <a id="btnNew" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加子菜单</a>
                        <button id="btnSave" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
                        <button id="btnDelete" class="btn btn-primary-outline radius" type="button"><i class="Hui-iconfont">&#xe60b;</i> 删除</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script src="${ctx}/include/Scripts/jquery-1.7.2.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/layer/layer.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/DataTables/jquery.dataTables.defaults.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/lib/Validform/5.3.2/Validform.min.js"></script>
<script src="${ctx}/include/Scripts/H-ui/js/H-ui.js"></script>
<script src="${ctx}/include/Scripts/Common.js"></script>
<script>
    var wForm = null;
    $(function () {
        $("#btnNew").hide();
        $("#btnDelete").hide();
        wForm = $("#webform").Validform();
        $("#btnDelete").click(function () {
            formPost("${ctx}/tmenu/APPMENUDelete", function (d) {
                if (d.code > 0) {
                    layer.msg("删除成功！", { time: 500 });
                    location.reload();
                } else {
                    layer.alert("删除失败！");
                }
            })
        });
        $("#btnNew").click(function () {
            $("#btnNew").hide();
            $('#webform')[0].reset();
            $("#hMENUID").val("");
            $("#hPARENTID").val(getTree('menutree').getSelectedNodes()[0].id);
        });
        $("#btnReset").click(function () {
            location.reload();
            $("#btnNew").hide();
            getTree('menutree').refresh();
            $('#webform')[0].reset();
        });
        $("#btnSave").click(function () {
            if (wForm.check()) {
                formPost("${ctx}/tmenu/AppMenuSave", function (r) {
                    if (r.code > -1) {
                        layer.msg("保存成功！", { time: 500 }, function () {
                            loadtree();
                            $('#webform')[0].reset();
                        });
                    } else {
                        layer.alert("保存失败！" + r.msg);
                    }
                });
            } else {
                wForm.ajaxPost();
            }
        });
        loadtree();
    });
    function loadtree() {
        var treeid = "menutree";
        //bindAsyncTree("menutree", { idKey: "MENUID", pIdKey: "PARENTID", title: "MENUNAME", showCheck: false, selectedMulti: false, setCheckUrl: "AdminService.svc/AppRoleMenuList", callback: { onClick: zTreeOnClick } });
        var settings = {
            async: {
                enable: true,
                url: "${ctx}/tmenu/GetMenuList",
                autoParam: ["id"],
                otherParam: ["rootid", null],
                contentType: "application/json; charset=utf-8",
                type: "POST",
                dataType: "json"
            },
            callback: {
                onAsyncSuccess: loadSuccess,
                onClick: zTreeOnClick
            },
            view: {
                selectedMulti: false
            }
        };
        $.fn.zTree.init($("#" + treeid), settings);
    }
    var loadSuccess = function (e, id, n, m) {
        if (!!m) {
            var tree = getTree(id);
            tree.expandAll(false);
            $.each(m, function (i, v) {
                var node = tree.getNodeByParam("id", v.id, null);
                tree.reAsyncChildNodes(node, "refresh");
            });
        }
    }
    var zTreeOnClick = function (e, treeId, treeNode) {
        ajaxPost("${ctx}/tmenu/GetAPPMENU", { MENUID: treeNode.id }, function (d) {
            formAssign(d);
        });
        if (!treeNode.isParent) {
            $("#btnNew").hide();
            $("#btnDelete").show();
        }
        else {
            $("#btnNew").show();
            $("#btnDelete").hide();
        }
    }
</script>
</body>
</html>