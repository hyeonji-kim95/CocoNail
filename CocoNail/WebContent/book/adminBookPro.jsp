<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int book_num = Integer.parseInt(request.getParameter("book_num"));
	
	BookDAO dao = new BookDAO();
	
	dao.DoneBook(book_num);
%>

	<script>
		alert("변경완료");
		window.close();
	</script>