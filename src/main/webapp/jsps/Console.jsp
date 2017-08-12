<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title></title>
    <link href="${ctx}/include/Scripts/zui/css/zui.min.css" rel="stylesheet"/>
    <link href="${ctx}/include/Scripts/zui/lib/dashboard/zui.dashboard.min.css" rel="stylesheet"/>
    <style>
        .panel > .panel-heading {
            color: #fff;
            background: #4092e8;
            background: -moz-linear-gradient(top, #4092e8 0%, #287ed5 100%);
            background: -webkit-linear-gradient(top, #4092e8 0%, #287ed5 100%);
            background: linear-gradient(to bottom, #4092e8 0%, #287ed5 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4092e8', endColorstr='#287ed5', GradientType=0);
            box-shadow: 0 1px 1px rgba(10, 85, 160, 0.47);
        }
    </style>
</head>
<body>
<div class="btn-primary" align="center" style="height: 22px; line-height: 22px;">
    <span id="btnChange" style="cursor:pointer;">高级搜索 <i class="icon icon-caret-down"></i></span>
</div>
<div style=" padding-top: 5px;padding-left: 20px;">
    <div id="search" class="text-c pd">
        <form id="webform" class="form-inline">
            <div class="input-group" style="width: 360px">
                <span class="input-group-addon">企业类型：</span>

                <span class="input-group-btn">
                    <button type="button" class="btn btn-default" id="btnSearch"><i
                            class="icon icon-search"></i> 查询
                    </button>
                    <button type="button" class="btn btn-default" id="btnRemove"><i class="icon icon-eraser"></i> 清空
                    </button>
                </span>
            </div>
        </form>
    </div>
</div>
<div style="padding: 20px;">
    <div id="dashboard" class="dashboard dashboard-draggable" data-height="300">
        <section class="row">
            <div class="col-md-6 col-sm-6">
                <div class="panel" data-id="1">
                    <div class="panel-heading">
                        <i class="icon icon-list"></i>
                        <span class="title">产品分类统计</span>
                    </div>
                    <div class="panel-body">

                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6">
                <div class="panel" data-id="2">
                    <div class="panel-heading">
                        <i class="icon icon-list"></i>
                        <span class="title">企业分布统计</span>
                    </div>
                    <div class="panel-body">

                    </div>

                </div>
            </div>
            <div class="col-md-6 col-sm-6">
                <div class="panel" data-id="3">
                    <div class="panel-heading">
                        <i class="icon icon-table"></i>
                        <span class="title">医疗器械行业规模统计</span>
                    </div>
                    <div class="panel-body no-padding">

                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel" data-id="4">
                    <div class="panel-heading">
                        <i class="icon icon-bolt"></i>
                        <span class="title">企业分类统计</span>
                    </div>
                    <div class="panel-body no-padding">

                    </div>
                </div>
            </div>

        </section>
    </div>
</div>
<script src="${ctx}/include/Scripts/jquery-1.11.3.min.js"></script>
<script src="${ctx}/include/Scripts/zui/js/zui.min.js"></script>
<script src="${ctx}/include/Scripts/zui/lib/dashboard/zui.dashboard.min.js"></script>
<script>
    $(function () {
        $('#dashboard').dashboard({draggable: true});
        $("#search").hide();
        $("#btnChange").click(function () {
            $("#search").slideToggle();
        });
        $("#btnRemove").click(function () {
            $("#webform :input").not(":button, :submit, :reset, :hidden").val("").removeAttr("checked").remove("selected");
        });
        //bindData();
    });
</script>
</body>
</html>
