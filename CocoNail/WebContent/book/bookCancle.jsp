<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); // 맨 첫줄에 적어야 함

	int book_num = Integer.parseInt(request.getParameter("book_num"));
	
	
	BookDAO dao = new BookDAO();
	dao.bookCancle(book_num);
%>

	<script>
		alert("취소완료");
		window.close();
	</script>