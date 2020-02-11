<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 1. 회원가입을 위해 join.jsp에서 입력한 회원 정보들은 request 내장 객체 영역에 저장되어 있다.
	//    request 내장객체 영역에 저장된 데이터중 한글이 존재하면 한글 깨짐 방지를 위해 문자셋 방식을 UTF-8로 설정함
	request.setCharacterEncoding("UTF-8"); // 맨 첫줄에 적어야 함
%>
	<jsp:useBean id="memberbean" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="memberbean"/>
<%
	// 4. 입력한 회원정보, 즉 MemberBean의 정보를 DB에 INSERT하기 위해 MemberDAO객체 생성
	MemberDAO dao = new MemberDAO();
	
	// MemberBean의 정보를 DB에 INSERT하기 위해 insertMember()메소드 호출시 메소드의 인자로 MemberBean객체를 전달 함
	dao.insertMember(memberbean);
	
	// 5. 회원가입에 성공했다면 login.jsp로 이동하기 위해 포워딩(재요청)
	response.sendRedirect("login.jsp");
	
%>