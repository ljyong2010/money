<%@ Page Language="C#" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="css/buttons.dataTables.min.css" rel="stylesheet" />
    <script src="../../../jquery-1.7.2.min.js"></script>
    <script src="jquery.dataTables.min.js"></script>
    <script src="dataTables.buttons.min.js"></script>
    <script src="buttons.flash.min.js"></script>
    <script src="buttons.html5.min.js"></script>
    <script src="buttons.print.min.js"></script>
</head>
<body>
    <table id="example" style="width: 100%;">
        <thead>
            <tr>
                <th>asdf</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>jhdsf</td>
            </tr>
        </tbody>
    </table>
    <script>
        $(document).ready(function () {
            $('#example').DataTable({
                dom: 'Bfrtip',
                buttons: [{ text: '导出Excel', extend: 'excel' }, { text: '导出PDF', extend: 'pdf' }, { text: '打印', extend: 'print' }]
            });
        });
    </script>
</body>
</html>
