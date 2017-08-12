/// <reference path="../../Scripts/H-ui/lib/zTree/v3/js/jquery.ztree.all-3.5.js" />
/// <reference path="jquery1.9.1.js" />
/// <reference path="/Scripts/H-ui/lib/zTree/v3/js/jquery.ztree.all-3.5.min.js" />

function bindTreeNT(treeid, setting) {
    formPost(!!setting.getDataUrl ? setting.getDataUrl : $("#webform").attr("action"), function (d) {
        $.fn.zTree.init($("#" + treeid), {          
            view: {
                selectedMulti: setting.selectedMulti,
                showLine: false,
                showIcon:false
            },
            data: {
                key: {
                    name: setting.title,
                    title: setting.title
                }, simpleData: {
                    enable: true,
                    idKey: setting.idKey,
                    pIdKey: setting.pIdKey
                }
            },
            check: {
                enable: true,
                enable: setting.showCheck,
                chkStyle: "checkbox",
                chkboxType: { "Y": "ps", "N": "ps" }
            },
            callback:{
                onClick: function (event, treeId, treeNode, clickFlag) {
                    var zT = getTree(treeId);
                    if(treeNode.checked)
                        zT.checkNode(treeNode, false, true);
                    else
                        zT.checkNode(treeNode, true, true);
                }
            }
        }, d.data);
        //alert("dddddddd");
        var t = getTree(treeid);
        var nodes = t.getNodes();
        t.expandNode(nodes[0], true, false, true);

        // t.expandNode(nodes[0], true, false, true);
        if (!!setting.setCheckUrl) {
            formPost(setting.setCheckUrl, function (data) {
                var zT = getTree(treeid);
                try {
                    $.each(data, function (i, v) {
                        var node = zT.getNodeByTId(v.toString());
                        zT.checkNode(node, true, true);
                    });
                }
                catch (e) {
                    $.each(zT.transformToArray(zT.getNodes()), function (i, node) {
                        if (data.indexOf(node[setting.idKey]) > -1) zT.checkNode(node, true, true);
                    });
                }
            });
        }

    });
}

function saveTreeNT(treeid, setting, fnCallBack) {    
    var data = getTreeData(getTree(treeid).getChangeCheckedNodes(),setting.idKey);
    $("#" + setting.inputId).val(data.join(','));
    formPost(setting.saveUrl, function (data) { fnCallBack(data); });
}
function getTreeData(checkedNodes,idk) {
    var data = [];
    $.each(checkedNodes, function (i, v) {

        if (!v.isParent) {
            data.push(v[idk]);
        }

    });
    return data;
}



