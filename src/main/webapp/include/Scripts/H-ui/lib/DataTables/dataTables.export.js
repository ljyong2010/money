document.write("<link href='../Scripts/H-ui/lib/DataTables/css/buttons.dataTables.min.css' rel='stylesheet' \/>");
document.write("<script src='/Scripts/H-ui/lib/DataTables/dataTables.buttons.min.js'><\/script>");
document.write("<script src='/Scripts/H-ui/lib/DataTables/buttons.flash.min.js'><\/script>");
document.write("<script src='/Scripts/H-ui/lib/DataTables/buttons.html5.min.js'><\/script>");
document.write("<script src='/Scripts/H-ui/lib/DataTables/buttons.print.min.js'><\/script>");
$.fn.dataTable.Buttons.swfPath = '/Scripts/H-ui/lib/DataTables/swf/flashExport.swf';
$.extend($.fn.dataTable.defaults, {
	dom: 'Bfrtip',
	buttons: [{ text: '导出Excel', extend: 'excel', className:'btn' }, { text: '导出PDF', extend: 'pdf', className:'btn' }, { text: '打印', extend: 'print', className:'btn' }]
});