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
                <select id="sUSERID" name="USERID" class="select-box" style="width: 150px"></select>
                &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-primary radius" id="btnRemove" ><i class="Hui-iconfont">&#xe68f;</i> 清空</button>
            </form>
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
        function load(fnCallBack) {
            ajaxPost("tassessor/userName", {}, function (d) {
                $('<option value="">选择审核员</option>').appendTo($("#sUSERID"));
                $.each(d.data, function (i, v) {
                    $('<option value="' + v.USERTYPEID + '">' + v.USERTYPENAME + '</option>').appendTo($("#sUSERTYPEID"));
                });
                fnCallBack();
            });
        }
    </script>
</body>
</html>
