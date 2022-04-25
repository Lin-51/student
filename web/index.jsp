<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="img/stu.ico"/>
		<title>学生信息管理系统-首页</title>
		<script src="js/jquery3.6.js"></script>
		<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
		<!--缩放-->
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/index.css">
		<script src="js/countUp.min.js"></script>
		<script src="js/style.js"></script>
		<script src="js/line.js"></script>
		<script src="js/index.js"></script>
	</head>
	<body>


		<!-- 父容器 会响应式 -->
		<div class="container">
			<!-- 导航栏 -->
			<nav class="navbar navbar-default navbar-fixed-top">
			   <div class="container-fluid">
			      <!-- Brand and toggle get grouped for better mobile display -->
			      <div class="navbar-header">
			        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
			          <span class="sr-only">Toggle navigation</span>
			          <span class="icon-bar"></span>
			          <span class="icon-bar"></span>
			          <span class="icon-bar"></span>
			        </button>
			        <a class="navbar-brand" href="#">学生信息管理系统</a>
			      </div>
			  
			      <!-- Collect the nav links, forms, and other content for toggling -->
			      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			        <ul class="nav navbar-nav">
			          <li class="active"><a href="/index.jsp">首页 <span class="sr-only">(current)</span></a></li>
			          <li ><a id="checkLoginUser" onclick="return checkLogin()"  data-container="body" data-toggle="popover" data-placement="bottom" data-trigger="focus" title="友情提示" data-content="还未登录，请先登录!" href="/UserServlet?m=queryByPage">进入系统</a></li>
			        </ul>

			        <ul class="nav navbar-nav navbar-right">
						<c:if test="${loginUser !=null}">

						<li><img src="/upload/${loginUser.userPicture}" width="50px"  class="img-responsive img-rounded" alt="Responsive image"></li>
							<li><a href="#" id="LoginUserInfo2">${loginUser.userName},欢迎你!</a></li>
						</c:if>

						<c:if test="${loginUser ==null}">
							<li><img src="/img/defaultImg.jpg" width="50px" class="img-responsive img-rounded" alt="Responsive image"></li>
							<li><a href="#" id="LoginUserInfo">当前未登录</a></li>
						</c:if>


			          <li><a href="#" data-toggle="modal" data-target="#ModalLogin" data-whatever="@getbootstrap">登录</a></li>
					  <li><a href="#" data-toggle="modal" data-target="#ModalUpdate" data-whatever="@getbootstrap" href="#">注册</a></li>
					  
			          <li class="dropdown">
			            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">更多 <span class="caret"></span></a>
			            <ul class="dropdown-menu">
			              <li><a href="#" data-toggle="modal" data-target="#ModalLogin" data-whatever="@getbootstrap">切换用户</a></li>
			              <li><a href="#boot">联系我们</a></li>
			              <li role="separator" class="divider"></li>
			              <li><a href="/UserServlet?m=loginOut">退出登录</a></li>
			            </ul>
			          </li>
			        </ul>
			      </div><!-- /.navbar-collapse -->
			    </div><!-- /.container-fluid -->
			</nav>
		 </div>
		 <!-- 登录的弹框 -->
		 
		 <div class="modal fade" id="ModalLogin" tabindex="-1" role="dialog" aria-labelledby="   ">
		   <div class="modal-dialog" role="document">
		     <div class="modal-content">
		       <div class="modal-header">
		         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		         <h4 class="modal-title" id="   ">用户登录</h4>
		       </div>
		       <div class="modal-body">
		         <form id="loginForm" >
		           <div class="form-group">
		             <label  class="control-label">用户名:</label> <label  id="checkLoginUserName" class="control-label"></label>
		             <input type="text" onkeyup="checkLoginUserName(this.value)" class="form-control" id="LoginUserName">
		           </div>
		           <div class="form-group">
		             <label  class="control-label">密码:</label><label  id="checkLoginUserPass" class="control-label"></label>
		             <input type="text"  onkeyup="checkLoginUserPass(this.value)" class="form-control" id="LoginUserPass">
		           </div>
					 <div class="form-group">
						 <label  class="control-label">自动登录:</label><label   class="control-label"></label>
						 <input type="checkbox"  name="autoLogin" id="autoLogin">
					 </div>

		         </form>
		       </div>
		       <div class="modal-footer">
		         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		         <button type="button" id="loginSub" onclick="doLogin()" class="btn btn-primary">登录</button>
		       </div>
		     </div>
		   </div>
		 </div>
		<!-- 注册 -->
		<div class="modal fade" id="ModalUpdate" tabindex="-1" role="dialog" aria-labelledby="   ">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="">用户注册</h4>
					</div>
					<div class="modal-body">
						<form id="registerForm" >

							<div class="form-group">
								<label for="" class="control-label">用户名:</label><label id="checkUserName" class="control-label"></label>
								<input onkeyup="checkUserName(this.value)" name="userName" type="text" class="form-control" id="userName">
							</div>
							<div class="form-group">
								<label  class="control-label">密码:</label>
								<input name="userPass" type="text" class="form-control" id="">
							</div>
							<div class="form-group">
								<label  class="control-label">性别:</label>
								<select class="form-control" name="userGender">
									<option>男</option>
									<option>女</option>
								</select>
							</div>
							<div class="form-group">
								<label  class="control-label">年龄:</label><label id="checkUserAge"  class="control-label"></label>
								<input onkeyup="checkUserAge(this.value)" name="userAge" type="text" class="form-control" id="userAge">
							</div>
							<div class="form-group">
								<label  class="control-label">电话:</label>
								<input name="userPhone" type="text" class="form-control" id="">
							</div>
							<div class="form-group">
								<label  class="control-label">地址:</label>
								<input name="userAddress" type="text" class="form-control" id="">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button id="sub" type="button" onclick="doSubmit()" class="btn btn-primary">注册</button>
					</div>
				</div>
			</div>
		</div>
		 <!--顶部导航结束 -->
		 
		 <!-- 轮播图开始-->
		 <div class="container-fluid"> 
		 <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
		   <!-- Indicators -->
		   <ol class="carousel-indicators">
		     <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		     <li data-target="#carousel-example-generic" data-slide-to="1"></li>
		     <li data-target="#carousel-example-generic" data-slide-to="2"></li>
		   </ol>
		 
		   <!-- Wrapper for slides -->
		   <div class="carousel-inner" role="listbox">
		     <div class="item active">
		       <img src="img/lunbo1.png" alt="...">
		       <div class="carousel-caption">
		         <h3>欢迎光临学生信息管理系统</h3>
		             <p>首页</p>
		       </div>
		     </div>
		     <div class="item">
		       <img src="img/lunbo2.png" alt="...">
		       <div class="carousel-caption">
		       <h3>欢迎光临学生信息管理系统</h3>
		           <p>首页</p>
		       </div>
		     </div>
		     <div class="item">
		       <img src="img/lunbo3.png" alt="...">
		       <div class="carousel-caption">
		        <h3>欢迎光临学生信息管理系统</h3>
		            <p>首页</p>
		       </div>
		     </div>
		   </div>
		 
		   <!-- Controls -->
		   <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
		     <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		     <span class="sr-only">Previous</span>
		   </a>
		   <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
		     <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		     <span class="sr-only">Next</span>
		   </a>
		 </div>
		 </div>
		 <!-- 轮播图结束-->
		 
		 
		 
	<!-- 我们的成绩 start -->
			<div class="result pad10">
				<div class="container">
					<div class="row">
						<div class="col-sm-12 main_title text-center">
							<h2 class="h1">我们的成绩</h2>
							<p class="line"></p>
							<h2><small>2019年1月1日至2021年12月30日，我们的数据。</small></h2>
						</div>
						<div class="col-sm-3 sum-apply">
							<div class="num_wrap">
								<span id="sum-apply" class="run-number" data-to="240">58,397</span>
							</div>
							<h4 class="title">累计访问人数</h4>
						</div>
						<div class="col-sm-3 sum-rate">
							<div class="num_wrap">
								<span id="sum-rate" class="run-number" data-to="240">98.8</span>%
							</div>
							<h4 class="title">网站访问成功率</h4>
						</div>
						<div class="col-sm-3 sum-urgent">
							<div class="num_wrap">
								<span id="sum-urgent" class="run-number" data-to="240">3,273</span>
							</div>
							<h4 class="title">当前在线人数</h4>
						</div>
						<div class="col-sm-3 urgent-rate">
							<div class="num_wrap">
								<span id="urgent-rate" class="run-number" data-to="240">100</span>%
							</div>
							<h4 class="title">处理业务成功率</h4>
						</div>
					</div>
				</div>
			</div>
			<!-- 我们的成绩 end -->
	
			<!--轮播图结束-->
			<!-- 更多疑问 全面解答 start -->
			<div class="answer">
				<canvas id="waves" class="waves" width="5328" height="514" style="width: 2664.2px; height: 257px;"></canvas>
				<div class="container">
					<div class="row">
						<div class="col-sm-12 text-center main_title">
							<h2 class="h1">更多疑问 全面解答</h2>
							<h4>资深Java讲师在线为您解答所有疑惑</h4>
							<a href="#" class="btn">免费咨询</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 更多疑问 全面解答 end -->
	
			<!-- 友链  尾部  start-->
			<div class="footer">
				<div class="container">
					<div class="row">
						<div class="col-xs-6 col-sm-2 footer-item">
							<div class="footer-list">
								<h4>常用工具</h4>
								<a name="boot"></a>
								<ul>
									<li>
										<a href="#" target="_blank">电码查询</a>
									</li>
									<li>
										<a href="#">护照追踪</a>
									</li>
									<li>
										<a href="#">资料下载</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-xs-6 col-sm-2 footer-item">
							<div class="footer-list">
								<h4>快捷裢接</h4>
								<ul>
									<li>
										<a href="#" target="_blank">教务资讯</a>
									</li>
									<li>
										<a href="#">教务指南</a>
									</li>
									<li>
										<a href="#">常见问题</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-xs-6 col-sm-2 footer-item">
							<div class="footer-list">
								<h4>关于我们</h4>
								<ul>
									<li>
										<a href="#" target="_blank">关于我们</a>
									</li>
									<li>
										<a href="#">服务协议</a>
									</li>
									<li>
										<a href="#">收藏本站</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-xs-6 col-sm-2 footer-item">
							<div class="footer-wechat">
								<img class="img-responsive" src="img/wx.png">
								<p>微信
									<sapn class="hidden-sm">号:</sapn>xzpublic</p>
							</div>
						</div>
						<div class="col-xs-12 col-sm-4 footer-item footer-item-last">
							<div class="footer-contact">
								<h2><img src="img/pc-footer-phone.png">029-85123098</h2>
								<h2><img src="img/pc-footer-qq.png">945912173</h2>
								<h2><img src="img/pc-footer-mob.png">15389071915</h2>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 友链  尾部  end-->
	
			<!-- 备案 start -->
			<div class="copyright">
				<div class="container">
					<div class="row">
						<div class="col-sm-12">
							<p>Copyright © 2006-2019 clantrip.com All Rights Reversed. 学生管理系统
								<a target="_blank" href="#">京ICP备16015317号</a>
							</p>
							<div>
								<a target="_blank" href="#">
									<img src="img/ghs.png" style="float:left;">
									<p>京公网安备 11010102002687号</p>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 备案 end -->
	
			<!-- 右侧滑块儿 start -->
			<div id="clan-slider">
				<ul>
					<li class="hidden-xs">
						<a id="slider-chat" class="web-chat" href="javascript:;"></a>
						<div class="clan-slider-tips" style="display: none;">
							在线咨询
						</div>
					</li>
					<li class="hidden-xs">
						<a target="_blank" href="#" id="slider-qq"></a>
						<div class="clan-slider-tips">
							QQ咨询
						</div>
					</li>
					<li class="hidden-xs">
						<a id="slider-phone" href="javascript:void(0);"></a>
						<div class="clan-slider-tips">
							029-85123098
						</div>
					</li>
					<li class="hidden-xs">
						<a id="slider-wechat" href="javascript:void(0);"></a>
						<div class="clan-slider-tips-wechat">
							<img src="img/wx.png">
						</div>
					</li>
					<li class="slider-goTop">
						<a id="slider-goTop" href="javascript:void(0);">
						</a>
					</li>
				</ul>
			</div>
			<!-- 右侧滑块儿 end -->
	
			<!-- 手机端底部 start -->
			<div id="mob-bottom" class="visible-xs-block">
				<div class="container">
					<div class="row">
						<div class="col-xs-3 mob-bottom-item">
							<a href="tel:15389071915">
								<img class="img-responsive center-block" src="img/mob-footer-phone.png">
								<span>电话咨询</span>
							</a>
						</div>
						<div class="col-xs-3 mob-bottom-item">
							<a href="tel:15389071915">
								<img class="img-responsive center-block" src="img/mob-footer-mob.png">
								<span>紧急电话</span>
							</a>
						</div>
						<div class="col-xs-3 mob-bottom-item">
							<a href="#">
								<img class="img-responsive center-block web-chat" src="img/mob-footer-chat.png">
								<span>在线咨询</span>
							</a>
						</div>
						<div class="col-xs-3 mob-bottom-item">
							<a href="sms:15389071915">
								<img class="img-responsive center-block" src="img/mob-footer-msm.png">
								<span>短信咨询</span>
							</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 手机端底部 end -->
	
		</body>
	
	</html>
	<script>


		$(function(){
			$("#loginSub").attr("disabled","disabled");
			$("#sub").attr("disabled","disabled");
			//注意注意再注意  一旦在js中使用el表达式，这个js只能嵌入在当前这个页面中，不能提取出去
			let userName="${loginUser.userName}";
			console.log(userName)
			if(userName==''||userName==null){
				$("#LoginUserInfo").html("当前未登录");
			}else{
				$("#LoginUserInfo").html(userName+",欢迎你！");
			}
		})


		$('.carousel').carousel({
			interval: 3000
		})


        function checkLogin(){

		    let loginUser ="${loginUser}";

		    if(loginUser==""|| loginUser==null){

                $('#checkLoginUser').popover("show");

                return false;
            }else{
                return true;
            }

        }
	</script>
<script src="/js/student.js"></script>