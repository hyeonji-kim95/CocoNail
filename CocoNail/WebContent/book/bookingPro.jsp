<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); // 맨 첫줄에 적어야 함
%>
	<jsp:useBean id="bookBean" class="book.BookBean"/>
	<jsp:setProperty property="*" name="bookBean"/>
<%
	String book_sub1 = request.getParameter("book_sub1");
	String book_sub2 = request.getParameter("book_sub2");
	String book_sub3 = request.getParameter("book_sub3");
	
	String book_sub = null;
	
	// 하나만 예약한 경우
	if(book_sub1 == null && book_sub2 == null && book_sub3 != null){
		book_sub = book_sub3;
	} else if(book_sub1 == null && book_sub2 != null && book_sub3 == null) {
		book_sub = book_sub2;
	} else if(book_sub1 != null && book_sub2 == null && book_sub3 == null) {
		book_sub = book_sub1;
	}
	
	// 두개 예약한 경우
	else if(book_sub1 == null && book_sub2 != null && book_sub3 != null){
		book_sub = book_sub2 + " / " + book_sub3;
	} else if(book_sub1 != null && book_sub2 == null && book_sub3 != null) {
		book_sub = book_sub1 + " / " + book_sub3;
	} else if(book_sub1 != null && book_sub2 != null && book_sub3 == null) {
		book_sub = book_sub1 + " / " + book_sub2;
	}
	
	// 세개 예약한 경우
	
	else if(book_sub1 != null && book_sub2 != null && book_sub3 != null){
		book_sub = book_sub1 + " / " + book_sub2 + " / " + book_sub3;
	} else {
%>
	<script>
		alert("예약 내용을 선택해주세요!");
		location.href="booking.jsp?member_id=<%=bookBean.getMember_id()%>&book_date=<%=bookBean.getBook_date()%>";
	</script>
<%	
	}
	
	
	bookBean.setBook_sub(book_sub);
	
	BookDAO dao = new BookDAO();
	
	// MemberBean의 정보를 DB에 INSERT하기 위해 insertMember()메소드 호출시 메소드의 인자로 MemberBean객체를 전달 함
	dao.insertBook(bookBean);
	
%>
	<script>
		alert("예약완료! 감사합니다^^");
		window.close();
	</script>