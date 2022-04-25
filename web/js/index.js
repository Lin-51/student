$(function () {
    
    /**通用-我们的成绩等数字滚动特效   调用countUp.js**/
    var numOptions = {
        useEasing: true,//是否使用动画曲线
        useGrouping: true,//数字是否用separator隔开 
        separator: ',',//数字用逗号隔开
        decimal: '.',//小数点符号
        prefix: '',//添加前缀
        suffix: ''//添加后缀
    }
    var numGroup = new Array(
        new CountUp("sum-apply", 0, 18397, 0, 2.5, numOptions),//目标元素 开始值 结束值 小数位数，默认是0 动画延迟描述默认值2
        new CountUp("sum-rate", 0, 98.8, 1, 2.5, numOptions),
        new CountUp("sum-urgent", 0, 3273, 0, 2.5, numOptions),
        new CountUp("urgent-rate", 0, 100, 0, 2.5, numOptions)
    );
    // 执行数字滚动
    var runNumber = function () {
        $('.run-number').each(function () {
            var oTop = $(this).offset().top;//获取每个滚动数字 距顶层高度
            var sTop = $(window).scrollTop();//获取屏幕滚动高度
            var oHeight = $(this).height();//获取 滚动数字 的高度
            var oIndex = $(this).index('.run-number');
            
            // 进行判断 判断目标元素与屏幕滚动高度的比例 执行数字滚动动画 
            if (oTop >= sTop && (oTop + (oHeight / 2)) < (sTop + $(window).height())) {
                numGroup[oIndex].start();//执行数字滚动动画
                // console.log('元素'+$(this).index('.run-number')+'可见');
            } else {
                // console.log('元素'+$(this).index('.run-number')+'不可见');
            }
        });
    }

    runNumber(); //页面加载时判断一次
    /**视口发生变化时的事件**/
    $(window).resize(function () {
        runNumber();//判断是否执行动画
    });
    /**滚动事件**/
    $(window).scroll(function () {
        runNumber();
    });

    //首页-我们的服务
    function addScale(){
        $('.card_module').each(function () {//遍历 4个模块 给每个添加 鼠标移入事件 改变当前目标模块的类名 实现动画效果
            $(this).mouseover(function () {
                $(this).addClass('active scale').siblings().removeClass('active scale');
            });
        });
    }
    addScale();

    
});
