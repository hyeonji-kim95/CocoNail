<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<header>
			<div>
			<%
				//session객체영역에 세션id값을 얻어...
				String member_id = (String)session.getAttribute("member_id");
				
				//session객체 영역에 세션id값이 저장되어 있지 않다면?
				if(member_id == null){ //로그아웃된 상태의 화면을 보여 주자 
			%>		
				<div id="login">
					<a href="member/login.jsp">login</a>
					<a href="member/join.jsp">join</a>
				</div>
			<%		
				}else{//session객체 영역에 세션id값이 저장되어 있다면?
			%>	
				<div id="login">
			<%
				if(member_id.equals("admin")) {
			%>
					<a href="member/admin.jsp">admin</a>
					<a href="member/logout.jsp">logout</a>
			<%
				} else {
			%>
					<a href="member/myPage.jsp">myPage</a>
					<a href="member/logout.jsp">logout</a>
			<%  }	%>
				</div>
			<%			
				}
			%>
			<div id="logo">
				<a href="index.jsp" class="logo"><img src="img/title/logo3.png" alt=""></a>
				<ul id="navigation">
					<li class="selected">
						<a href="index.jsp">Home</a>
					</li>
					<li class="menu">
						<a href="about.jsp">About</a>
						<ul class="primary">
							<li>
								<a href="gallery.jsp">Gallery</a>
							</li>
						</ul>
					</li>
					<li class="menu">
						<a href="book.jsp">Book</a>
						<ul class="secondary">
							<li>
								<a href="price.jsp">Price</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="review.jsp">Review</a>
					</li>
				</ul>
			</div>
		</header>