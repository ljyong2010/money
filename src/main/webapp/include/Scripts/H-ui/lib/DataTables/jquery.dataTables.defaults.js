$.extend($.fn.dataTable.defaults, {
    "fnServerData": function (sSource, aoData, fnCallback) {
        var d = $((!!$(this).attr("for")) ? "#" + $(this).attr("for") : "#webform").serializeArray();
        // d.push({ "sEcho": aoData[0].value, "iColumns": aoData[1].value, "iDisplayStart": aoData[3].value, "iDisplayLength": aoData[4].value });
       /* var  param ={'iparam':d};*/
       d.push({"name":"sEcho","value":aoData[0].value});
        d.push({"name":"iColumns","value":aoData[1].value});
        d.push({"name":"iDisplayStart","value":aoData[3].value});
        d.push({"name":"iDisplayLength","value":aoData[4].value});
        d.push({"name":"numbers","value":parseInt(aoData[3].value)/aoData[4].value+1});
        ajaxPost(sSource, d, function (data) { fnCallback(data); });
    },
    "serverSide": true,
    "searching": false,
    "ordering": false,
    "processing": true,
    "bLengthChange": false,
    "sPaginationType": "full_numbers",
    "language": { "url": "../include/Scripts/H-ui/lib/DataTables/zh_CN.txt" }
});