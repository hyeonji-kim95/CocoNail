<%@page import="book.BookDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//요청값 얻기
	//1. login.jsp에서 입력한 id password request영역에서 꺼내오기
	String member_id = request.getParameter("member_id");
	
	//2.입력한 ID가 DB에 존재 하면 삭제
	MemberDAO memberdao = new MemberDAO();
	//유무체크를 위한 메소드 호출!
	//check = 1 -> 아이디 존재O
	//check = 0 -> 아이디 존재X
	int check = memberdao.deleteMember(member_id);
	
	BookDAO dao = new BookDAO();
	
	if(check == 1){//DB에 저장되어 있는  아이디, 비밀번호가  입력한 아이디 , 비밀번호 같을떄..
		dao.delAllBook(member_id);
%>
		<script>
			alert("삭제 완료");
			location.href="admin.jsp";
		</script>
<%
		//index.jsp로 이동(재요청 하여 이동)
// 		response.sendRedirect("admin.jsp");
	}else {
%>
		<script>
			alert("아이디 없음");
			history.go(-1); //이전 페이지로 이동 
		</script>
<%
	}
%>


%>