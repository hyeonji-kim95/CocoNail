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
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="css/mobile.css">
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
			location.href="review/findContent.jsp?keyword=" + keyword;
		}
	</script>
	
</head>
<body>
	<div id="page">
		<div id="header">
			<jsp:include page="inc/top.jsp"/>
		</div>
		<div id="body">
			<div class="header">
				<div>
					<h1>Review</h1>
				</div>
			</div>
			<div class="footer">
				<div>
					<h1>Review</h1>
					<%
					//게시판에 새글을 추가 했다면.. review.jsp페이지에
					//DB에 저장된 새글 정보를 검색하여 가져와서 글리스트 목록을 아래에 출력 해주어야 함.
					ReviewDAO reviewDAO = new ReviewDAO();
				
					//게시판에 저장되어 있는 전체 글개수 검색해서 얻기
					int count = reviewDAO.getreviewCount();	 
					
					//한페이지에 보여줄 글 개수 10개로 지정
					int pageSize = 10;
					
					//review.jsp화면의 아래쪽 페이지번호를 클릭시..클릭한 페이지 번호 받아오기
					String pageNum = request.getParameter("pageNum");
					
					
					//review.jsp화면 요청시..아래쪾의 페이지번호를 클릭 하지 않은 상태이다..
					//이럴때는 현재 클릭한 페이지 번호가 없으면? 현재 보여지는 페이지를 1페이지로 지정
					if(pageNum == null){
						pageNum = "1";
					}
					
					//위의 pageNum변수값을 정수로 변환 해서 저장
					int currentPage = Integer.parseInt(pageNum);
					
					//-------------------------------------------------------------
					
					//각페이지 마다... 첫번째로 보여질 시작 글번호 구하기 
					//(현재 보여지는 페이지번호  - 1) * 한페이지당 보여줄 글개수 5
					int startRow = (currentPage - 1) * pageSize;
					
					//board테이블에서 검색한 글의 정보를 저장할 용도의 
					//List인터페이스 타입의 변수 list선언
					List<ReviewBean> list = null;
					
					//만약 board테이블에 글이 존재 한다면
					if(count > 0){
						
						//board테이블에 모든 글 검색
						//(각페이지 마다 맨위에 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
						list = reviewDAO.getReviewList(startRow,pageSize);
						
					} 	
				%>		
					<table align="center">
						<tr align="center" bgcolor="pink">
							<td width="250px">No.</td>
							<td width="2500px">Title</td>
							<td width="350px">Writer</td>
							<td width="550px">Date</td>
							<td width="250px">Read</td>
						</tr>
				<%
					if(count > 0){//게시판에 글이 존재 하면
						//ArrayList사이즈 만큼 반복 (BoardBean객체 개수 만큼)
						for(int i=0; i<list.size(); i++){
							//ArrayList배열의 각 인덱스 위치에 저장된  BoardBean객체 얻기
							ReviewBean bean = list.get(i);
				%>			
						<tr onclick="location.href='review/content.jsp?review_num=<%=bean.getReview_num() %>&pageNum=<%=pageNum%>'" align="center">
							<td><%=bean.getReview_num()%></td>
							<td><%=bean.getReview_subject() %></td>
							<td><%=bean.getMember_id() %></td>
							<td><%=new SimpleDateFormat("yyyy/MM/dd").format(bean.getReview_date()) %></td>
							<td><%=bean.getReview_readcount() %></td>
						</tr>
				<%						
						}
					}else{
				%>		
						<tr align="center">
							<td colspan="11" >후기글 없음</td>	
						</tr>
				<%		
					}
				%>	
					</table>
					
					<%
						//각각 페이지에서 로그인후.. 현재 게시판페이지로 이동 해 올 떄..
						//session영역은 유지가 됨.
						//session영역에 저장되어 있는 값이 있냐 업냐에 따라..
						//글쓰기 버튼을 보이게 보이지 않게 설정 하자.
						String member_id = (String)session.getAttribute("member_id");
						
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
					<%
						if(count > 0){
							//전체 페이지수 구하기 
							//예)  글 20개 -> 한페이지당 보여줄 글수 10개 => 2개의 페이지
							//예)  글 25개 -> 한페이지당 보여줄 글수 10개 => 3개의 페이지
						//전체 페이지수 = 
						//전체글수/한페이지에 보여줄 글수+(전체글수를 한페이지에 보여줄 글수로 나눈 나머지값)
							int pageCount = count/pageSize + (count%pageSize==0?0:1);
						
						//한화면에 보여질 페이지 수 설정
							int pageBlock = 2;
						
						//시작 페이지 번호 구하기
						// 1~10 => 1    11~20 => 11  21~30 => 21
						//( (아래쪾에 클릭한 페이지번호 / 한화면에 보여줄 페이지수) - 
						//	(아래쪽에 클릭한 페이지 번호를 한화면에 보여줄 페이지수로 나눈 나머지값) )
						// * 하나의 화면에 보여줄 페이지수 + 1
						int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0)) * pageBlock + 1;
						
						//끝페이지 번호 구하기 
						// 1~10 => 10   11~20 =>20  21~30 => 30
						//시작페이지번호 + 현재블럭(한화면)에 보여줄 페이지수 - 1
						int endPage = startPage + pageBlock - 1;
						
						//끝페이지 번호가 전체페이지수보다 클때...
						if(endPage > pageCount){
							//끝페이지 번호를 전체페이지수로 저장
							endPage = pageCount;
						}
						//[이전] 시작페이지번호가 한화면에 보여줄 페이지수보다 클때..
						if(startPage > pageBlock){
						%>
							<a href="review.jsp?pageNum=<%=startPage-pageBlock%>">&lt;</a>
						<%
						}
						// [1] [2]...... 페이지번호 나타내기
						for(int i=startPage; i<=endPage; i++){
						%>
							<a href="review.jsp?pageNum=<%=i%>"><%=i%></a>
						<%	
						}
						//[다음] 끝페이지 번호가 전체페이지 수보다 작을떄..
						if(endPage < pageCount){
						%>	
							<a href="review.jsp?pageNum=<%=startPage+pageBlock%>">&gt;</a>		
						<%
						}
					}
					%>
					</div>
						<input type="text" id="searchText" class="input_box" style="position: absolute; right: 560px;"> 
						<input type="button" value="search" class="butn" style="position: absolute; right: 450px;" onclick="searchT();">
					</div>
					<div>
						
					</div>
				</div>
				
			</div>
		</div>
		<div id="footer">
			<div>
				<div class="connect">
					<a href="https://www.facebook.com/"><img src="img/footer/facebook.png" width="30" height="30" id="facebook"></a>
					<a href="https://www.instagram.com/"><img src="img/footer/instagram.png" width="30" height="30" id="instagram"></a>
					<a href="https://twitter.com/"><img src="img/footer/twitter.png" width="30" height="30" id="twitter"></a>
					<a href="mailto:coco_nail@style.com"><img src="img/footer/outlook.png" width="30" height="30" id="gmail"></a>
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
    