<%@page import="java.text.SimpleDateFormat"%>
<%@page import="review.ReviewBean"%>
<%@page import="java.util.List"%>
<%@page import="review.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session값 얻기
	String member_id = (String)session.getAttribute("member_id");

	//session값이 저장되어 있지 않다면..login.jsp로 이동
	if(member_id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");

	String keyword = request.getParameter("keyword");
	if(keyword == null){
		keyword=" ";
				
	}

	ReviewDAO dao = new ReviewDAO();

%>

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
		.butn {
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
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function searchT() {
			var keyword = $("#searchText").val();
			location.href="../review/findContent.jsp?keyword=" + keyword;
		}
	</script>
	
</head>
<body>
	<div id="page">
		<div id="header">
			<div>
			<%
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
	</div>
		<div id="body" class="review">
			<div class="header">
				<div>
					<h1>Review</h1>
				</div>
			</div>
			<div class="footer">
				<div>	
					<table align="center">
						<tr align="center" bgcolor="pink">
							<td width="250px">No.</td>
							<td width="2500px">Title</td>
							<td width="350px">Writer</td>
							<td width="550px">Date</td>
							<td width="250px">Read</td>
						</tr>
				<%
					
					
					List<ReviewBean> list =
					 dao.findReviewContent(keyword);
					
						for(int i=0; i< list.size(); i++){
							ReviewBean bean = list.get(i);
				%>			
						<tr onclick="location.href='content.jsp?review_num=<%=bean.getReview_num() %>'" align="center">
							<td><%=bean.getReview_num()%></td>
							
							<td class="left">
								<%=bean.getReview_subject() %>
							</td>
							<td><%=bean.getMember_id() %></td>
							<td><%=new SimpleDateFormat("yyyy/MM/dd").format(bean.getReview_date()) %></td>
							<td><%=bean.getReview_readcount() %></td>
						</tr>
						
				<%		} %>	
					</table>
					<div></div>
					
					<%
						//각각 페이지에서 로그인후.. 현재 게시판페이지로 이동 해 올 떄..
						//session영역은 유지가 됨.
						//session영역에 저장되어 있는 값이 있냐 업냐에 따라..
						//글쓰기 버튼을 보이게 보이지 않게 설정 하자.
						member_id = (String)session.getAttribute("member_id");
						
						//session영역에 값이 저장되어 있으면.. 글쓰기 버튼을 만들어 보이게 설정
						if(member_id != null){
					%>		
							<div> 
								<input type="button" value="Write" class="butn" onclick="location.href='review/write.jsp'">
							</div>		
					<%	
						}
					%>
							
					
					<div id="page_control">
					<div style="text-align: center;">
					
					</div>
						<input type="text" id="searchText" class="input_box" style="position: absolute; right: 560px;"> 
						<input type="button" value="search" class="butn" style="position: absolute; right: 450px;" onclick="searchT();">
					</div>
				</div>
				
				
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
	
	</div>
</body>
</html>
    