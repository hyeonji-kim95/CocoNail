<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>login - Coco Nail</title>
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/mobile.css">
	<script src="../js/mobile.js" type="text/javascript"></script>
</head>
<body>
	<div id="page">
		<div id="header">
			<div>
			<%
				//session객체영역에 세션id값을 얻어...
				String member_id = (String)session.getAttribute("member_id");
				
				//session객체 영역에 세션id값이 저장되어 있지 않다면?
				if(member_id == null){ //로그아웃된 상태의 화면을 보여 주자 
			%>		
				<div id="login">
					<a href="login.jsp">login</a>
					<a href="join.jsp">join</a>
				</div>
			<%		
				}else{//session객체 영역에 세션id값이 저장되어 있다면?
			%>	
				<div id="login">
			<%
				if(member_id.equals("admin")) {
			%>
					<a href="admin.jsp">admin</a>
					<a href="logout.jsp">logout</a>
			<%
				} else {
			%>
					<a href="myPage.jsp">myPage</a>
					<a href="logout.jsp">logout</a>
			<%  }	%>
				</div>
			<%			
				}
			%>
			</div>
			<div id="logo">
				<a href="../index.jsp" class="logo"><img src="../img/title/logo3.png" alt=""></a>
				<ul id="navigation">
					<li class="selected">
						<a href="../index.jsp">Home</a>
					</li>
					<li class="menu">
						<a href="../about.jsp">About</a>
						<ul class="primary">
							<li>
								<a href="../gallery.jsp">Gallery</a>
							</li>
						</ul>
					</li>
					<li class="menu">
						<a href="../book.jsp">Book</a>
						<ul class="secondary">
							<li>
								<a href="../price.jsp">Price</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="../review.jsp">Review</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="body">
			<div class="header">
				<div>
					<h1>login</h1>
				</div>
			</div>
			<div class="body">
				<img src="../img/t_4_r2.jpg" alt="" width="1200px" height="249px">
			</div>
			<div class="footer">
				<div class="sidebar">
					<h1>Welcome</h1>
					<p>Hello ^_^<br>This is login page.<br> Please enter your ID and Password on the right.<br> If you are not a member,<br> <a href="join.jsp">join</a> now.</p>
				</div>
				<div class="article"><br><br><br><br><br></div>
				<div class="article">
					<h1>Login</h1>
					<form action="loginPro.jsp" id="join" method="post">
						<fieldset>
							<legend>Login Info</legend>
							<label>User ID</label> <input type="text" name="member_id"><br>
							<label>Password</label> <input type="password" name="member_pw"><br>
						</fieldset>
						<div class="clear"></div>
						<div id="buttons">
							<input type="submit" value="로그인" class="submit"> 
							<input type="reset" value="다시입력" class="cancel">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="footer">
			<jsp:include page="../inc/bottom.jsp"/>
		</div>
	</div>
</body>
</html>