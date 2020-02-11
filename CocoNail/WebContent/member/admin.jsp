<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	//한글처리
 	request.setCharacterEncoding("UTF-8");
 	
	MemberDAO memberdao = new MemberDAO();

 	//DB에 저장되어 있는 모든 회원정보 검색을 위한 listMembers()메소드 호출!
 	ArrayList list = memberdao.listMembers(); 	
 %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Admin - Coco Nail</title>
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/mobile.css">
	<script src="../js/mobile.js" type="text/javascript"></script>
</head>
<body>
	<div id="page">
		<div id="header">
			<div>
			<%
				//session객체영역에 세션id값을 얻어...
				String member_id = (String)session.getAttribute("member_id");
				
				//session객체 영역에 세션id값이 저장되어 있지 않다면?
				if(member_id == null){ //로그아웃된 상태의 화면을 보여 주자 
			%>		
				<div id="login">
					<a href="login.jsp">login</a>
					<a href="join.jsp">join</a>
				</div>
			<%		
				}else{//session객체 영역에 세션id값이 저장되어 있다면?
			%>	
				<div id="login">
			<%
				if(member_id.equals("admin")) {
			%>
					<a href="admin.jsp">admin</a>
					<a href="logout.jsp">logout</a>
			<%
				} else {
			%>
					<a href="myPage.jsp">myPage</a>
					<a href="logout.jsp">logout</a>
			<%  }	%>
				</div>
			<%			
				}
			%>
			</div>
			<div id="logo">
				<a href="../index.jsp" class="logo"><img src="../img/title/logo3.png" alt=""></a>
				<ul id="navigation">
					<li class="selected">
						<a href="../index.jsp">Home</a>
					</li>
					<li class="menu">
						<a href="../about.jsp">About</a>
						<ul class="primary">
							<li>
								<a href="../gallery.jsp">Gallery</a>
							</li>
						</ul>
					</li>
					<li class="menu">
						<a href="../book.jsp">Book</a>
						<ul class="secondary">
							<li>
								<a href="../price.jsp">Price</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="../review.jsp">Review</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="body">
			<div class="header">
				<div>
					<h1>Admin</h1>
				</div>
			</div>
			
			<table align="center">
				<tr align="center" bgcolor="pink">
					<td width="110px">ID</td>
					<td width="110px">PW</td>
					<td width="110px">Name</td>
					<td width="80px">Birth</td>
					<td width="110px">Phone</td>
					<td width="80px">Post</td>
					<td width="500px">Address</td>
					<td width="190px">Email</td>
					<td width="80px">Delete</td>
				</tr>
		<%
			//DB의 테이블에서 검색한 회원정보가 없으면?
			if(list.size() == 0){//검색한.....
								 //ArrayList배열에 저장되어 있는 MemberBean객체가 없다면
		%>						 
				<tr>
					<td colspan="5">등록된 회원이 없습니다.</td>
				</tr>
		<%		
			}else{//DB의 테이블에서 검색한 회원정보가 존재 하면?
				String member_birth, member_email;
				//ArrayList배열에 저장되어 있는 MemberBean객체의 갯수 만큼 반복 하여
				for(int i=0; i<list.size(); i++){
					//ArryList에 각인덱스 위치에 저장되어 있는  MemberBean객체를 각각 얻어 출력
					MemberBean bean = (MemberBean)list.get(i);
					String id = bean.getMember_id();
					if(bean.getMember_birth() == null) {
						member_birth = "";
					} else {
						member_birth = bean.getMember_birth();
					}
					if(bean.getMember_email() == null) {
						member_email = "";
					} else {
						member_email = bean.getMember_email();
					}
					
		%>			
				<form action="adminPro.jsp?member_id=<%=id%>" id="join" method="post">
					<tr align="center">
						<td name="member_id"><%=bean.getMember_id()%> </td>
						<td name="member_pw"><%=bean.getMember_pw()%> </td>
						<td name="member_name"><%=bean.getMember_name() %> </td>
						<td name="member_birth"><%=member_birth %> </td>
						<td name="member_phone"><%=bean.getMember_phone() %> </td>
						<td name="member_post"><%=bean.getMember_post() %> </td>
						<td name="member_address"><%=bean.getMember_address()%>,&nbsp;<%=bean.getMember_address2()%>&nbsp;<%=bean.getMember_address3()%> </td>
						<td name="member_email"><%=member_email %> </td>
		<%
					if(!bean.getMember_id().equals("admin")) {
		%>
						<td width="80px"><input type="button" value="삭제" onclick="delMember('<%=id %>');"></td>
		<% 			} %>
					</tr>
				</form>
		<%		
				}		
			}
		%>
					<tr align="center" bgcolor="pink">
						<td colspan="7">총 회원 수(admin제외)</td>
						<td colspan="2"><%=list.size()-1 %></td>
					</tr>
			</table>
			
		</div>
		<div id="footer">
			<jsp:include page="../inc/bottom.jsp"/>
		</div>
	</div>
	
	<script type="text/javascript">
		function delMember(member_id) {
			if(confirm('삭제하시겠습니까?')){
				location.href="adminPro.jsp?member_id=" + member_id;
			} else {
				alert('삭제 취소');
			}
		}
	</script>
	
</body>
</html>