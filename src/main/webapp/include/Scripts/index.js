$(function () {
    $('nav[data-ride=menu]').on('click', 'ul.tagx li a[href!="#"]', function (e) {
        var id = $(this).parent().attr('id');
        if (id) {
            if ($('#main').find('#tab' + id).length == 0) {
                $('#main .active').removeClass('active');
                $('<li><a id="tab' + id + '" data-tab href="#tabpane' + id + '">' + $(this).parent().text() + ' <i class="icon icon-times"></i></a></li>').addClass('active').appendTo($('#main ul.nav-tabs'));
                $('<div id="tabpane' + id + '" class="tab-pane"><iframe src="' + basePath + $(this).attr('href') + '"></iframe></div>').addClass('active').appendTo($('#main div.tab-content'));
            } else {
                if (!$('#tab' + id).hasClass('active')) {
                    $('#main .active').removeClass('active');
                    $('#tab' + id).trigger('click');
                }
            }
        } else alert('菜单设置有误！');
        e.stopPropagation();
        return false;
    });
    $('#main ul.nav-tabs').on('click', 'i.icon', function (e) {
        var p = $(this).parents('li:eq(0)');
        if (p.hasClass('active'))
            p.siblings().eq(0).find('a:eq(0)').trigger('click');
        $('#main #' + p.find('a:eq(0)').attr('id').replace('tab', 'tabpane')).remove();
        p.remove();
    });
    $('#main ul.nav-tabs').on('mouseenter mouseleave', 'li i.icon', function (e) {
        if (e.type == 'mouseenter') {
            $(this).addClass('icon-remove-sign').removeClass('icon-times');
        } else {
            $(this).addClass('icon-times').removeClass('icon-remove-sign');
        }
    });
    $('#treeMenu').on('click', 'a', function() {
        $('#treeMenu li.active').removeClass('active');
        $(this).closest('li').addClass('active');
    });
    //getTheme();
    $('#sys-theme').on('click', 'a', function () {
        setTheme($(this).attr('data-theme'));
    });
    $(".btn_l").click(function () {

        if ($(this).hasClass("btn_k")) {
            $(this).removeClass("btn_k");
            $(".leftcontent").animate({left: 0}, 300);
            $(".maincontent").animate({left: 220}, 300);
            $(this).animate({left: 220}, 300);
        }
        else {
            $(".btn_l").addClass("btn_k");
            $(".leftcontent").animate({left: -220}, 300);
            $(".maincontent").animate({left: 0}, 300);
            $(this).animate({left: 0}, 300);
        }

    });
});
function getTheme() {
    var myTheme = $.zui.store.get('$mySkin');
    if (!myTheme) {
        myTheme = 'indigo';
        $.zui.store.set('$mySkin', myTheme);
    }
    $('#sys-theme li.active').removeClass('active');
    $('#sys-theme').find('a[data-theme=' + myTheme + ']').parent().addClass('active');
    $('link#mytheme').attr('href', 'Scripts/zui/css/skin/zui-theme-' + myTheme + '.css');

}
function setTheme(theme) {
    $.zui.store.set('$mySkin', theme);
    getTheme();
}