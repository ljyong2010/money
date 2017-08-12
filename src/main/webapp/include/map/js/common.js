var openWindows = undefined;
$(function () {
    if (!openWindows) openWindows = new JqueryUIDialog();
    //var aaa = new myCommon();
    //aaa.openWindows
});

function myCommon() {
    this.Dialog.Option = function () {

    },
    this.Dialog.Open = function (divId,title,width,height,modal,resizable) {

    }
}


function JqueryUIDialog() {
    this.modal = true,  
    this.title = '',
    this.minWidth = 300,
    this.minHeight = 200,
    this.maxHeight = 600,
    this.open = function (divId, divTitle) {
        if(!!divTitle) this.title = divTitle;
        var zWidth = $(window).width() * 0.85;
        var zHeight = $(window).height() * 0.85; //this.maxHeight;
        if ($("#" + divId).attr("z-width")) {
            zWidth = $("#" + divId).attr("z-width");
        }
        if ($("#" + divId).attr("z-height")) {
            zHeight = $("#" + divId).attr("z-height");
        }
        if (!this.title) {
            this.title = $("#" + divId).attr("title");
        } 
        var option = {
            bgiframe: true,
            title: this.title,
            resizable: true,
            width: zWidth,
            height: zHeight,
            modal: this.modal,
            overlay: {
                backgroundColor: '#000',
                opacity: 0.8
            }, 
            open: function () {
                if (document.forms[0]) {
                    $("body > div[role=dialog]").appendTo(document.forms[0]);
                }
            }
        };
        $("#" + divId).dialog(option);
    },
    this.close = function (divId) {
        $("#" + divId).dialog().dialog('close');
    }
}

function addYear(dtstr, n) {   // n个月后 
    var datetime = parseISO8601(dtstr);
    var year = datetime.getUTCFullYear() + n;
    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
    return year + "-" + month + "-" + date;
}

function parseISO8601(dateStringInRange) {
    var isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/,
        date = new Date(NaN), month,
        parts = isoExp.exec(dateStringInRange);

    if (parts) {
        month = +parts[2];
        date.setFullYear(parts[1], month - 1, parts[3]);
        if (month != date.getMonth() + 1) {
            date.setTime(NaN);
        }
    }
    return date;
}

function new_guid() {
    var guid = "";
    for (var i = 1; i <= 32; i++) {
        var n = Math.floor(Math.random() * 16.0).toString(16);
        guid += n;
    }
    return guid;
}

function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);

    if (r != null) {
        if (name == "qy_name") {
            return r[2];
        }
        else {
            return decodeURI(r[2]);
        }
    }
    return "";

}

function myEval(value) {
    var v = value;
    if (v) {
        v = eval(value.replace(/[\r\n]/g, "\\r\\n"));
        if (v) {
            return v;
        }
    } else {
        return v;
    }
}

function CurrDate(fromat) {
    return new Date().Format(fromat);
}

function formatDate(val) {
    var re = /-?\d+/;
    var m = re.exec(val);
    var d = new Date(parseInt(m[0]));
    return d.Format("yyyy-MM-dd");
}

function formatTime(val) {
    var re = /-?\d+/;
    var m = re.exec(val);
    var d = new Date(parseInt(m[0]));
    return d.Format("yyyy-MM-dd hh:mm:ss");
}

// 对Date的扩展，将 Date 转化为指定格式的String   
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
// 例子：   
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function (fmt) { //author: meizz   
    var o = {
        "M+": this.getMonth() + 1,                 //月份   
        "d+": this.getDate(),                    //日   
        "h+": this.getHours(),                   //小时   
        "m+": this.getMinutes(),                 //分   
        "s+": this.getSeconds(),                 //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds()             //毫秒   
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function MyDate(d) {
    return new Date(Date.parse(d.replace(/-/g, "/"))).Format("yyyy-MM-dd");
}

function MyCommonDate(sDateTime, lenth) {
    if (!sDateTime) return "";
    var len = sDateTime.length;
    if (lenth) {
        len = lenth;
    }
    if (len > 0) {
        switch (len) {
            case 4:
                return sDateTime.substr(0, 4);
            case 6:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2);
            case 8:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2);
            case 10:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2);
            case 12:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2, 2);
            case 14:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2 + 2, 2);
            case 17:
                return sDateTime.substr(0, 4) + "-" +
                    sDateTime.substr(4, 2) + "-" +
                    sDateTime.substr(4 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2, 2) + ":" +
                    sDateTime.substr(4 + 2 + 2 + 2 + 2, 2) + " " +
                    sDateTime.substr(4 + 2 + 2 + 2 + 2 + 2, 3);
        }
    }
    return sDateTime;
}

