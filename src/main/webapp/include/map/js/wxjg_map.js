var colorList = [
    '#0094ff', '#b200ff', '#6d492f', '#C1232B',
    '#27727B', '#808080', '#00ff21', '#ff006e',
    '#ff0000', '#3a3086', '#85412e', '#C6E579',
    '#E87C25', '#FCCE10', '#B5C334', '#F4E001',
    '#FAD860', '#9BCA63', '#FE8463', '#6AC8DD',
    '#ABCA63', '#FEA463', '#60C0DD', '#F3DA60',
    '#D7504B', '#F3A43B', '#A3A43B', '#0026ff',
    '#F0805A', '#27727B', '#26C0C0'
];

$(function () {
   win();
    $(window).resize(function () {
        win();
    });
})

function win() {
   var h2 = $(".t-box").height();
    var w1 = $(".sbox").width();//大框宽
    var wsr = $(".box-r").width();//右框宽
    var w2 = w1 - wsr - 30;//左框宽
    $(".box-l").width(w2);
    /!*nav宽*!/
    $(".nav b").width(wsr / 3 - 2);
    $(".n6").width(wsr / 6 - 2);
    $(".n5").width(wsr / 5 - 2);
    $(".n4").width(wsr / 4 - 2);
    $(".n3").width(wsr / 3 - 2);
    $(".n2").width(wsr / 2 - 2);
    $(".n1").width(wsr - 2);

    var h1 = $(".box-r").height() - 50;
    var h3 = h1 - h2;
    $(".h3").height(h3);
    $(".sh1").height(h1) - 50;
    $(".c-box").width(wsr - 2);
}

function addMarkerArea(obj) {

    var title = obj.PATH;
    var jingdu = obj.LONGITUDE;
    var weidu = obj.LATITUDE;
    var imgurl = '/include/map/img/flag2.png';

    var point = new BMap.Point(jingdu, weidu);
    var myIcon = new BMap.Icon(imgurl, new BMap.Size(31, 40));
    var marker = new BMap.Marker(point, { icon: myIcon, title: title });  // 创建标注
    marker.addEventListener("click", function (e) {
        var cAreaCode = obj.AREA_CODE;
        var AAA011S = simpleAreaCode(obj.AREA_CODE);
        var point = new BMap.Point(e.point.lng, e.point.lat);
        var path = obj.PATH;
        ajaxPost("/tpage/TJSumQYLX", { areacode: cAreaCode }, function (data) {
            if (!!data) {
                var sContent = "<div class='cx'><p style='font-size: 18px;border-bottom: 1px dashed #CCC;white-space: nowrap;padding-right:20px;'><b>" + path + "</b></p>" +
                    "<p style='font-size: 14px;padding-left:18px;'>医疗器械生产<b class='numb1 clicks' onclick='loadQyList(0," + cAreaCode + ")'>" + data.SUM_SC + "</b>家</p>" +
                    "<p style='font-size: 14px;padding-left:18px;'>医疗器械经营<b class='numb1 clicks' onclick='loadQyList(2," + cAreaCode + ")'>" + data.SUM_JY + "</b>家</p>" +
                    "<p style='font-size: 14px;padding-left:18px;'>医疗器械使用<b class='numb1 clicks' onclick='loadQyList(3," + cAreaCode + ")'>" + data.SUM_SY + "</b>家</p>";
                if (AAA011S.length < 6) {
                    sContent += "<p style='text-align:right;font-size: 14px;border-top: 1px dashed #CCC;margin-top:5px;'><a href='#' onclick='pageInit(" + cAreaCode + ",\"" + path + "\")' style='color:#1e71bf;line-height:30px;'>查看详情<b>...</b></a></p>";
                }
                sContent += "</div>";
                var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象
                map.openInfoWindow(infoWindow, point); //开启信息窗口
            }
        });
    });
    map.addOverlay(marker);
    marker.disableMassClear();
}

