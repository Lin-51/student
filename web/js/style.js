$(function(){
    
    /**通用-banner大图自定义缩放**/
    var zoomWidth = 992; //缩放阀值992px, 即所有小于992px的视口都会对原图进行缩放, 只是缩放比例不同
    var maxWidth = 1920; //最大宽度1920px
    var ratio = 1; //缩放比例
    var viewWidth = window.innerWidth; // 视口宽度
    var zoomSlider = function () {
        if (viewWidth < 768) { //当视口小于768时(移动端), 按992比例缩放
            ratio = viewWidth / zoomWidth; //视口宽度除以阀值, 计算缩放比例
        } else if (viewWidth < zoomWidth) { //当视口界于768与992之间时, bootstrap主宽度为750, 这区间图片缩放比例固定.
            ratio = zoomWidth / (zoomWidth + (zoomWidth - 750));
        } else { // PC端不缩放
            ratio = 1;
        }
        //ratio = viewWidth / zoomWidth; //视口宽度除以阀值, 计算缩放比例
        //ratio = (ratio<=1) ? ratio : 1; //如果比例值大于1, 说明视口宽度高于阀值, 则不进行任何缩放
        var width = maxWidth * ratio; //缩放宽度
        $(".my-slide img").each(function () {
            $(this).css({
                "width": width,
                "max-width": width,
                "margin-left": -(width - viewWidth) / 2
            }); //图片自适应居中, 图片宽度与视口宽度差除以2的值, 设置为负margin
        });
    }
    zoomSlider(); //页面加载时初始化并检查一次.
    $(window).resize(function(){
        viewWidth = window.innerWidth; // 重置视口宽度
        zoomSlider();
    });
}())

//通用返回顶部
$(function(){
    //首先将#back-to-top隐藏
    $("#slider-goTop").hide();
    //当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
    $(window).scroll(function(){
        // 滚动条滚动高度大于100 返回顶层按钮渐入页面
        if ($(window).scrollTop()>100){
            $("#slider-goTop").fadeIn();
        }else{
            $("#slider-goTop").fadeOut();
        }
    });
    //当点击跳转链接后，回到页面顶部位置
    $("#slider-goTop").click(function(){
        $('body,html').animate({scrollTop:0},500);
        return false;
    });
    //返回顶部等滑块hover事件  右侧滑块儿各内容显示隐藏方式
    $('#slider-chat,#slider-qq,#slider-phone,#slider-wechat').hover(
        function(){
            $(this).next().show();
        },
        function(){
            $(this).next().hide();
        }
    );
});

$(function(){
   
}())

// 一级菜单内容折叠展开
function foldMenu(){
    $(".sidebar_box>li").click(function(e){
        stopBubble(e);//阻止冒泡
        $(this).children("a").addClass("left-active").parent().siblings().children("a").removeClass("left-active");//为选中的选项添加样式
        $(window).scrollTop(82); //内容高度回到最上面
        $(".second").eq($(this).index()).addClass("active").siblings().removeClass("active");
       if($(this).hasClass("active")){//进行 判断设置一级菜单的折叠
            $(this).removeClass("active");
       }else{
            $(this).addClass("active").siblings().removeClass("active");
            secondMenuCon();//设置菜单锚点 菜单内容
       }
    });
}

// 设置二级菜单选项内容 添加锚点 
function secondMenuCon(){
    var sidebar = $('#sidebar'); //获取菜单元素
    var navHeight = (window.innerWidth < 768) ? 0 : 82;//判断屏幕宽度 移动端赋值为0 大于等于768赋值为82 用作菜单绝对定位的top值
    var floor = new Array();//用来存储 菜单选项对应锚点的top值
    
    // 左侧菜单第二级内容
    var buildAnchor2 = function(){
        var anchorLi = '';
        //将页面的h3作为锚点链接, 添加到导航菜单中
        // 遍历出页面中的h3 
        $('.active .usinfo-article-second .article-content h3').each(function(){
            floor.push($(this).offset().top);// 获取他们各自距顶层的top值 存入数组
            anchorLi += '<li><a>' + $(this).text() + '</a></li>';//获取页面中h3的文本内容 拼接上html元素 存入anchorLi
            // console.log(anchorLi);
        });
        
        $('.sidebar_box>li:not(".first").active .item-wrapper').empty();//清空对应的2级菜单 
        // console.log($('.sidebar_box>li:not(".first").active .item-wrapper'))
        $('.sidebar_box>li:not(".first").active .item-wrapper').append(anchorLi);//把创建的>li 菜单选项加入二级菜单的子菜单中
        $('.sidebar_box>li:not(".first").active .item-wrapper').children(':first').children(':first').addClass('left-active-sub');//设置3级菜单的第一个元素的文本样式
        
        // 移动端时  点击li后 隐藏移动端菜单 模态框
        if (window.innerWidth >= 768) {
               
        } else {
            $(".left-anchor li").click(function () {
                $('#sidebar').hide();
                $('#sidebar-bg').hide();
            });
        }
    }
    //为新加的锚点裢接绑定跳转事件
    var skip2=function(){
        // 3级菜单的个选项添加锚点 设置点击事件 
        $('.item-wrapper li').click(function(e){
            // console.log($(' .usinfo-article-second .article-content h3'))
            stopBubble(e);//阻止冒泡
            $(this).children("a").addClass("left-active-sub").parent().siblings().children("a").removeClass("left-active-sub");//设置3级菜单 点击后选项的样式
            $(window).scrollTop(($('.active .usinfo-article-second .article-content h3').eq($(this).index()).offset().top)-navHeight);//设置对应内容区的top值 
            
        });
    }
    buildAnchor2();// 左侧菜单第二级内容
    skip2();//为新加的锚点裢接绑定跳转事件
}