/* 强密码验证 */
function checkPass(pass) {
    if (pass.length < 8 || pass.length > 32) {
        alert("密码长度为8-32位");
        return false;
    }
    var ls = 0;
    if (pass.match(/([a-z])+/)) { ls++; }
    if (pass.match(/([0-9])+/)) { ls++; }
    if (pass.match(/([A-Z])+/)) { ls++; }
    if (pass.match(/[^a-zA-Z0-9]+/)) { ls++; }
    if (ls >= 3)
    {
        return true;
    }
    else {
        alert("密码长度为8-32位，登录密码须同时包含字母、数字及特殊字符!");
        return false;
    }
}

/*
tbid：要合并的table ID
row：要从哪一行开始合并 一般会去掉标题行
col：要合并的是那一列
*/
function autoRowSpan(tbid, row, col) {
    var tb = document.getElementById(tbid);
    var lastValue = "";
    var value = "";
    var pos = 1;
    for (var i = row; i < tb.rows.length; i++) {
        value = tb.rows[i].cells[col].innerText;
        if (lastValue == value) {
            tb.rows[i].deleteCell(col);
            tb.rows[i - pos].cells[col].rowSpan = tb.rows[i - pos].cells[col].rowSpan + 1;
            pos++;
        } else {
            lastValue = value;
            pos = 1;
        }
    }
}

//全选
function CheckAllCheckBox(obj) {
    $("input[groupName='" + $(obj).attr("groupName") + "'][type='checkbox']").attr("checked", obj.checked);
}
//获取选中的复选框的值
function GetCheckBoxVal(grpn) {
    var pkids = "";
    var isFlag = false;
    var isStr = false;
    $("input[groupName='" + grpn + "']").each(function (index) {
        if (index > 0) {
            if (this.checked) {
                if (isNaN($(this).val())) isStr = true;
                if (pkids != null && pkids != "") pkids += ",";
                pkids += "'" + $(this).val() + "'";
            }
        }
    })
    if (!isStr) pkids.replace(/'/g, "");
    return pkids;
}

//自定义字典表
var myDictionary = function () {
    this.elements = new Array();

    this.size = function () {
        return this.elements.length;
    }

    this.isEmpty = function () {
        return (this.elements.length < 1);
    }

    this.clear = function () {
        this.elements.length = 0;
    }

    this.put = function (_key, _value) {
        this.elements.push({
            key: _key,
            value: _value
        });
    }

    this.remove = function (_key) {
        try {
            for (var i = 0; i < this.size() ; i++) {

                if (this.elements[i].key == _key)
                    this.elements.splice(i, 1);
                return true;
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    this.get = function (_key) {

        try {
            for (var i = 0; i < this.size() ; i++) {
                if (this.elements[i].key == _key) {
                    var _value = this.elements[i].value;
                    return _value;
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    this.containsKey = function (_key) {
        try {
            for (var i = 0; i < this.size() ; i++) {
                if (this.elements[i].key == _key) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }


    this.getValues = function () {
        var values = new Array();
        try {
            for (var i = 0; i < this.size() ; i++) {
                values.push(this.elements[i].key);
            }
        } catch (e) {
            alert("Can not get Map Values ! {1}" + e.message);
            return null;
        }
        return values;
    }

    this.getKeys = function () {
        var keys = new Array();
        try {
            for (var i = 0; i < this.size() ; i++) {
                keys.push(this.elements[i].values);
            }
        } catch (e) {
            alert("Can not get Map Keys ! {1}" + e.message);
            return null;
        }
        return keys;
    }

    this.mapStr = function () {
        return this.elements.toString();

    }
}

function common() {

}
common.exportShow = function () {

    if ($("#exportLoad")) {
        $(document.body).append("<div class='z1' id='exportLoad' style='display:none' >" +
            "<div class='box-dt lay'>" +
            "<div style=' margin-top:60px; margin-bottom:20px;  '>文件导出中，请等待......</div>" +
            "<img src='/jquery_plugins/img/loading.gif' />" +
            "</div><div class='s-box'></div></div>");
    }
    $("#exportLoad").show();
}

common.exportHide = function () {
    $("#exportLoad").hide();
}

Math.formatFloat = function (f, digit) {
    var m = Math.pow(10, digit);
    return parseInt(f * m, 10) / m;
}


//调用ajax的公共方法
function myAjaxCommon(url, data, callFun, async) {
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        dataType: "json",
        url: url,
        data: JSON.stringify(data),
        async: (async != false),
        error: function (XMLHttpRequest) {
            try {
                alert(eval("(" + XMLHttpRequest.responseText + ")").Message);
            }
            catch (e) {
                //alert(e.description);
            }
        },
        success: callFun
    });
}

//调用ajax的公共方法
function myAjaxCommon2(url, data, callFun, async) {
    $.ajax({
        type: 'POST',
        contentType: "application/json",
        dataType: "json",
        url: url,
        data: JSON.stringify(data),
        async: (async != false),
        error: function (XMLHttpRequest) {
            try {
                alert(eval("(" + XMLHttpRequest.responseText + ")").Message);
            }
            catch (e) {
                //alert(e.description);
            }
        },
        success: function (data, status) {
            callFun(data.d, status);
        }
    });
}