function loadQyList(qylx, areacode) {
    var title = "";
    switch (qylx) {
        case 0:
            title = "医疗器械生产";
            break;
        case 2:
            title = "医疗器械经营";
            break;
        case 3:
            title = "医疗器械使用";
            break;
    }
     openWin('../tpage?pindex=ZF_QYList&qylx=' + qylx + '&areacode=' + areacode, title, 1200, 600);
}

function addMarkerJGDX(obj) {
    var title = obj.CNAME;
    var jingdu = obj.LONGITUDE;
    var weidu = obj.LATITUDE;
    var imgurl = '../include/map/img/spyx-s-sp-ls.png';
    switch (obj.CTYPE) {
        case "0":
            imgurl = '../include/map/img/spyx-s-sp-bl.png';
            break;
        case "2":
            imgurl = '../include/map/img/spyx-s-sp-cs.png';
            break;
        case "3":
            imgurl = '../include/map/img/spyx-s-sp-hs.png';
            break;
    }

    var point = new BMap.Point(jingdu, weidu);
    var myIcon = new BMap.Icon(imgurl, new BMap.Size(31, 40));
    var marker = new BMap.Marker(point, {icon: myIcon, title: title});  // 创建标注
    marker.addEventListener("click", function (e) {
        //alert("企业详细信息");
        layer.open({
            type: 1,
            title: '监管对象详细信息',
            area: ['720px', '500px'], //宽高
            content: $('#qyxx'), //捕获的元素
            shadeClose: true,
            shade: 0.5
        });
        $("#td_CNAME").html(obj.CNAME);
        $("#td_USCC").html(obj.USCC);
        $("#td_LINKMAN").html(obj.LINKMAN);
        $("#td_LPHONE").html(obj.LPHONE);
        $("#td_SNAME").html(obj.SNAME);
        $("#td_REGION").html(obj.REGION);
        $("#td_LEGALPERSON").html(obj.LEGALPERSON);
        $("#td_CRP").html(obj.CRP);
        $("#td_LKEY").html(obj.LKEY);
    });
    map.addOverlay(marker);
}

function ajaxAsyncPost(url, data, fnCallback) {
    return $.ajax({
        "type": "POST",
        "url": url,

        "data": JSON.stringify(data),
        "contentType": "application/json; charset=utf-8",
        "dataType": "json",
        "processData": true,
        "success": function (data) { try { if (data.code == -2) { mui.alert(data.msg); top.location.href = "/"; return; } } catch (e) {; } fnCallback(data); },
        "error": function (r) { /*try { if (!!mui) mui.alert(r.statusText + "!" + r.responseText); else alert(r.statusText + "!" + r.responseText); } catch (e) {; } if (r.statusText === "Server Too Busy") { location.href = "/"; }*/ }
    });
}

function ajaxPost(url, data, fnCallback) {
    return $.ajax({
        "type": "POST",
        "url": url,
        "async": false,
        "data": JSON.stringify(data),
        "contentType": "application/json; charset=utf-8",
        "dataType": "json",
        "processData": true,
        "success": function (data) { try { if (data.code == -2) { mui.alert(data.msg); top.location.href = "/"; return; } } catch (e) {; } fnCallback(data); },
        "error": function (r) { /*try { if (!!mui) mui.alert(r.statusText + "!" + r.responseText); else alert(r.statusText + "!" + r.responseText); } catch (e) {; } if (r.statusText === "Server Too Busy") { location.href = "/"; }*/ }
    });
}

function simpleAreaCode(areacode) {
    areacode = areacode+"";
    if (areacode.length > 6) {
        if (areacode.slice(-3) == "000") {
            return simpleAreaCode(areacode.slice(0,areacode.length-3))
        }
    } else {
        if (areacode.slice(-2) == "00") {
            return simpleAreaCode(areacode.slice(0,areacode.length-2))
        }
    }
    return areacode;
}
