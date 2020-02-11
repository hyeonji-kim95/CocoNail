<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="gallery.GalleryDAO"%>
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
	

	
	ServletContext ctx = getServletContext();
	String realFolder = ctx.getRealPath("/gallery/upload");

	int max = 10 * 1024 * 1024;
	
	MultipartRequest mulRequest = new MultipartRequest(request, realFolder, max, "UTF-8", new DefaultFileRenamePolicy());
	
	String gallery_img_name = mulRequest.getFilesystemName("gallery_img_name");
	
	
	if(gallery_img_name == null) {
%>
		<script>
			alert("업로드할 파일이 없습니다.");
			history.go(-1);
		</script>
<%
	}
	
	String gallery_img = "gallery/upload/" + gallery_img_name;
	
	GalleryDAO dao = new GalleryDAO();
	dao.addPicture(gallery_img, gallery_img_name);
	
	
	
	response.sendRedirect("../gallery.jsp");
 
%>