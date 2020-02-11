<%@page import="book.BookDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	String member_id = request.getParameter("member_id");
	
	MemberDAO mdao = new MemberDAO();

	int check = mdao.deleteMember(member_id);
	
	BookDAO bdao = new BookDAO();

	if(check == 1){
		session.invalidate(); // 로그아웃
		
		bdao.delAllBook(member_id);
		
%>
		<script>
			alert("회원탈퇴 성공");
			location.href="../index.jsp";
		</script>
<%
		
		//index.jsp로 이동(재요청 하여 이동)
// 		response.sendRedirect("../index.jsp");
	}else {
%>
		<script>
			alert("아이디 없음");
			history.go(-1); //이전 페이지로 이동 
		</script>
<%
	}
%>