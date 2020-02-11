<%@page import="java.sql.Timestamp"%>
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
	
	<script type="text/javascript">
		function review_reCon() {
			var review_reContent = $("#review_reContent").value();
			alert(review_reContent);
		}
	</script>
	
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
	/*글 상세보기 페이지*/
	//notice.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//notice.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 얻기
	int review_num =  Integer.parseInt(request.getParameter("review_num"));
	String pageNum = request.getParameter("pageNum");
	
	//글목록하나를 클릭 했을 떄.. 조회수 증가 DB작업
	ReviewDAO dao = new ReviewDAO();
	
	//조회수1증가 시키는 메소드 호출
	dao.updateReadCount(review_num); 
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	ReviewBean reviewBean = dao.getReview(review_num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = reviewBean.getReview_num();//검색한 글번호 
	int DBReadcount =reviewBean.getReview_readcount();//검색한 글의 조회수 
	String Image = "upload/" + reviewBean.getReview_file();
	String DBMember_id = reviewBean.getMember_id();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = reviewBean.getReview_date();//검색한 글을 작성한 날짜
	String DBSubject = reviewBean.getReview_subject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(reviewBean.getReview_content() != null){
		DBContent = reviewBean.getReview_content().replace("\r\n", "<br>");
	}
	//답변 달기에 관한 검색한 값3개 저장
	int DBRe_ref = reviewBean.getRe_ref();//주글과 답글이 같은 값을 가질수 있는 유일한 그룹값
	int DBRe_lev = reviewBean.getRe_lev();//주글(답글)의 들여쓰기 정도값
	int DBRe_seq = reviewBean.getRe_seq();//주글(답글)들을 board테이블에 추가하면 글의 순서
	
	
%>
		<div>
				<table id="content">
					<tr>
						<td width="100px" class="tdOther">No</td>
						<td width="500px" class="tdOther">Title</td>
						<td width="100px" class="tdOther">Read</td>
						<td width="200px" class="tdOther">Writer</td>
						<td width="200px" class="tdOther">Date</td>
					</tr>		
					<tr align="center">
						<td><%=DBnum%></td>
						<td><%=DBSubject%></td>
						<td><%=DBReadcount%></td>
						<td><%=DBMember_id%></td>
						<td><%=new SimpleDateFormat("yyyy.MM.dd").format(DBDate)%></td>
					</tr>	
					<tr>
						<td colspan="5" class="tdContent">Content</td>
					</tr>
					<tr>
						<td colspan="5">
							<img src=<%=Image%> alt="" width="700px"><br>
							<%=DBContent%>
						</td>
					</tr>			
				</table>
				
				<div id="table_search">
				<%
					String review_reContent = dao.findReview_reContent(DBnum);
					if(member_id != null){
						if(member_id.equals("admin")) {
							if(review_reContent == null) {
								review_reContent = "";
							}
				%>
					<br>
					<form action="reContent.jsp">
						<input type="hidden" value="<%=reviewBean.getReview_num() %>" name="review_num">
						<textarea name="review_reContent" cols="134" rows="6"><%=review_reContent %></textarea><br>
						<input type="submit" value="comment" class="btn" style="position: absolute; right: 480px;" onclick="review_reCon();"><br><br>
					</form>
				<%			
						} else {
							if(reviewBean.getReview_re() > 0) {
				%>
					<br>
					<textarea name="review_reContent" cols="134" rows="6" disabled="disabled" style="background-color:#FFFFE9"><%=review_reContent %></textarea><br>
					
				<%
							}
						}
						if(member_id.equals(DBMember_id) || member_id.equals("admin")) {
				%>
					<input type="button" value="update" class="btn" 
					onclick="location.href='update.jsp?review_num=<%=DBnum%>&pageNum=<%=pageNum%>'">
					
					<input type="button" value="delete" class="btn"
					onclick="location.href='deletePro.jsp?review_num=<%=DBnum%>&pageNum=<%=pageNum%>&review_file=<%=reviewBean.getReview_file()%>'">
				<% 		}
					}
				%>
				<input type="button" value="list" class="btn" 
				onclick="location.href='../review.jsp?pageNum=<%=pageNum%>'">
				</div>
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
    