/** 响应式sidebar 菜单定位 **/
function sidebarMenu() {
    //获取菜单元素
    var sidebar = $('#sidebar');
    //判断屏幕宽度 移动端赋值为0 大于等于768赋值为82 用作菜单绝对定位的top值
    var navHeight = (window.innerWidth < 768) ? 0 : 82; 
    //浮动菜单函数
    var flowMenu = function (validHeight) {
        // console.log($(window).scrollTop())
        // 获取菜单相对于窗口的偏移量 当小于滚动条滚动距离时 设置菜单绝对定位于窗口
        if ($('.main-container-row').offset().top < $(window).scrollTop() + navHeight) {
            // console.log('跑出去了');
            sidebar.css({
                "position": "fixed",
                "width": sidebar.parent().width(),
                "height": validHeight,
                "top": navHeight
            });
        } else {
            sidebar.css({
                "position": "relative",
                "width": sidebar.parent().width(),
                "height": validHeight,
                "top": ""
            });
        }
    }
    // 窗口滚动时  获取row底部到视口顶部的距离
    $(window).scroll(function(){
         //row底部到视口顶部的距离, 元素顶部偏移 + 元素高度 - 滚动条偏移 - 固定导航条高度
         var validHeight = $('.main-container-row').offset().top + $('.main-container-row').outerHeight()-$(window).scrollTop()-navHeight;
        //  console.log(validHeight)
         //PC端时, 控制左边菜单列浮动显示
        if(window.innerWidth>=768){
            flowMenu(validHeight);
        }
    });
}

// 设置三级菜单选项内容 添加锚点 
function sidebarMenu2(){
    var sidebar = $('#sidebar'); //获取菜单元素
    var navHeight = (window.innerWidth < 768) ? 0 : 82;//判断屏幕宽度 移动端赋值为0 大于等于768赋值为82 用作菜单绝对定位的top值
    var floor = new Array();//用来存储 菜单选项对应锚点的top值
    // 遍历菜单第二级 设置菜单第三级内容显隐
    var nav2=function(){
        $(".item-wrapper>li").click(function(e){
            stopBubble(e);
            if($(this).index()>=2){//后面的内容暂未设置
                // alert("待开发");
            }else{
                contentErgodic($(this).index());//设置内容对应显隐
                $(this).addClass("active").siblings().removeClass("active");//打开选中的二级菜单
                buildAnchor();//向菜单中加入选项
                skip();//绑定锚点
            }
        });
    
    }
    // 遍历内容  设置显隐  右侧内容
    var contentErgodic=function(index){
        $(".usinfo-article").eq(index).addClass("active").siblings(".usinfo-article").removeClass("active");
    }
    // 左侧菜单第三级内容
    var buildAnchor = function(){
        var anchorLi = '';
        //将页面的h3作为锚点链接, 添加到导航菜单中
        // 遍历出页面中的h3 
        $('.usinfo-article.active .article-content h3').each(function(){
            floor.push($(this).offset().top);// 获取他们各自距顶层的top值 存入数组
            anchorLi += '<li><a>' + $(this).text() + '</a></li>';//获取页面中h3的文本内容 拼接上html元素 存入anchorLi
        });
        
        $('.item-wrapper .left-anchor').empty();//清空对应的3级菜单 
        $('.item-wrapper .active .left-anchor').append(anchorLi);//把创建的 li 菜单选项加入二级菜单的子菜单中
        $('.item-wrapper .active .left-anchor').children(':first').children(':first').addClass('left-active-sub');//设置3级菜单的第一个元素的文本样式
        // 移动端时  点击li后 隐藏移动端菜单 模态框
        if (window.innerWidth >= 768) {
               
        } else {
            $(".left-anchor li").click(function () {
                $('#sidebar').hide();
                $('#sidebar-bg').hide();
            });
        }
    }
    //为新加的锚点裢接绑定跳转事件
    var skip=function(){
        // 3级菜单的个选项添加锚点 设置点击事件 
        $('.item-wrapper .active .left-anchor li').click(function(e){
            // console.log($(this).children("a"))
            stopBubble(e);
            $(this).children("a").addClass("left-active-sub").parent().siblings().children("a").removeClass("left-active-sub");//设置3级菜单 点击后选项的样式
            $(window).scrollTop(($('.usinfo-article.active .article-content h3').eq($(this).index()).offset().top)-navHeight);//设置对应内容区的top值 
            
        });
    }
    skip();
    nav2();
}
/** 响应式sidebar 左侧菜单 **/
// 阻止冒泡
function stopBubble(e) {
    //如果提供了事件对象，则这是一个非IE浏览器 
    if (e && e.stopPropagation)
        //因此它支持W3C的stopPropagation()方法 
        e.stopPropagation();
    else
        //否则，我们需要使用IE的方式来取消事件冒泡 
        window.event.cancelBubble = true;
}
