<%@page import="book.BookDAO"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8"); // 맨 첫줄에 적어야 함

	String book_date = request.getParameter("book_date");
	String book_status = request.getParameter("book_status");
	int book_num = Integer.parseInt(request.getParameter("book_num"));

	
	Date d = new Date();
	String year = d.getYear()+1900 + "";
	String month = d.getMonth()+1 + "";
	String date = d.getDate() + "";
	
	
	String today = year + "/" + month + "/" + date;

	
	BookDAO dao = new BookDAO();
	
	// 예약상태가 book이고, 예약일이 오늘이 아닌 경우 삭제 가능(과거는 관리자가 done 또는 cancle을 해놓으면 여기에 안걸리게 됨)
	if(book_status.equals("book") && !book_date.equals(today)) {
		dao.bookCancle(book_num);
%>
	<script>
		alert("취소완료");
		window.close();
	</script>
<%
	} else {
%>
	<script>
		alert("취소할 수 없는 날짜입니다.");
		history.go(-1);
	</script>
<%
	}
	

%>