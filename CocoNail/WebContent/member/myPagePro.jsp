<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	String member_id = request.getParameter("member_id");
	String member_pw_n = request.getParameter("member_pw_n");
	
	//MemberBean객체를 생성 하여 요청한 수정할 글정보들을 각변수에 저장
%>
	<jsp:useBean id="mBean"  class="member.MemberBean"/>
	<jsp:setProperty property="*" name="mBean"/>

	<%--UPDATE작업을 위한 MemberDAO객체 생성 --%>
	<jsp:useBean id="mdao" class="member.MemberDAO" />
	
<%
	//UPDATE작업을 위해 메소드 호출시.. MemberBean을 전달 하여 UPDATE작업함. 
	
	System.out.println(member_pw_n);
	int check = mdao.updateMember(mBean, member_pw_n);
	
	if(check == 1){ //수정성공!
%>	
	<script type="text/javascript">
		window.alert("수정성공");
		location.href="myPage.jsp?member_id=<%=member_id%>"; 
	</script>
<%		
	} else if(check == -1) { // 새 비밀번호 입력 안함
%>	
		<script type="text/javascript">
			window.alert("새 비밀번호를 입력하세요");
			history.back();
		</script>
<%		
	} else {//수정실패! 비밀번호 틀림 -> 이전 페이지로 되돌아 가게 하기 
%>		
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
<%		
	}
%>