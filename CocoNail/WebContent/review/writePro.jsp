<%@page import="review.ReviewBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="review.ReviewDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	//session값 얻기
	String member_id = (String)session.getAttribute("member_id");

	//session값이 저장되어 있지 않다면..login.jsp로 이동
	if(member_id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	

	// 파일 저장
	ServletContext ctx = getServletContext();
	String realFolder = ctx.getRealPath("/review/upload");

	int max = 10 * 1024 * 1024;
	
	MultipartRequest mulRequest = new MultipartRequest(request, realFolder, max, "UTF-8", new DefaultFileRenamePolicy());
	

	String review_file = mulRequest.getFilesystemName("review_file");
	
	ReviewBean rBean = new ReviewBean();
	rBean.setMember_id(member_id);
	rBean.setReview_subject(mulRequest.getParameter("review_subject"));
	rBean.setReview_content(mulRequest.getParameter("review_content"));
	rBean.setReview_file(review_file);

	
	
	//1.2.1 현재 글쓴 날짜 정보....를 추가로 ReviewBean에 저장
	rBean.setReview_date(new Timestamp(System.currentTimeMillis()));

	//2. 데이터베이스의 review테이블에  우리가 입력한 새글 정보를 INSERT
	ReviewDAO rdao = new ReviewDAO();//DB작업
	
	
	rdao.insertReview(rBean);
	
	
	
	
	if(review_file == null) {
%>
		<script>
			alert("업로드할 파일이 없습니다.");
			history.go(-1);
		</script>
<%
	}
	
	//notice.jsp를 재요청(포워딩) 해 이동
	response.sendRedirect("../review.jsp");
 
%>