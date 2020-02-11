<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
 	//한글처리
 	request.setCharacterEncoding("UTF-8");
	
	String member_id = request.getParameter("member_id");

	BookDAO dao = new BookDAO();

 	//DB에 저장되어 있는 모든 회원정보 검색을 위한 listMembers()메소드 호출!
 	ArrayList list = dao.listBooks(member_id); 	
 %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mybook</title>

	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="../text/css" href="css/mobile.css">
</head>
<body>
		<div>
			<h2 style="text-align: center; color: #CB3362;"><%=member_id %>님의 예약 내역</h2>
			<table align="center">
				<tr align="center" bgcolor="pink">
					<td width="150px">예약 날짜</td>
					<td width="130px">예약시간</td>
					<td width="300px">예약내용</td>
					<td width="110px">예약상태</td>
					<td width="80px">예약취소</td>
				</tr>
		<%
			//DB의 테이블에서 검색한 회원정보가 없으면?
			if(list.size() == 0){
		%>						 
				<tr>
					<td colspan="5">예약내역이 없습니다.</td>
				</tr>
		<%		
			}else{//DB의 테이블에서 검색한 회원정보가 존재 하면?
				//ArrayList배열에 저장되어 있는 MemberBean객체의 갯수 만큼 반복 하여
				for(int i=0; i<list.size(); i++){
					//ArryList에 각인덱스 위치에 저장되어 있는  MemberBean객체를 각각 얻어 출력
					BookBean bean = (BookBean)list.get(i);
		%>			
				<form action="MybookPro.jsp?book_date=<%=bean.getBook_date()%>&book_status=<%=bean.getBook_status()%>&book_num=<%=bean.getBook_num()%>" id="join" method="post">
					<tr align="center">
						<td name="book_date"><%=bean.getBook_date()%> </td>
						<td name="book_time"><%=bean.getBook_time() %> </td>
						<td name="book_sub"><%=bean.getBook_sub() %> </td>
						<td name="book_status"><%=bean.getBook_status() %> </td>
		<%		if(bean.getBook_status().equals("done")) { %>
						<td width="80px">완료</td>
		<%		} else { %>
						<td width="80px"><input type="submit" value="취소"></td>
		<%		} %>
					</tr>
				</form>
		<%		
				}		
			}
		%>
			</table>
			
		</div>
</body>
</html>