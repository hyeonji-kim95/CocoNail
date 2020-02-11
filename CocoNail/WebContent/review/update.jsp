<%@page import="java.sql.Timestamp"%>
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
		.tdOther {
			height: 25px;
			background-color:pink;
			text-align: center;
		}
		.tdContent {
			height: 25px;
			background-color:pink;
			font-size: 20px;
			text-align: center;
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

	
	//content.jsp페이지에서 글수정버튼을 클릭해서  요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//content.jsp페이지에서 글수정버튼을 클릭해서  요청받아 넘어온 num,pageNum 얻기
	int review_num =  Integer.parseInt(request.getParameter("review_num"));
	String pageNum = request.getParameter("pageNum");
	
	//글수정을 위한 하나의 글정보 검색 DB작업을 위한 객체 생성
	ReviewDAO dao = new ReviewDAO();
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	ReviewBean reviewBean = dao.getReview(review_num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = reviewBean.getReview_num();//검색한 글번호 
	int DBReadcount = reviewBean.getReview_readcount();//검색한 글의 조회수 
	String DBMember_id = reviewBean.getMember_id();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = reviewBean.getReview_date();//검색한 글을 작성한 날짜 및 시간 
	String DBSubject = reviewBean.getReview_subject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(reviewBean.getReview_content() != null){
		DBContent = reviewBean.getReview_content().replace("<br>", "\r\n");
	}
		
%>
		<div>
		<form action="updatePro.jsp?pageNum=<%=pageNum%>&member_id=<%=member_id %>" method="post">
			<input type="hidden" name="review_num" value="<%=DBnum%>">
			<table>
				<tr>
					<td>Writer</td>
					<td><input type="text" name="member_id" value="<%=DBMember_id%>" readonly style="height:20px"></td>
				</tr>
				<tr>
					<td>Title</td>
					<td><input type="text" name="review_subject" value="<%=DBSubject%>" style="width:929px;height:20px"></td>
				</tr>
				<tr>
					<td>Content</td>
					<td>
						<textarea name="review_content" rows="30" cols="130">
						<%=DBContent%>
						</textarea>
					</td>
				</tr>				
			</table>
			
		<div id="table_search">
			<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input type="submit" value="Save" class="btn">
			<input type="reset" value="Cancel" class="btn">
			<input type="button" value="List" class="btn" 
				   onclick="location.href='review.jsp?pageNum=<%=pageNum%>'">
		</div>
		</form>
		</div>
		</div>
		<div class="clear"></div>		
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