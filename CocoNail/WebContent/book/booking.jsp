<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>booking</title>

	<style type="text/css">
		body {
			background-color: #FFF0F5;
			font-size: 20px;
		}
		input {
			height: 20px;
		}
		h3 {
			color: #E32A62;
		}
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
</head>
<body>
<%
	String member_id = request.getParameter("member_id");
	String book_date = request.getParameter("book_date");
	
	BookDAO dao = new BookDAO();
	int check = dao.bookTimeChk(book_date); // 해당 날짜에 예약 내역이 있는지 확인하고, 없으면 0반환, 있으면 개수 반환
	
	if(check == 2) {
%>
	<script type="text/javascript">
		alert('죄송합니다. 해당 날짜에 예약이 불가능합니다.');
		window.close();
	</script>
<%
	}
%>

	<form action="bookingPro.jsp" method="post">
		<p>
			<h3>환영합니다. Coco Nail은 고객님의 아름다움을 위해 항상 노력합니다^^</h3>
		</p>
		<br>
		<label>&nbsp;&nbsp;예약자&nbsp;&nbsp;&nbsp;</label><input type="text" value="<%=member_id %>" name="member_id" height="10" readonly><br>
		<label>예약 날짜&nbsp;</label><input type="text" value="<%=book_date %>" name="book_date" readonly>
		
		<br><br>
		
		<label>예약 시간을 선택하세요.</label><br>
	<%
		if(check == 0) { // 해당 날짜에 예약내역이 없는 경우
	%>
		<input type="radio" value="10:00" name="book_time"> 10:00
		<input type="radio" value="15:00" name="book_time"> 15:00
	<%
		} else { // 해당 날짜에 예약이 하나 있는 경우
			String book_time = dao.getBookTime(book_date);
			String book_status = dao.getBookStatus(book_date);
			if(book_status.equals("done") || book_status.equals("cancle")) {
	%>
		<input type="radio" value="10:00" name="book_time"> 10:00
		<input type="radio" value="15:00" name="book_time"> 15:00
	<%
			} else {
				if(book_time.equals("10:00")) {
	%>
				<input type="radio" value="15:00" name="book_time"> 15:00
	<%
				} else {
	%>
				<input type="radio" value="10:00" name="book_time"> 10:00
	<%	
				}
			}
			
		}
	%>
		<br><br>
		
		<label>예약 내용을 선택하세요.(시간관계상 한가지만 작업 가능합니다.)</label><br>
		<input type="checkbox" value="Gel Nail" name="book_sub1"> 젤 네일 
		<input type="checkbox" value="Gel Pedi" name="book_sub2"> 젤 페디 
		<input type="checkbox" value="Care" name="book_sub3"> 케어 
		
		<br><br><br>
		
		<input type="submit" class="butn" value="book">
	</form>
</body>
</html>