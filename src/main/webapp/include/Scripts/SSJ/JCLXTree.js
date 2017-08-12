; (function ($, window, document, undefined) {
    $.fn.JCLXTree = function (code, selectedP, setting) {
        var $this = this;
        var $this_id = $this.attr("id");
        if ($('#' + $this_id + '_ztree').length > 0) return;
        var $parent = this.parent().on("click", showTree);
        var $height = $this.outerHeight();
        var $width = $this.outerWidth();
        var $isReadonly = !!$this.attr("readonly") || !!$this.attr("disabled");
        var $IsTargetReady = false;
        var $IsShowLabel = $this.hasClass("label");
        var $label = $('<label id="' + $this_id + '_label"><span>&nbsp;</span></label>');
        var $txt = $('<input type="text" id="' + $this_id + '_txt" class="input-text" readonly="true" style="width: ' + $width + 'px;" placeholder="' + (!!$this.attr("placeholder")?$this.attr("placeholder"):"" ) + '" />');
        if ($IsShowLabel) {
            $label.insertBefore($this);
            if ($this.hasClass("input-text")) { $label.css({ "background-color": "#efeef0" }); $parent.attr("title", "点击选择区域"); }
        }
        else {
            $txt.insertBefore($this);
        }
        var $div = $('<div id="' + $this_id + '_div" class="box-shadow bg-1" style="overflow:auto;position:absolute;z-index:2147483647;width: ' + $width + 'px;min-width:200px;height:280px;border:1px solid #ccc;"></div>').on("click", hideTree);
        var $tree = $('<ul id="' + $this_id + '_ztree" class="ztree"></ul>').appendTo($div.appendTo("body").hide());
        var $tree_id = $this_id + "_ztree";
        var defaults = {
            async: {
                enable: true,
                url: "/ssjcc/SSJCCService.svc/DicJCLXTree",
                autoParam: ["id"],
                otherParam: JSON.stringify(["rootid", (!!code ? code : "")]),
                contentType: "application/json; charset=utf-8",
                type: "POST",
                dataType: "json"
            },
            callback: {
                beforeCheck: function (treeId, treeNode) {
                    return !!selectedP?!!selectedP:!treeNode.isParent;
                },
                beforeClick: function (treeId, treeNode) {
                    return !!selectedP ? !!selectedP : !treeNode.isParent;
                },
                onAsyncSuccess: function (e, id, n, m) {
                    if (!!m) {
                        var tree = getTree(id);
                        var hv = $this.val();
                        $.each(m, function (i, v) {
                            if (hv.indexOf(v.sid) == 0) {
                                var node = tree.getNodeByParam("id", v.id, null);
                                if (!$IsTargetReady)
                                    tree.reAsyncChildNodes(node, "refresh");
                                if (hv == v.id.toString()) {
                                    writeName($IsShowLabel ? getParentName(node, setName(v.name, true)) : v.name);
                                    tree.selectNode(node);
                                    $IsTargetReady = $isReadonly;
                                }
                                return true;
                            }
                        });
                    }
                },
                onClick: function (e, id, n) {
                    if (n.id == "0") {
                        n.name = "";
                        n.id = "";
                    }
                    writeName($IsShowLabel ? getParentName(n, setName(n.name, true)) : n.name);
                    $this.val(n.id);
                    $div.slideUp('fast');
                }
            },
            view: {
                selectedMulti: false
            }
        };

        function setName(name, b) {
            return !$IsShowLabel ? name : '<span' + (!!b ? ' class="label label-success"' : '') + '>' + name + '</span>';
        }
        function getParentName(node, name) {
            var p = node.getParentNode();
            if (!!p)
                return getParentName(p, setName(p.name) + ',' + name);
            return name;
        }

        function writeName(name) {
            if ($IsShowLabel) $label.html(name); else $txt.val(name);
        }
        function showTree(e) {
            if ($div.is(":visible") || $isReadonly) return;
            $div.css({ "left": $parent.offset().left, "top": $parent.offset().top + $height - 4 }).slideDown('slow');
            $(document).one("click", function () { $div.slideUp('fast'); });
            e.stopPropagation();
        }
        function hideTree(e) {
            e.stopPropagation();
        }
        (function init() {
            $this.addClass("hidden");
            $.fn.zTree.init($tree, $.extend({}, defaults, setting));
        })();
    }
})(jQuery, window, document);

