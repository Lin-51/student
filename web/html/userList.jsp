<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="../img/stu.ico"/>
		<title>学生信息管理系统-首页</title>
		<script src="../js/jquery3.6.js"></script>
		<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
		<!--缩放-->
		<link rel="stylesheet" href="../css/style.css">
		<link rel="stylesheet" href="../css/index.css">
		<script src="../js/countUp.min.js"></script>
		<script src="../js/style.js"></script>
		<script src="../js/line.js"></script>
		<script src="../js/index.js"></script>
		<style>

		</style>
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
			          <li ><a href="../index.jsp">首页 <span class="sr-only">(current)</span></a></li>
			          <li class="active"><a href="userList.jsp">进入系统</a></li>
			        </ul>
			        
			        <ul class="nav navbar-nav navbar-right">
						<li><img data-toggle="modal" data-target="#ModalUpdatePic" data-whatever="@getbootstrap" src="/upload/${loginUser.userPicture}" width="50px"  class="img-responsive img-rounded" alt="Responsive image"> <img  ></a></li>
					  <li><a href="#" id="LoginUserInfo">${loginUser.userName},欢迎你！</a></li>
					  <li><a href="#" id="currentTime">2021年11月10日 14:16:20</a></li>

			          <li class="dropdown">
			            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">更多 <span class="caret"></span></a>
			            <ul class="dropdown-menu">
			              <li><a href="#" data-toggle="modal" data-target="#ModalUpdatePassword" data-whatever="@getbootstrap">修改密码</a></li>
			              <li><a href="#" data-toggle="modal" data-target="#ModalLogin" data-whatever="@getbootstrap">切换用户</a></li>
			              <li role="separator" class="divider"></li>
			              <li><a href="/UserServlet?m=loginOut">退出登录</a></li>
			            </ul>
			          </li>
			        </ul>
					<form class="navbar-form navbar-right" action="/UserServlet?m=queryByPage" method="post">
					       <div class="form-group">
					         <input type="text" value="${pager.searchUserName}" name="userName" class="form-control" placeholder="admin">
					       </div>
								<select id="searchUserGender" class="form-control" name="userGender" >

								   <option value="">请选择</option>
									<c:if test="${pager.searchUserGender=='男'}">
								  		<option selected value="男">男</option>
									</c:if>
									<c:if test="${pager.searchUserGender!='男'}">
										<option  value="男">男</option>
									</c:if>
									<c:if test="${pager.searchUserGender=='女'}">
										<option selected value="女">女</option>
									</c:if>
									<c:if test="${pager.searchUserGender!='女'}">
										<option  value="女">女</option>
									</c:if>

								</select>
					       <button type="submit" class="btn btn-default">搜索</button>
					     </form>
			      </div><!-- /.navbar-collapse -->
			    </div><!-- /.container-fluid -->
			</nav>
		 </div>
		 
		 <!-- 修改密码的弹框 -->
		 
		 <div class="modal fade" id="ModalUpdatePassword" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		   <div class="modal-dialog" role="document">
		     <div class="modal-content">
		       <div class="modal-header">
		         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		         <h4 class="modal-title" id="Label">修改密码</h4>
		       </div>
		       <div class="modal-body">
		         <form>
		           <div class="form-group">
		             <label  class="control-label">原密码:</label><label id="oldUserPassSpan" class="control-label"></label>
		             <input type="text" class="form-control" id="oldUserPass" >
		           </div>
		           <div class="form-group">
		             <label  class="control-label">新密码:</label><label id="newUserPassSpan" class="control-label"></label>
		             <input type="password" class="form-control" id="newUserPass">
		           </div>
				   <div class="form-group">
				     <label  class="control-label">确认密码:</label><label id="confirmUserPassSpan" class="control-label"></label>
				     <input type="password" class="form-control" id="confirmUserPass">
				   </div>
		         </form>
		       </div>
		       <div class="modal-footer">
		         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		         <button type="button" id="updateUserPassSub" onclick="updateUserPass()" class="btn btn-primary">修改</button>
		       </div>
		     </div>
		   </div>
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
		 <!-- 修改头像 -->
		 <div class="modal fade" id="ModalUpdatePic" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		   <div class="modal-dialog" role="document">
		     <div class="modal-content">
		       <div class="modal-header">
		         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		         <h4 class="modal-title"  >修改头像</h4>
		       </div>
		       <div class="modal-body">
		         <form action="/UserServlet?m=updateUserPicture" method="post" enctype="multipart/form-data">
		          
		           <div class="form-group">
					   <input  type="hidden" value="${loginUser.userId}" name="userId">
		             <label  class="control-label">选择头像:</label>
		             <input type="file" class="form-control" name="picture">
		           </div>

		       </div>
		       <div class="modal-footer">
		         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		         <button type="submit" class="btn btn-primary">修改</button>
		       </div>
				 </form>
		     </div>
		   </div>
		 </div>
		 <!--顶部导航结束 -->
		
		<div class="container-fluid">
			<div class="row">
				
			</div>
			
				<ol class="breadcrumb">
				  <li><a href="#">学生信息管理系统</a></li>
				  <li><a href="#">首页</a></li>
				  <li><a href="#">系统</a></li>
				   <li class="" style="float: right; margin-right: 60px;"><a onclick="openSave()" data-whatever="@getbootstrap" href="#">新增 <span class="sr-only">(current)</span></a></li>
				</ol>
				
			<div class="table-responsive">
			
			
			<table class="table table-hover text-center  ">
				
				<tr>
					<td>编号</td>
					<td>头像</td>
					<td>用户</td>
					<td>性别</td>
					<td>年龄</td>
					<td>电话</td>
					<td>地址</td>
					<td>操作</td>
				</tr>
				<c:forEach var="user" items="${pager.users}" varStatus="s">
				<tr>
					<td>${s.index+1}</td>
					<td><img width="40px"  src="/upload/${user.userPicture}"></td>
					<td>${user.userName}</td>
					<td>${user.userGender}</td>
					<td>${user.userAge}</td>
					<td>${user.userPhone}</td>
					<td>${user.userAddress}</td>
					<td>
					<%-- 登录的用户是管理员--%>
					<c:if test="${loginUser.userType==1}">
						<a href="#" onclick="updateUser('${user.userId}')"  data-whatever="@getbootstrap">修改 </a>
						<a href="/UserServlet?m=deleteUserByUserId&userId=${user.userId}" onclick="javascript: return confirm('确定要删除吗？')"  >删除 </a>
					</c:if>
							<%--登录的是管理  可以删除和修改
                            不是管理员但是登录的是自己  只能删除和修改自己
                         当前登录的用户是自己  --%>
					<c:if test="${loginUser.userType==0 && loginUser.userId==user.userId}">
							<a href="#" onclick="updateUser('${user.userId}')" data-whatever="@getbootstrap">修改 </a>
					</c:if>

						<c:if test="${loginUser.userType==0 && loginUser.userId!=user.userId}">
							<a href="#">无权限 <span class="sr-only">(current)</span></a>
						</c:if>

					</td>
				</tr>
				</c:forEach>
			</table>
			</div>
		</div>
		<!-- 新增或者修改 -->
		<div class="modal fade" id="ModalUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title"  >更新数据</h4>
		      </div>
				<form action="/UserServlet?m=saveOrUpdate" method="post">
		      <div class="modal-body">
				  <input  name="userId" type="hidden" class="form-control">

					<div class="form-group">
						<label for="" class="control-label">用户名:</label><label id="checkUserName" class="control-label"></label>
						<input onkeyup="checkUserName(this.value)" name="userName" type="text" class="form-control" id="userName">
					</div>
					<div class="form-group" id="UpdateUserPass">
						<label  class="control-label">密码:</label>
						<input name="userPass" type="text" class="form-control" id="">
					</div>
					<div class="form-group">
						<label  class="control-label">性别:</label>
						<select id="UpuserGender" class="form-control" name="userGender">
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


		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		        <button type="submit" class="btn btn-primary">更新</button>
		      </div>
				</form>
		    </div>
		  </div>
		</div>
		
		<div class="container-fluid"> 

		<div class="row">
			<div class="col-md-1 col-xs-12" >
				共有${pager.total}条
			</div>

			<div class="col-md-1 col-xs-12">

				<c:if test="${pager.pageCount==null}">
					<select id="pageCount"  onchange="che(this.value)" class="form-control ">
						<option>5</option>
						<option>10</option>
						<option>20</option>
						<option>50</option>
					</select>
				</c:if>

				<c:if test="${pager.pageCount!=null}">
					<select  onchange="che(this.value)"   class="form-control ">
						<option hidden>${pager.pageCount}</option>
						<option>5</option>
						<option>10</option>
						<option>20</option>
						<option>50</option>
					</select>
				</c:if>


			</div>

			<div class="col-md-7 col-xs-12 col-md-offset-3" >
			<nav aria-label="Page navigation " >
			  <ul class="pagination  pagination-lg"  >
				<c:if test="${pager.currentPage==1}">
			    <li class="disabled">
			      <a href="/UserServlet?m=queryByPage&currentPage=${pager.currentPage-1}&pageCount=${pager.pageCount}&userName=${pager.searchUserName}&userGender=${pager.searchUserGender}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
				</c:if>
				  <c:if test="${pager.currentPage!=1}">
					  <li >
						  <a href="/UserServlet?m=queryByPage&currentPage=${pager.currentPage-1}&pageCount=${pager.pageCount}&userName=${pager.searchUserName}&userGender=${pager.searchUserGender}" aria-label="Previous">
							  <span aria-hidden="true">&laquo;</span>
						  </a>
					  </li>
				  </c:if>
				 <%-- /**

				  		第1页    从1 开始  1-1 *5 +1
				  		第二页   从5+1     2-1 *5 +1
				  		第三页   10+1      3-1 *5 +1
				  		第四页   15+1


				  */--%>

				 <c:forEach begin="1" end="${pager.pageSize}" var="curr">

				  <c:if test="${pager.currentPage==curr}">
					  <li class="active"><a href="/UserServlet?m=queryByPage&currentPage=${curr}&pageCount=${pager.pageCount}&userName=${pager.searchUserName}&userGender=${pager.searchUserGender}">${curr}</a></li>
				  </c:if>
				  <c:if test="${pager.currentPage!=curr}">
					  <li ><a href="/UserServlet?m=queryByPage&currentPage=${curr}&pageCount=${pager.pageCount}&userName=${pager.searchUserName}&userGender=${pager.searchUserGender}">${curr}</a></li>
				  </c:if>
					</c:forEach>

				  <c:if test="${pager.currentPage!=pager.pageSize}">
					  <li>
						  <a href="/UserServlet?m=queryByPage&currentPage=${pager.currentPage+1}&pageCount=${pager.pageCount}&userName=${pager.searchUserName}&userGender=${pager.searchUserGender}" aria-label="Next">
							  <span aria-hidden="true">&raquo;</span>
						  </a>
					  </li>
				  </c:if>
				  <c:if test="${pager.currentPage==pager.pageSize}">
					  <li  class="disabled">
						  <a href="/UserServlet?m=queryByPage&currentPage=${pager.currentPage+1}&pageCount=${pager.pageCount}&userName=${pager.searchUserName}&userGender=${pager.searchUserGender}" aria-label="Next">
							  <span aria-hidden="true">&raquo;</span>
						  </a>
					  </li>
				  </c:if>
			  </ul>
			</nav>
			</div>
		</div>
		
		 
		 </div>
	
			
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
								<img class="img-responsive" src="../img/wx.png">
								<p>微信
									<sapn class="hidden-sm">号:</sapn>xzpublic</p>
							</div>
						</div>
						<div class="col-xs-12 col-sm-4 footer-item footer-item-last">
							<div class="footer-contact">
								<h2><img src="../img/pc-footer-phone.png">029-85123098</h2>
								<h2><img src="../img/pc-footer-qq.png">945912173</h2>
								<h2><img src="../img/pc-footer-mob.png">15389071915</h2>
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
									<img src="../img/ghs.png" style="float:left;">
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
							<img src="../img/wx.png">
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
								<img class="img-responsive center-block" src="../img/mob-footer-phone.png">
								<span>电话咨询</span>
							</a>
						</div>
						<div class="col-xs-3 mob-bottom-item">
							<a href="tel:15389071915">
								<img class="img-responsive center-block" src="../img/mob-footer-mob.png">
								<span>紧急电话</span>
							</a>
						</div>
						<div class="col-xs-3 mob-bottom-item">
							<a href="#">
								<img class="img-responsive center-block web-chat" src="../img/mob-footer-chat.png">
								<span>在线咨询</span>
							</a>
						</div>
						<div class="col-xs-3 mob-bottom-item">
							<a href="sms:15389071915">
								<img class="img-responsive center-block" src="../img/mob-footer-msm.png">
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
			setInterval("currentTime()",1000);
			$("#loginSub").attr("disabled","disabled");
			$("#sub").attr("disabled","disabled");
			let pagers="${pager}";
			if(pagers==""||pagers==null){

				window.location.href="/index.jsp";
			}

		});


		function updateUserPass(){
			let userId="${loginUser.userId}"
			let oldUserPass = $("#oldUserPass").val();
			let newUserPass = $("#newUserPass").val();
			let confirmUserPass = $("#confirmUserPass").val();
			$("#oldUserPassSpan").html("");
			$("#newUserPassSpan").html("");
			$("#confirmUserPassSpan").html("");
			if(oldUserPass==''){
				$("#oldUserPassSpan").html("请输入原密码");
				return;
			}

			if(newUserPass==''){
				$("#newUserPassSpan").html("请输入密码");
				return;
			}

			if(newUserPass!=confirmUserPass){
				$("#confirmUserPassSpan").html("两次密码不一致");
				return ;
			}

			$.post("/UserServlet?m=updateUserPass",
					{
					userId:userId,
					oldUserPass:oldUserPass,
					 newUserPass:newUserPass
					},
					function(jsonStr){

						let data = JSON.parse(jsonStr);

						if(data.status==0){ //原密码不正确

							$("#oldUserPassSpan").html(data.message);

						}
						if(data.status==1){ //修改密码成功

							window.location.href="/UserServlet?m=loginOut"

						}
						if(data.status==2){ //修改密码失败
							$("#newUserPassSpan").html(data.message);

						}


					}

			)

		}


		function currentTime(){
			//2021年11月10日 14:16:20
			let time=new Date();
			let fullYear = time.getFullYear();
			let month = time.getMonth();
			let day = time.getDate();
			let hours = time.getHours();
			if(hours<10){
                hours="0"+hours;
            }
			let minutes = time.getMinutes();
            if(minutes<10){
                minutes="0"+minutes;
            }
			let seconds = time.getSeconds();
            if(seconds<10){
                seconds="0"+seconds;
            }
			let date=fullYear+"年"+(month+1)+"月"+day+"日 "+hours+":"+minutes+":"+seconds;
			$("#currentTime").html(date);
		}

		function che(pageCount){
			$.get("/UserServlet?m=queryByPage&pageCount="+pageCount,function(){
				window.location.reload();
			})
		}

		function updateUser(userId){

			$.get("/UserServlet?m=queryByUserId&userId="+userId,function(jsonStr){

				let data=JSON.parse(jsonStr);

				$("#UpdateUserPass").css("display","none");
				$("#ModalUpdate input[name='userId']").val(data.userId);
				$("#ModalUpdate input[name='userName']").val(data.userName);
				$("#UpuserGender").val(data.userGender)

				$("#ModalUpdate input[name='userAge']").val(data.userAge);
				$("#ModalUpdate input[name='userPhone']").val(data.userPhone);
				$("#ModalUpdate input[name='userAddress']").val(data.userAddress);
				$('#ModalUpdate').modal('show');
			}
			)

		}
		function openSave(){
			$("#UpdateUserPass").css("display","block");
			$("#ModalUpdate input[name='userId']").val("");
			$("#ModalUpdate input[name='userName']").val("");
			$("#ModalUpdate input[name='userAge']").val("");
			$("#ModalUpdate input[name='userPhone']").val("");
			$("#ModalUpdate input[name='userAddress']").val("");
			$('#ModalUpdate').modal('show');


		}



	</script>
<script src="/js/student.js"></script>