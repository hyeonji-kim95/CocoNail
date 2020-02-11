<%@page import="review.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session값 얻기
	String member_id = (String)session.getAttribute("member_id");

	//session값이 저장되어 있지 않다면..login.jsp로 이동
	if(member_id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");

	int review_num = Integer.parseInt(request.getParameter("review_num"));
	String review_reContent = request.getParameter("review_reContent");
	
	ReviewDAO reviewDAO = new ReviewDAO();
	reviewDAO.updateReview_re(review_num, review_reContent);
 
%>
<script>
	history.go(-1);
</script>