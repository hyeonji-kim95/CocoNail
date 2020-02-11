<%@page import="book.bBean"%>
<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	String book_date = request.getParameter("book_date");
	BookDAO dao = new BookDAO();
	
 	//DB에 저장되어 있는 모든 회원정보 검색을 위한 listMembers()메소드 호출!
 	ArrayList<bBean> list = dao.todayBooking(book_date);
 %> 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>adminBook</title>
</head>
<body>
		<div>
			<h2 style="text-align: center; color: #CB3362;"><%=book_date %> 예약 내역</h2>
			<table align="center">
				<tr align="center" bgcolor="pink">
					<td width="100px">예약자 ID</td>
					<td width="100px">예약자명</td>
					<td width="140px">예약자 전화번호</td>
					<td width="100px">예약 날짜</td>
					<td width="90px">예약시간</td>
					<td width="330px">예약내용</td>
					<td width="100px">예약상태</td>
					<td width="70px">완료</td>
					<td width="70px">취소</td>
				</tr>
		<%
			//DB의 테이블에서 검색한 회원정보가 없으면?
			if(list.size() == 0){
		%>						 
				<tr>
					<td colspan="6">해당 날짜에 예약이 존재하지 않습니다.</td>
				</tr>
		<%		
			}else{
				for(int i=0; i<list.size(); i++){
					bBean bean = (bBean)list.get(i);
					String book_status = bean.getBook_status();
		%>
				<form action="adminBookPro.jsp?book_num=<%=bean.getBook_num()%>" id="join" method="post">
					<tr align="center">
						<td name="member_id"><%=bean.getMember_id() %></td>
						<td name="member_name"><%=bean.getMember_name() %></td>
						<td name="member_phone"><%=bean.getMember_phone() %></td>
						<td name="book_date"><%=bean.getBook_date()%> </td>
						<td name="book_time"><%=bean.getBook_time() %> </td>
						<td name="book_sub"><%=bean.getBook_sub() %> </td>
						<td name="book_status"><%=bean.getBook_status() %> </td>
			<%		if(!book_status.equals("book")) { %>
						<td width="80px">완료</td>
						<td width="80px">X</td>
			<%		} else { %>
						<td width="80px"><input type="submit" value="완료"/></td>
						<td width="80px"><input type="button" value="취소" onclick="bookCancle(<%=bean.getBook_num()%>);"/></td>
		<%		} %>
					</tr>
				</form>
		<%		
				} // for문		
			} // else문
		%>
			</table>
			
		</div>
		
		<script type="text/javascript">
			function bookCancle(book_num) {
				location.href="bookCancle.jsp?book_num=" + book_num;
			}
		</script>
</body>
</html>
