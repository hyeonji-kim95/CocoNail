<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="review.ReviewBean"%>
<%@page import="review.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Review - Coco Nail</title>
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/mobile.css">
	<script src="js/mobile.js" type="text/javascript"></script>
	<style type="text/css">
		.btn {
			height: 25px;
			width: 100px;
			border: 1px solid #666;
			border-radius:10px;
			box-shadow:3px 3px 2px #CCC;
			font-size: 14px;
			background-color: #FF7493;
			margin: 0 0 0 20px;
			background-repeat: repeat-x;
			background-position: center center;
			color: #ffffff;
		}
	</style>
</head>
<body>
	<div id="page">
		<div id="header">
			<%
				//session객체영역에 세션id값을 얻어...
				String member_id = (String)session.getAttribute("member_id");
				
				//session객체 영역에 세션id값이 저장되어 있지 않다면?
				if(member_id == null){ //로그아웃된 상태의 화면을 보여 주자 
			%>		
				<div id="login">
					<a href="../member/login.jsp">login</a>
					<a href="../member/join.jsp">join</a>
				</div>
			<%		
				}else{//session객체 영역에 세션id값이 저장되어 있다면?
			%>	
				<div id="login">
			<%
				if(member_id.equals("admin")) {
			%>
					<a href="../member/admin.jsp">admin</a>
					<a href="../member/logout.jsp">logout</a>
			<%
				} else {
			%>
					<a href="../member/myPage.jsp">myPage</a>
					<a href="../member/logout.jsp">logout</a>
			<%  }	%>
				</div>
			<%			
				}
			%>
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
					<h1>Review</h1>
				</div>
			</div>
				<div>&nbsp;</div>
		<%
				if(member_id == null){//로그인 페이지로 
					response.sendRedirect("../member/login.jsp");
				}
		%>
		<div>
			<form action="writePro.jsp" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td>Writer</td>
						<td><input type="text" name="member_id" value="<%=member_id%>" readonly style="height:20px"></td>
					</tr>
					<tr>
						<td>Title</td>
						<td><input type="text" name="review_subject" style="width:929px;height:20px"></td>
					</tr>
					<tr>
						<td>Content</td>
						<td><textarea rows="30" cols="130" name="review_content"></textarea> </td>
					</tr>
					<tr>
						<td>Image File</td>
						<td><input type="file" name="review_file"></td>
					</tr>
				</table>
				
				<div id="table_search">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="submit" value="Save" class="btn"> 
					<input type="reset" value="Clear" class="btn">
					<input type="button" value="List" class="btn" 
						   onclick="location.href='../review.jsp'">
				</div>
			</form>	
		</div>
		<div class="clear"></div>		
		</div>
		</div>
		<div id="footer">
			<div>
				<div class="connect">
					<a href="https://www.facebook.com/"><img src="../img/footer/facebook.png" width="30" height="30" id="facebook"></a>
					<a href="https://www.instagram.com/"><img src="../img/footer/instagram.png" width="30" height="30" id="instagram"></a>
					<a href="https://twitter.com/"><img src="../img/footer/twitter.png" width="30" height="30" id="twitter"></a>
					<a href="mailto:coco_nail@style.com"><img src="../img/footer/outlook.png" width="30" height="30" id="gmail"></a>
				</div>
				<p>
					<span>address</span>&nbsp;&nbsp; 서울 강남구 청담동 ○○-○○번지<br>
				    <span>contact</span>&nbsp;&nbsp; coco_nail@style.com \ 02-123-4567<br>
				    <span>service</span>&nbsp;&nbsp; AM 10:00 - PM 8:00<br>
				</p>
			</div>
		</div>
		
	
</body>
</html>
    