var wsr_right = 0;
var cx = 0;

function win() {
    /*一级布局宽*/
    var h2 = $(".t-box").height();
    var w1 = $(".sbox").width();//大框宽
    var wsr = $(".box-r").width();//右框宽
    var w2 = w1 - wsr - 30;//左框宽    
    if (cx == 1) {
        w2 = w2 + wsr;
    }
    $(".box-l").width(w2);
    /*nav宽*/
    $(".nav b").width(wsr / 3 - 2);
    $(".n6").width(wsr / 6 - 2);
    $(".n5").width(wsr / 5 - 2);
    $(".n4").width(wsr / 4 - 2);
    $(".n3").width(wsr / 3 - 2);
    $(".n2").width(wsr / 2 - 2);
    $(".n1").width(wsr - 2);

    var h1 = $(".box-r").height()-50;
    var h3 = h1 - h2;
    $(".h3").height(h3);
    $(".sh1").height(h1)-50;
    $(".c-box").width(wsr - 2);

}

$(function () {
    win();
    $(window).resize(function () {
        win();
    });
    $(".nav b").each(function (ss) {
        $(this).click(function () {
            $(this).siblings("b").removeClass("on");
            $(this).addClass("on");
            $(this).parent(".nav").siblings(".s-box:eq(" + ss + ")").show().siblings(".s-box").hide();;
        });
    });
    /*图例显示 隐藏*/
    var wl = $(".tu_li").width()
    wl = wl - 9;
    var count = 0;
    $(".tu_li .tn").click(function () {
        $(".op").toggle();
        $(".cl").toggle();
        if (count == 1) {
            $(".tu_li").stop().animate({ right: 0 }, 300);
            count = 0;
        }
        else {
            $(".tu_li").stop().animate({ right: -wl }, 300);
            count = 1;
        }
    });

    $(".bxr-tn").click(function () {
        var w1 = $(".sbox").width();//大框宽
        var wsr = $(".box-r").width();//右框宽
        var w2 = w1 - wsr - 22;//左框宽

        if (cx == 1) {
            $(this).addClass("c");
            $(".box-l").stop().animate({ width: w2 - 9 }, 300);
            $(".box-r").stop().animate({ right: 8 }, 300);
            cx = 0;
        }
        else {
            $(this).removeClass("c");
            $(".box-l").stop().animate({ width: w1 - 22 }, 300);
            $(".box-r").stop().animate({ right: -wsr }, 300);
            cx = 1;
        }
    });
})


var ryid;
var ryname
function GetJGDXByRyID(_ryid, _ryname) {
    ryid = _ryid;
    ryname = _ryname;
    var title = '监管对象详细信息';
    var width = 800;
    var height = 540;
    var divId = "GetJGDXByRyID";
    if ($("#" + divId).length == 0) {
        var html = "<div id='" + divId + "' z-width='" + width + "' z-height='" + height + "' title='" + title + "' style='display:none'></div>";
        $(document.body).append(html);
    }

    var html = "";
    html += "<div class='contents'>";
    html += "    <div class='search-box'>";
    html += "        监管对象名称：<input id='txt_jgdx_name' type='text' class='wp1' />";
    //html += "        监管对象类型：<select id='sel_qylx' class='wp1'>";
    //html += "            <option value=''>请选择</option>";
    //html += "            <option value='S'>食品</option>";
    //html += "            <option value='Y'>药品</option>";
    //html += "            <option value='B'>保健品</option>";
    //html += "            <option value='H'>化妆品</option>";
    //html += "            <option value='Q'>医疗器械</option>";
    //html += "        </select>";
    html += "        <input type='button' id='btnsearch' value='查询' class='btns' onclick='GetJGDXByRyID.LoadData(1);' />";
    html += "    </div>";
    html += "    <table class='tb-list'>";
    html += "        <thead>";
    html += "            <tr>";
    html += "                <th>监管对象名称</th>";
    html += "                <th>注册地址</th>";
    //html += "                <th>监管对象类型</th>";
    html += "                <th>联系人</th>";
    html += "                <th>联系电话</th>";
    //html += "                <th style='width:70px;'>操作</th>";
    html += "            </tr>";
    html += "        </thead>";
    html += "        <tbody id='tbody_JGDXByRyID'></tbody>";
    html += "    </table>";
    html += "    <div id='pager" + divId + "' class='feny' style='text-align:center;'></div>";
    html += "</div>";
    $("#" + divId).html(html);
    if (!GetJGDXByRyID.Pager) {
        GetJGDXByRyID.Pager = new myPager("pager" + divId, "GetJGDXByRyID.LoadData");
    }
    GetJGDXByRyID.LoadData(1);
    openWindows.open(divId, title);
}


GetJGDXByRyID.Pager = undefined;

GetJGDXByRyID.LoadData = function (pi) {
    var txt_jgdx_name = $("#txt_jgdx_name").val();
    var sel_qylx = $("#sel_qylx").val();
    var otherParams = "pIndex:'" + pi + "'";
    otherParams += ",pNum:'10'";
    otherParams += ",QYMC:'" + txt_jgdx_name + "'";
    otherParams += ",QYLX:'" + sel_qylx + "'";
    otherParams += ",ryid:'" + ryid + "'";
    otherParams += ",ryname:'" + ryname + "'";


    myAjaxCommon2("/bus_wg/ws/ws_wg.asmx/GetJGDXByRyIDs", { jsonParam: "{" + otherParams + "}" }, function (data, status) {
        if (data) {
            GetJGDXByRyID.Pager.init(pi, data.pcount, data.pnum);
            $("#tbody_JGDXByRyID").empty();
            $.each(data.pdata, function (key, v) {
                $("<tr>" +
                    "<td>" + v.P1 + "</td>" +
                    "<td>" + v.P6 + "</td>" +
                    //"<td>" + v.P2 + "</td>" +
                    "<td>" + v.P3 + "</td>" +
                    "<td>" + v.P4 + "</td>" +
                "</tr>").appendTo($("#tbody_JGDXByRyID"));
            });
        }
    },false);
}

function GetQYLXNameByQYLXCode(qylx, qylx2) {
    var qylxName = "";
    if (!!qylx) {
        switch (qylx) {
            case 0:
                qylxName = "药品";
                break;
            case 1:
                qylxName = "医疗器械";
                break;
            case 2:
                qylxName = "食品";
                break;
            case 3:
                qylxName = "化妆品";
                break;
            case 4:
                qylxName = "保健食品";
                break;
        }
    }
    if (!!qylx2) {
        switch (qylx2) {
            case 0:
                qylxName += "->生产";
                break;
            case 1:
                qylxName += "->批发";
                break;
            case 2:
                qylxName += "->流通";
                break;
            case 3:
                qylxName += "->医疗机构";
                break;
            case 4:
                qylxName += "->餐饮";
                break;
            case 5:
                qylxName += "->五小";
                break;
        }
    }

    return "";
}


