$(function(){
    // 移动端 菜单显示 隐藏
    wapMenu();
    function wapMenu() {
        var sidebar = $('#sidebar'); //获取菜单外层元素
        var sidebarBg = $('#sidebar-bg'); // sidebarBg 移动端菜单显示时出现的
        // 移动端时  点击显示菜单按钮 签证指南页面
        $('#slider-menu').click(function (event) {
            if (sidebar.is(':hidden')) { //判断菜单元素时候隐藏
                sidebar.show();
                sidebarBg.css({ //将菜单框改为绝对定位 相对于屏幕定位
                    "position": "fixed",
                    "top": 0,
                    "left": 0,
                    "display": "block",
                    "width": "100%",
                    "height": "100%",
                    "z-index": 1090,
                    "background-color": "rgba(0,0,0,0.5)"
                });
            } else {
                sidebar.hide(); //菜单隐藏
                sidebarBg.hide(); //模态层隐藏
            }
        });
        // 如果是手机屏幕, 点周空白处隐藏菜单
        sidebarBg.click(function () {
            sidebar.hide(); //菜单隐藏
            sidebarBg.hide(); //菜单背景隐藏
        });
        // 菜单选项点击 后菜单 模态层隐藏
            if (window.innerWidth >= 768) {
               
            } else {
                $(".left-anchor li").click(function () {
                    sidebar.hide();
                    sidebarBg.hide();
                });
            }


    }
}())